Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB4F207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755331AbdEDN4I (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:56:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:57417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755290AbdEDN4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:56:05 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeeNW-1dr7VR0Exy-00qS3z; Thu, 04
 May 2017 15:55:43 +0200
Date:   Thu, 4 May 2017 15:55:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 05/25] git_config_rename_section_in_file(): avoid resource
 leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <9f1b809e84b1f175d1c56e58c53c785faab79ae2.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oypYIOHIuuk4g64oLmTQy3J2UUvC7ePo3Iatve4ZT6fvnU7HUji
 QZSlD7/PIc8zWD+js3hXEYg5a+/xNbxr9EgQ6wBQhQ7M1QxNUM+M3CRAMG+5Sb64iDvOMN+
 n+hNEef7FYqv6I9wQu+a5BYg5dZqX1bqIXdjCVIHc+BA4vs8wX6imKTJNPS2pNe+oVrp6H2
 7K2G0gBA/TXel80hDJ0GQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NaL/JAtGNHU=:cvuAfLshO+JUFqGkKLeBzG
 U1bJ8x/nbXuLHAGaF/pv2b3ozbkYsLKzqqUGOEE2Oyu+kK3g3Pvwi0pcoUXf/PrnLK5VHUVcm
 vCT/vyoQ0nPghRAag9hq0JtdvZzmH+b4+ofjdKYtD76+SeivCAO/V2VXAs6be8uVy3AgjnQDh
 QXF4/c3nUW3rNo7c2uZjCgsc0nxDJ7UbrqEIDVjxBQmi8P4GL1HsFbLSesofAEdF3/PRPL13/
 GXxfJtMPCHplnwopxb/upEp0paFgzsl4WxwalQMXVqyQ2Q7bEbnbi/VkKYgH0vUmRKeOsQ66J
 UVx9AZp04p/+A/wZMJkZQC2HEPSIzOXYknCQKHKvVLjSTXV3yVSl3AUA4yjPmoph5RXWkSqE+
 n+T1EINJbjvfdC83sXeP0msSQY8WUWivRloihuO9oe5wpBeyF4GAOMyRIXyi69C/gdOE/xvR0
 sitHhQdEC3bg7LWV4EOXA+OgRClHgfD+CESnegvOJGGKkb93bU0OHEzF8/kcmPHsJj6LzG31B
 IUFjq0QcnAXGHTOUd0bpKAhZ9lnGgn5ZeMBvoTj3eJHZeP3xOT+sHs7+PwbcrcDAZEQ5WF0vK
 3/6H/ZfdYdGY0utm1Lz9hFQXM5yxf1ZHxoQ6Gw2zemAuEmTHOHsbNqOkFUQYORf3SwKhOvFDB
 vt5K85axgvqW2IpdNH1OeyePlZFsSG1uY9hHphXWNA+Ml0XE2fd7J3ZoHYjVfU20ETqZsy5WW
 NHgBv0256IprST/dfHXS2ZsrdtYzAttzvV7wnWmCPYcc5GSMHQfjbLTkRQcCds+eR3P0CRx43
 F5Zg5VJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case of errors, we really want the file descriptor to be closed.

Discovered by a Coverity scan.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index b4a3205da32..a30056ec7e9 100644
--- a/config.c
+++ b/config.c
@@ -2621,7 +2621,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	struct lock_file *lock;
 	int out_fd;
 	char buf[1024];
-	FILE *config_file;
+	FILE *config_file = NULL;
 	struct stat st;
 
 	if (new_name && !section_name_is_ok(new_name)) {
@@ -2703,11 +2703,14 @@ int git_config_rename_section_in_file(const char *config_filename,
 		}
 	}
 	fclose(config_file);
+	config_file = NULL;
 commit_and_out:
 	if (commit_lock_file(lock) < 0)
 		ret = error_errno("could not write config file %s",
 				  config_filename);
 out:
+	if (config_file)
+		fclose(config_file);
 	rollback_lock_file(lock);
 out_no_rollback:
 	free(filename_buf);
-- 
2.12.2.windows.2.800.gede8f145e06


