From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch --track and remote branches with / in the name
Date: Tue, 05 Jun 2007 03:22:39 -0700
Message-ID: <7v4plmd7kg.fsf@assigned-by-dhcp.cox.net>
References: <20070605090404.24707.qmail@b58755fd627261.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWBd-0004ZC-G0
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763748AbXFEKWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763735AbXFEKWl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:22:41 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51557 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763486AbXFEKWk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:22:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070605102240.PLBQ9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Jun 2007 06:22:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7mNf1X0071kojtg0000000; Tue, 05 Jun 2007 06:22:39 -0400
In-Reply-To: <20070605090404.24707.qmail@b58755fd627261.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Tue, 5 Jun 2007 09:04:04 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49182>

Gerrit Pape <pape@smarden.org> writes:

> Hi, the --track option to git branch or git checkout doesn't work for
> remote branches that contain a slash in the name:
>
>  $ tail -n6 .git/config
>  [remote "origin"]
>          url = /tmp/repo
>          fetch = +refs/heads/*:refs/remotes/origin/*
>  [branch "master"]
>          remote = origin
>          merge = refs/heads/master
>  $ git branch -r
>    origin/HEAD
>    origin/b
>    origin/foo/b
>    origin/master
>  $ git branch --track b origin/b    
>  Branch b set up to track remote branch refs/remotes/origin/b.
>  $ git branch --track foo/b origin/foo/b
>  $ tail -n6 .git/config
>  [branch "master"]
>          remote = origin
>          merge = refs/heads/master
>  [branch "b"]
>          remote = origin
>          merge = refs/heads/b
>  $ 

Indeed the "find matching remote tracking branch" code was
somewhat sloppy and needlessly complex/clever.

How about this patch?

-- >8 --
git-branch --track: fix tracking branch computation.

The original code did not take hierarchical branch names into account at all.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-branch.c  |   67 ++++++++++++++++++++++++++++++++--------------------
 t/t3200-branch.sh |   16 +++++++++---
 2 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index a5b6bbe..4bed12b 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -317,8 +317,6 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 static char *config_repo;
 static char *config_remote;
 static const char *start_ref;
-static int start_len;
-static int base_len;
 
 static int get_remote_branch_name(const char *value)
 {
@@ -334,26 +332,41 @@ static int get_remote_branch_name(const char *value)
 
 	end = value + strlen(value);
 
-	/* Try an exact match first.  */
+	/*
+	 * Try an exact match first.  I.e. handle the case where the
+	 * value is "$anything:refs/foo/bar/baz" and start_ref is exactly
+	 * "refs/foo/bar/baz". Then the name at the remote is $anything.
+	 */
 	if (!strcmp(colon + 1, start_ref)) {
-		/* Truncate the value before the colon.  */
+		/* Truncate the value before the colon. */
 		nfasprintf(&config_repo, "%.*s", colon - value, value);
 		return 1;
 	}
 
-	/* Try with a wildcard match now.  */
-	if (end - value > 2 && end[-2] == '/' && end[-1] == '*' &&
-	    colon - value > 2 && colon[-2] == '/' && colon[-1] == '*' &&
-	    (end - 2) - (colon + 1) == base_len &&
-	    !strncmp(colon + 1, start_ref, base_len)) {
-		/* Replace the star with the remote branch name.  */
-		nfasprintf(&config_repo, "%.*s%s",
-			   (colon - 2) - value, value,
-			   start_ref + base_len);
-		return 1;
-	}
+	/*
+	 * Is this a wildcard match?
+	 */
+	if ((end - 2 <= value) || end[-2] != '/' || end[-1] != '*' ||
+	    (colon - 2 <= value) || colon[-2] != '/' || colon[-1] != '*')
+		return 0;
 
