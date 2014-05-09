From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH] How to keep a project's canonical history correct.
Date: Thu,  8 May 2014 23:08:41 -0700
Message-ID: <1399615721-566-1-git-send-email-ischis2@cox.net>
References: <xmqq4n119wgk.fsf@gitster.dls.corp.google.com>
Cc: "Stephen P. Smith" <ischis2@cox.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 08:06:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Widwx-00073r-R0
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 08:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbaEIGGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 02:06:23 -0400
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:37388 "EHLO
	fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaEIGGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 02:06:22 -0400
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20140509060622.TZUP17341.fed1rmfepo202.cox.net@fed1rmimpo209>
          for <git@vger.kernel.org>; Fri, 9 May 2014 02:06:22 -0400
Received: from thunderbird ([68.231.74.114])
	by fed1rmimpo209 with cox
	id zi6M1n00H2TxN4s01i6M5k; Fri, 09 May 2014 02:06:21 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A02020A.536C705D.00BF,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=fKfnK+me c=1 sm=1
 a=So8zV0cAyE/J2U/+o1/Dyg==:17 a=KW5EA1bX42UA:10 a=G8Uczd0VNMoA:10
 a=kviXuzpPAAAA:8 a=ybZZDoGAAAAA:8 a=LmBk-rk3AAAA:8 a=tkIwO-gpi0EyPdaDy0cA:9
 a=iRhpN0CPQkkA:10 a=4vB-4DCPJfMA:10 a=qIVjreYYsbEA:10 a=gA6IeH5FQcgA:10
 a=NWVoK91CQyQA:10 a=So8zV0cAyE/J2U/+o1/Dyg==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from localhost.localdomain (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 4FF5B13F635;
	Thu,  8 May 2014 23:09:30 -0700 (MST)
X-Mailer: git-send-email 2.0.0.rc1
In-Reply-To: <xmqq4n119wgk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248516>

During the mail thread about "Pull is mostly evil" a user asked how
the first parent could become reversed.

This howto explains how the first parent can get reversed when viewed
by the project and then explains a method to keep the history correct.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 Documentation/Makefile                             |   1 +
 .../howto/keep-canonical-history-correct.txt       | 213 +++++++++++++++++++++
 2 files changed, 214 insertions(+)
 create mode 100644 Documentation/howto/keep-canonical-history-correct.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index fc6b2cf..cea0e7a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -59,6 +59,7 @@ SP_ARTICLES += howto/recover-corrupted-blob-object
 SP_ARTICLES += howto/recover-corrupted-object-harder
 SP_ARTICLES += howto/rebuild-from-update-hook
 SP_ARTICLES += howto/rebase-from-internal-branch
+SP_ARTICLES += howto/keep-canonical-history-correct
 SP_ARTICLES += howto/maintain-git
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
new file mode 100644
index 0000000..927154c
--- /dev/null
+++ b/Documentation/howto/keep-canonical-history-correct.txt
@@ -0,0 +1,213 @@
+From: Junio C Hamano <gitster@pobox.com>
+Date: Wed, 07 May 2014 13:15:39 -0700
+Subject: Beginner question on "Pull is mostly evil"
+Abstract: This how-to explains a method for keeping a 
+ project's history correct when using git pull.
+Content-type: text/asciidoc
+
+Keep authoritative canonical history correct with git pull
+==========================================================
+
+Sometimes a new project integrator will end up with project history
+that appears to be "backwards" from what other project developers
+expect. This howto presents a suggested integration workflow for
+maintaining a central repository.
+
+Suppose that that central repository has this history:
+
+------------
+    ---o---o---A
+------------
+
+which ends at commit `A` (time flows from left to right and each node
+in the graph is a commit, lines between them indicating parent-child
+relationship).
+
+Then you clone it and work on your own commits, which leads you to
+have this history in *your* repository:
+
+------------
+    ---o---o---A---B---C
+------------
+
+Imagine your coworker did the same and built on top of `A` in *his*
+repository in the meantime, and then pushed it to the
+central repository:
+
+------------
+    ---o---o---A---X---Y---Z
+------------
+
+Now, if you "git push" at this point, beause your history that leads
+to `C` lacks `X`, `Y` and `Z`, it will fail.  You need to somehow make
+the tip of your history a descendant of `Z`.
+
+One suggested way to solve the problem is "fetch and then merge", aka
+"git pull". When you fetch, your repository will have a history like
+this:
+
+------------
+    ---o---o---A---B---C
+                \
+                 X---Y---Z
+------------
+
+Once you run merge after that, while still on *your* branch, i.e. `C`,
+you will create a merge `M` and make the history look like this:
+
+------------
+    ---o---o---A---B---C---M
+                \         /
+                 X---Y---Z
+------------
+
+`M` is a descendant of `Z`, so you can push to update the central
+repository.  Such a merge `M` does not lose any commit in both
+histories, so in that sense it may not be wrong, but when people want
+to talk about "the authoritative canonical history that is shared
+among the project participants", i.e. "the trunk", the way they often
+use is to do:
+
+------------
+    $ git log --first-parent
+------------
+
+For all other people who observed the central repository after your
+coworker pushed `Z` but before you pushed `M`, the commit on the trunk
+used to be `o-o-A-X-Y-Z`.  But because you made `M` while you were on
+`C`, `M`'s first parent is `C`, so by pushing `M` to advance the
+central repository, you made `X-Y-Z` a side branch, not on the trunk.
+
+You would rather want to have a history of this shape:
+
+------------
+    ---o---o---A---X---Y---Z---M'
+                \             /
+                 B-----------C
+------------
+
+so that in the first-parent chain, it is clear that the project first
+did `X` and then `Y` and then `Z` and merged a change that consists of
+two commits `B` and `C` that achieves a single goal.  You may have
+worked on fixing the bug #12345 with these two patches, and the merge
+`M'` with swapped parents can say in its log message "Merge
+'fix-bug-12345'". Having a way to tell "git pull" to create a merge
+but record the parents in reverse order may be a way to do so.
+
+Note that I said "achieves a single goal" above, because this is
+important.  "swapping the merge order" only covers a special case
+where the project does not care too much about having unrelated
+things done on a single merge but cares a lot about first-parent
+chain.
+
+There are multiple schools of thought about the "trunk" management.
+
+ 1. Some projects want to keep a completely linear history without any
+    merges.  Obviously, swapping the merge order would not match their
+    taste.  You would need to flatten your history on top of the
+    updated upstream to result in a history of this shape instead:
++
+------------
+    ---o---o---A---X---Y---Z---B---C
+------------
++
+    with `git pull --rebase` or something.
+
+ 2. Some projects tolerate merges in their history, but do not worry
+    too much about the first-parent order, and allow fast-forward
+    merges.  To them, swapping the merge order does not hurt, but
+    it is unnecessary.
+
+ 3. Some projects want each commit on the "trunk" to do one single
+    thing.  The output of `git log --first-parent` in such a project
+    would show either a merge of a side branch that completes a single
+    theme, or a single commit that completes a single theme by itself.
+    If your two commits `B` and `C` (or they may even be two groups of
+    commits) were solving two independent issues, then the merge `M'`
+    we made in the earlier example by swapping the merge order is
+    still not up to the project standard.  It merges two unrelated
+    efforts `B` and `C` at the same time.
+
+For projects in the last category (Git itself is one of them),
+individual developers would want to prepare a history more like
+this:
+
+------------
+                 C0--C1--C2     topic-c
+                /
+    ---o---o---A                master
+                \
+                 B0--B1--B2     topic-b
+------------
+
+That is, keeping separate topics on separate branches, perhaps like
+so:
+
+------------
+    $ git clone $URL work && cd work
+    $ git checkout -b topic-b master
+    $ ... work to create B0, B1 and B2 to complete one theme
+    $ git checkout -b topic-c master
+    $ ... same for the theme of topic-c
+------------
+
+And then
+
+------------
+    $ git checkout master
+    $ git pull --ff-only
+------------
+
+would grab `X`, `Y` and `Z` from the upstream and advance your master
+branch:
+
+------------
+                 C0--C1--C2     topic-c
+                /
+    ---o---o---A---X---Y---Z    master
+                \
+                 B0--B1--B2     topic-b
+------------
+
+And then you would merge these two branches separately:
+
+------------
+    $ git merge topic-b
+    $ git merge topic-c
+------------
+
+to result in
+
+------------
+                 C0--C1---------C2
+                /                 \
+    ---o---o---A---X---Y---Z---M---N
+                \             /
+                 B0--B1-----B2
+------------
+
+and push it back to the central repository.
+
+It is very much possible that while you are merging topic-b and
+topic-c, somebody again advanced the history in the central repository
+to put `W` on top of `Z`, and make your "git push" fail.
+
+In such a case, you would rewind to discard `M` and `N`, update the
+tip of your 'master' again and redo the two merges:
+
+------------
+    $ git reset --hard origin/master
+    $ git pull --ff-only
+    $ git merge topic-b
+    $ git merge topic-c
+------------
+
+------------
+                 C0--C1--------------C2
+                /                     \
+    ---o---o---A---X---Y---Z---W---M'--N'
+                \                 /
+                 B0--B1---------B2
+------------
+
+See http://git-blame.blogspot.com/2012/03/fun-with-first-parent.html
-- 
2.0.0.rc1
