From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3] Let submodule command exit with error status if path
	does not exist
Date: Tue, 14 Aug 2012 22:35:27 +0200
Message-ID: <20120814203526.GA33843@book.hvoigt.net>
References: <1340872080.2103.92.camel@athena.dnet> <20120809200302.GA93203@book.hvoigt.net> <7vboijol03.fsf@alter.siamese.dyndns.org> <20120811064912.GA83365@book.hvoigt.net> <7vy5lkfyx1.fsf@alter.siamese.dyndns.org> <20120813163911.GA6418@book.hvoigt.net> <7vvcgmemyk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Milde <daniel@milde.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:35:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Nq1-000190-VT
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430Ab2HNUfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:35:36 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:38623 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab2HNUff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:35:35 -0400
X-Greylist: delayed 100569 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2012 16:35:35 EDT
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T1Npo-00085W-CG; Tue, 14 Aug 2012 22:35:28 +0200
Content-Disposition: inline
In-Reply-To: <7vvcgmemyk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203445>

Previously the exit status of git submodule was zero for various
subcommands even though the user specified an unknown path.

The reason behind that was that they all pipe the output of module_list
into the while loop which then does the action on the paths specified by
the commandline. Since the exit code of piped commands is ignored by the
shell, the status code of module_list was swallowed.

In case ls-files returns with an error code we pipe a special string
that is not possible in non error situations. If the perl filter behind
that encounters this string it outputs a single line with the special
tag '#unmatched'. This is then used by all reader from module_list to
die with an error code.

The error message that there is an unmatched pathspec comes through
stderr directly from ls-files. So the user still gets a hint whats going
on.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Hi Junio,

this is an updated version with your proposal incorporated. I changed
the name of check_unmatched to die_if_unmatched because IMO it describes
more clearly what the function is doing.

Cheers Heiko

 git-submodule.sh           | 33 ++++++++++++++++++++++++++++++---
 t/t7400-submodule-basic.sh | 26 ++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index aac575e..0840524 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -109,26 +109,48 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" |
+	(
+		git ls-files --error-unmatch --stage -- "$@" ||
+		echo "unmatched pathspec exists"
+	) |
 	perl -e '
 	my %unmerged = ();
 	my ($null_sha1) = ("0" x 40);
+	my @out = ();
+	my $unmatched = 0;
 	while (<STDIN>) {
+		if (/^unmatched pathspec/) {
+			$unmatched = 1;
+			next;
+		}
 		chomp;
 		my ($mode, $sha1, $stage, $path) =
 			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
 		next unless $mode eq "160000";
 		if ($stage ne "0") {
 			if (!$unmerged{$path}++) {
-				print "$mode $null_sha1 U\t$path\n";
+				push @out, "$mode $null_sha1 U\t$path\n";
 			}
 			next;
 		}
-		print "$_\n";
+		push @out, "$_\n";
+	}
+	if ($unmatched) {
+		print "#unmatched\n";
+	} else {
+		print for (@out);
 	}
 	'
 }
 
+die_if_unmatched ()
+{
+	if test "$1" = "#unmatched"
+	then
+		exit 1
+	fi
+}
+
 #
 # Map submodule path to submodule name
 #
@@ -385,6 +407,7 @@ cmd_foreach()
 	module_list |
 	while read mode sha1 stage sm_path
 	do
+		die_if_unmatched "$mode"
 		if test -e "$sm_path"/.git
 		then
 			say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
@@ -437,6 +460,7 @@ cmd_init()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		die_if_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit
 
 		# Copy url setting when it is not set yet
@@ -537,6 +561,7 @@ cmd_update()
 	err=
 	while read mode sha1 stage sm_path
 	do
+		die_if_unmatched "$mode"
 		if test "$stage" = U
 		then
 			echo >&2 "Skipping unmerged submodule $sm_path"
@@ -932,6 +957,7 @@ cmd_status()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		die_if_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath="$prefix$sm_path"
@@ -1000,6 +1026,7 @@ cmd_sync()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		die_if_unmatched "$mode"
 		name=$(module_name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c73bec9..56a81cd 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -258,6 +258,27 @@ test_expect_success 'init should register submodule url in .git/config' '
 	test_cmp expect url
 '
 
+test_failure_with_unknown_submodule () {
+	test_must_fail git submodule $1 no-such-submodule 2>output.err &&
+	grep "^error: .*no-such-submodule" output.err
+}
+
+test_expect_success 'init should fail with unknown submodule' '
+	test_failure_with_unknown_submodule init
+'
+
+test_expect_success 'update should fail with unknown submodule' '
+	test_failure_with_unknown_submodule update
+'
+
+test_expect_success 'status should fail with unknown submodule' '
+	test_failure_with_unknown_submodule status
+'
+
+test_expect_success 'sync should fail with unknown submodule' '
+	test_failure_with_unknown_submodule sync
+'
+
 test_expect_success 'update should fail when path is used by a file' '
 	echo hello >expect &&
 
@@ -418,10 +439,7 @@ test_expect_success 'moving to a commit without submodule does not leave empty d
 '
 
 test_expect_success 'submodule <invalid-path> warns' '
-
-	git submodule no-such-submodule 2> output.err &&
-	grep "^error: .*no-such-submodule" output.err
-
+	test_failure_with_unknown_submodule
 '
 
 test_expect_success 'add submodules without specifying an explicit path' '
-- 
1.7.12.rc2.11.g5d52328
