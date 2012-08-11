From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] Let submodule command exit with error status if path
	does not exist
Date: Sat, 11 Aug 2012 08:49:14 +0200
Message-ID: <20120811064912.GA83365@book.hvoigt.net>
References: <1340872080.2103.92.camel@athena.dnet> <20120809200302.GA93203@book.hvoigt.net> <7vboijol03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Milde <daniel@milde.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 08:49:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T05Vp-00016W-HU
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 08:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab2HKGtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 02:49:24 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:36885 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab2HKGtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 02:49:23 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T05Vb-0001l5-EA; Sat, 11 Aug 2012 08:49:15 +0200
Content-Disposition: inline
In-Reply-To: <7vboijol03.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203280>

Previously the exit status of git submodule was zero for various
subcommands even though the user specified an unknown path.

The reason behind that was that they all pipe the output of module_list
into the while loop which then does the action on the paths specified by
the commandline. Since the exit code of piped commands is ignored by the
shell, the status code of module_list was swallowed.

We work around this by piping a submodule with an empty path and a null
sha1 as commit. This is necessary to pass through the perl snippet that
is used to select submodule entries. The while loop now checks for such
a submodule specification, exits with 1 and the exit code is propagated.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Thu, Aug 09, 2012 at 01:42:20PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> A plausible hack, assuming all the problematic readers of the pipe
> are of the form "... | while read mode sha1 stage sm_path", might be
> to update module_list () to do something like:
> 
> 	(
> 		git ls-files --error-unmatch ... ||
>                 echo "#unmatched"
> 	)
> 
> and then update the readers to catch "#unmatched" token, e.g.
> 
> 	module_list "$@" |
>         while read mode sha1 stage sm_path
>         do
> 		if test "$mode" = "#unmatched"
>                 then
>         		... do the necessary error thing ...
>                         continue
> 		fi
>                 ... whatever the loop originally did ...
> 	done

Unfortunately it does not work that simple, but I have implemented
something like this in this patch.

> One thing to note is that the above is not good if you want to
> atomically reject
> 
> 	git submodule foo module1 moduel2

> 
> and error the whole thing out without touching module1 (which
> exists) because of misspelt module2.
> 
> But is it what we want to see happen in these codepaths?

I think it is fine if we are working atomically for each submodule and
stop once we hit an unknown path. If we want to continue propagating the
error code will make the code more complex than is justified (IMO).

If the user wants to proceed its easier for him to correct his spelling. :-)

> This is a tangent, but among the 170 hits
> 
> 	git grep -e '^[a-z][a-z0-9A-Z_]* *(' -- './git-*.sh'
> 
> gives, about 120 have SP after funcname, i.e.
> 
> 	funcname () {
> 
> and 50 don't, i.e.
> 
> 	funcname() {
> 
> This file has 12 such definitions, among which 10 are the latter
> form.  There is no "rational" reason to choose between the two, but
> having two forms in the same project hurts greppability.  Updating
> the style of existing code shouldn't be done in the same patch, but
> please do not make things worse.

[...]

> > +test_failure_with_unknown_submodule() {
> 
> Likewise, even though inside t/ directory we seem to have more
> offenders (190/480 ~ 40%, vs 50/170 ~ 30%).

I did not know that you prefer a space after the function name. I simply
imitated the style from C and there we do not have spaces. It makes the
style rules a bit more complicated. Wouldn't it be nicer to have the
same as in C so we have less rules?

Nevertheless, I adjusted the patch.

 git-submodule.sh           | 23 ++++++++++++++++++++++-
 t/t7400-submodule-basic.sh | 26 ++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index aac575e..48014f2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -109,7 +109,8 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" |
+	(git ls-files --error-unmatch --stage -- "$@" ||
+		echo '160000 0000000000000000000000000000000000000000 0	') |
 	perl -e '
 	my %unmerged = ();
 	my ($null_sha1) = ("0" x 40);
@@ -385,6 +386,10 @@ cmd_foreach()
 	module_list |
 	while read mode sha1 stage sm_path
 	do
+		if test -z "$sm_path"; then
+			exit 1
+		fi
+
 		if test -e "$sm_path"/.git
 		then
 			say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
@@ -437,6 +442,10 @@ cmd_init()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		if test -z "$sm_path"; then
+			exit 1
+		fi
+
 		name=$(module_name "$sm_path") || exit
 
 		# Copy url setting when it is not set yet
@@ -537,6 +546,10 @@ cmd_update()
 	err=
 	while read mode sha1 stage sm_path
 	do
+		if test -z "$sm_path"; then
+			exit 1
+		fi
+
 		if test "$stage" = U
 		then
 			echo >&2 "Skipping unmerged submodule $sm_path"
@@ -932,6 +945,10 @@ cmd_status()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		if test -z "$sm_path"; then
+			exit 1
+		fi
+
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath="$prefix$sm_path"
@@ -1000,6 +1017,10 @@ cmd_sync()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		if test -z "$sm_path"; then
+			exit 1
+		fi
+
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
1.7.12.rc2.10.gaf2525e
