Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3CC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B9E20727
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOSd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:33:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:47992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726191AbgEOSd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:33:57 -0400
Received: (qmail 26079 invoked by uid 109); 15 May 2020 18:33:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 18:33:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14175 invoked by uid 111); 15 May 2020 18:33:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 14:33:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 14:33:56 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 09/13] upload-pack: pass upload_pack_data to send_ref()
Message-ID: <20200515183356.GI3692649@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515100454.14486-10-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515100454.14486-10-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 12:04:50PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's pass that struct to send_ref(), so that
> this function, and the functions it calls, can use all the
> fields of the struct in followup commits.

OK, this is the natural consequence of the previous patch. We could make
use of data->writer, as below, but I don't think it buys us much.

I went looking for other things we could use from upload_pack_data, too.
It looks like some bits like stateless_rpc could be re-used.

-Peff

diff --git a/upload-pack.c b/upload-pack.c
index bc259f1713..7be81c479c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1068,7 +1068,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, &data->symref);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
+		packet_writer_write(&data->writer,
+			     "%s %s%c%s%s%s%s%s%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
@@ -1081,11 +1082,13 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
-		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_writer_write(&data->writer, "%s %s\n",
+				    oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
 	if (!peel_ref(refname, &peeled))
-		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+		packet_writer_write(&data->writer, "%s %s^{}\n",
+				    oid_to_hex(&peeled), refname_nons);
 	return 0;
 }
 
