From: greened@obbligato.org
Subject: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Sun,  4 Mar 2012 17:23:57 -0600
Message-ID: <1330903437-31386-2-git-send-email-greened@obbligato.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 00:27:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4KpQ-0006tV-69
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 00:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab2CDX0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 18:26:52 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:54810 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755267Ab2CDX0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 18:26:49 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S4KqX-0006kJ-7O; Sun, 04 Mar 2012 17:28:09 -0600
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1330903437-31386-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -1.0 (-)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> Allow tests
    that do not live in the top-level t/ directory to run under valgrind. This
    requires exporting a couple more variables to indicate where the git tools
    were built and where the valgrind support files live. [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192183>

From: "David A. Greene" <greened@obbligato.org>

Allow tests that do not live in the top-level t/ directory to run
under valgrind.  This requires exporting a couple more variables to
indicate where the git tools were built and where the valgrind support
files live.

Prior to this chage the valgrind support files were hard-coded to be
in a sibling directory to where the valgrind tests are run.

Also prior to this change the base git build was hard-coded to be
exactly two directories up from where the valgrind tests are run.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 t/test-lib.sh          |   22 ++++++++++++++++++++--
 t/valgrind/valgrind.sh |    4 ++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cb3a0a2..0ebb3a8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -56,6 +56,7 @@ unset $(perl -e '
 		PROVE
 		VALGRIND
                 BUILD_DIR
+                VALGRIND_TOOLS
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
@@ -917,6 +918,20 @@ then
        GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 fi
 
+# GIT_VALGRIND_TOOLS is the location of tools like valgrind.sh.
+if test -z "$GIT_VALGRIND_TOOLS"
+then
+	# We allow tests to override this, in case they want to run tests
+	# outside of t/.
+ 
+        # For in-tree test scripts, this is in TEST_DIRECTORY/valgrind
+        # (t/valgrind), but a test script that lives outside t/ can
+        # set this variable to point at the right place so that it can
+        # find t/valgrind directory that house test helpers like
+        # valgrind.sh.
+       GIT_VALGRIND_TOOLS="$TEST_DIRECTORY"/valgrind
+fi
+
 if test -n "$valgrind"
 then
 	make_symlink () {
@@ -954,11 +969,11 @@ then
 		    test ! -d "$symlink_target" &&
 		    test "#!" != "$(head -c 2 < "$symlink_target")"
 		then
-			symlink_target=../valgrind.sh
+			symlink_target=${GIT_VALGRIND_TOOLS}/valgrind.sh
 		fi
 		case "$base" in
 		*.sh|*.perl)
-			symlink_target=../unprocessed-script
+			symlink_target=${GIT_VALGRIND_TOOLS}/unprocessed-script
 		esac
 		# create the link, or replace it if it is out of date
 		make_symlink "$symlink_target" "$GIT_VALGRIND/bin/$base" || exit
@@ -986,7 +1001,10 @@ then
 	IFS=$OLDIFS
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
+	# Make these available in valgrind.sh
+	export GIT_BUILD_DIR
 	export GIT_VALGRIND
+	export GIT_VALGRIND_TOOLS
 elif test -n "$GIT_TEST_INSTALLED" ; then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index 582b4dc..d638d10 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -13,10 +13,10 @@ TRACK_ORIGINS=--track-origins=yes
 
 exec valgrind -q --error-exitcode=126 \
 	--leak-check=no \
-	--suppressions="$GIT_VALGRIND/default.supp" \
+	--suppressions="$GIT_VALGRIND_TOOLS/default.supp" \
 	--gen-suppressions=all \
 	$TRACK_ORIGINS \
 	--log-fd=4 \
 	--input-fd=4 \
 	$GIT_VALGRIND_OPTIONS \
-	"$GIT_VALGRIND"/../../"$base" "$@"
+	"$GIT_BUILD_DIR"/"$base" "$@"
-- 
1.7.9.1
