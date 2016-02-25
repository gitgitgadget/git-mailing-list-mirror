From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] t5313: test bounds-checks of corrupted/malicious
 pack/idx files
Date: Thu, 25 Feb 2016 20:12:58 +0100
Message-ID: <56CF523A.8050208@kdbg.org>
References: <20160225142004.GA17678@sigill.intra.peff.net>
 <20160225142112.GA17811@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jacek Wielemborek <d33tah@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 20:13:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1LY-000309-0s
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933514AbcBYTND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:13:03 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:29104 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933417AbcBYTNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:13:02 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qB3fg2Yyxz5tlB;
	Thu, 25 Feb 2016 20:12:59 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id A5786520F;
	Thu, 25 Feb 2016 20:12:58 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160225142112.GA17811@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287418>

Am 25.02.2016 um 15:21 schrieb Jeff King:
> +munge () {
> +	printf "$3" | dd of="$1" bs=1 conv=notrunc seek=$2
> +}

Instead of adding another call of dd, would it be an option to insert
the following patch at the front of this series and then use
test_overwrite_bytes?

---- 8< ----
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] tests: overwrite bytes in files using a perl script instead of dd

The dd in my build environment on Windows crashes unpredictably. Work it
around by rewriting most instances with a helper function that uses perl
behind the scenes.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t1060-object-corruption.sh          |  2 +-
 t/t5300-pack-object.sh                |  8 ++++----
 t/t5302-pack-index.sh                 |  5 +++--
 t/t5303-pack-corruption-resilience.sh |  2 +-
 t/test-lib-functions.sh               | 16 ++++++++++++++++
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 3f87051..e3c5de8 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -12,7 +12,7 @@ obj_to_file() {
 corrupt_byte() {
 	obj_file=$(obj_to_file "$1") &&
 	chmod +w "$obj_file" &&
-	printf '\0' | dd of="$obj_file" bs=1 seek="$2" conv=notrunc
+	printf '\0' | test_overwrite_bytes "$obj_file" "$2"
 }
 
 test_expect_success 'setup corrupt repo' '
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index fc2be63..f45a101 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -226,7 +226,7 @@ test_expect_success \
 test_expect_success \
     'verify-pack catches a corrupted pack signature' \
     'cat test-1-${packname_1}.pack >test-3.pack &&
-     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
+     echo | test_overwrite_bytes test-3.pack 2 &&
      if git verify-pack test-3.idx
      then false
      else :;
@@ -235,7 +235,7 @@ test_expect_success \
 test_expect_success \
     'verify-pack catches a corrupted pack version' \
     'cat test-1-${packname_1}.pack >test-3.pack &&
-     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
+     echo | test_overwrite_bytes test-3.pack 7 &&
      if git verify-pack test-3.idx
      then false
      else :;
@@ -244,7 +244,7 @@ test_expect_success \
 test_expect_success \
     'verify-pack catches a corrupted type/size of the 1st packed object data' \
     'cat test-1-${packname_1}.pack >test-3.pack &&
-     echo | dd of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
+     echo | test_overwrite_bytes test-3.pack 12 &&
      if git verify-pack test-3.idx
      then false
      else :;
@@ -255,7 +255,7 @@ test_expect_success \
     'l=$(wc -c <test-3.idx) &&
      l=$(expr $l - 20) &&
      cat test-1-${packname_1}.pack >test-3.pack &&
-     printf "%20s" "" | dd of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
+     printf "%20s" "" | test_overwrite_bytes test-3.idx $l &&
      if git verify-pack test-3.pack
      then false
      else :;
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index c2fc584..5a82f19 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -225,8 +225,9 @@ test_expect_success \
      obj=$(git hash-object file_001) &&
      nr=$(index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj) &&
      chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
-     printf xxxx | dd of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
-        bs=1 count=4 seek=$((8 + 256 * 4 + $(wc -l <obj-list) * 20 + $nr * 4)) &&
+     printf xxxx |
+		test_overwrite_bytes ".git/objects/pack/pack-${pack1}.idx" \
+			$((8 + 256 * 4 + $(wc -l <obj-list) * 20 + $nr * 4)) &&
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
        done <obj-list ) &&
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 5940ce2..9d2e437 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -51,7 +51,7 @@ do_corrupt_object() {
     ofs=$(git show-index < ${pack}.idx | grep $1 | cut -f1 -d" ") &&
     ofs=$(($ofs + $2)) &&
     chmod +w ${pack}.pack &&
-    dd of=${pack}.pack bs=1 conv=notrunc seek=$ofs &&
+    test_overwrite_bytes "${pack}.pack" "$ofs" &&
     test_must_fail git verify-pack ${pack}.pack
 }
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index ec6125d..f7ba047 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -880,6 +880,22 @@ test_skip_or_die () {
 	esac
 }
 
+# Overwrite bytes at an offset in a file
+# $1 ... the file to modify
+# $2 ... byte offset into file
+# stdin ... new bytes
+test_overwrite_bytes () {
+	perl -e '
+		$fname = shift @ARGV;
+		$offset = shift @ARGV;
+		$bytes = <>;
+		open my $fh, "+<", $fname	or die "open $fname: $!\n";
+		seek($fh, $offset, 0)		or die "seek $fname: $!\n";
+		syswrite($fh, $bytes)		or die "write $fname: $!\n";
+		close $fh			or die "close $fname: $!\n";
+	' "$@"
+}
+
 # The following mingw_* functions obey POSIX shell syntax, but are actually
 # bash scripts, and are meant to be used only with bash on Windows.
 
-- 
2.7.0.118.g90056ae
