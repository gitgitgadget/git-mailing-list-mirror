From: Fabio Augusto Dal Castel <fdcastel@gmail.com>
Subject: [RFC] New command: 'git snapshot'.
Date: Mon, 9 Feb 2009 16:54:58 -0200
Message-ID: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 19:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbIv-0008Hn-8u
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 19:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbZBISzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 13:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754324AbZBISzB
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 13:55:01 -0500
Received: from qb-out-0506.google.com ([72.14.204.237]:51860 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbZBISzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 13:55:00 -0500
Received: by qb-out-0506.google.com with SMTP id q18so1148984qba.17
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 10:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=84BeUrDoerNpMNM8vtc7tZ14l9W5hSK9UXHZycPUTO8=;
        b=bETExexwPBQom8+ZyCAsix+Z+uLKiNm6+Zt9roIgQu3C8rsUIbLWTKKBrADYPSVVNK
         xX0C8aR2/hIi25Cugpk4b450BUKRkJlA0ws2ckU+L5VaCplenSY7bMndLimwrh1Acpfq
         FXkh30lVenp2EhgOCxUb7cTDxkiYonH9bC14s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nvj1SPwA5kJXEHAxU3MLXpjjIv8NoNms5ccFqSWOlSahlYFb53xqvxkFbwpV9gbwyT
         gAyKZp1PE/v6X4Qs7wlxJEic8yc/tDQgiLqcVGVrSigoBvs6HOtpiey7v5GGKokfbOFC
         1PuncIKNcx1rJ3J41nkEQWOtcP7lF4pSEmRls=
Received: by 10.231.19.198 with SMTP id c6mr38536ibb.46.1234205698326; Mon, 09 
	Feb 2009 10:54:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109103>

Abstract: Requesting suggestions for a new command to save the current
working dir state without collateral effects.


Q. "Why another command? We already have stash!"

A. Stash was always subject of many controversies. Trying to stay
apart from near-religious debates like

* whether the syntax should be "dangerous" [sic] or "newbie friendly";
* whether untracked files should be stashed or not;
* whether stashes should expire or not

the fact is that different users have different needs and those
discussions arise when trying to apply different behaviors to same
command. Stash was always oriented to a 'pull into a dirty tree'
solution, and serves this purpose very well.

So, I propose a new 'git snapshot' command to use when 'git stash'
behaviour is not exactly what user needs.


Q. Why on earth would someone want this instead of our lovely stash?

A. Sometimes what we want is just a (you bet) "snapshot" of working
dir. Something like "Just remember. Do not touch."

In the excellent paper "Git From the Bottom Up" John Wiegley suggests
a "git-snapshot" script to be used in a cron job -- nothing more than:

git stash && git stash apply

However, this is not an optimal solution for a 'real' snapshot:

* It makes TWO unnecessary changes to working dir (to HEAD and back
again). Besides the heavier disk usage, this could, for example,
cause an editor using inotify to think that the current file was
externally changed by another program and annoy the user asking if he
wants to load the new content.

* It will not save untracked files. An user counting with periodic
snapshots and working furiously for three days may be disappointed (to
say the least) when discover that a significant part of his work were
NOT saved in history because contents actually were in new (untracked)
files.

* Stashes expire (already discussed in
http://thread.gmane.org/gmane.comp.version-control.git/84665 )

In resume, all that 'git snapshot' would NOT do.


Q. What are the differences between 'git stash' and 'git snapshot'?

A.

git stash                         git snapshot

temporary/short-term              permanent/long-term
reflog-based                      branch-based
applies a "git reset --hard"      leaves working dir / index untouched
does not stash untracked files    snapshots ALL files (except ignored)


Q. How it works?

A.[What follows is a textual description of my current implementation.
Of course, there is nothing carved in stone: suggestions and comments
are MORE than welcome.]

All snapshots are stored in a special branch ("<branch>_snapshots").
So, if you are on 'master' branch, a 'git snapshot' will create/use a
'master_snapshots' branch.

If anything differs from last snapshot (a change into index, into a
file, or a new untracked file) the command will:

1. Save the current index state;
2. Add untracked/updated files to index;
3. Create a new commit for the current state in snapshots branch;
4. Update the HEAD of snapshots branch to this new commit;
5. Restore the original index state (of step 1).

However, if the current state of working dir is equal to the last
snapshot taken, there is no need to make another identical copy and
the command will just exit.

The command would not work if the current branch is a detached head.
It is by design, but just because I had a no better idea of what to do
in this case <g>.

Typical usage:

	(hack hack hack)
	git-snapshot
	(hack hack hack)
	git-snapshot
	(...)

Open questions / To-do list:

- How to 'rollback' to a specific snapshot?
  - Make a 'git-rollback <snapshot>' ? It would:
   - Apply diffs between <snapshot> and current head (possible loss!).
   - Restore the original index (where to save it? 'Hidden' commit?)


Best Regards,

Fabio.





diff --git a/git-snapshot.sh b/git-snapshot.sh
new file mode 100644
index 0000000..5f19a6f
--- /dev/null
+++ b/git-snapshot.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 F.D.Castel.
+#
+
+. git-sh-setup
+require_work_tree
+cd_to_toplevel
+
+# Get current branch.
+current_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
+test -z "$current_branch" &&
+	die 'fatal: Cannot take snapshot from a detached HEAD.'
+	
+# Save the current index state.
+original_index=$(git write-tree) ||
+	die "fatal: Error saving original index state."
+
+# Create commit message describing the changes.
+temp_file="$TMP/.git-snapshot"
+(
+	date -R
+	printf '\n* New files:\n'		# ToDo: How to get only untracked? (without added)
+	git ls-files --full-name -o
+	printf '\n* Changed files:\n'
+	git ls-files --full-name -m		# ToDo: How to get only modified?
(without deleted)
+	printf '\n* Deleted files:\n'
+	git ls-files --full-name -d
+) > "${temp_file}.message"
+
+# Add untracked/updated files to index.
+git add --all . ||
+	die "fatal: Error adding current state to index."
+
+# Set clean up trap (restore original index and delete temp files on exit).
+trap "git read-tree $original_index && rm -f '$temp_file.*'" 0
+
+# Create snapshots branch (if needed).
+snapshots_branch="${current_branch}_snapshots"
+git show-ref --verify --quiet -- "refs/heads/$snapshots_branch" ||
+	git branch $snapshots_branch
+
+# Compare changes with last snapshot.
+git diff --exit-code --raw --cached $snapshots_branch &&
+	die 'Nothing to do: no changes since the last snapshot.'
+
+# Create a new commit for the current state in snapshots branch.
+new_index=$(git write-tree) &&
+	snapshots_head=$(git rev-parse --verify $snapshots_branch) &&
+	new_commit=$(cat ${temp_file}.message | git commit-tree $new_index
-p $snapshots_head) ||
+		die "fatal: Error commiting current state into snapshots branch."
+
+# ToDo: Where to store the original index (for a future 'rollback')?
+#original_index_commit=$(printf '(original index for child commit)' |
git commit-tree $original_index)
+
+# Update the HEAD of snapshots branch to this new commit.
+git symbolic-ref HEAD refs/heads/$snapshots_branch &&
+	git update-ref -m "'Snapshotting $current_branch to $new_commit'"
HEAD $new_commit $snapshots_head &&
+	git symbolic-ref HEAD refs/heads/$current_branch ||
+		die "fatal: Error updating HEAD of snapshots branch."
+		
\ No newline at end of file
