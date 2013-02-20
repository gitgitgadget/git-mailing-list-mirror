From: Jeff King <peff@peff.net>
Subject: [PATCH v3 03/19] upload-pack: remove packet debugging harness
Date: Wed, 20 Feb 2013 14:55:28 -0500
Message-ID: <20130220195528.GC25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 20:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Flj-0000Et-C5
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 20:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934914Ab3BTTzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 14:55:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54556 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934854Ab3BTTza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 14:55:30 -0500
Received: (qmail 17607 invoked by uid 107); 20 Feb 2013 19:57:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 14:57:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 14:55:28 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216717>

If you set the GIT_DEBUG_SEND_PACK environment variable,
upload-pack will dump lines it receives in the receive_needs
phase to a descriptor. This debugging harness is a strict
subset of what GIT_TRACE_PACKET can do. Let's just drop it
in favor of that.

A few tests used GIT_DEBUG_SEND_PACK to confirm which
objects get sent; we have to adapt them to the new output
format.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5503-tagfollow.sh       | 38 +++++++++++++++++---------------------
 t/t5700-clone-reference.sh | 10 +++++-----
 upload-pack.c              |  9 ---------
 3 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 60de2d6..d181c96 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -5,7 +5,7 @@ if ! test_have_prereq NOT_MINGW; then
 . ./test-lib.sh
 
 if ! test_have_prereq NOT_MINGW; then
-	say "GIT_DEBUG_SEND_PACK not supported - skipping tests"
+	say "GIT_TRACE_PACKET not supported - skipping tests"
 fi
 
 # End state of the repository:
@@ -42,21 +42,26 @@ test_expect_success NOT_MINGW 'fetch A (new commit : 1 connection)' '
 
 test_expect_success NOT_MINGW 'setup expect' '
 cat - <<EOF >expect
-#S
 want $A
-#E
 EOF
 '
 
+get_needs () {
+	perl -alne '
+		next unless $F[1] eq "upload-pack<";
+		last if $F[2] eq "0000";
+		print $F[2], " ", $F[3];
+	' "$@"
+}
+
 test_expect_success NOT_MINGW 'fetch A (new commit : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
+		GIT_TRACE_PACKET=3 git fetch 3>../$U &&
 		test $A = $(git rev-parse --verify origin/master)
 	) &&
-	test -s $U &&
-	cut -d" " -f1,2 $U >actual &&
+	get_needs $U >actual &&
 	test_cmp expect actual
 '
 
@@ -74,10 +79,8 @@ want $T
 
 test_expect_success NOT_MINGW 'setup expect' '
 cat - <<EOF >expect
-#S
 want $C
 want $T
-#E
 EOF
 '
 
@@ -85,13 +88,12 @@ test_expect_success NOT_MINGW 'fetch C, T (new branch, tag : 1 connection)' '
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
+		GIT_TRACE_PACKET=3 git fetch 3>../$U &&
 		test $C = $(git rev-parse --verify origin/cat) &&
 		test $T = $(git rev-parse --verify tag1) &&
 		test $A = $(git rev-parse --verify tag1^0)
 	) &&
-	test -s $U &&
-	cut -d" " -f1,2 $U >actual &&
+	get_needs $U >actual &&
 	test_cmp expect actual
 '
 
@@ -113,10 +115,8 @@ want $S
 
 test_expect_success NOT_MINGW 'setup expect' '
 cat - <<EOF >expect
-#S
 want $B
 want $S
-#E
 EOF
 '
 
@@ -124,22 +124,19 @@ want $S
 	rm -f $U &&
 	(
 		cd cloned &&
-		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
+		GIT_TRACE_PACKET=3 git fetch 3>../$U &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $S = $(git rev-parse --verify tag2)
 	) &&
-	test -s $U &&
-	cut -d" " -f1,2 $U >actual &&
+	get_needs $U >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success NOT_MINGW 'setup expect' '
 cat - <<EOF >expect
-#S
 want $B
 want $S
-#E
 EOF
 '
 
@@ -151,15 +148,14 @@ test_expect_success NOT_MINGW 'new clone fetch master and tags' '
 		cd clone2 &&
 		git init &&
 		git remote add origin .. &&
-		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
+		GIT_TRACE_PACKET=3 git fetch 3>../$U &&
 		test $B = $(git rev-parse --verify origin/master) &&
 		test $S = $(git rev-parse --verify tag2) &&
 		test $B = $(git rev-parse --verify tag2^0) &&
 		test $T = $(git rev-parse --verify tag1) &&
 		test $A = $(git rev-parse --verify tag1^0)
 	) &&
-	test -s $U &&
-	cut -d" " -f1,2 $U >actual &&
+	get_needs $U >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index c47d450..9cd3b4d 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -55,10 +55,10 @@ test_expect_success 'fetched no objects' \
 rm -f "$U.D"
 
 test_expect_success 'cloning with reference (no -l -s)' \
-'GIT_DEBUG_SEND_PACK=3 git clone --reference B "file://$(pwd)/A" D 3>"$U.D"'
+'GIT_TRACE_PACKET=3 git clone --reference B "file://$(pwd)/A" D 3>"$U.D"'
 
 test_expect_success 'fetched no objects' \
-'! grep "^want" "$U.D"'
+'! grep " want" "$U.D"'
 
 cd "$base_dir"
 
@@ -173,12 +173,12 @@ test_expect_success 'fetch with incomplete alternates' '
 	(
 		cd K &&
 		git remote add J "file://$base_dir/J" &&
-		GIT_DEBUG_SEND_PACK=3 git fetch J 3>"$U.K"
+		GIT_TRACE_PACKET=3 git fetch J 3>"$U.K"
 	) &&
 	master_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/master) &&
-	! grep "^want $master_object" "$U.K" &&
+	! grep " want $master_object" "$U.K" &&
 	tag_object=$(cd A && git for-each-ref --format="%(objectname)" refs/tags/HEAD) &&
-	! grep "^want $tag_object" "$U.K"
+	! grep " want $tag_object" "$U.K"
 '
 
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 1aee407..63cea91 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -42,7 +42,6 @@ static int use_sideband;
  * otherwise maximum packet size (up to 65520 bytes).
  */
 static int use_sideband;
-static int debug_fd;
 static int advertise_refs;
 static int stateless_rpc;
 
@@ -580,8 +579,6 @@ static void receive_needs(void)
 	int has_non_tip = 0;
 
 	shallow_nr = 0;
-	if (debug_fd)
-		write_str_in_full(debug_fd, "#S\n");
 	for (;;) {
 		struct object *o;
 		const char *features;
@@ -590,8 +587,6 @@ static void receive_needs(void)
 		reset_timeout();
 		if (!len)
 			break;
-		if (debug_fd)
-			write_in_full(debug_fd, line, len);
 
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
@@ -653,8 +648,6 @@ static void receive_needs(void)
 			add_object_array(o, NULL, &want_obj);
 		}
 	}
-	if (debug_fd)
-		write_str_in_full(debug_fd, "#E\n");
 
 	/*
 	 * We have sent all our refs already, and the other end
@@ -845,8 +838,6 @@ int main(int argc, char **argv)
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
 	git_config(upload_pack_config, NULL);
-	if (getenv("GIT_DEBUG_SEND_PACK"))
-		debug_fd = atoi(getenv("GIT_DEBUG_SEND_PACK"));
 	upload_pack();
 	return 0;
 }
-- 
1.8.2.rc0.9.g352092c
