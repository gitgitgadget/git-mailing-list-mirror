Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88AC2018E
	for <e@80x24.org>; Sat,  9 Jul 2016 14:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbcGIOrS (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 10:47:18 -0400
Received: from mout.web.de ([212.227.15.4]:54035 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbcGIOrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 10:47:17 -0400
Received: from [192.168.178.36] ([79.237.48.206]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LiFT1-1b0MLw1TgR-00nQ6r; Sat, 09 Jul 2016 16:47:07
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] rm: reuse strbuf for all remove_dir_recursively() calls
Message-ID: <57810E68.5040301@web.de>
Date:	Sat, 9 Jul 2016 16:47:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:QjNVhfxH3kSuwhZBbmY3QNA/sWBUlfPwGU5TH68ceMTfqIKoVru
 5ztlDJWxXxM0Kc8EC20cU9+XdkjS8yryACyuYIoCKfUwvBpEszIB+p/qyIAWaSKCKLFdOi9
 CY97M84bCqRCazN8QfqHZhq3XtBMjxOgBjt8OlnZgakSV8N6K+ClDJSomAc8NEX3pOQswl+
 kJ9NeelzoIcKh3KdOS6kg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:EujWPFGw++I=:InIl9ksKLRn3CTVAYQHvc3
 hFPL+XYzbUhuJqNAPxjqD27utxRONP7oRxYBpZlnuyB0dgsoLhWRXz0PUU6e7VcA8PKHT91TC
 L+ukVbuLsNB7VYENe3B5PetT5qK45IY8bmDbbqigdePv7td3BHavLGG50KIrO0jpN3/7DzWS5
 +tnIN/a9kaLcfgIRafX+Q0UokhDTSdo5GUfKbZOZRAhDQlAKEFFzCbl/Nmjwt8cYXyqHTAGWl
 zdjBi8QYSxsGzSW53u16T+6ostAwXVLK7nZ6Yg6CnDlehP7crzIE95X4X3Hwq+dfR3BugNnhC
 oQNlvoUJ4AbwUOAzM7b9KewqfdgTFinUFQDUJ0jjllVidA64jYaekxjYz7xb1HkL3SEagokrM
 BJkRetvXPStxqJiQHHd3qS/hovUW2pSCE0BrJS+WQ4Sk5KSlnIHdLRKN/c2rkjwmsYeepcejQ
 0tbRYDr0tbB1wHQHKc4ZoCzv2hOrmR1TecHITs5fVzFfP/Wwamc9vRmkpMMn1Vjolw0DSUVOs
 EIkHeOuGcuHwew7EEVLJWXzWt4rkSiSsJaosmLdt8K1vdaAAnD7GMycm8IjVzCjr0KbFUa+Ys
 5CxCbOtvbdUV8dbsyGzzXbUNdhf5TQanElEoeRSWJ7ag3cfVnO4wjsm9H2ihLVIC6aL8cOxLi
 TYSJG/6jARcpA5mxGAbwaj2CELUIOTpgyZ62xg8MHLVnql7RZbWqCZ/ItEYMcOiVe2mpagMjG
 pJiMZ40pFAAYYNehTDymyMCYxY5+a5OMg/O+n05CNRCbU+ABbpFuDIESTIIlO/a1+EYV6VIsF
 mbzj18O
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Don't throw the memory allocated for remove_dir_recursively() away after
a single call, use it for the other entries as well instead.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/rm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 8abb020..b2fee3e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -387,6 +387,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 */
 	if (!index_only) {
 		int removed = 0, gitmodules_modified = 0;
+		struct strbuf buf = STRBUF_INIT;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.entry[i].name;
 			if (list.entry[i].is_submodule) {
@@ -398,7 +399,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 						continue;
 					}
 				} else {
-					struct strbuf buf = STRBUF_INIT;
+					strbuf_reset(&buf);
 					strbuf_addstr(&buf, path);
 					if (!remove_dir_recursively(&buf, 0)) {
 						removed = 1;
@@ -410,7 +411,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 						/* Submodule was removed by user */
 						if (!remove_path_from_gitmodules(path))
 							gitmodules_modified = 1;
-					strbuf_release(&buf);
 					/* Fallthrough and let remove_path() fail. */
 				}
 			}
@@ -421,6 +421,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			if (!removed)
 				die_errno("git rm: '%s'", path);
 		}
+		strbuf_release(&buf);
 		if (gitmodules_modified)
 			stage_updated_gitmodules();
 	}
-- 
2.9.0

