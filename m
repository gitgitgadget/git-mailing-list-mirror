From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Add some simple howtos, culled from the mailing list.
Date: Mon, 15 Aug 2005 04:25:53 -0400
Message-ID: <1124094353822-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 10:26:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4aIB-0000WP-0P
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 10:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVHOIZz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 04:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVHOIZz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 04:25:55 -0400
Received: from mail.autoweb.net ([198.172.237.26]:15831 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932102AbVHOIZz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 04:25:55 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E4aI6-0008Cq-Eh; Mon, 15 Aug 2005 04:25:54 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E4aI5-00059g-00; Mon, 15 Aug 2005 04:25:53 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1E4aI5-00070y-MX; Mon, 15 Aug 2005 04:25:53 -0400
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think these are useful, and I think putting them in a new "howto"
directory might help some users until we get to the point of splitting
up the tutorial to be easier to read.

Given the authorship, I think it's safe to put these in the repository.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Documentation/howto/make-dist.txt                  |   47 ++++++
 Documentation/howto/rebase-and-edit.txt            |   78 ++++++++++
 .../howto/rebase-from-internal-branch.txt          |  163 +++++++++++++++++++++++
 3 files changed, 288 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/howto/make-dist.txt
 create mode 100644 Documentation/howto/rebase-and-edit.txt
 create mode 100644 Documentation/howto/rebase-from-internal-branch.txt

5276bcd9892bd712b648761f4b1eeaf6f972594b
diff --git a/Documentation/howto/make-dist.txt b/Documentation/howto/make-dist.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/howto/make-dist.txt
@@ -0,0 +1,47 @@
+Date:   Fri, 12 Aug 2005 22:39:48 -0700 (PDT)
+From: Linus Torvalds <torvalds@osdl.org>
+To: Dave Jones <davej@redhat.com>
+cc: git@vger.kernel.org
+Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
+
+On Sat, 13 Aug 2005, Dave Jones wrote:
+>
+>  > Git actually has a _lot_ of nifty tools. I didn't realize that people
+>  > didn't know about such basic stuff as "git-tar-tree" and "git-ls-files".
+>
+> Maybe its because things are moving so fast :)  Or maybe I just wasn't
+> paying attention on that day. (I even read the git changes via RSS,
+> so I should have no excuse).
+
+Well, git-tar-tree has been there since late April - it's actually one of
+those really early commands. I'm pretty sure the RSS feed came later ;)
+
+I use it all the time in doing releases, it's a lot faster than creating a
+tar tree by reading the filesystem (even if you don't have to check things
+out). A hidden pearl.
+
+This is my crappy "release-script":
+
+        [torvalds@g5 ~]$ cat bin/release-script
+        #!/bin/sh
+        stable="$1"
+        last="$2"
+        new="$3"
+        echo "# git-tag-script v$new"
+        echo "git-tar-tree v$new linux-$new | gzip -9 > ../linux-$new.tar.gz"
+        echo "git-diff-tree -p v$stable v$new | gzip -9 > ../patch-$new.gz"
+        echo "git-rev-list --pretty v$new ^v$last > ../ChangeLog-$new"
+        echo "git-rev-list --pretty=short v$new ^v$last | git-shortlog > ../ShortLog"
+        echo "git-diff-tree -p v$last v$new | git-apply --stat > ../diffstat-$new"
+
+and when I want to do a new kernel release I literally first tag it, and
+then do
+
+        release-script 2.6.12 2.6.13-rc6 2.6.13-rc7
+
+and check that things look sane, and then just cut-and-paste the commands.
+
+Yeah, it's stupid.
+
+                Linus
+
diff --git a/Documentation/howto/rebase-and-edit.txt b/Documentation/howto/rebase-and-edit.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/howto/rebase-and-edit.txt
@@ -0,0 +1,78 @@
+Date:	Sat, 13 Aug 2005 22:16:02 -0700 (PDT)
+From:	Linus Torvalds <torvalds@osdl.org>
+To:	Steve French <smfrench@austin.rr.com>
+cc:	git@vger.kernel.org
+Subject: Re: sending changesets from the middle of a git tree
+
+On Sat, 13 Aug 2005, Linus Torvalds wrote:
+
+> That's correct. Same things apply: you can move a patch over, and create a 
+> new one with a modified comment, but basically the _old_ commit will be 
+> immutable.
+
+Let me clarify.
+
+You can entirely _drop_ old branches, so commits may be immutable, but
+nothing forces you to keep them. Of course, when you drop a commit, you'll 
+always end up dropping all the commits that depended on it, and if you 
+actually got somebody else to pull that commit you can't drop it from 
+_their_ repository, but undoing things is not impossible.
+
+For example, let's say that you've made a mess of things: you've committed
+three commits "old->a->b->c", and you notice that "a" was broken, but you
+want to save "b" and "c". What you can do is
+
+	# Create a branch "broken" that is the current code
+	# for reference
+	git branch broken
+
+	# Reset the main branch to three parents back: this 
+	# effectively undoes the three top commits
+	git reset HEAD^^^
+	git checkout -f
+
+	# Check the result visually to make sure you know what's
+	# going on
+	gitk --all
+
+	# Re-apply the two top ones from "broken"
+	#
+	# First "parent of broken" (aka b):
+	git-diff-tree -p broken^ | git-apply --index
+	git commit --reedit=broken^
+
+	# Then "top of broken" (aka c):
+	git-diff-tree -p broken | git-apply --index
+	git commit --reedit=broken
+
+and you've now re-applied (and possibly edited the comments) the two
+commits b/c, and commit "a" is basically gone (it still exists in the
+"broken" branch, of course).
+
+Finally, check out the end result again:
+
+	# Look at the new commit history
+	gitk --all
+
+to see that everything looks sensible.
+
+And then, you can just remove the broken branch if you decide you really 
+don't want it:
+
+	# remove 'broken' branch
+	rm .git/refs/heads/broken
+
+	# Prune old objects if you're really really sure
+	git prune
+
+And yeah, I'm sure there are other ways of doing this. And as usual, the 
+above is totally untested, and I just wrote it down in this email, so if 
+I've done something wrong, you'll have to figure it out on your own ;)
+
+			Linus
+-
+To unsubscribe from this list: send the line "unsubscribe git" in
+the body of a message to majordomo@vger.kernel.org
+More majordomo info at  http://vger.kernel.org/majordomo-info.html
+
+
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -0,0 +1,163 @@
+From:	Junio C Hamano <junkio@cox.net>
+To:	git@vger.kernel.org
+Cc:	Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>
+Subject: Re: sending changesets from the middle of a git tree
+Date:	Sun, 14 Aug 2005 18:37:39 -0700
+
+Petr Baudis <pasky@suse.cz> writes:
+
+> Dear diary, on Sun, Aug 14, 2005 at 09:57:13AM CEST, I got a letter
+> where Junio C Hamano <junkio@cox.net> told me that...
+>> Linus Torvalds <torvalds@osdl.org> writes:
+>> 
+>> > Junio, maybe you want to talk about how you move patches from your "pu" 
+>> > branch to the real branches.
+>> 
+> Actually, wouldn't this be also precisely for what StGIT is intended to?
+
+Exactly my feeling.  I was sort of waiting for Catalin to speak
+up.  With its basing philosophical ancestry on quilt, this is
+the kind of task StGIT is designed to do.
+
+I just have done a simpler one, this time using only the core
+GIT tools.
+
+I had a handful commits that were ahead of master in pu, and I
+wanted to add some documentation bypassing my usual habit of
+placing new things in pu first.  At the beginning, the commit
+ancestry graph looked like this:
+
+                             *"pu" head
+    master --> #1 --> #2 --> #3
+
+So I started from master, made a bunch of edits, and committed:
+
+    $ git checkout master
+    $ cd Documentation; ed git.txt git-apply-patch-script.txt ...
+    $ cd ..; git add Documentation/*.txt
+    $ git commit -s -v
+
+NOTE.  The -v flag to commit is a handy way to make sure that
+your additions are not introducing bogusly formatted lines.
+
+After the commit, the ancestry graph would look like this:
+
+                              *"pu" head
+    master^ --> #1 --> #2 --> #3
+          \
+            \---> master
+
+The old master is now master^ (the first parent of the master).
+The new master commit holds my documentation updates.
+
+Now I have to deal with "pu" branch.
+
+This is the kind of situation I used to have all the time when
+Linus was the maintainer and I was a contributor, when you look
+at "master" branch being the "maintainer" branch, and "pu"
+branch being the "contributor" branch.  Your work started at the
+tip of the "maintainer" branch some time ago, you made a lot of
+progress in the meantime, and now the maintainer branch has some
+other commits you do not have yet.  And "git rebase" was written
+with the explicit purpose of helping to maintain branches like
+"pu".  You _could_ merge master to pu and keep going, but if you
+eventually want to cherrypick and merge some but not necessarily
+all changes back to the master branch, it often makes later
+operations for _you_ easier if you rebase (i.e. carry forward
+your changes) "pu" rather than merge.  So I ran "git rebase":
+
+    $ git checkout pu
+    $ git rebase master pu
+
+What this does is to pick all the commits since the current
+branch (note that I now am on "pu" branch) forked from the
+master branch, and forward port these changes.
+
+    master^ --> #1 --> #2 --> #3
+          \                                  *"pu" head
+            \---> master --> #1' --> #2' --> #3'
+
+The diff between master^ and #1 is applied to master and
+committed to create #1' commit with the commit information (log,
+author and date) taken from commit #1.  On top of that #2' and #3'
+commits are made similarly out of #2 and #3 commits.
+
+Old #3 is not recorded in any of the .git/refs/heads/ file
+anymore, so after doing this you will have dangling commit if
+you ran fsck-cache, which is normal.  After testing "pu", you
+can run "git prune" to get rid of those original three commits.
+
+While I am talking about "git rebase", I should talk about how
+to do cherrypicking using only the core GIT tools.
+
+Let's go back to the earlier picture, with different labels.
+
+You, as an individual developer, cloned upstream repository and
+amde a couple of commits on top of it.
+
+                              *your "master" head
+   upstream --> #1 --> #2 --> #3
+
+You would want changes #2 and #3 incorporated in the upstream,
+while you feel that #1 may need further improvements.  So you
+prepare #2 and #3 for e-mail submission.
+
+    $ git format-patch master^^ master
+
+This creates two files, 0001-XXXX.txt and 0002-XXXX.txt.  Send
+them out "To: " your project maintainer and "Cc: " your mailing
+list.  You could use contributed script git-send-email-script if
+your host has necessary perl modules for this, but your usual
+MUA would do as long as it does not corrupt whitespaces in the
+patch.
+
+Then you would wait, and you find out that the upstream picked
+up your changes, along with other changes.
+
+   where                      *your "master" head
+  upstream --> #1 --> #2 --> #3
+    used   \ 
+   to be     \--> #A --> #2' --> #3' --> #B --> #C
+                                                *upstream head
+
+The two commits #2' and #3' in the above picture record the same
+changes your e-mail submission for #2 and #3 contained, but
+probably with the new sign-off line added by the upsteam
+maintainer and definitely with different committer and ancestry
+information, they are different objects from #2 and #3 commits.
+
+You fetch from upstream, but not merge.
+
+    $ git fetch upstream
+
+This leaves the updated upstream head in .git/FETCH_HEAD but
+does not touch your .git/HEAD nor .git/refs/heads/master.  
+You run "git rebase" now.
+
+    $ git rebase FETCH_HEAD master
+
+Earlier, I said that rebase applies all the commits from your
+branch on top of the upstream head.  Well, I lied.  "git rebase"
+is a bit smarter than that and notices that #2 and #3 need not
+be applied, so it only applies #1.  The commit ancestry graph
+becomes something like this:
+
+   where                     *your old "master" head
+  upstream --> #1 --> #2 --> #3
+    used   \                      your new "master" head*
+   to be     \--> #A --> #2' --> #3' --> #B --> #C --> #1'
+                                                *upstream
+                                                head
+
+Again, "git prune" would discard the disused commits #1-#3 and
+you continue on starting from the new "master" head, which is
+the #1' commit.
+
+-jc
+
+-
+To unsubscribe from this list: send the line "unsubscribe git" in
+the body of a message to majordomo@vger.kernel.org
+More majordomo info at  http://vger.kernel.org/majordomo-info.html
+
+
