From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 04/23] builtin-remote: add set-head subcommand
Date: Tue, 24 Feb 2009 04:50:52 -0500
Message-ID: <f712297e8a8df716fa9f75c8ce5ce0bb79380369.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzt-0002Ej-H3
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922AbZBXJvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbZBXJva
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:30 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:21822 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbZBXJv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:26 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005599yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jIaEoWuIiOZ9XUV4Ue8ymm9iCpI7Vvx17OEpPreQDjw=;
        b=Q2NVMsLO0VlFuYTJnlF7ZVhyqbIrJE2Oe7CLDbWrTfpfjqzIDjj+3JG6klp7n7UfQC
         5fmvrjtwTx2vceycWxlW1U28N2TiPWfGyE2xNj30ytell1UX3/yxnKepJ1A1oLVYD2DY
         YLJx1EJIp7tsX2QesJvO+C4Dg6+FmOBHSlVOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UfSTS2icNeRr2L/zV7r+CYebbyz/D3IgJmtJLGjzC/ZcXJSGYqQQJAWAgXEpvG6vfG
         wCNGj5sZWy7gUOm7JEKOjqdZhRSuFisuvaUJWKsVJQKL+Fze6KTE5wb0L2OvXs1fbp4N
         s59Uon3LrLr4HBt9UdqnRDBqd/qUyp2omkrdY=
Received: by 10.100.121.12 with SMTP id t12mr2426822anc.148.1235469084614;
        Tue, 24 Feb 2009 01:51:24 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c29sm12791174anc.43.2009.02.24.01.51.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:24 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111256>

Provide a porcelain command for setting and deleting
$GIT_DIR/remotes/<remote>/HEAD.

While we're at it, document what $GIT_DIR/remotes/<remote>/HEAD is all
about.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-remote.txt           |   28 ++++++++++++++++-
 builtin-remote.c                       |   51 ++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |    2 +-
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index fad983e..c9c0e6f 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
+'git remote set-head' <name> [-a | -d | <branch>]
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
 'git remote update' [group]
@@ -53,8 +54,7 @@ is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
-up to point at remote's `<master>` branch instead of whatever
-branch the `HEAD` at the remote repository actually points at.
+up to point at remote's `<master>` branch. See also the set-head command.
 +
 In mirror mode, enabled with `\--mirror`, the refs will not be stored
 in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
@@ -76,6 +76,30 @@ the configuration file format.
 Remove the remote named <name>. All remote tracking branches and
 configuration settings for the remote are removed.
 
+'set-head'::
+
+Sets or deletes the default branch (`$GIT_DIR/remotes/<name>/HEAD`) for
+the named remote. Having a default branch for a remote is not required,
+but allows the name of the remote to be specified in lieu of a specific
+branch. For example, if the default branch for `origin` is set to
+`master`, then `origin` may be specified wherever you would normally
+specify `origin/master`.
++
+With `-d`, `$GIT_DIR/remotes/<name>/HEAD` is deleted.
++
+With `-a`, the remote is queried to determine its `HEAD`, then
+`$GIT_DIR/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
+`HEAD` is pointed at `next`, "`git remote set-head origin -a`" will set
+`$GIT_DIR/refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
+only work if `refs/remotes/origin/next` already exists; if not it must be
+fetched first.
++
+Use `<branch>` to set `$GIT_DIR/remotes/<name>/HEAD` explicitly. e.g., "git
+remote set-head origin master" will set `$GIT_DIR/refs/remotes/origin/HEAD` to
+`refs/remotes/origin/master`. This will only work if
+`refs/remotes/origin/master` already exists; if not it must be fetched first.
++
+
 'show'::
 
 Gives some information about the remote <name>.
diff --git a/builtin-remote.c b/builtin-remote.c
index 465c87a..fcb166b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -12,6 +12,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
+	"git remote set-head <name> [-a | -d | <branch>]",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [group]",
@@ -777,6 +778,54 @@ static int show(int argc, const char **argv)
 	return result;
 }
 
+static int set_head(int argc, const char **argv)
+{
+	int opt_a = 0, opt_d = 0, result = 0;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	char *head_name = NULL;
+
+	struct option options[] = {
+		OPT_GROUP("set-head specific options"),
+		OPT_BOOLEAN('a', "auto", &opt_a,
+			    "set refs/remotes/<name>/HEAD according to remote"),
+		OPT_BOOLEAN('d', "delete", &opt_d,
+			    "delete refs/remotes/<name>/HEAD"),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+	if (argc)
+		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
+
+	if (!opt_a && !opt_d && argc == 2) {
+		head_name = xstrdup(argv[1]);
+	} else if (opt_a && !opt_d && argc == 1) {
+		struct ref_states states;
+		memset(&states, 0, sizeof(states));
+		get_remote_ref_states(argv[0], &states, 1);
+		head_name = xstrdup(states.head_name);
+		free_remote_ref_states(&states);
+	} else if (opt_d && !opt_a && argc == 1) {
+		if (delete_ref(buf.buf, NULL, REF_NODEREF))
+			result |= error("Could not delete %s", buf.buf);
+	} else
+		usage_with_options(builtin_remote_usage, options);
+
+	if (head_name) {
+		unsigned char sha1[20];
+		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		/* make sure it's valid */
+		if (!resolve_ref(buf2.buf, sha1, 1, NULL))
+			result |= error("Not a valid ref: %s", buf2.buf);
+		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
+			result |= error("Could not setup %s", buf.buf);
+		free(head_name);
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&buf2);
+	return result;
+}
+
 static int prune(int argc, const char **argv)
 {
 	int dry_run = 0, result = 0;
@@ -947,6 +996,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
+	else if (!strcmp(argv[0], "set-head"))
+		result = set_head(argc, argv);
 	else if (!strcmp(argv[0], "show"))
 		result = show(argc, argv);
 	else if (!strcmp(argv[0], "prune"))
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a3092f..15b938b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1443,7 +1443,7 @@ _git_config ()
 
 _git_remote ()
 {
-	local subcommands="add rename rm show prune update"
+	local subcommands="add rename rm show prune update set-head"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
-- 
1.6.2.rc1.291.g83eb
