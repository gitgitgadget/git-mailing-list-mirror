From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Tue, 15 Feb 2011 16:18:32 -0600
Message-ID: <20110215221832.GA826@elie>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:18:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTEN-0001HF-JO
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233Ab1BOWSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 17:18:43 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61000 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab1BOWSm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 17:18:42 -0500
Received: by vxb37 with SMTP id 37so476277vxb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 14:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=BStQoiGiETFoGSHtBzbn6OgA5j3Zmsycdl/N+QDQg5Q=;
        b=JRyqbji2PaZGX9xyWZx+nz3jfwaHDfrXiANjcsB2pGUJos7cOi/d6ILGx1133qgEa5
         Z9HgFfBWfEtIcsaa4lyTL4KgQeHbSwwUkDtZ0JPc7rTOfZhzQKIG2S+NDuLqyBkxswbI
         LaLF7tgdtUoTK0aUPUTGkgUZJUCYV0D1mxwag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VU7OwGtqh/16vyANHA3aR6wDYrbVNC4QN6GXpTCzE3Zp545WhMVDVLOAuaPgZE10TU
         PS5BTKmSfXxqTbcAJAGxI3I8yX5BfogX4aZZunU2KiihCFGdzqHmf0FsM/0bSrQMSlNR
         9GwS44vVCLueqcPNjLE5oRZAFSx9UcieQv3eA=
Received: by 10.220.188.76 with SMTP id cz12mr1616738vcb.186.1297808321199;
        Tue, 15 Feb 2011 14:18:41 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id u4sm1464883vch.12.2011.02.15.14.18.39
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 14:18:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166888>

Jay Soffian wrote:

> When a cherry-pick conflicts git advises to use:
>
>  $ git commit -c <original commit id>
>
> to preserve the original commit message and authorship. Instead,
> let's record the original commit id in CHERRY_HEAD and advise to use:
>
>   $ git commit -c CHERRY_HEAD
>
> In the next commit, we teach git to handle the '-c CHERRY_HEAD' part.

Nice!  Thanks for working on this.

I wonder if cherry-pick shouldn't also write MERGE_MSG or similar so
that gets taken care of automatically?  That would also allow options
like -x and -m to work better.

Sign-off?

> +++ b/branch.c
> @@ -217,6 +217,7 @@ void create_branch(const char *head,
>
>  void remove_branch_state(void)
>  {
> +	unlink(git_path("CHERRY_HEAD"));
>  	unlink(git_path("MERGE_HEAD"));
[...]
> +++ b/builtin/commit.c
> @@ -1424,6 +1424,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
[...]
>  
> +	unlink(git_path("CHERRY_HEAD"));
>  	unlink(git_path("MERGE_HEAD"));

Another piece of code that checks for MERGE_HEAD is cmd_merge's
"You have not concluded your merge" check.  Should it check for
CHERRY_HEAD, too?

> +++ b/builtin/revert.c
> @@ -248,6 +248,22 @@ static void set_author_ident_env(const char *message)
>  			sha1_to_hex(commit->object.sha1));
>  }
>  
> +static void write_cherry_head(void)
> +{
> +	int fd;
> +	struct strbuf buf = STRBUF_INIT;

Leaked, I think.  I would have been tempted to put it in a char buf[50] ---
we can be glad you are writing this code. :)

With whatever subset of the following seems useful,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-cherry-pick.txt |   19 +++++++++++++++++++
 Documentation/revisions.txt       |    5 ++++-
 builtin/merge.c                   |    7 +++++++
 builtin/revert.c                  |    4 ++--
 t/t3507-cherry-pick-conflict.sh   |   22 +++++++++++++++++++++-
 5 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 749d68a..e8db99b 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -16,6 +16,25 @@ Given one or more existing commits, apply the change each one
 introduces, recording a new commit for each.  This requires your
 working tree to be clean (no modifications from the HEAD commit).
 
