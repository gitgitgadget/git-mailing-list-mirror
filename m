From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 2/2] sha1-lookup: handle duplicates in sha1_pos()
Date: Wed, 01 Oct 2014 17:02:37 +0200
Message-ID: <542C178D.6070302@web.de>
References: <542C1711.6080609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:03:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZLRK-0006ec-3z
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 17:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbaJAPDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 11:03:34 -0400
Received: from mout.web.de ([212.227.15.4]:59130 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbaJAPDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 11:03:33 -0400
Received: from [192.168.178.27] ([79.250.168.13]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LhNaa-1Y4IU649Vg-00mabq; Wed, 01 Oct 2014 17:03:31
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <542C1711.6080609@web.de>
X-Provags-ID: V03:K0:KBKNTg7YpC+dK6snLATAFLHsvq/GJ8GYuYDyVfK7gG+xJXP1EWY
 BIAlBHkiN7hvnXftFIYSoJXl+bX0mR+/N/zmaQkZWunU22tnT6W03orVt1Db9lILwycDQ9g
 jOPeL+UYXfHXRto7xChS1ztiGeH76uT1ffXCm+sYFTcsLBLtoi8IA79+OqneHA3sufr42Mq
 E65PTz79uqkXeEAn45Hhw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257754>

If the first 18 bytes of the SHA1's of all entries are the same then
sha1_pos() dies and reports that the lower and upper limits of the
binary search were the same that this wasn't supposed to happen.  This
is wrong because the remaining two bytes could still differ.

Furthermore: It wouldn't be a problem if they actually were the same,
i.e. if all entries have the same SHA1.  The code already handles
duplicates just fine.  Simply remove the erroneous check.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1-lookup.c         |  2 --
 t/t0064-sha1-array.sh | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sha1-lookup.c b/sha1-lookup.c
index 2dd8515..5f06921 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -84,8 +84,6 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 				die("BUG: assertion failed in binary search");
 			}
 		}
-		if (18 <= ofs)
-			die("cannot happen -- lo and hi are identical");
 	}
 
 	do {
diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
index 3f26e11..dbbe2e9 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -71,4 +71,24 @@ test_expect_success 'lookup non-existing entry with duplicates' '
 	test "$n" -lt 0
 '
 
+test_expect_success 'lookup with almost duplicate values' '
+	{
+		echo "append 5555555555555555555555555555555555555555" &&
+		echo "append 555555555555555555555555555555555555555f" &&
+		echo20 lookup 55
+	} | test-sha1-array >actual &&
+	n=$(cat actual) &&
+	test "$n" -eq 0
+'
+
+test_expect_success 'lookup with single duplicate value' '
+	{
+		echo20 append 55 55 &&
+		echo20 lookup 55
+	} | test-sha1-array >actual &&
+	n=$(cat actual) &&
+	test "$n" -ge 0 &&
+	test "$n" -le 1
+'
+
 test_done
-- 
2.1.2
