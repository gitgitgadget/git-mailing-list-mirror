From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/8] add -i, send-email, svn, p4, etc: use "git var
 GIT_EDITOR"
Date: Fri, 30 Oct 2009 20:42:34 -0500
Message-ID: <20091031014234.GF5160@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:32:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42pL-0005vW-LA
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077AbZJaBcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 21:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757601AbZJaBcN
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:32:13 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35354 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757594AbZJaBcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 21:32:12 -0400
Received: by yxe17 with SMTP id 17so3224147yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PbuCpK//hzONVy8xl1ZcPB/KrUk9yja1/x+lZgwH2eA=;
        b=C6JQ11IYhHUZyKaaaSOfO5i1ozekcEwxNX7a6YRViZldqNs7GtU8Zc4IfCB+/R6zXs
         CDtqzihHfJ+sxKqQQcD0QrifQEna1I8nozxIgUthxGLnTzAFFwJaPcJtvKHfJjLikaqb
         Cxmu6Tp+dD7E20K/YvSFasNf/rqZJcyV91mz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wRhUMFEL2aFClzuP2sPMmqm1TgyH2yGLIfRuZjHJXSiBmP5Tmpx5klR1ZLskhHFcWR
         tcEZm9MvC84hKISL8GaHPAEsjmR9eNafxmFYWWq/n+vwLfIxu+tqC/2aKi97qby5tyVj
         0LL5B/p6q90a5RwojXjHJahzznQ6Xv+utclpI=
Received: by 10.150.172.1 with SMTP id u1mr4184214ybe.300.1256952737613;
        Fri, 30 Oct 2009 18:32:17 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm830528gxk.8.2009.10.30.18.32.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 18:32:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031012050.GA5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131818>

Use the new "git var GIT_EDITOR" feature to decide what editor to
use, instead of duplicating its logic elsewhere.  This should make
the behavior of commands in edge cases (e.g., editor names with
spaces) a little more consistent.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config.txt         |    4 +---
 Documentation/git-commit.txt     |    2 +-
 Documentation/git-send-email.txt |    4 ++--
 contrib/fast-import/git-p4       |    5 +----
 git-add--interactive.perl        |    3 +--
 git-send-email.perl              |    3 ++-
 git-sh-setup.sh                  |   19 ++++++-------------
 git-svn.perl                     |    5 ++---
 8 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1e2120..5181b77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -387,9 +387,7 @@ core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
 	variable when it is set, and the environment variable
-	`GIT_EDITOR` is not set.  The order of preference is
-	`GIT_EDITOR` environment, `core.editor`, `VISUAL` and
-	`EDITOR` environment variables and then finally `vi`.
+	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
 
 core.pager::
 	The command that git will use to paginate output.  Can
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0578a40..3ea80c8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -323,7 +323,7 @@ ENVIRONMENT AND CONFIGURATION VARIABLES
 The editor used to edit the commit log message will be chosen from the
 GIT_EDITOR environment variable, the core.editor configuration variable, the
 VISUAL environment variable, or the EDITOR environment variable (in that
-order).
+order).  See linkgit:git-var[1] for details.
 
 HOOKS
 -----
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 767cf4d..c85d7f4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -60,8 +60,8 @@ The --bcc option must be repeated for each user you want on the bcc list.
 The --cc option must be repeated for each user you want on the cc list.
 
 --compose::
-	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
-	introductory message for the patch series.
+	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
+	to edit an introductory message for the patch series.
 +
 When '--compose' is used, git send-email will use the From, Subject, and
 In-Reply-To headers specified in the message. If the body of the message
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e710219..48059d0 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -729,13 +729,10 @@ class P4Submit(Command):
             tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
             tmpFile.close()
             mtime = os.stat(fileName).st_mtime
-            defaultEditor = "vi"
-            if platform.system() == "Windows":
-                defaultEditor = "notepad"
             if os.environ.has_key("P4EDITOR"):
                 editor = os.environ.get("P4EDITOR")
             else:
-                editor = os.environ.get("EDITOR", defaultEditor);
+                editor = read_pipe("git var GIT_EDITOR")
             system(editor + " " + fileName)
 
             response = "y"
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 69aeaf0..0c74e5c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -987,8 +987,7 @@ sub edit_hunk_manually {
 EOF
 	close $fh;
 
-	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor")
-		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	chomp(my $editor = run_cmd_pipe(qw(git var GIT_EDITOR)));
 	system('sh', '-c', $editor.' "$@"', $editor, $hunkfile);
 
 	if ($? != 0) {
diff --git a/git-send-email.perl b/git-send-email.perl
index a0279de..4f5da4e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -162,7 +162,8 @@ my $compose_filename;
 
 # Handle interactive edition of files.
 my $multiedit;
-my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+my $editor = Git::command_oneline('var', 'GIT_EDITOR');
+
 sub do_edit {
 	if (defined($multiedit) && !$multiedit) {
 		map {
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c41c2f7..99cceeb 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -99,19 +99,12 @@ set_reflog_action() {
 }
 
 git_editor() {
-	: "${GIT_EDITOR:=$(git config core.editor)}"
-	: "${GIT_EDITOR:=${VISUAL:-${EDITOR}}}"
-	case "$GIT_EDITOR,$TERM" in
-	,dumb)
-		echo >&2 "No editor specified in GIT_EDITOR, core.editor, VISUAL,"
-		echo >&2 "or EDITOR. Tried to fall back to vi but terminal is dumb."
-		echo >&2 "Please set one of these variables to an appropriate"
-		echo >&2 "editor or run $0 with options that will not cause an"
-		echo >&2 "editor to be invoked (e.g., -m or -F for git-commit)."
-		exit 1
-		;;
-	esac
-	eval "${GIT_EDITOR:=vi}" '"$@"'
+	if test -z "${GIT_EDITOR:+set}"
+	then
+		GIT_EDITOR="$(git var GIT_EDITOR)" || return $?
+	fi
+
+	eval "$GIT_EDITOR" '"$@"'
 }
 
 is_bare_repository () {
diff --git a/git-svn.perl b/git-svn.perl
index 6a3b501..42c9a72 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1321,9 +1321,8 @@ sub get_commit_entry {
 	close $log_fh or croak $!;
 
 	if ($_edit || ($type eq 'tree')) {
-		my $editor = $ENV{VISUAL} || $ENV{EDITOR} || 'vi';
-		# TODO: strip out spaces, comments, like git-commit.sh
-		system($editor, $commit_editmsg);
+		chomp(my $editor = command_oneline(qw(var GIT_EDITOR)));
+		system('sh', '-c', $editor.' "$@"', $editor, $commit_editmsg);
 	}
 	rename $commit_editmsg, $commit_msg or croak $!;
 	{
-- 
1.6.5.2
