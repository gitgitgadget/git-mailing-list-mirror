From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 04/10] git-shell: allow running git-cvsserver, not just cvs
Date: Sat, 24 Jan 2009 16:43:15 -0700
Message-ID: <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>,
	<Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBd-0006Ei-Fe
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbZAXXnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbZAXXnn
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:43 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:57598 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753404AbZAXXnc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:32 -0500
Received: from OMTA06.emeryville.ca.mail.comcast.net ([76.96.30.51])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id 7QbH1b00A16AWCUA2bjYW7; Sat, 24 Jan 2009 23:43:32 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA06.emeryville.ca.mail.comcast.net with comcast
	id 7bjW1b00K1TYyYj8SbjX60; Sat, 24 Jan 2009 23:43:32 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id A7EDA89118;
	Sat, 24 Jan 2009 16:43:24 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107018>

Add the ability to ask a git-shell restricted account to explicitly run
git-cvsserver, instead of requesting a fake "cvs".  With this, an account
could be reconfigured to use/not use git-shell without requiring
changes to client side configuration.  It also avoids confusing
users about which way cvs should be configured; if cvs is accessing
a git repository, always set CVS_SERVER=git-cvsserver.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

--------------
Question 1:

There is a surprising shortage of solid information about the
best way(s) restrict what commands can be run by ssh accounts,
both in general and for git specifically.  Is
putting git-shell in /etc/passwd the best way?  Are there other ways,
just as good or better?

Perhaps someone who really knows could add something to the git-shell.txt
man page describing the possible way(s) to configure an account to
be restricted to git-shell.

--------------
Question 2:

As near as I can tell, git-shell as run by sshd is typically
invoked such that it ends up with an argv with 3 arguments of the
form ("git-shell","-c","command arguments"). 
But the (argc==2 "cvs server") special case near line 69 of shell.c
appears to allow the middle argument ("-c") to be missing, but
only for "cvs server".

My question is, why was this special case put there?  Is a remnant of
an imperfect ad-hoc test framework someone used, or is there a
legitimate configuration where the "-c" is missing?

It seems to me that either this missing "-c" case should be
eliminated, or it should be made more general: If some
configuration of sshd leaves out the "-c", then it probably
leaves it out for anything you try to invoke, not just
"cvs server".

--------------
Hints about testing:

In addition to the test cases that are included in the patch, I tested
this by setting up an extra user account with the following
shell script set as the shell in /etc/passwd (yes, a shell script
is my shell...).  This allows me to tweak enviornment variables,
log how it is invoked, maybe tee off the stdin/stdout, etc:

---CUT---
#!/bin/sh

log()
{ echo "$1" >> remote.log
}

log "------------"
log ""
log "cmd:$0"
for arg in "$@" ; do
  log "arg:$arg"
done

PATH="/path/to/version/to/test:$PATH"
log "path: $PATH"
#tee input.out | git-shell "$@" | tee output.out
exec git-shell "$@"
---CUT---

