From: Dmitry Potapov <dpotapov@gmail.com>
Subject: git rebase interactive: usability issue
Date: Thu, 26 Jun 2008 03:32:08 +0400
Message-ID: <20080625233208.GE5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:33:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeUa-0000qM-3i
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbYFYXcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756464AbYFYXcQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:32:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31804 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbYFYXcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:32:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1465304fgg.17
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 16:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=X2W+yH7jvo3PUQmMfQNbXKCqhPySQakQRAWcsTXN504=;
        b=F7Eryp6wXmBE/hOmlqFvYjt/rkVGDITFJFCnDqXnNmXZTg8u/T/oDrkDzfXARtO4wR
         AB3MBx9+XyNMLq+If8c/B0+vPheWiGLD86QOcz4UhXZRHRYHXpmNpEJiCqh/hHjUf5FT
         NjcneTeGaNNgxCfLP6ifDgzzOU63VcZHRbaFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=TNZwfHmuy9IQhAY1v2AWYoa6sMACWmdVqoFjuGI7zL5Rsn29GCW79ANADHbpN1Orp7
         mEVU2fu1khgdTwSBBp2sitEORbkshd3WDoQhNc5o+o9bjjyhd9pJm55c2xcc7g7V+Smy
         pfwHYy5LGyLTcP7Dtgqoc91oWQ43vM7gyDDK4=
Received: by 10.86.29.19 with SMTP id c19mr11280080fgc.28.1214436731608;
        Wed, 25 Jun 2008 16:32:11 -0700 (PDT)
Received: from localhost ( [85.141.151.43])
        by mx.google.com with ESMTPS id d6sm15501793fga.2.2008.06.25.16.32.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 16:32:10 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86372>

Hello All,

Today I got another user complaining that git rebase interactive
sometimes squashing changes without being told to do that. Studying the
reflog revealed what I expected to see: the user started the process of
editing of  chain of patches started by "git rebase -i", and then used
"git commit --amend" to correct some of them, but at some point the
process of rebasing was stopped due to a conflict caused by some previous
changes. The user after resolving this conflict run "git commit --amend"
as he did before, without realising that this time it will squash the
current patch with the previous one.

Though the user realized his mistake after my explanation of how git
rebase works, I still believe it is a serious usability issue, because
the same command: "git commit --amend" produces drastically different
results depends on whether the rebase process stopped due to conflict
or on the "edit" mark. Moreover, the commit message of second patch is
getting lost as result of using "git commit --amend" in the former case.

Personally, I have avoided this issue because normally I don't use git
commit --amend during rebasing unless I have to correct the commit
message. Instead, I just edit files and then do "git add" on them and
then run "git rebase --continue". But latest versions of git suggest
you use "git commit --amend" during interactive rebasing and following
this advice, it is easy to fall into this trap.

The following patch disables "git commit --amend" during rebase when
the process was stopped due to conflict.

-- >8 --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Wed, 25 Jun 2008 23:23:22 +0400
Subject: [PATCH] don't allow 'commit --amend' during rebase conflict resolution

Running 'commit --amend' during git rebase is almost certainly a mistake,
which causes that two consequent patches are squashed together. Moreover,
the commit message of the second commit is silently lost. It is almost
certainly not what the user expects. In that very unlikely case when you
really want to combine two patches during rebase conflict resolution,
you can do that using "git reset --soft HEAD^" followed by "git commit".

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 builtin-commit.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e3ad38b..d03696f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -925,6 +925,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage);
 
+	strbuf_init(&sb, 0);
+	if (amend)
+	{
+		strbuf_addf(&sb, "%s/.dotest-merge", get_git_dir());
+		if (!access(sb.buf, F_OK)) {
+			strbuf_addstr(&sb,"/amend");
+			if (access(sb.buf, F_OK))
+				die("amend not committed yet patch?");
+		}
+	}
+
 	index_file = prepare_index(argc, argv, prefix);
 
 	/* Set up everything for writing the commit object.  This includes
@@ -937,7 +948,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	/*
 	 * The commit object
 	 */
-	strbuf_init(&sb, 0);
+	strbuf_reset(&sb);
 	strbuf_addf(&sb, "tree %s\n",
 		    sha1_to_hex(active_cache_tree->sha1));
 
-- 
1.5.6
