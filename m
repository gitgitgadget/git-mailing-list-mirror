Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336E31FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 15:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbcLHPg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:36:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:59734 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932173AbcLHPgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:25 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmOLO-1cotir0Aks-00ZuSI; Thu, 08
 Dec 2016 16:36:11 +0100
Date:   Thu, 8 Dec 2016 16:36:09 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC 2/7] read_early_config(): avoid .git/config hack when
 unneeded
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Message-ID: <ac26b262fa2429897064118bcbe6b80847556b1b.1481211338.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6Sn1jMTWl9Qztel9F4vRTJLYjWikqoJ8WM0yu3DhDHxPYT4P9uz
 TpAT2wq/P9Iwep6PIScY5w6g7rx8WnBpQcxqonPk6TadJ74mR+o6Dk3RHxmFBafwLXf/Slj
 pMX7sMTSQJGrYrJ5aRc5J5iRxMY4awXNVUWyiROTAnPc92iGRMOUP3mJFL91pxVpRIbyFhK
 pytjJM4y9PcVwLZAYlFXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oyFJy5+TLLs=:wc3W/pHQszUJgvVUSdbm5H
 i037mYMpYRoI4A6Uvt3JDw3gFHANBxRsv9Zgitu7Y/ZS26iBn5CagIsf4JGiUYfcQo4SOW8XR
 Mh79uwZ8vRHb9VRfa8lWQVX7tGjIqkygD2iwGWhxY2mIIHokZ7CKl1fCCcjo78b9ohAlVG+sz
 mQ2+1S5VXFiyY9/XGE9wwJJLZPmUuTFp3J+g/gfFlG2OnOMyKqkXl6O4QPYsJUTj7Ap6sd10q
 ukxhFIpAQyTziE0FJXgcyKuEJ7sLEfKX+GH5WU4iiBg9r1NT/SEMBwrDn3Vq2j/sCsoLIoHv8
 pHmXmxksPBMQsaH5YQXmuaFgphNWeIdmWlRSainPDphyEf3XJ8CH2n/vjcvlJsDJH4F+1o0ij
 tDRpMTxybt5cCBJg+Q6Hn9ePsVR86AWrKPHghFYAl35mDOD0ZlKs8ElBgX3422p2a9z4lTWcp
 IVcagHlWpZGuZTfdK7IENRTHD3y7LTYQs5/qE7bamUwYFtAo8VPkcYD29HIWiQShpVMnW0/DZ
 cpxXwDH7oNKY8a6NfGr75AIs09wrmgPWuCKcCJA9iMe+S2LsYKHEpBKoBwvWuvLAB246xzrAV
 FZ3eGVLVDr3Kg1VVWcZnhzDaECQykx26oqKXPR6Y58XurbliLvUM4Fl7/uN15NYvFMpWo9hrQ
 5/NuyaexRMcwd3NFMN8mWzCRIRk93wfLQtgeHudc8Ku/4Mp+5RfZPJ/oQTVyl9fivE/4DSSah
 JpOxPcO4rYFX4y8N4qgNIUOiL0U4a2aVdxW38fo4KXiMhUK+Xf9UFYxY86WU3iHmqL2geIa8a
 e71qTRt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far, we only look whether the startup_info claims to have seen a
git_dir.

However, do_git_config_sequence() (and consequently the
git_config_with_options() call used by read_early_config() asks the
have_git_dir() function whether we have a .git/ directory, which in turn
also looks at git_dir and at the environment variable GIT_DIR.

Let's just use the same function, have_git_dir(), to determine whether we
have to look for .git/config specifically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 7dcd8d8622..104c3c3dcd 100644
--- a/config.c
+++ b/config.c
@@ -1407,7 +1407,7 @@ void read_early_config(config_fn_t cb, void *data)
 	 * valid repository), and would rarely make things worse (i.e., you do
 	 * not generally have a .git/config file sitting around).
 	 */
-	if (!startup_info->have_repository) {
+	if (!have_git_dir()) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
-- 
2.11.0.rc3.windows.1


