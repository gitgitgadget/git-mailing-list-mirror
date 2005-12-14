From: Junio C Hamano <junkio@cox.net>
Subject: Re: new file leaked onto release branch
Date: Wed, 14 Dec 2005 12:45:51 -0800
Message-ID: <7virtrxv9c.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056B83F2@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 21:48:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmdVp-0003QI-FI
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 21:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVLNUp4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 15:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVLNUpz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 15:45:55 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1464 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964918AbVLNUpz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 15:45:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214204411.BWRO17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 15:44:11 -0500
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30056B83F2@hdsmsx401.amr.corp.intel.com>
	(Len Brown's message of "Wed, 14 Dec 2005 14:20:04 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13640>

"Brown, Len" <len.brown@intel.com> writes:

> Should I be using something different than git merge?
> is Documentation/howto/using-topic-branches out of date?

I reviewed it once again right now.  The document claims to be
last updated for 0.99.9f, but I do not see anything outdated in
there for the latest.  Tony's procedure looks valid [*1*], so do
the scripts you sent in this thread.

Sorry, but I do not seem to be able to spot anything obviously
wrong with your troubled commits nor scripts.  I'll do some more
digging, including rewinding to an older git and trying them,
but I am pessimistic.

I pointed out one anomaly which is the commit should never have
been created because it was not even a fast forward but already
up-to-date case, and it was followed up with exchange of a few
messages between Linus and you.  But even if we got that mixed
up, the resulting merge should not have contained the file
neither parents had.  That part worries me the most.

One question.  You mentioned these in your message, you have
a "git.commit wrapper" that contains these lines:

    git-update-index --add --remove `quilt files`
    git commit

I am not familiar with 'quilt', but is "quilt files" the command
to show the list of files with patches applied to the working
tree?

If so, the above do tell git about the modified (including added
or removed) files that the applied quilt patches touch, which
sounds like the correct thing to do.

But the resulting commit from that procedure would not be a
merge commit, and the commit in question that had the rsinfo
file magically appeared from nowhere is a merge, so this does
not seem to have much to do with the current problem...

Still puzzlled, sorry.


[Footnote]

*1* Except that the rsync transport is probably suboptimal for
people who stay reasonably up-to-date with Linus and I would
apply the following change if I were Tony, but that shouldn't
have anything to do with the trouble we are discussing here.

---
diff --git a/Documentation/howto/using-topic-branches.txt b/Documentation/howto/using-topic-branches.txt
index 4698abe..4944297 100644
--- a/Documentation/howto/using-topic-branches.txt
+++ b/Documentation/howto/using-topic-branches.txt
@@ -31,7 +31,7 @@ test tree and then pull to the release t
 patches blocked in the test tree waiting for complex changes to accumulate
 enough test time to graduate.
 
-Back in the BitKeeper days I achieved this my creating small forests of
+Back in the BitKeeper days I achieved this by creating small forests of
 temporary trees, one tree for each logical grouping of patches, and then
 pulling changes from these trees first to the test tree, and then to the
 release tree.  At first I replicated this in GIT, but then I realised
@@ -42,7 +42,8 @@ So here is the step-by-step guide how th
 
 First create your work tree by cloning Linus's public tree:
 
- $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
+ $ git clone \
+   master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
 
 Change directory into the cloned tree you just created
 
@@ -52,7 +53,7 @@ Set up a remotes file so that you can fe
 branch into a local branch named "linus":
 
  $ cat > .git/remotes/linus
- URL: rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+ URL: master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
  Pull: master:linus
  ^D
 
