From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] read-cache.c: fix index memory allocation
Date: Mon, 24 Oct 2011 03:01:27 +0200
Message-ID: <4EA4B8E7.5070106@lsrfire.ath.cx>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr> <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx> <20111023162944.GB28156@sigill.intra.peff.net> <4EA453D3.7080002@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Oct 24 03:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RI8v6-0001yl-09
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 03:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1JXBBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 21:01:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:60130 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab1JXBBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 21:01:34 -0400
Received: from [192.168.2.104] (p4FFD9D8D.dip.t-dialin.net [79.253.157.141])
	by india601.server4you.de (Postfix) with ESMTPSA id BA2DC2F8042;
	Mon, 24 Oct 2011 03:01:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4EA453D3.7080002@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184148>

estimate_cache_size() tries to guess how much memory is needed for the
in-memory representation of an index file.  It does that by using the
file size, the number of entries and the difference of the sizes of the
on-disk and in-memory structs -- without having to check the length of
the name of each entry, which varies for each entry, but their sums are
the same no matter the representation.

Except there can be a difference.  First of all, the size is really
calculated by ce_size and ondisk_ce_size based on offsetof(..., name),
not sizeof, which can be different.  And entries are padded with 1 to 8
NULs at the end (after the variable name) to make their total length a
multiple of eight.

So in order to allocate enough memory to hold the index, change the
delta calculation to be based on offsetof(..., name) and round up to
the next multiple of eight.

On a 32-bit Linux, this delta was used before:

	sizeof(struct cache_entry)        == 72
	sizeof(struct ondisk_cache_entry) == 64
	                                    ---
	                                      8

The actual difference for an entry with a filename length of one was,
however (find the definitions are in cache.h):

	offsetof(struct cache_entry, name)        == 72
	offsetof(struct ondisk_cache_entry, name) == 62

	ce_size        == (72 + 1 + 8) & ~7 == 80
	ondisk_ce_size == (62 + 1 + 8) & ~7 == 64
	                                      ---
	                                       16

So eight bytes less had been allocated for such entries.  The new
formula yields the correct delta:

	(72 - 62 + 7) & ~7 == 16

Reported-by: John Hsing <tsyj2007@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 read-cache.c            |    6 ++--
 t/t7510-status-index.sh |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 3 deletions(-)
 create mode 100755 t/t7510-status-index.sh

diff --git a/read-cache.c b/read-cache.c
index 01a0e25..5790a91 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1249,9 +1249,9 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 
 static inline size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
 {
-	long per_entry;
-
-	per_entry = sizeof(struct cache_entry) - sizeof(struct ondisk_cache_entry);
+	size_t fix_size_mem = offsetof(struct cache_entry, name);
+	size_t fix_size_dsk = offsetof(struct ondisk_cache_entry, name);
+	long per_entry = (fix_size_mem - fix_size_dsk + 7) & ~7;
 
 	/*
 	 * Alignment can cause differences. This should be "alignof", but
diff --git a/t/t7510-status-index.sh b/t/t7510-status-index.sh
new file mode 100755
index 0000000..bca359d
--- /dev/null
+++ b/t/t7510-status-index.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='git status with certain file name lengths'
+
+. ./test-lib.sh
+
+files="0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z"
+
+check() {
+	len=$1
+	prefix=$2
+
+	for i in $files
+	do
+		: >$prefix$i
+	done
+
+	test_expect_success "status, filename length $len" "
+		git add $prefix* &&
+		git status
+	"
+	rm $prefix* .git/index
+}
+
+check  1
+check  2 p
+check  3 pr
+check  4 pre
+check  5 pref
+check  6 prefi
+check  7 prefix
+check  8 prefix-
+check  9 prefix-p
+check 10 prefix-pr
+check 11 prefix-pre
+check 12 prefix-pref
+check 13 prefix-prefi
+check 14 prefix-prefix
+check 15 prefix-prefix-
+check 16 prefix-prefix-p
+check 17 prefix-prefix-pr
+check 18 prefix-prefix-pre
+check 19 prefix-prefix-pref
+check 20 prefix-prefix-prefi
+check 21 prefix-prefix-prefix
+check 22 prefix-prefix-prefix-
+check 23 prefix-prefix-prefix-p
+check 24 prefix-prefix-prefix-pr
+
+test_done
-- 
1.7.7
