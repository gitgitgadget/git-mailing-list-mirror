From: Salikh Zakirov <salikh@gmail.com>
Subject: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Wed, 05 Dec 2007 05:08:19 +0900
Message-ID: <4755B3B3.80704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 21:09:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ize4n-0003i3-F0
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 21:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbXLDUI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 15:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbXLDUI1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 15:08:27 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:62981 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbXLDUI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 15:08:26 -0500
Received: by an-out-0708.google.com with SMTP id d31so923393and
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 12:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=gCpfChj76pTQZJlqkC+9Sg5oMaj0l41vKesKH0cB5J4=;
        b=qt2V+nivr9xeTmQr0cgYVuglkxBnOa8jINqMpMUVkMA8Xf6CpiXhasIQcMXev8V/i4NZXI0ZkxrOLAOTYSSxnvlT8EnuQakAz9v7QgL43F7AocDck+jlDYOtta+sK2rHaVZrFx9WYg+VW1KTLwAS3971NVFY0C4ytlostNQfDU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ht0V/bKpK7DIodc+mQ0ImxgJRHaISN3It0xlxJwwn9To2f2grkSeE4+kFKVNYefnj1NyNx0jMILxNTpTLr/1o2aGN64SThPDa8lQ+wYtjARKTj4C9SuuPUqbZrKO9MOrKAEtbhcjYeOT23Q4Xb8hpYxu2dUNXeEbg65/MtopGO0=
Received: by 10.100.172.17 with SMTP id u17mr2209319ane.1196798904526;
        Tue, 04 Dec 2007 12:08:24 -0800 (PST)
Received: from ?221.115.75.108? ( [221.115.75.108])
        by mx.google.com with ESMTPS id z26sm624408ele.2007.12.04.12.08.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Dec 2007 12:08:23 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070819)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67079>


Before this change, .git/HEAD file played two roles:
(a) point to the base commit of the working directory
(b) point to current branch

This combination leads to the confusing user experience
if the branch changes independently of the working directory.
This can happen in following cases:

1) git clone repo repo2
   cd repo2
   ... edit something
   git commit -a
   git push

2) checking out the same branch in the another working directory
associated with the same repository, e.g. created by
contrib/workdir/git-new-workdir

   git new-workdir repo repo2
   cd repo2
   ... edit something
   git commit -a

In both cases original repository will report differences between
index and HEAD, even if though particular working directory
state has not been changed at all.

This patch separates the notion of the current branch from
the base commit. HEAD will always be "detached", and will store
the hash of the base commit. Newly introduced BRANCH reference
will point to the current branch.

When new commit is created, it is first stored in the HEAD.
Then HEAD is compared to the branch head (BRANCH), and branch
head is updated only if it is fast forward.
So, in all simple case there will be no difference in the workflow.

In the "irregular" use cases above, branch head may diverge from
the base commit of the repository. This situation is detected
by the updaters of the HEAD, and user is advised to run merge.
---

Unfortunately, I have not figured out how to set up an empty repository
to use separate HEAD and BRANCH, so one needs to set up an existing
repository manually in order to play with this change:

	git rev-parse HEAD > .git/HEAD.new
	mv .git/HEAD .git/BRANCH
	mv .git/HEAD.new .git/HEAD

