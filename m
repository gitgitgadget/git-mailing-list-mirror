From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH 1/2] submodule: preserve all arguments exactly when recursing
Date: Tue,  2 Nov 2010 21:34:41 -0700
Message-ID: <1288758882-77286-1-git-send-email-kevin@sb.org>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 05:35:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDV45-0002Wa-Vi
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 05:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab0KCEe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 00:34:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37565 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab0KCEe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 00:34:56 -0400
Received: by pwj3 with SMTP id 3so83909pwj.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 21:34:56 -0700 (PDT)
Received: by 10.142.48.14 with SMTP id v14mr855916wfv.359.1288758896130;
        Tue, 02 Nov 2010 21:34:56 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm12496476wfh.15.2010.11.02.21.34.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 21:34:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.200.ga1bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160572>

When performing a recursive status or update, any argments with whitespace
would be split along that whitespace when passed to the recursive invocation
of the update or status command.

This is caused by the special handling that sh provides to the $@ variable.
Status and update stored "$@" into a separate variable, and passed that
variable to the recursive invocation. Unfortunately, the special handling
afforded to $@ isn't given to this new variable, and word-breaking occurs
along whitespace boundaries.

We can work around this by taking advantage of an easy technique to quote
any arbitrary string in the shell. Because single-quoted strings don't
support backslash-escapes, any arbitrary string can be quoted by wrapping
it in single-quotes and replacing any single-quotes inside the string with
the sequence '\''.

This commit introduces a new shell function quote_words that uses the quote
trick to produce a string containing the quoted version of all its
arguments. This string can then be used with `set -` to restore the original
value of $@. This shell function is used in cmd_status and in cmd_update
to store the original value of $@, which is then restored before the
recursive invocation takes place.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
I tried to write tests for this, but there are only two ways to get args
with spaces to be accepted and passed to the recursive invocation.
The first is via the --reference flag, but I don't think it really makes
sense to use that flag in connection with --recursive and was not comfortable
using it in a test. The second is as a pathname after the flags, but it
also doesn't make sense to pass these to recursive invocations, and in fact
the subsequent commit fixes it so the pathnames are not passed to recursive
invocations.

That said, despite the lack of tests I still believe this is a worthwhile
change, and it will certainly future-proof the command in case new flags
are added. It's also a reasonable model for how to handle this problem
in other shell commands.
 git-submodule.sh |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9ebbab7..ec7a5e4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -64,6 +64,39 @@ module_list()
 }
 
 #
+# Emit a quoted version of the all argument suitable for passing to `eval`
+# $@ = words to quote
+#
+# This is intended to be used like the following:
+#   orig_args="$(quote_words "$@")"
+#   # do some work that includes calling shift
+#   eval "set - $orig_args"
+#   # now $@ has been restored, suitable for passing to another command
+#
+# Note that you cannot simply save off $@ into another variable because
+# the shell gives $@ and $* special handling in parameter expansion
+#
+quote_words ()
+{
+	while test $# -ne 0; do
+		# this can be done using sed like so:
+		#   printf "'%s'" "$(printf "%s" "$1" | sed -e "s/'/'\\\\''/g")"
+		# but in an attempt to avoid spawning a process for every argument, we'll
+		# just use the prefix/suffix pattern matching stuff
+		local word= suffix="$1" prefix=
+		while test -n "$suffix"
+		do
+			prefix="${suffix%%\'*}"
+			test "$prefix" != "$suffix" || break
+			suffix="${suffix#*\'}"
+			word="$word$prefix'\\''"
+		done
+		printf "'%s' " "$word$suffix"
+		shift
+	done
+}
+
+#
 # Map submodule path to submodule name
 #
 # $1 = path
@@ -374,7 +407,7 @@ cmd_init()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
-	orig_args="$@"
+	orig_args="$(quote_words "$@")"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -500,7 +533,8 @@ cmd_update()
 
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && cmd_update $orig_args) ||
+			eval "set - $orig_args"
+			(clear_local_git_env; cd "$path" && cmd_update "$@") ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
 	done
@@ -733,7 +767,7 @@ cmd_summary() {
 cmd_status()
 {
 	# parse $args after "submodule ... status".
-	orig_args="$@"
+	orig_args="$(quote_words "$@")"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -788,9 +822,10 @@ cmd_status()
 		then
 			(
 				prefix="$displaypath/"
+				eval "set - $orig_args"
 				clear_local_git_env
 				cd "$path" &&
-				cmd_status $orig_args
+				cmd_status "$@"
 			) ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
-- 
1.7.3.2.200.ga1bd