+When it is not obvious how to apply a change, the following
+happens:
+
+1. The current branch and `HEAD` pointer stay at the last commit
+   successfully made.
+2. The `CHERRY_HEAD` ref is set to point at the commit that
+   introduced the change that is difficult to apply.
+3. Paths in which the change applied cleanly are updated both
+   in the index file and in your working tree.
+4. For conflicting paths, the index file records up to three
+   versions, as described in the "TRUE MERGE" section of
+   linkgit:git-merge[1].  The working tree files will include
+   a description of the conflict bracketed by the usual
+   conflict markers `<<<<<<<` and `>>>>>>>`.
+5. No other modifications are made.
+
+See linkgit:git-merge[1] for some hints on resolving such
+conflicts.
+
 OPTIONS
 -------
 <commit>...::
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 9e92734..02f0813 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -25,7 +25,8 @@ blobs contained in a commit.
   first match in the following rules:
 
   . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
-    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD` and `MERGE_HEAD`);
+    useful only for `HEAD`, `FETCH_HEAD`, `CHERRY_HEAD`, `ORIG_HEAD`
+    and `MERGE_HEAD`);
 
   . otherwise, `refs/<name>` if exists;
 
@@ -40,6 +41,8 @@ blobs contained in a commit.
 HEAD names the commit your changes in the working tree is based on.
 FETCH_HEAD records the branch you fetched from a remote repository
 with your last 'git fetch' invocation.
+CHERRY_HEAD records the commit you are applying the change from
+when you run 'git cherry-pick'.
 ORIG_HEAD is created by commands that moves your HEAD in a drastic
 way, to record the position of the HEAD before their operation, so that
 you can change the tip of the branch back to the state before you ran
diff --git a/builtin/merge.c b/builtin/merge.c
index 9403747..cabfc9c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -971,6 +971,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die("You have not concluded your merge (MERGE_HEAD exists).");
 	}
+	if (file_exists(git_path("CHERRY_HEAD"))) {
+		if (advice_resolve_conflict)
+			die("You have not concluded your cherry-pick (CHERRY_HEAD exists).\n"
+			    "Please, commit your changes before you can merge.");
+		else
+			die("You have not concluded your cherry-pick (CHERRY_HEAD exists).");
+	}
 	resolve_undo_clear();
 
 	if (verbosity < 0)
diff --git a/builtin/revert.c b/builtin/revert.c
index c373e69..04da0e1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -259,9 +259,9 @@ static void write_cherry_head(void)
 	if (fd < 0)
 		die_errno("Could not open '%s' for writing",
 			  git_path("CHERRY_HEAD"));
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
 		die_errno("Could not write to '%s'", git_path("CHERRY_HEAD"));
-	close(fd);
+	strbuf_release(&buf);
 }
 
 static void advise(const char *advice, ...)
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 607bf25..71a2167 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -11,6 +11,12 @@ test_description='test cherry-pick and revert with conflicts
 
 . ./test-lib.sh
 
+test_cmp_rev () {
+	git rev-parse --verify "$1" >expect.rev &&
+	git rev-parse --verify "$2" >actual.rev &&
+	test_cmp expect.rev actual.rev
+}
+
 test_expect_success setup '
 
 	echo unrelated >unrelated &&
@@ -51,13 +57,27 @@ test_expect_success 'advice from failed cherry-pick' "
 	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: and commit the result with 'git commit -c \$picked'
+	hint: and commit the result with 'git commit -c CHERRY_HEAD'
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
 	test_cmp expected actual
 "
 
+test_expect_success 'failed cherry-pick sets CHERRY_HEAD' '
+
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	test_must_fail git cherry-pick picked &&
+
+	test_cmp_rev picked CHERRY_HEAD
+'
+
 test_expect_success 'failed cherry-pick produces dirty index' '
 
 	git checkout -f initial^0 &&
-- 
1.7.4.1
