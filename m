From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] git-submodule: fix subcommand parser
Date: Tue, 15 Jan 2008 03:19:44 -0800
Message-ID: <7vve5ve3ov.fsf_-_@gitster.siamese.dyndns.org>
References: <1200280956-19920-1-git-send-email-imyousuf@gmail.com>
	<7vzlv7flb5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 15 12:20:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEjqD-0005og-Dh
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 12:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbYAOLT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 06:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYAOLT5
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 06:19:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbYAOLT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 06:19:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 114291927;
	Tue, 15 Jan 2008 06:19:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB541925;
	Tue, 15 Jan 2008 06:19:50 -0500 (EST)
In-Reply-To: <7vzlv7flb5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 15 Jan 2008 02:13:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70513>

The subcommand parser of "git submodule" made its subcommand
names reserved words.  As a consequence, a command like this:

    $ git submodule add init update

which is meant to add a submodule called 'init' at path 'update'
was misinterpreted as a request to invoke more than one mutually
incompatible subcommands and incorrectly rejected.

This patch fixes the issue by stopping the subcommand parsing at
the first subcommand word, to allow the sample command line
above to work as expected.

It also introduces the usual -- option disambiguator, so that a
submodule at path '-foo' can be updated with

    $ git submodule update -- -foo

without triggering an "unrecognized option -foo" error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is the second part to fix the real issue.

 git-submodule.sh |  157 ++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 116 insertions(+), 41 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3c104e3..a6aaf40 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,11 +9,8 @@ OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
 
-add=
+command=
 branch=
-init=
-update=
-status=
 quiet=
 cached=
 
@@ -123,6 +120,32 @@ module_clone()
 #
 cmd_add()
 {
+	# parse $args after "submodule ... add".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-b | --branch)
+			case "$2" in '') usage ;; esac
+			branch=$2
+			shift
+			;;
+		-q|--quiet)
+			quiet=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
 	repo=$1
 	path=$2
 
@@ -176,6 +199,27 @@ cmd_add()
 #
 cmd_init()
 {
+	# parse $args after "submodule ... init".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			quiet=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -209,6 +253,27 @@ cmd_init()
 #
 cmd_update()
 {
+	# parse $args after "submodule ... update".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			quiet=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -268,6 +333,30 @@ set_name_rev () {
 #
 cmd_status()
 {
+	# parse $args after "submodule ... status".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			quiet=1
+			;;
+		--cached)
+			cached=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -293,20 +382,17 @@ cmd_status()
 	done
 }
 
-while test $# != 0
+# This loop parses the command line arguments to find the
+# subcommand name to dispatch.  Parsing of the subcommand specific
+# options are primarily done by the subcommand implementations.
+# Subcommand specific options such as --branch and --cached are
+# parsed here as well, for backward compatibility.
+
+while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add)
-		add=1
-		;;
-	init)
-		init=1
-		;;
-	update)
-		update=1
-		;;
-	status)
-		status=1
+	add | init | update | status)
+		command=$1
 		;;
 	-q|--quiet)
 		quiet=1
@@ -335,30 +421,19 @@ do
 	shift
 done
 
-case "$add,$branch" in
-1,*)
-	;;
-,)
-	;;
-,*)
+# No command word defaults to "status"
+test -n "$command" || command=status
+
+# "-b branch" is accepted only by "add"
+if test -n "$branch" && test "$command" != add
+then
 	usage
-	;;
-esac
-
-case "$add,$init,$update,$status,$cached" in
-1,,,,)
-	cmd_add "$@"
-	;;
-,1,,,)
-	cmd_init "$@"
-	;;
-,,1,,)
-	cmd_update "$@"
-	;;
-,,,*,*)
-	cmd_status "$@"
-	;;
-*)
+fi
+
+# "--cached" is accepted only by "status"
+if test -n "$cached" && test "$command" != status
+then
 	usage
-	;;
-esac
+fi
+
+"cmd_$command" "$@"
-- 
1.5.4.rc3.11.g4e67
