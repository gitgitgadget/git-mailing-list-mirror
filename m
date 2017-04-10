Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F4124209F1
	for <e@80x24.org>; Mon, 10 Apr 2017 14:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbdDJO2w (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 10:28:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41816 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbdDJO2v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 10:28:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4966C20966;
        Mon, 10 Apr 2017 14:28:50 +0000 (UTC)
Date:   Mon, 10 Apr 2017 14:28:50 +0000
From:   Eric Wong <e@80x24.org>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        ttaylorr@github.com
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170410142850.GA23068@starla>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
 <20170409191107.20547-5-larsxschneider@gmail.com>
 <16331164-8E8C-4CDA-B319-AB8092BD7188@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16331164-8E8C-4CDA-B319-AB8092BD7188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:
> > diff --git a/convert.h b/convert.h
> > index 82871a11d5..da6c702090 100644
> > --- a/convert.h
> > +++ b/convert.h
> > @@ -42,6 +42,11 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
> > 			  struct strbuf *dst, enum safe_crlf checksafe);
> > extern int convert_to_working_tree(const char *path, const char *src,
> > 				   size_t len, struct strbuf *dst);
> > +extern int async_convert_to_working_tree(const char *path, const char *src,
> > +					 size_t len, struct strbuf *dst,
> > +					 void *dco);
> > 
> 
> I don't like the void pointer here. However, "cache.h" includes "convert.h" and
> therefore "convert.h" cannot include "cache.h". That's why "convert.h" doesn't
> know about "struct delayed_checkout". 

You can forward declare the struct without fields in convert.h:

diff --git a/convert.h b/convert.h
index da6c702090..3fb6b420b2 100644
--- a/convert.h
+++ b/convert.h
@@ -32,6 +32,8 @@ enum eol {
 #endif
 };
 
+struct delayed_checkout;
+
 extern enum eol core_eol;
 extern const char *get_cached_convert_stats_ascii(const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
@@ -44,7 +46,7 @@ extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int async_convert_to_working_tree(const char *path, const char *src,
 					 size_t len, struct strbuf *dst,
-					 void *dco);
+					 struct delayed_checkout *dco);
 extern int async_query_available_blobs(const char *cmd, unsigned long **delay_ids,
 				       int *delay_ids_nr);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,

> 
> I just realized that I could move "struct delayed_checkout" and "enum ce_delay_state"
> definition from "cache.h" to "convert.h" to solve the problem nicely.
> 

But yeah, maybe you can reduce cache.h size, too :)

> Any objection to this approach?
> 
