From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 2/3] git-submodule foreach: export .gitmodules settings as
 variables
Date: Thu, 08 Nov 2012 22:35:13 -0500
Message-ID: <2121ce36cf4eb02385255cbd5b0bbd1dcc803113.1352431675.git.wking@tremily.us>
References: <cover.1352431674.git.wking@tremily.us>
Cc: Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 05:43:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWgQn-0002I5-1t
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 05:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab2KIEmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 23:42:47 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:52538 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2KIEmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 23:42:46 -0500
X-Greylist: delayed 3608 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2012 23:42:46 EST
Received: from odin.tremily.us ([unknown] [72.68.90.158])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MD7004B8BMJQ400@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 08 Nov 2012 21:42:20 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id E462D68EDC6; Thu,
 08 Nov 2012 22:42:18 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.gc2eb43a
In-reply-to: <cover.1352431674.git.wking@tremily.us>
In-reply-to: <cover.1352431674.git.wking@tremily.us>
References: <20121029222759.GI20513@sigill.intra.peff.net>
 <cover.1352431674.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209204>

From: "W. Trevor King" <wking@tremily.us>

This makes it easy to access per-submodule variables.  For example,

  git submodule foreach 'git checkout $(git config --file $toplevel/.gitmodules submodule.$name.branch) && git pull'

can now be reduced to

  git submodule foreach 'git checkout $submodule_branch && git pull'

Every submodule.<name>.<opt> setting from .gitmodules is available as
a $submodule_<sanitized-opt> variable.  These variables are not
propagated recursively into nested submodules.

Signed-off-by: W. Trevor King <wking@tremily.us>
Based-on-patch-by: Phil Hord <phil.hord@gmail.com>
---
 Documentation/git-submodule.txt |  3 +++
 git-sh-setup.sh                 | 20 ++++++++++++++++++++
 git-submodule.sh                | 16 ++++++++++++++++
 t/t7407-submodule-foreach.sh    | 29 +++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 mode change 100644 => 100755 git-sh-setup.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cbec363..9a99826 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -175,6 +175,9 @@ foreach::
 	$path is the name of the submodule directory relative to the
 	superproject, $sha1 is the commit as recorded in the superproject,
 	and $toplevel is the absolute path to the top-level of the superproject.
+	In addition, every submodule.<name>.<opt> setting from .gitmodules
+	is available as the variable $submodule_<sanitized_opt>.  These
+	variables are not propagated recursively into nested submodules.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
old mode 100644
new mode 100755
index ee0e0bc..179a920
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -222,6 +222,26 @@ clear_local_git_env() {
 	unset $(git rev-parse --local-env-vars)
 }
 
+# Remove any suspect characters from a user-generated variable name.
+sanitize_variable_name() {
+	VAR_NAME="$1"
+	printf '%s' "$VAR_NAME" |
+	sed -e 's/^[^a-zA-Z]/_/' -e 's/[^a-zA-Z0-9]/_/g'
+}
+
+# Return a command for setting a new variable.
+# Neither the variable name nor the variable value passed to this
+# function need to be sanitized.  You need to eval the returned
+# string, because new variables set by the function itself don't
+# effect the calling process.
+set_user_variable() {
+	VAR_NAME="$1"
+	VAR_VALUE="$2"
+	VAR_NAME=$(sanitize_variable_name "$VAR_NAME")
+	VAR_VALUE=$(printf '%s' "$VAR_VALUE" |
+		sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')
+	printf '%s=%s;\n' "$VAR_NAME" "\"$VAR_VALUE\""
+}
 
 # Platform specific tweaks to work around some commands
 case $(uname -s) in
diff --git a/git-submodule.sh b/git-submodule.sh
index bc33112..e4d26f9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -434,8 +434,24 @@ cmd_foreach()
 				clear_local_git_env
 				# we make $path available to scripts ...
 				path=$sm_path
+
+				# make all submodule variables available to scripts
+				eval $(
+					git config -f .gitmodules --get-regexp "^submodule\.${name}\..*" |
+					sed -e "s|^submodule\.${name}\.||" |
+					while read VAR_NAME VAR_VALUE ; do
+						VAR_NAME=$(printf '%s' "$VAR_NAME" | tr A-Z a-z)
+						set_user_variable "submodule_${VAR_NAME}" "$VAR_VALUE"
+					done)
+				UNSET_CMD=$(set |
+					sed -n -e 's|^\(submodule_[a-z_]*\)=.*$|\1|p' |
+					while read VAR_NAME ; do
+						printf 'unset %s;\n' "$VAR_NAME"
+					done)
+
 				cd "$sm_path" &&
 				eval "$@" &&
+				eval "$UNSET_CMD" &&
 				if test -n "$recursive"
 				then
 					cmd_foreach "--recursive" "$@"
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9b69fe2..46ac746 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -313,4 +313,33 @@ test_expect_success 'command passed to foreach --recursive retains notion of std
 	test_cmp expected actual
 '
 
+cat > expect <<EOF
+Entering 'nested1'
+nested1 nested1 wonky"value
+Entering 'nested1/nested2'
+nested2 nested2 another wonky"value
+Entering 'nested1/nested2/nested3'
+nested3 nested3
+Entering 'nested1/nested2/nested3/submodule'
+submodule submodule
+Entering 'sub1'
+sub1 sub1
+Entering 'sub2'
+sub2 sub2
+Entering 'sub3'
+sub3 sub3
+EOF
+
+test_expect_success 'test foreach environment variables' '
+	(
+		cd clone2 &&
+		git config -f .gitmodules submodule.nested1.wonky-var "wonky\"value" &&
+		git config -f nested1/.gitmodules submodule.nested2.wonky-var "another wonky\"value" &&
+		git submodule foreach --recursive "echo \$path \$submodule_path \$submodule_wonky_var" > ../actual
+	) &&
+	test_i18ncmp expect actual
+'
+#
+#"echo \$toplevel-\$name-\$submodule_path-\$submodule_url"
+
 test_done
-- 
1.8.0.3.gc2eb43a
