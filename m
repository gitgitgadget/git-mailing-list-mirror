Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2061F790
	for <e@80x24.org>; Tue,  2 May 2017 16:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750717AbdEBQBn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:01:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:52117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdEBQBk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:01:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVedf-1da97Z0WGV-00YvNj; Tue, 02
 May 2017 18:01:26 +0200
Date:   Tue, 2 May 2017 18:01:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 05/25] git_config_rename_section_in_file(): avoid resource
 leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <ff873d8c56a5cff786c9964fef71089d3f5e5e59.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+Ne0veg/uGuWtyiWXdvGAOypGPbOHvYkV8TcVXXETzq59NKSe9Y
 Rs3qUhFzW8qY4OjH2gnQAUaITCk9K4fBdvL4hmii/0oGAkw1mfK6Hdb8XRQVDqRIX6xB08Y
 w4sBo1w99Hv5tgmcipJBYfDvyU4p2J0xoVEHL+kg8umWdl6v/Nk2tSA4cwHLzC51snRTNc+
 Lgkj5HqE37O1RnceUysYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vuQussmBcJU=:iGkaMQz01T5l5LlU+uzTRj
 gYk5Mv2soaxrBILeNsXk1xCuOrM6DflTFt1vkN4IE2I1RUvPw9FP0DsVwKu8XRK6A9HoHTEs4
 ThLvNuQethzZ2yu2MbTB191kl6Cg8jyTVMXYQIp4cKdJV27R3jnOTBg+28H7yJU+euRVoWOA2
 pYf+fAz0IlfPBg328+gL1H8MyPc4uPpgU6lEbz3fIwYQ4RWZ563I/u67ort0HURTOvtDpuMgc
 XeSsmAWmV6cWEeGBu19G8qigpR0e0nb0uANCtaYfy3spAihvPB2lkQqIKTj+M8MxZuM78KHax
 4hNUfI8Z9QLcTwHiLtiHRwHOBOSW4hUMFWLpd0wW+Q2+FF0EEmSqhnnk14h+0LImsWEfgw3N7
 s/ZrUTrcMtVrrF+UL/XNhYivCi6z7jXJhN1aS9S8/G9Kwxjdk36VlwAOFtORQ1uZ2vnqKBFjl
 KoLwQVszqpd2/Hf8afTzTw/Z0nPOLov1IQBZQcmh8KTdIGrBkBIXSfGDgAGJiUBYS//f/UFuZ
 mHTet5RkspYrzVMgxdkvc4a0/npBwIFP7Z3nNNHcEZ4e8ejMhmNwHYtnDRljllSU/PiXkvdk+
 efrs7sCLpbCbnQOAZZxYf0i922QCaW1yjunYbVSMTAnwTHxq0U/SEsuhHiKhLW6O5Y9mBkUhC
 kMviE/TKwYNAQ7Jdu1umSBBXDcPDEaUGpBKaSlht1MGapbmeJDocdmD1WJ3ZMjZKfPWvRNs/9
 Nzppi4Mbyx/icn9jQMudKXGwaShdpz2KgufBXmLzhaAfbN4DgiqTzPYIx/z4YrL5h+e8KQIrG
 E5mgdgQ
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


