From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t: use perl instead of "$PERL_PATH" where applicable
Date: Mon, 28 Oct 2013 21:23:03 -0400
Message-ID: <20131029012303.GC27738@sigill.intra.peff.net>
References: <20131029011859.GA22140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 02:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vay1a-00061j-7F
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 02:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab3J2BXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 21:23:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:57409 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751825Ab3J2BXH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 21:23:07 -0400
Received: (qmail 28991 invoked by uid 102); 29 Oct 2013 01:23:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 20:23:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 21:23:03 -0400
Content-Disposition: inline
In-Reply-To: <20131029011859.GA22140@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236882>

As of the last commit, we can use "perl" instead of
"$PERL_PATH" when running tests, as the former is now a
function which uses the latter. As the shorter "perl" is
easier on the eyes, let's switch to using it everywhere.

This is not quite a mechanical s/$PERL_PATH/perl/
replacement, though. There are some places where we invoke
perl from a script we generate on the fly, and those scripts
do not have access to our internal shell functions. The
result can be double-checked by running:

  ln -s /bin/false bin-wrappers/perl
  make test

which continues to pass even after this patch.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is noisy and optional on top of 2/3. We could also just fix up
cases as we see them going forward.

 t/gitweb-lib.sh                           | 2 +-
 t/lib-git-svn.sh                          | 4 ++--
 t/lib-terminal.sh                         | 4 ++--
 t/t0202-gettext-perl.sh                   | 4 ++--
 t/t1010-mktree.sh                         | 4 ++--
 t/t3300-funny-names.sh                    | 6 +++---
 t/t4014-format-patch.sh                   | 2 +-
 t/t4020-diff-external.sh                  | 2 +-
 t/t4029-diff-trailing-space.sh            | 2 +-
 t/t4103-apply-binary.sh                   | 4 ++--
 t/t4116-apply-reverse.sh                  | 4 ++--
 t/t4200-rerere.sh                         | 8 ++++----
 t/t5300-pack-object.sh                    | 8 ++++----
 t/t5303-pack-corruption-resilience.sh     | 4 ++--
 t/t5551-http-fetch.sh                     | 2 +-
 t/t6011-rev-list-with-bad-commit.sh       | 2 +-
 t/t6013-rev-list-reverse-parents.sh       | 4 ++--
 t/t7508-status.sh                         | 2 +-
 t/t9129-git-svn-i18n-commitencoding.sh    | 2 +-
 t/t9137-git-svn-dcommit-clobber-series.sh | 8 ++++----
 t/t9300-fast-import.sh                    | 2 +-
 t/t9350-fast-export.sh                    | 2 +-
 t/t9400-git-cvsserver-server.sh           | 2 +-
 t/t9401-git-cvsserver-crlf.sh             | 2 +-
 t/t9402-git-cvsserver-refs.sh             | 2 +-
 t/t9700-perl-git.sh                       | 4 ++--
 t/t9810-git-p4-rcs.sh                     | 2 +-
 t/test-lib-functions.sh                   | 6 +++---
 28 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 9e381e0..8cf909a 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -69,7 +69,7 @@ gitweb_run () {
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	"$PERL_PATH" -- "$SCRIPT_NAME" \
+	perl -- "$SCRIPT_NAME" \
 		>gitweb.output 2>gitweb.log &&
 	perl -w -e '
 		open O, ">gitweb.headers";
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index c5e55b1..b0ec12f 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -29,7 +29,7 @@ export svnrepo
 svnconf=$PWD/svnconf
 export svnconf
 
-"$PERL_PATH" -w -e "
+perl -w -e "
 use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
@@ -146,7 +146,7 @@ stop_httpd () {
 }
 
 convert_to_rev_db () {
-	"$PERL_PATH" -w -- - "$@" <<\EOF
+	perl -w -- - "$@" <<\EOF
 use strict;
 @ARGV == 2 or die "usage: convert_to_rev_db <input> <output>";
 open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 58d911d..737df28 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -19,7 +19,7 @@ test_expect_success PERL 'set up terminal for tests' '
 	then
 		:
 	elif
-		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl \
+		perl "$TEST_DIRECTORY"/test-terminal.perl \
 			sh -c "test -t 1 && test -t 2"
 	then
 		test_set_prereq TTY &&
@@ -29,7 +29,7 @@ test_expect_success PERL 'set up terminal for tests' '
 				echo >&4 "test_terminal: need to declare TTY prerequisite"
 				return 127
 			fi
-			"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
+			perl "$TEST_DIRECTORY"/test-terminal.perl "$@"
 		}
 	fi
 '
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
index 428ebb0..a29d166 100755
--- a/t/t0202-gettext-perl.sh
+++ b/t/t0202-gettext-perl.sh
@@ -12,7 +12,7 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
-"$PERL_PATH" -MTest::More -e 0 2>/dev/null || {
+perl -MTest::More -e 0 2>/dev/null || {
 	skip_all="Perl Test::More unavailable, skipping test"
 	test_done
 }
@@ -22,6 +22,6 @@ test_external_has_tap=1
 
 test_external_without_stderr \
     'Perl Git::I18N API' \
-    "$PERL_PATH" "$TEST_DIRECTORY"/t0202/test.pl
+    perl "$TEST_DIRECTORY"/t0202/test.pl
 
 test_done
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index df573c4..b946f87 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -42,13 +42,13 @@ test_expect_success 'ls-tree piped to mktree (2)' '
 '
 
 test_expect_success 'ls-tree output in wrong order given to mktree (1)' '
-	"$PERL_PATH" -e "print reverse <>" <top |
+	perl -e "print reverse <>" <top |
 	git mktree >actual &&
 	test_cmp tree actual
 '
 
 test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
-	"$PERL_PATH" -e "print reverse <>" <top.withsub |
+	perl -e "print reverse <>" <top.withsub |
 	git mktree >actual &&
 	test_cmp tree.withsub actual
 '
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 7480d6e..9a146f1 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -69,7 +69,7 @@ test_expect_success 'ls-files -z does not quote funny filename' '
 	tabs	," (dq) and spaces
 	EOF
 	git ls-files -z >ls-files.z &&
-	"$PERL_PATH" -pe "y/\000/\012/" <ls-files.z >current &&
+	perl -pe "y/\000/\012/" <ls-files.z >current &&
 	test_cmp expected current
 '
 
@@ -106,7 +106,7 @@ test_expect_success 'diff-index -z does not quote funny filename' '
 	tabs	," (dq) and spaces
 	EOF
 	git diff-index -z --name-status $t0 >diff-index.z &&
-	"$PERL_PATH" -pe "y/\000/\012/" <diff-index.z >current &&
+	perl -pe "y/\000/\012/" <diff-index.z >current &&
 	test_cmp expected current
 '
 
@@ -116,7 +116,7 @@ test_expect_success 'diff-tree -z does not quote funny filename' '
 	tabs	," (dq) and spaces
 	EOF
 	git diff-tree -z --name-status $t0 $t1 >diff-tree.z &&
-	"$PERL_PATH" -pe y/\\000/\\012/ <diff-tree.z >current &&
+	perl -pe y/\\000/\\012/ <diff-tree.z >current &&
 	test_cmp expected current
 '
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 8f272bc..73194b2 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -293,7 +293,7 @@ check_threading () {
 	(git format-patch --stdout "$@"; echo $? > status.out) |
 	# Prints everything between the Message-ID and In-Reply-To,
 	# and replaces all Message-ID-lookalikes by a sequence number
-	"$PERL_PATH" -ne '
+	perl -ne '
 		if (/^(message-id|references|in-reply-to)/i) {
 			$printing = 1;
 		} elsif (/^\S/) {
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 2e7d73f..8a30979 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -177,7 +177,7 @@ test_expect_success 'no diff with -diff' '
 	git diff | grep Binary
 '
 
-echo NULZbetweenZwords | "$PERL_PATH" -pe 'y/Z/\000/' > file
+echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
 
 test_expect_success 'force diff with "diff"' '
 	echo >.gitattributes "file diff" &&
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 36e2f07..3ccc237 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -27,7 +27,7 @@ test_expect_success \
      git config --bool diff.suppressBlankEmpty true &&
      git diff f > actual &&
      test_cmp exp actual &&
-     "$PERL_PATH" -i.bak -p -e "s/^\$/ /" exp &&
+     perl -i.bak -p -e "s/^\$/ /" exp &&
      git config --bool diff.suppressBlankEmpty false &&
      git diff f > actual &&
      test_cmp exp actual &&
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index b1b906b..1b420e3 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -23,10 +23,10 @@ test_expect_success 'setup' '
 	git commit -m "Initial Version" 2>/dev/null &&
 
 	git checkout -b binary &&
-	"$PERL_PATH" -pe "y/x/\000/" <file1 >file3 &&
+	perl -pe "y/x/\000/" <file1 >file3 &&
 	cat file3 >file4 &&
 	git add file2 &&
-	"$PERL_PATH" -pe "y/\000/v/" <file3 >file1 &&
+	perl -pe "y/\000/v/" <file3 >file1 &&
 	rm -f file2 &&
 	git update-index --add --remove file1 file2 file3 file4 &&
 	git commit -m "Second Version" &&
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index fca8153..2298ece 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -12,14 +12,14 @@ test_description='git apply in reverse
 test_expect_success setup '
 
 	for i in a b c d e f g h i j k l m n; do echo $i; done >file1 &&
-	"$PERL_PATH" -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
+	perl -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
 
 	git add file1 file2 &&
 	git commit -m initial &&
 	git tag initial &&
 
 	for i in a b c g h i J K L m o n p q; do echo $i; done >file1 &&
-	"$PERL_PATH" -pe "y/mon/\\000\\001\\002/" <file1 >file2 &&
+	perl -pe "y/mon/\\000\\001\\002/" <file1 >file2 &&
 
 	git commit -a -m second &&
 	git tag second &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7f6666f..076e770 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -78,7 +78,7 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
 	test_might_fail git config --unset rerere.enabled &&
 	test_must_fail git merge first &&
 
-	sha1=$("$PERL_PATH" -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep "^=======\$" $rr/preimage &&
 	! test -f $rr/postimage &&
@@ -91,7 +91,7 @@ test_expect_success 'rerere.enabled works, too' '
 	git reset --hard &&
 	test_must_fail git merge first &&
 
-	sha1=$("$PERL_PATH" -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep ^=======$ $rr/preimage
 '
@@ -101,7 +101,7 @@ test_expect_success 'set up rr-cache' '
 	git config rerere.enabled true &&
 	git reset --hard &&
 	test_must_fail git merge first &&
-	sha1=$("$PERL_PATH" -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1
 '
 
@@ -185,7 +185,7 @@ test_expect_success 'rerere updates postimage timestamp' '
 
 test_expect_success 'rerere clear' '
 	rm $rr/postimage &&
-	echo "$sha1	a1" | "$PERL_PATH" -pe "y/\012/\000/" >.git/MERGE_RR &&
+	echo "$sha1	a1" | perl -pe "y/\012/\000/" >.git/MERGE_RR &&
 	git rerere clear &&
 	! test -d $rr
 '
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a07c871..c755c09 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -13,9 +13,9 @@ TRASH=`pwd`
 test_expect_success \
     'setup' \
     'rm -f .git/index* &&
-     "$PERL_PATH" -e "print \"a\" x 4096;" > a &&
-     "$PERL_PATH" -e "print \"b\" x 4096;" > b &&
-     "$PERL_PATH" -e "print \"c\" x 4096;" > c &&
+     perl -e "print \"a\" x 4096;" > a &&
+     perl -e "print \"b\" x 4096;" > b &&
+     perl -e "print \"c\" x 4096;" > c &&
      test-genrandom "seed a" 2097152 > a_big &&
      test-genrandom "seed b" 2097152 > b_big &&
      git update-index --add a a_big b b_big c &&
@@ -129,7 +129,7 @@ test_expect_success \
 cd "$TRASH"
 
 test_expect_success 'compare delta flavors' '
-	"$PERL_PATH" -e '\''
+	perl -e '\''
 		defined($_ = -s $_) or die for @ARGV;
 		exit 1 if $ARGV[0] <= $ARGV[1];
 	'\'' test-2-$packname_2.pack test-3-$packname_3.pack
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 35926de..663b02b 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -98,7 +98,7 @@ test_expect_success \
     'create_new_pack &&
      git prune-packed &&
      chmod +w ${pack}.pack &&
-     "$PERL_PATH" -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
+     perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
      test_must_fail git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -155,7 +155,7 @@ test_expect_success \
     'create_new_pack &&
      git prune-packed &&
      chmod +w ${pack}.pack &&
-     "$PERL_PATH" -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
+     perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 8196af1..f036392 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -224,7 +224,7 @@ test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 	done | git fast-import --export-marks=marks &&
 
 	# now assign tags to all the dangling commits we created above
-	tag=$("$PERL_PATH" -e "print \"bla\" x 30") &&
+	tag=$(perl -e "print \"bla\" x 30") &&
 	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
 	)
 '
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index bbb0581..e51eb41 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -37,7 +37,7 @@ test_expect_success 'verify number of revisions' \
 
 test_expect_success 'corrupt second commit object' \
    '
-   "$PERL_PATH" -i.bak -pe "s/second commit/socond commit/" .git/objects/pack/*.pack &&
+   perl -i.bak -pe "s/second commit/socond commit/" .git/objects/pack/*.pack &&
    test_must_fail git fsck --full
    '
 
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 892a537..59fc2f0 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -25,7 +25,7 @@ test_expect_success 'set up --reverse example' '
 
 test_expect_success '--reverse --parents --full-history combines correctly' '
 	git rev-list --parents --full-history master -- foo |
-		"$PERL_PATH" -e "print reverse <>" > expected &&
+		perl -e "print reverse <>" > expected &&
 	git rev-list --reverse --parents --full-history master -- foo \
 		> actual &&
 	test_cmp actual expected
@@ -33,7 +33,7 @@ test_expect_success '--reverse --parents --full-history combines correctly' '
 
 test_expect_success '--boundary does too' '
 	git rev-list --boundary --parents --full-history master ^root -- foo |
-		"$PERL_PATH" -e "print reverse <>" > expected &&
+		perl -e "print reverse <>" > expected &&
 	git rev-list --boundary --reverse --parents --full-history \
 		master ^root -- foo > actual &&
 	test_cmp actual expected
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 6fb59f3..c987b5e 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -994,7 +994,7 @@ test_expect_success 'status -s submodule summary (clean submodule)' '
 
 test_expect_success 'status -z implies porcelain' '
 	git status --porcelain |
-	"$PERL_PATH" -pe "s/\012/\000/g" >expect &&
+	perl -pe "s/\012/\000/g" >expect &&
 	git status -z >output &&
 	test_cmp expect output
 '
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 9a40f1e..8cfdfe7 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -29,7 +29,7 @@ fi
 compare_svn_head_with () {
 	# extract just the log message and strip out committer info.
 	# don't use --limit here since svn 1.1.x doesn't have it,
-	LC_ALL="$a_utf8_locale" svn log `git svn info --url` | "$PERL_PATH" -w -e '
+	LC_ALL="$a_utf8_locale" svn log `git svn info --url` | perl -w -e '
 		use bytes;
 		$/ = ("-"x72) . "\n";
 		my @x = <STDIN>;
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index c17aa31..d60da63 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -20,8 +20,8 @@ test_expect_success '(supposedly) non-conflicting change from SVN' '
 	test x"`sed -n -e 61p < file`" = x61 &&
 	svn_cmd co "$svnrepo" tmp &&
 	(cd tmp &&
-		"$PERL_PATH" -i.bak -p -e "s/^58$/5588/" file &&
-		"$PERL_PATH" -i.bak -p -e "s/^61$/6611/" file &&
+		perl -i.bak -p -e "s/^58$/5588/" file &&
+		perl -i.bak -p -e "s/^61$/6611/" file &&
 		poke file &&
 		test x"`sed -n -e 58p < file`" = x5588 &&
 		test x"`sed -n -e 61p < file`" = x6611 &&
@@ -40,8 +40,8 @@ test_expect_success 'some unrelated changes to git' "
 test_expect_success 'change file but in unrelated area' "
 	test x\"\`sed -n -e 4p < file\`\" = x4 &&
 	test x\"\`sed -n -e 7p < file\`\" = x7 &&
-	"$PERL_PATH" -i.bak -p -e 's/^4\$/4444/' file &&
-	"$PERL_PATH" -i.bak -p -e 's/^7\$/7777/' file &&
+	perl -i.bak -p -e 's/^4\$/4444/' file &&
+	perl -i.bak -p -e 's/^7\$/7777/' file &&
 	test x\"\`sed -n -e 4p < file\`\" = x4444 &&
 	test x\"\`sed -n -e 7p < file\`\" = x7777 &&
 	git commit -m '4 => 4444, 7 => 7777' file &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 88fc407..27263df 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -12,7 +12,7 @@ test_description='test git fast-import utility'
 # This could be written as "head -c $1", but IRIX "head" does not
 # support the -c option.
 head_c () {
-	"$PERL_PATH" -e '
+	perl -e '
 		my $len = $ARGV[1];
 		while ($len > 0) {
 			my $s;
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 34c2d8f..2312dec 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -429,7 +429,7 @@ test_expect_success 'fast-export quotes pathnames' '
 		--cacheinfo 100644 $blob "path with \\backslash" \
 		--cacheinfo 100644 $blob "path with space" &&
 	 git commit -m addition &&
-	 git ls-files -z -s | "$PERL_PATH" -0pe "s{\\t}{$&subdir/}" >index &&
+	 git ls-files -z -s | perl -0pe "s{\\t}{$&subdir/}" >index &&
 	 git read-tree --empty &&
 	 git update-index -z --index-info <index &&
 	 git commit -m rename &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 0431386..3edc408 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -20,7 +20,7 @@ then
     skip_all='skipping git-cvsserver tests, cvs not found'
     test_done
 fi
-"$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     skip_all='skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
 }
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 8c3db76..5a4ed28 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -68,7 +68,7 @@ then
     skip_all='skipping git-cvsserver tests, perl not available'
     test_done
 fi
-"$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     skip_all='skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
 }
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index db69af2..1e266ef 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -76,7 +76,7 @@ then
 	skip_all='skipping git-cvsserver tests, perl not available'
 	test_done
 fi
-"$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
 	skip_all='skipping git-cvsserver tests, Perl SQLite interface unavailable'
 	test_done
 }
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 435d896..102c133 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -11,7 +11,7 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
-"$PERL_PATH" -MTest::More -e 0 2>/dev/null || {
+perl -MTest::More -e 0 2>/dev/null || {
 	skip_all="Perl Test::More unavailable, skipping test"
 	test_done
 }
@@ -55,6 +55,6 @@ test_external_has_tap=1
 
 test_external_without_stderr \
     'Perl API' \
-    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
+    perl "$TEST_DIRECTORY"/t9700/test.pl
 
 test_done
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 34fbc90..8134ab4 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -263,7 +263,7 @@ test_expect_success 'cope with rcs keyword expansion damage' '
 		git config git-p4.attemptRCSCleanup true &&
 		(cd "$cli" && p4_append_to_file kwfile1.c) &&
 		old_lines=$(wc -l <kwfile1.c) &&
-		"$PERL_PATH" -n -i -e "print unless m/Revision:/" kwfile1.c &&
+		perl -n -i -e "print unless m/Revision:/" kwfile1.c &&
 		new_lines=$(wc -l <kwfile1.c) &&
 		test $new_lines = $(($old_lines - 1)) &&
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 53af452..bb878f3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -76,11 +76,11 @@ test_decode_color () {
 }
 
 nul_to_q () {
-	"$PERL_PATH" -pe 'y/\000/Q/'
+	perl -pe 'y/\000/Q/'
 }
 
 q_to_nul () {
-	"$PERL_PATH" -pe 'y/Q/\000/'
+	perl -pe 'y/Q/\000/'
 }
 
 q_to_cr () {
@@ -648,7 +648,7 @@ test_seq () {
 	2)	;;
 	*)	error "bug in the test script: not 1 or 2 parameters to test_seq" ;;
 	esac
-	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
+	perl -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
 }
 
 # This function can be used to schedule some commands to be run
-- 
1.8.4.1.898.g8bf8a41.dirty
