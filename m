Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C35202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 22:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdKDWqH (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 18:46:07 -0400
Received: from ikke.info ([178.21.113.177]:43566 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751463AbdKDWqG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 18:46:06 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 1EBE8440809; Sat,  4 Nov 2017 23:46:05 +0100 (CET)
Received: from epsilon.home (unknown [10.8.0.22])
        by vps892.directvps.nl (Postfix) with ESMTP id 0304C440803;
        Sat,  4 Nov 2017 23:46:03 +0100 (CET)
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: Re: [PATCH v1 1/2] refs: extract function to normalize partial refs
Date:   Sat,  4 Nov 2017 23:45:11 +0100
Message-Id: <20171104224511.22609-1-me@ikke.info>
X-Mailer: git-send-email 2.15.0.rc2.57.g2f899857a9
In-Reply-To: <xmqqo9oiok10.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 04, 2017 at 11:27:39AM +0900, Junio C Hamano wrote:
> I however notice that addition of /* to the tail is trying to be
> careful by using strbuf_complete('/'), but prefixing with "refs/"
> does not and we would end up with a double-slash if pattern begins
> with a slash.  The contract between the caller of this function (or
> its original, which is for_each_glob_ref_in()) and the callee is
> that prefix must not begin with '/', so it may be OK, but we might
> want to add "if (*pattern == '/') BUG(...)" at the beginning.
>
> I dunno.  In any case, that is totally outside the scope of this two
> patch series.

I do think it's a good idea to make future readers of the code aware of
this contract, and adding a BUG assert does that quite well. Here is a
patch that implements it.

This applies of course on top of this patch series.

-- >8 --
Subject: [PATCH] normalize_glob_ref: assert implicit contract of prefix

normalize_glob_ref has an implicit contract of expecting 'prefix' to not
start with a '/', otherwise the pattern would end up with a
double-slash.

Mark it as a BUG when the prefix argument of normalize_glob_ref starts
with a '/' so that future callers will be aware of this contract.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index e9ae659ae..6747981d1 100644
--- a/refs.c
+++ b/refs.c
@@ -372,6 +372,8 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 void normalize_glob_ref(struct strbuf *normalized_pattern, const char *prefix,
 		const char *pattern, int flags)
 {
+	if (prefix && *prefix == '/') BUG("prefix cannot not start with '/'");
+
 	if (!prefix && !starts_with(pattern, "refs/"))
 		strbuf_addstr(normalized_pattern, "refs/");
 	else if (prefix)
-- 
2.15.0.rc2.57.g2f899857a9