The way branch head is updated after HEAD update in this patch
is clearly unacceptable, as it causes too much code duplication.
I wonder if it would be better to introduce a special case  in git-update-ref?

 git-checkout.sh |    4 +++-
 git-commit.sh   |   16 ++++++++++++++++
 git-merge.sh    |   15 +++++++++++++++
 wt-status.c     |   11 +++++++----
 wt-status.h     |    1 +
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index f6d58ac..8e1a1ab 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -266,7 +266,9 @@ if [ "$?" -eq 0 ]; then
 	if test -n "$branch"
 	then
 		old_branch_name=`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
-		GIT_DIR="$GIT_DIR" git symbolic-ref -m "checkout: moving from ${old_branch_name:-$old} to $branch" HEAD "refs/heads/$branch"
+		GIT_DIR="$GIT_DIR" git symbolic-ref -m "checkout: moving from ${old_branch_name:-$old} to $branch" BRANCH "refs/heads/$branch"
+		commit=$(git rev-parse --verify BRANCH 2>/dev/null) &&
+		git update-ref --no-deref -m "checkout: moving from ${old_branch_name:-$old} to $branch" HEAD "$commit"
 		if test -n "$quiet"
 		then
 			true	# nothing
diff --git a/git-commit.sh b/git-commit.sh
index 2c4a406..b7315c1 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -609,7 +609,23 @@ then
 		mv "$NEXT_INDEX" "$THIS_INDEX"
 	else
 		: ;# happy
+	fi && {
+	branchhead=$(git rev-parse --verify BRANCH 2>/dev/null)
+	if test -n "$branchhead"
+	then
+		if test -z "`git rev-list $commit..$branchhead`"
+		then
+			# fast-forward, update the branch pointer as well
+			git update-ref -m "$GIT_REFLOG_ACTION: $rlogm" BRANCH $commit "$branchhead"
+		else
+			name=$(git symbolic-ref BRANCH | sed 's,refs/heads/,,')
+			echo >&2 "* HEAD diverged from $name"
+			echo >&2 "* Consider 'git merge $name'"
+		fi
+	else
+		git-update-ref -m "$GIT_REFLOG_ACTION: $rlogm" BRANCH $commit "$branchhead"
 	fi
+	}
 else
 	echo >&2 "* no commit message?  aborting commit."
 	false
diff --git a/git-merge.sh b/git-merge.sh
index 1c123a3..3d4b31b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -94,6 +94,21 @@ finish () {
 		*)
 			git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
 			git gc --auto
+			branchhead=$(git rev-parse --verify BRANCH 2>/dev/null)
+			if test -n "$branchhead"
+			then
+				if test -z "`git rev-list $commit..$branchhead`"
+				then
+					# fast-forward, update the branch pointer as well
+					git update-ref -m "$rlogm" BRANCH "$1" "$branchhead" || exit 1
+				else
+					name=$(git symbolic-ref BRANCH | sed 's,refs/heads/,,')
+					echo >&2 "* HEAD diverged from $name"
+					echo >&2 "* Consider 'git merge $name'"
+				fi
+			else
+				git-update-ref -m "$GIT_REFLOG_ACTION: $rlogm" BRANCH $commit "$branchhead"
+			fi
 			;;
 		esac
 		;;
diff --git a/wt-status.c b/wt-status.c
index bf2fe8d..9fe5d10 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -44,12 +44,14 @@ static const char* color(int slot)
 
 void wt_status_prepare(struct wt_status *s)
 {
-	unsigned char sha1[20];
-	const char *head;
+	unsigned char sha1[20], sha2[20];
+	const char *head, *branch;
 
 	memset(s, 0, sizeof(*s));
 	head = resolve_ref("HEAD", sha1, 0, NULL);
-	s->branch = head ? xstrdup(head) : NULL;
+	branch = resolve_ref("BRANCH", sha2, 0, NULL);
+	s->diverged = hashcmp(sha1, sha2);
+	s->branch = branch ? xstrdup(branch) : NULL;
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
@@ -309,6 +311,7 @@ void wt_status_print(struct wt_status *s)
 	if (s->branch) {
 		const char *on_what = "On branch ";
 		const char *branch_name = s->branch;
+		const char *diverged = (s->diverged ? ", diverged" : "");
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
@@ -316,7 +319,7 @@ void wt_status_print(struct wt_status *s)
 			on_what = "Not currently on any branch.";
 		}
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
-			"# %s%s", on_what, branch_name);
+			"# %s%s%s", on_what, branch_name, diverged);
 	}
 
 	if (s->is_initial) {
diff --git a/wt-status.h b/wt-status.h
index 7744932..db8129d 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -17,6 +17,7 @@ struct wt_status {
 	int verbose;
 	int amend;
 	int untracked;
+	int diverged;
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
-- 
1.5.3.5.610.g3532b
