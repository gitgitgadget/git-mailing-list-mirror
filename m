From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git remote add should be able to extend remotes
Date: Sat, 15 May 2010 19:45:38 -0500
Message-ID: <20100516004538.GA5528@progeny.tock>
References: <20070710133226.GA23751@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 432557@bugs.debian.org, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Sun May 16 02:45:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODRzG-0000bg-Dl
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 02:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab0EPApj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 20:45:39 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:40352 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab0EPApi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 20:45:38 -0400
Received: by gxk9 with SMTP id 9so2505492gxk.8
        for <git@vger.kernel.org>; Sat, 15 May 2010 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tRnPS6FmgnTTwRLzPd2/YICKacN4o4LCO/Q34YCSF+E=;
        b=e5kr5wh47JALkoh/le17oBRBykbpMGNrljoQVMh51cH42faKf0NQ4i5b9w9kvc74J4
         x88xYDC8pu4wctc8iOoQ+o2Afb9T/9TdbBXN99ZE+WQWGMHSzX56onjbjsZtSrHwiqKV
         BsDshgWPiHmeRet2PkdRhrLMatl+u+OavDNis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sjGYEfKsaggnFeQ2KzeffXFLPSGwlzfFlWdLY0JlcYvObl3X1RfkIFjCMCy+dWdUMd
         JNaqsW5fGiosQbIBou8Z2wgkLf1dmfcAedjlMwj50uLR/VoWGUFaK535zYAzAh3oM2EP
         J190Nsj9SQyrDREEglyhDFU1T7XQyZ9XhJtSg=
Received: by 10.150.127.5 with SMTP id z5mr4430149ybc.275.1273970737221;
        Sat, 15 May 2010 17:45:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2524447yxe.10.2010.05.15.17.45.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 17:45:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070710133226.GA23751@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147171>

reassign 432557 git git/1:1.5.2.3-1
found 432557 git/1:1.7.1-1
tags 432557 + upstream
quit

Hi Martin,

Sorry for the long silence.

martin f krafft wrote:

> piper:/tmp/cdt.xBt19067/host1> git remote add -t A -t B base ../base
> piper:/tmp/cdt.xBt19067/host1> git remote add -t C base ../base
> remote base already exists.
> 
> It would be nice if I could add branches to be tracked in a given
> remote, ideally without having to specify the path:
> 
>   git remote add -t C base

Yes, this seems like useful functionality.

It would be handy to be able to remove branches, too.  I have not
really wrapped my head around the set-* subcommands, but how about
something like this?

  git remote set-branches base --add C
  git remote set-branches base A B D
  git remote set-branches base --delete D; # not implemented

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-remote.txt |   13 +++++
 builtin/remote.c             |  102 +++++++++++++++++++++++++++++++++++++-----
 t/t5505-remote.sh            |   88 ++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 3fc599c..de4386b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
+'git remote set-branches' <name> [--add] <branch>...
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
@@ -104,6 +105,18 @@ remote set-head origin master" will set `$GIT_DIR/refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
 +
 
+'set-branches'::
+
+Changes the list of branches tracked by the named remote.
+This can be used to track a subset of the available remote branches
+after the initial setup for a remote.
++
+The named branches will be interpreted as if specified with the
+`-t` option on the 'git remote add' command line.
++
+With `--add`, instead of replacing the list of currently tracked
+branches, adds to that list.
+
 'set-url'::
 
 Changes URL remote points to. Sets first URL remote points to matching
diff --git a/builtin/remote.c b/builtin/remote.c
index c13e2dd..7de1614 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
+	"git remote set-branches <name> [--add] <branch>...",
 	"git remote set-url <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
 	"git remote set-url --delete <name> <url>",
@@ -42,6 +43,12 @@ static const char * const builtin_remote_sethead_usage[] = {
 	NULL
 };
 
+static const char * const builtin_remote_setbranches_usage[] = {
+	"git remote set-branches <name> <branch>...",
+	"git remote set-branches --add <name> <branch>...",
+	NULL
+};
+
 static const char * const builtin_remote_show_usage[] = {
 	"git remote show [<options>] <name>",
 	NULL
@@ -104,6 +111,20 @@ static int fetch_remote(const char *name)
 	return 0;
 }
 
+static int add_branch(const char *key, const char *branchname,
+		const char *remotename, int mirror, struct strbuf *tmp)
+{
+	strbuf_reset(tmp);
+	strbuf_addch(tmp, '+');
+	if (mirror)
+		strbuf_addf(tmp, "refs/%s:refs/%s",
+				branchname, branchname);
+	else
+		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
+				branchname, remotename, branchname);
+	return git_config_set_multivar(key, tmp->buf, "^$", 0);
+}
+
 static int add(int argc, const char **argv)
 {
 	int fetch = 0, mirror = 0;
@@ -151,17 +172,8 @@ static int add(int argc, const char **argv)
 	if (track.nr == 0)
 		string_list_append("*", &track);
 	for (i = 0; i < track.nr; i++) {
-		struct string_list_item *item = track.items + i;
-
-		strbuf_reset(&buf2);
-		strbuf_addch(&buf2, '+');
-		if (mirror)
-			strbuf_addf(&buf2, "refs/%s:refs/%s",
-					item->string, item->string);
-		else
-			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
-					item->string, name, item->string);
-		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
+		if (add_branch(buf.buf, track.items[i].string,
+				name, mirror, &buf2))
 			return 1;
 	}
 
@@ -1265,6 +1277,72 @@ static int update(int argc, const char **argv)
 	return run_command_v_opt(fetch_argv, RUN_GIT_CMD);
 }
 
