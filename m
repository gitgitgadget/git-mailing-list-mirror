Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51CD220899
	for <e@80x24.org>; Thu, 10 Aug 2017 09:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbdHJJmb (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 05:42:31 -0400
Received: from mout.web.de ([217.72.192.78]:57176 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbdHJJma (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 05:42:30 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNjo-1dJrVY2eTQ-00mXYG; Thu, 10
 Aug 2017 11:42:24 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1_file: release delta_stack on error in unpack_entry()
Message-ID: <79879fc4-c0e4-219d-2ed9-683a23c78840@web.de>
Date:   Thu, 10 Aug 2017 11:42:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JdRTh05LvtGb1tAzhmBLAv05vvk9e42wZbyzzL8htFGGQio4XwR
 duCWdKsS31BSNg0ge1j1B/aCIzGYymha8X0Lb46u8bWrZMupJgwMDohUYSsvEDZ9kQlJ0Y/
 B8pZy3FjRr/WOchK0zMmBNx6Cc7sONPljaUOl5AiwLKvOVnFFxpNa12AA5sJnPHzAaqRdwb
 pDM8nJP+uR3z2s6NBThNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jgx9WoVoUQ4=:+l0AHkMU07f+wpHfvetXvY
 D31K1W0FtCojcwG8Y0ecoU33n2wp6r+4dbAfvJCuwRJJEUWcQMjiJljIlYQLr5MaIlk9GOjtW
 3ufVdHOx9vT7PsqL/AROBT8/gp1vDTMlbA9ZAy+cItUIJO+UxKVskvbsIwcRSsv7Fh0D/z+/+
 lwhIspSmMxWgjKdEB7GjbEueBPQcFUYlrCfaUOKiv3boomZTmjUXkaISTvxDi5eLvvRJUHlsn
 Q7wRTgxXH3M5xaonineJABf2Cu2BbQFi7ZmHH0MWFARYbbimprR9cWzBfU7ScqY4Zr/i9fFUv
 ZAdcL3KTZhVAxPf/IIRL+0GtNe+nyZ3IxgqZfIuBQIWk5+mD6cmMLa3t0Ph4CgsCRh7vTU4XO
 LwaVTNAtvM5+k4h1wXpFJpvDsIBWD0bwKp8Mf4ldkE8VZkx/kf6qi8g8bSLb+X126GxVaP7zK
 sII3mmrCSz/H/Eq+gBBU3aHePPqp3FZd/OpLnqrd7WTqqywP/0/z3kvQPG+utsjXJmy0iooOE
 CTl0D4fJHFxxWnh8S9cO1gX9oL1tJLOWwaoBbaAyb1cop3isdFgOmtLvWbyQTmbdQWTgolOsa
 cV66BHYnjSXAOj01sBw2uUK2gbYSHf9TEK3HK4RZlGwu7b/VdEJzaGj+nNMhk9Te8JczoS6Xj
 A+E6LtPI7hg0RHw/vrVYp9JpfaFny7LrZxJTWPvN6PZd3qjRqjOYxmzXO5moGsDkkRfxLC4FY
 ENb1PHVDk+9nWGzo3LUhwIbLDSwaU2TSF0QVC2vmFI9ms4oSxtVU3c5j3yoec3WXtKIP79zMB
 xl0nlIYq7LmQLZ/Ffj00lnOWsd4JSOsPXDeb+HDqxe0GZ+/gn8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When unpack_entry() encounters a broken packed object, it returns early.
It adjusts the reference count of the pack window, but leaks the buffer
for a big delta stack in case the small automatic one was not enough.
Jump to the cleanup code at end instead, which takes care of that.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b60ae15f70..b7bb38b445 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2542,8 +2542,8 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 				error("bad packed object CRC for %s",
 				      sha1_to_hex(sha1));
 				mark_bad_packed_object(p, sha1);
-				unuse_pack(&w_curs);
-				return NULL;
+				data = NULL;
+				goto out;
 			}
 		}
 
@@ -2681,6 +2681,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	if (final_size)
 		*final_size = size;
 
+out:
 	unuse_pack(&w_curs);
 
 	if (delta_stack != small_delta_stack)
-- 
2.14.0
