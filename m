From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] use @@PERL@@ in built scripts
Date: Mon, 28 Oct 2013 21:19:59 -0400
Message-ID: <20131029011959.GA27738@sigill.intra.peff.net>
References: <20131029011859.GA22140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 02:20:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaxyc-000532-An
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 02:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757033Ab3J2BUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 21:20:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:57384 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756651Ab3J2BUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 21:20:02 -0400
Received: (qmail 28832 invoked by uid 102); 29 Oct 2013 01:20:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 20:20:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 21:19:59 -0400
Content-Disposition: inline
In-Reply-To: <20131029011859.GA22140@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236880>

Several of the built shell commands invoke a bare "perl" to
perform some one-liners. This will use the first perl in the
PATH rather than the one specified by the user's SHELL_PATH.
We are not asking these perl invocations to do anything
exotic, so typically any old system perl will do; however,
in some cases the system perl may have unexpected behavior
(e.g., by handling line endings differently). We should err
on the side of using the perl the user pointed us to.

The downside of this is that on systems with a sane perl
setup, we no longer find the perl at runtime, but instead
point to a static perl (like /usr/bin/perl). That means we
will not handle somebody moving perl without rebuilding git,
whereas before we tracked it just fine. This is probably not
a big deal, though, as the built perl scripts already
suffered from this.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-am.sh           | 4 ++--
 git-instaweb.sh     | 2 +-
 git-request-pull.sh | 2 +-
 git-submodule.sh    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 7ea40fe..bbea430 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -302,7 +302,7 @@ split_patches () {
 			# not starting with Author, From or Date is the
 			# subject, and the body starts with the next nonempty
 			# line not starting with Author, From or Date
-			perl -ne 'BEGIN { $subject = 0 }
+			@@PERL@@ -ne 'BEGIN { $subject = 0 }
 				if ($subject > 1) { print ; }
 				elsif (/^\s+$/) { next ; }
 				elsif (/^Author:/) { s/Author/From/ ; print ;}
@@ -334,7 +334,7 @@ split_patches () {
 			# Since we cannot guarantee that the commit message is in
 			# git-friendly format, we put no Subject: line and just consume
 			# all of the message as the body
-			LANG=C LC_ALL=C perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
+			LANG=C LC_ALL=C @@PERL@@ -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
 				if ($subject) { print ; }
 				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
 				elsif (/^\# Date /) {
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 01a1b05..e93a238 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -581,7 +581,7 @@ EOF
 
 gitweb_conf() {
 	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
-#!/usr/bin/perl
+#!@@PERL@@
 our \$projectroot = "$(dirname "$fqgitdir")";
 our \$git_temp = "$fqgitdir/gitweb/tmp";
 our \$projects_list = \$projectroot;
diff --git a/git-request-pull.sh b/git-request-pull.sh
index ebf1269..fe21d5d 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -106,7 +106,7 @@ find_matching_ref='
 	}
 '
 
-ref=$(git ls-remote "$url" | perl -e "$find_matching_ref" "$head" "$headrev" "$tag_name")
+ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "$head" "$headrev" "$tag_name")
 
 url=$(git ls-remote --get-url "$url")
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 896f1c9..20ebf2e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -156,7 +156,7 @@ module_list()
 		git ls-files -z --error-unmatch --stage -- "$@" ||
 		echo "unmatched pathspec exists"
 	) |
-	perl -e '
+	@@PERL@@ -e '
 	my %unmerged = ();
 	my ($null_sha1) = ("0" x 40);
 	my @out = ();
-- 
1.8.4.1.898.g8bf8a41.dirty