+static int remove_all_fetch_refspecs(const char *remote, const char *key)
+{
+	return git_config_set_multivar(key, NULL, NULL, 1);
+}
+
+static int add_branches(struct remote *remote, const char **branches,
+			const char *key)
+{
+	const char *remotename = remote->name;
+	int mirror = remote->mirror;
+	struct strbuf refspec = STRBUF_INIT;
+
+	for (; *branches; branches++)
+		if (add_branch(key, *branches, remotename, mirror, &refspec)) {
+			strbuf_release(&refspec);
+			return 1;
+		}
+
+	strbuf_release(&refspec);
+	return 0;
+}
+
+static int set_remote_branches(const char *remotename, const char **branches,
+				int add_mode)
+{
+	struct strbuf key = STRBUF_INIT;
+	struct remote *remote;
+
+	strbuf_addf(&key, "remote.%s.fetch", remotename);
+
+	if (!remote_is_configured(remotename))
+		die("No such remote '%s'", remotename);
+	remote = remote_get(remotename);
+
+	if (!add_mode && remove_all_fetch_refspecs(remotename, key.buf)) {
+		strbuf_release(&key);
+		return 1;
+	}
+	if (add_branches(remote, branches, key.buf)) {
+		strbuf_release(&key);
+		return 1;
+	}
+
+	strbuf_release(&key);
+	return 0;
+}
+
+static int set_branches(int argc, const char **argv)
+{
+	int add_mode = 0;
+	struct option options[] = {
+		OPT_BOOLEAN('\0', "add", &add_mode, "add branch"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_remote_setbranches_usage, 0);
+	if (argc == 0) {
+		error("no remote specified");
+		usage_with_options(builtin_remote_seturl_usage, options);
+	}
+	argv[argc] = NULL;
+
+	return set_remote_branches(argv[0], argv + 1, add_mode);
+}
+
 static int set_url(int argc, const char **argv)
 {
 	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
@@ -1430,6 +1508,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = rm(argc, argv);
 	else if (!strcmp(argv[0], "set-head"))
 		result = set_head(argc, argv);
+	else if (!strcmp(argv[0], "set-branches"))
+		result = set_branches(argc, argv);
 	else if (!strcmp(argv[0], "set-url"))
 		result = set_url(argc, argv);
 	else if (!strcmp(argv[0], "show"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 230c0cd..8aaf53e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -534,6 +534,94 @@ test_expect_success 'show empty remote' '
 	)
 '
 
+test_expect_success 'remote set-branches requires a remote' '
+	test_must_fail git remote set-branches &&
+	test_must_fail git remote set-branches --add
+'
+
+test_expect_success 'remote set-branches' '
+	echo "+refs/heads/*:refs/remotes/scratch/*" >expect.initial &&
+	sort <<-\EOF >expect.add &&
+	+refs/heads/*:refs/remotes/scratch/*
+	+refs/heads/other:refs/remotes/scratch/other
+	EOF
+	sort <<-\EOF >expect.replace &&
+	+refs/heads/maint:refs/remotes/scratch/maint
+	+refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/next:refs/remotes/scratch/next
+	EOF
+	sort <<-\EOF >expect.add-two &&
+	+refs/heads/maint:refs/remotes/scratch/maint
+	+refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/next:refs/remotes/scratch/next
+	+refs/heads/pu:refs/remotes/scratch/pu
+	+refs/heads/t/topic:refs/remotes/scratch/t/topic
+	EOF
+	sort <<-\EOF >expect.setup-ffonly &&
+	refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/next:refs/remotes/scratch/next
+	EOF
+	sort <<-\EOF >expect.respect-ffonly &&
+	refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/next:refs/remotes/scratch/next
+	+refs/heads/pu:refs/remotes/scratch/pu
+	EOF
+
+	git clone .git/ setbranches &&
+	(
+		cd setbranches &&
+		git remote rename origin scratch &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.initial &&
+
+		git remote set-branches scratch --add other &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.add &&
+
+		git remote set-branches scratch maint master next &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.replace &&
+
+		git remote set-branches --add scratch pu t/topic &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.add-two &&
+
+		git config --unset-all remote.scratch.fetch &&
+		git config remote.scratch.fetch \
+			refs/heads/master:refs/remotes/scratch/master &&
+		git config --add remote.scratch.fetch \
+			+refs/heads/next:refs/remotes/scratch/next &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.setup-ffonly &&
+
+		git remote set-branches --add scratch pu &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.respect-ffonly
+	) &&
+	test_cmp expect.initial actual.initial &&
+	test_cmp expect.add actual.add &&
+	test_cmp expect.replace actual.replace &&
+	test_cmp expect.add-two actual.add-two &&
+	test_cmp expect.setup-ffonly actual.setup-ffonly &&
+	test_cmp expect.respect-ffonly actual.respect-ffonly
+'
+
+test_expect_success 'remote set-branches with --mirror' '
+	echo "+refs/*:refs/*" >expect.initial &&
+	echo "+refs/heads/master:refs/heads/master" >expect.replace &&
+	git clone --mirror .git/ setbranches-mirror &&
+	(
+		cd setbranches-mirror &&
+		git remote rename origin scratch &&
+		git config --get-all remote.scratch.fetch >../actual.initial &&
+
+		git remote set-branches scratch heads/master &&
+		git config --get-all remote.scratch.fetch >../actual.replace
+	) &&
+	test_cmp expect.initial actual.initial &&
+	test_cmp expect.replace actual.replace
+'
+
 test_expect_success 'new remote' '
 	git remote add someremote foo &&
 	echo foo >expect &&
-- 
1.7.1
