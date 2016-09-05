Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345FF1FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbcIEPpM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 11:45:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:55509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbcIEPpL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 11:45:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LmbZb-1b7sB605tT-00aHaS; Mon, 05 Sep 2016 17:45:07
 +0200
Date:   Mon, 5 Sep 2016 17:45:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
In-Reply-To: <cover.1473090278.git.johannes.schindelin@gmx.de>
Message-ID: <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y60bjxEJDtMgCLGkTYsXGIYFFr8xqFg4htod07n1XUiF/mC0tom
 zX4TvbQx7OzHCriwbrmzcbct353oCiw+XVjwIQzZiLrSxLdqOhbeKtsPXVLtdPcOfmTc4j7
 +53kE8RYMZj8WGkS5rTDF+us8x8c9LNbrK1PqD4IqxIORXr0kZ0QEoc7gl2NqnEf8gt7AWK
 rS4jt3hizI6Wjd8wwl2og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8j/tSh/xuLA=:pTIeWQP+hGPaNvk9Vvf5+z
 HS8mRryqE7Y6ol4wowR9LJjZWEQvDngE6p4cm2/NMJsh+3sxVN9xsHxGh1lYHhlp05F/3SKbm
 rds3L706+V6gFTw7bcwAPVQNe3l+rz1Ibd4D8Ko3gcM7mdP8w/ImlaalPMUIOLIl2dMEVBg+q
 /RUkjtZ9HP4ISZJ8XigjeCoKjzxYYn42dvXqNQZaXOWlf+jDZ04tlhdfKrpBkyJqvL3kgzy4+
 Q6nQ7u7a+pP0bzNvN8Rjlgl0GHdOX0TPo+nR/tBFBKk+Ux7Trnz5Xdac74v03dwXlsXSTZH2J
 xRJWkDETAODamWhz9htFIh+SSWn50edL2zK/ZA/YiQjUWCmSLHTLYYU1jvCNOLONFXT+4Gw95
 r6sMje3Ep9zR4lRRLa0bPoDa2V8tDo5miszHFljNJOq+WGLmNv6UceJYgLyYPQvlrQMY19yHk
 65sKzFk0NgX+YM3+WBaiDBqu+g6xbAzf/JQBitA6Jh7JC1J78H0CubD49zBs7zHsfe3IMU7aW
 TFyZ5qUuDmKTLm/BiEMUzHGaEApQEYPPaoNm156sNmw3db+i+9z8dUXiYkbuhjvcfZ8XrIbMr
 qhAwffDoTb4XUHWoH33ONefntRqWNbjWqxhhKbCY36XV1P3TCLSxA29HioXqbI0b/Kk+aQ1OE
 ADAzVBuEFX9qFzvvjBXxGqkNY35hXpQk3LdG4xIvtLnWT2n7O7Rl8jmNe7GnH0nGSZSP8ZyB0
 +Ut5AznoPX6X7UqN8W6AxegJJ77jv2UkqpQ9KjzvFxLaC8VCjvxd3JgZK8CpL3vrReg5G5CNQ
 zkLF1j4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the xdiff machinery is quite capable of working with strings given
as pointer and size, Git's add-on functionality simply assumes that we
are operating on NUL-terminated strings, e.g. y running regexec() on the
provided pointer, with no way to pass the size, too.

In general, this assumption is wrong.

It is true that many code paths populate the mmfile_t structure silently
appending a NUL, e.g. when running textconv on a temporary file and
reading the results back into an strbuf.

The assumption is most definitely wrong, however, when mmap()ing a file.

Practically, we seemed to be lucky that the bytes after mmap()ed memory
were 1) accessible and 2) somehow contained NUL bytes *somewhere*.

In a use case reported by Chris Sidi, it turned out that the mmap()ed
file had the precise size of a memory page, and on Windows the bytes
after memory-mapped pages are in general not valid.

This patch works around that issue, giving us time to discuss the best
course how to fix this problem more generally.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/diff.c b/diff.c
index 534c12e..32f7f46 100644
--- a/diff.c
+++ b/diff.c
@@ -2826,6 +2826,15 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 			s->data = strbuf_detach(&buf, &size);
 			s->size = size;
 			s->should_free = 1;
+		} else {
+			/* data must be NUL-terminated so e.g. for regexec() */
+			char *data = xmalloc(s->size + 1);
+			memcpy(data, s->data, s->size);
+			data[s->size] = '\0';
+			munmap(s->data, s->size);
+			s->should_munmap = 0;
+			s->data = data;
+			s->should_free = 1;
 		}
 	}
 	else {
-- 
2.10.0.windows.1.2.g732a511