-	return 0;
+	/*
+	 * Value is "refs/foo/bar/<asterisk>:refs/baz/boa/<asterisk>"
+	 * and start_ref begins with "refs/baz/boa/"; the name at the
+	 * remote is refs/foo/bar/ with the remaining part of the
+	 * start_ref.  The length of the prefix on the RHS is (end -
+	 * colon - 2), including the slash immediately before the
+	 * asterisk.
+	 */
+	if ((strlen(start_ref) < end - colon - 2) ||
+	    memcmp(start_ref, colon + 1, end - colon - 2))
+		return 0; /* does not match prefix */
+
+	/* Replace the asterisk with the remote branch name.  */
+	nfasprintf(&config_repo, "%.*s%s",
+		   (colon - 1) - value, value,
+		   start_ref + (end - colon - 2));
+	return 1;
 }
 
 static int get_remote_config(const char *key, const char *value)
@@ -363,10 +376,12 @@ static int get_remote_config(const char *key, const char *value)
 		return 0;
 
 	var = strrchr(key, '.');
-	if (var == key + 6)
+	if (var == key + 6 || strcmp(var, ".fetch"))
 		return 0;
-
-	if (!strcmp(var, ".fetch") && get_remote_branch_name(value))
+	/*
+	 * Ok, we are looking at key == "remote.$foo.fetch";
+	 */
+	if (get_remote_branch_name(value))
 		nfasprintf(&config_remote, "%.*s", var - (key + 7), key + 7);
 
 	return 0;
@@ -392,14 +407,14 @@ static void set_branch_merge(const char *name, const char *config_remote,
 
 static void set_branch_defaults(const char *name, const char *real_ref)
 {
-	const char *slash = strrchr(real_ref, '/');
-
-	if (!slash)
-		return;
-
+	/*
+	 * name is the name of new branch under refs/heads;
+	 * real_ref is typically refs/remotes/$foo/$bar, where
+	 * $foo is the remote name (there typically are no slashes)
+	 * and $bar is the branch name we map from the remote
+	 * (it could have slashes).
+	 */
 	start_ref = real_ref;
-	start_len = strlen(real_ref);
-	base_len = slash - real_ref;
 	git_config(get_remote_config);
 	if (!config_repo && !config_remote &&
 	    !prefixcmp(real_ref, "refs/heads/")) {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 828d553..6f6d884 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -136,8 +136,8 @@ test_expect_success 'test tracking setup (non-wildcard, not matching)' \
      git-config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
      (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
      git-branch --track my5 local/master &&
-     ! test $(git-config branch.my5.remote) = local &&
-     ! test $(git-config branch.my5.merge) = refs/heads/master'
+     ! test "$(git-config branch.my5.remote)" = local &&
+     ! test "$(git-config branch.my5.merge)" = refs/heads/master'
 
 test_expect_success 'test tracking setup via config' \
     'git-config branch.autosetupmerge true &&
@@ -155,14 +155,22 @@ test_expect_success 'test overriding tracking setup via --no-track' \
      (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
      git-branch --no-track my2 local/master &&
      git-config branch.autosetupmerge false &&
-     ! test $(git-config branch.my2.remote) = local &&
-     ! test $(git-config branch.my2.merge) = refs/heads/master'
+     ! test "$(git-config branch.my2.remote)" = local &&
+     ! test "$(git-config branch.my2.merge)" = refs/heads/master'
 
 test_expect_success 'test local tracking setup' \
     'git branch --track my6 s &&
      test $(git-config branch.my6.remote) = . &&
      test $(git-config branch.my6.merge) = refs/heads/s'
 
+test_expect_success 'test tracking setup via --track but deeper' \
+    'git-config remote.local.url . &&
+     git-config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+     (git-show-ref -q refs/remotes/local/o/o || git-fetch local) &&
+     git-branch --track my7 local/o/o &&
+     test "$(git-config branch.my7.remote)" = local &&
+     test "$(git-config branch.my7.merge)" = refs/heads/o/o'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-- 
1.5.2.1.116.g9f308