But note that you probably do NOT want to route through a
wrapper like this for production...

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

 Documentation/git-cvsserver.txt |    7 ++-
 Documentation/git-shell.txt     |    5 +-
 shell.c                         |    1 +
 t/t9400-git-cvsserver-server.sh |   88 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 785779e..e32ad7b 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -113,9 +113,12 @@ cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
 ------
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
-variable.  SSH users restricted to 'git-shell' don't need to override the default
-with CVS_SERVER (and shouldn't) as 'git-shell' understands `cvs` to mean
+variable.  SSH users restricted to 'git-shell' do not need to
+override CVS_SERVER as 'git-cvsserver' because
+'git-shell' understands `cvs` to mean
 'git-cvsserver' and pretends that the other end runs the real 'cvs' better.
+But restricted users can still override it for consistency and to avoid
+reconfiguration if they are later promoted to full SSH access.
 --
 2. For each repo that you want accessible from CVS you need to edit config in
    the repo and add the following section.
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 3f8d973..68cb834 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -18,8 +18,9 @@ of server-side GIT commands implementing the pull/push functionality.
 The commands can be executed only by the '-c' option; the shell is not
 interactive.
 
-Currently, only three commands are permitted to be called, 'git-receive-pack'
-'git-upload-pack' with a single required argument or 'cvs server' (to invoke
+Currently, only four commands are permitted to be called, 'git-receive-pack'
+'git-upload-pack' with a single required argument,
+'git-cvsserver server', or 'cvs server' (to invoke
 'git-cvsserver').
 
 Author
diff --git a/shell.c b/shell.c
index e339369..6ed960f 100644
--- a/shell.c
+++ b/shell.c
@@ -40,6 +40,7 @@ static struct commands {
 } cmd_list[] = {
 	{ "git-receive-pack", do_generic_cmd },
 	{ "git-upload-pack", do_generic_cmd },
+	{ "git-cvsserver", do_cvs_cmd },
 	{ "cvs", do_cvs_cmd },
 	{ NULL },
 };
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 6a37f71..b23a774 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -501,4 +501,92 @@ test_expect_success 'cvs annotate' '
     test_cmp ../expect ../actual
 '
 
+#------------
+# access server through git-shell:
+#------------
+
+cd "$WORKDIR"
+test_expect_success 'setup fake_ssh' '
+    cd cvswork &&
+    ( echo "#!/bin/sh" &&
+      echo "echo \"cmd:\$*\" >> fake_ssh_sh.log" &&
+      echo "if test x\"\$1 \$2 \$3\" = x\"-l user machine\" ; then" &&
+      echo "  shift ; shift ; shift" &&
+      echo "  exec /bin/sh -c \"\$*\"" &&
+      echo "fi" &&
+      echo "echo FAIL" &&
+      echo "exit 1"
+    ) > fake_ssh_sh &&
+    ( echo "#!/bin/sh" &&
+      echo "echo \"cmd:\$*\" >> fake_ssh_git-shell.log" &&
+      echo "if test x\"\$1 \$2 \$3\" = x\"-l user machine\" ; then" &&
+      echo "  shift ; shift ; shift" &&
+      echo "  exec git-shell -c \"\$*\""
+      echo "fi" &&
+      echo "echo FAIL" &&
+      echo "exit 1"
+    ) > fake_ssh_git-shell &&
+    chmod +x fake_ssh_sh fake_ssh_git-shell
+'
+
+cd "$WORKDIR"
+test_expect_success 'fake_ssh ... sh git-cvsserver' '
+    ( cd cvswork &&
+      CVS_SERVER="git-cvsserver" &&
+      CVS_RSH="./fake_ssh_sh" &&
+      CVSROOT=":ext:user@machine$SERVERDIR" &&
+      export CVS_SERVER CVS_RSH CVSROOT &&
+      GIT_CONFIG="$git_config" cvs -d "$CVSROOT" up -p status.file > ../out &&
+      cmp status.file ../out
+    )
+'
+
+cd "$WORKDIR"
+test_expect_success 'fake_ssh ... sh git cvsserver' '
+    ( cd cvswork &&
+      CVS_SERVER="git cvsserver" &&
+      CVS_RSH="./fake_ssh_sh" &&
+      CVSROOT=":ext:user@machine$SERVERDIR" &&
+      export CVS_SERVER CVS_RSH CVSROOT &&
+      GIT_CONFIG="$git_config" cvs -d "$CVSROOT" up -p status.file > ../out &&
+      cmp status.file ../out
+    )
+'
+
+cd "$WORKDIR"
+test_expect_success 'fake_ssh ... git-shell git-cvsserver' '
+    ( cd cvswork &&
+      CVS_SERVER="git-cvsserver" &&
+      CVS_RSH="./fake_ssh_git-shell" &&
+      CVSROOT=":ext:user@machine$SERVERDIR" &&
+      export CVS_SERVER CVS_RSH CVSROOT &&
+      GIT_CONFIG="$git_config" cvs -d "$CVSROOT" up -p status.file > ../out &&
+      cmp status.file ../out
+    )
+'
+
+cd "$WORKDIR"
+test_expect_success 'fake_ssh ... git-shell git cvsserver' '
+    ( cd cvswork &&
+      CVS_SERVER="git cvsserver" &&
+      CVS_RSH="./fake_ssh_git-shell" &&
+      CVSROOT=":ext:user@machine$SERVERDIR" &&
+      export CVS_SERVER CVS_RSH CVSROOT &&
+      GIT_CONFIG="$git_config" cvs -d "$CVSROOT" up -p status.file > ../out &&
+      cmp status.file ../out
+    )
+'
+
+cd "$WORKDIR"
+test_expect_success 'fake_ssh ... git-shell cvs' '
+    ( cd cvswork &&
+      CVS_SERVER="cvs" &&
+      CVS_RSH="./fake_ssh_git-shell" &&
+      CVSROOT=":ext:user@machine$SERVERDIR" &&
+      export CVS_SERVER CVS_RSH CVSROOT &&
+      GIT_CONFIG="$git_config" cvs -d "$CVSROOT" up -p status.file > ../out &&
+      cmp status.file ../out
+    )
+'
+
 test_done
-- 
1.6.1.81.g9833d.dirty
