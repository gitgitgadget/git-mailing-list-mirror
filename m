Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2722022D
	for <e@80x24.org>; Sat, 25 Feb 2017 10:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdBYKCp (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 05:02:45 -0500
Received: from mout.web.de ([217.72.192.78]:61319 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751419AbdBYKCo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 05:02:44 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbJ02-1c2Uvc3zBa-00ktaO; Sat, 25
 Feb 2017 11:02:31 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1_file: release fallback base's memory in unpack_entry()
Message-ID: <fe07ed70-0b93-8b2c-59f9-967d3dc1313f@web.de>
Date:   Sat, 25 Feb 2017 11:02:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:1ppVNaB8+tNiFVLbrp28WTFUzXAk9zyT9Hv7Z8xmTT4pmC9j2F2
 ULQon8BHIki7fOM4nl2OURwGxfULA4kRAoFuKHfUZY1AoXKlWsnzjRUVMMxxuVQLWWY7j39
 J+3C4cOR1xye1lCgORIrgzNk6zUHR7DCOzW53nMIAbAayf+2bQFUBpzxatQdHniyzikxXuU
 +gxGbCyBC7iTKkReHQ+ZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LOVv+ATGlw4=:+M4r83XolaXV399sTUeaUS
 HFuhhiXQwOs9AnDlFyVav0XOs+5RTq6DgbTzc/MWQR+hbx604+4jkuYAxKpAaaDE/cBNe+Z95
 Wke4HtsUNhwOCnJln/d5fBy0FRtXZ/zVQdnQ3xWa/GXNtLsw43YdPZRLkPWgZE1bi5Ji09x19
 3D8GsA4+6+kXNytX4caEPWUp5999TkkF63oYKxGKrCX37uIVVTeKOIk7gXe1stzkIkyiJwdek
 g/b2Cvf/wrd5bsUViHzeAMRNOuBEiNYG5bsZN05wUhBTZhdxHGc7nfQilSV43VHeKSAVubyGs
 d7Va2mgw+vt1pA8BQfSFrNzlQnvcEArUqgJd2zDqoFYFHpHl9CegoG/WZkJqQ0249NW1rCjQj
 WblE+XnwfwwUmQZ/wuUDOEMBC5had/S3w8tPvY/41NAHqZiqfGjh37sofI5PHzTDKLTZlYBjn
 G/JReXCHz0XSw6kBX0DFMOIclJwvYCY7rWyL7yC13unXzcYfUyEM/6mp08Xi63AcCOvuGxqUG
 MY0TV2R6Tgcf0yZrs/tipBaXYHo24pnD0XskhN0EX+Ts2vMWgJZ6iPX5T/EAbP206FA+vDFCZ
 hFKjAKGRaqzeZicIT8FLVB/QXJwoeRYuEIpcW7qDt4rW38ZrEvj5hUj8AeVN//fpH0PMvDdTY
 HVfPDoN3K9MG9/qUiMzdvg4endjFZwRMYyfAIC1/Y2dZRPeGjX3NIUJhp3A2waqiux3w3F92n
 cTJv9QYUvGsIJ+5PAzpv/kAzgJK6kdfNuMJCc8dK/w4VgAdTFhHwjVczD1byuv1wSChtvcans
 yoAfvu+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a pack entry that's used as a delta base is corrupt, unpack_entry()
marks it as unusable and then searches the object again in the hope that
it can be found in another pack or in a loose file.  The memory for this
external base object is never released.  Free it after use.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index ec957db5e1..8ce80d4481 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2532,6 +2532,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	while (delta_stack_nr) {
 		void *delta_data;
 		void *base = data;
+		void *external_base = NULL;
 		unsigned long delta_size, base_size = size;
 		int i;
 
@@ -2558,6 +2559,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, base_sha1);
 				base = read_object(base_sha1, &type, &base_size);
+				external_base = base;
 			}
 		}
 
@@ -2576,6 +2578,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 			      "at offset %"PRIuMAX" from %s",
 			      (uintmax_t)curpos, p->pack_name);
 			data = NULL;
+			free(external_base);
 			continue;
 		}
 
@@ -2595,6 +2598,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 			error("failed to apply delta");
 
 		free(delta_data);
+		free(external_base);
 	}
 
 	*final_type = type;
-- 
2.12.0

