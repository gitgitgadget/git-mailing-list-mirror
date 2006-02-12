From: kent@lysator.liu.se
Subject: [PATCH] Add howto about separating topics.
Date: Sun, 12 Feb 2006 13:00:52 +0100
Message-ID: <m3accwrdl7.fsf_-_@ceres.unit.liu.se>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<87bqxgxfl7.wl%cworth@cworth.org>
	<7vr76c5avd.fsf@assigned-by-dhcp.cox.net>
	<87fymst399.wl%cworth@cworth.org>
	<7vfyms0x4p.fsf@assigned-by-dhcp.cox.net>
	<m31wybknuv.fsf@athena.unit.liu.se>
	<7vmzgxn1dz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 13:01:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8FuZ-0006zl-VT
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 13:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWBLMA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 07:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWBLMA7
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 07:00:59 -0500
Received: from ceres.unit.liu.se ([130.236.16.22]:62377 "EHLO
	ceres.unit.liu.se") by vger.kernel.org with ESMTP id S932390AbWBLMA6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 07:00:58 -0500
Received: by ceres.unit.liu.se (Postfix, from userid 500)
	id 0A2A238DAD8; Sun, 12 Feb 2006 13:00:53 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzgxn1dz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 11 Feb 2006 11:25:44 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15992>

This howto consists of a footnote from an email by JC to the git
mailing list (<7vfyms0x4p.fsf@assigned-by-dhcp.cox.net>).

Signed-off-by: Kent Engstrom <kent@lysator.liu.se>

---

 Documentation/howto/separating-topic-branches.txt |   91 +++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/howto/separating-topic-branches.txt

39f152ae224f45a3d977aa8966a477dbc1df676d
diff --git a/Documentation/howto/separating-topic-branches.txt b/Documentation/howto/separating-topic-branches.txt
new file mode 100644
index 0000000..090e2c9
--- /dev/null
+++ b/Documentation/howto/separating-topic-branches.txt
@@ -0,0 +1,91 @@
+From: Junio C Hamano <junkio@cox.net>
+Subject: Separating topic branches
+Abstract: In this article, JC describes how to separate topic branches.
+
+This text was originally a footnote to a discussion about the
+behaviour of the git diff commands.
+
+Often I find myself doing that [running diff against something other
+than HEAD] while rewriting messy development history.  For example, I
+start doing some work without knowing exactly where it leads, and end
+up with a history like this:
+
+            "master"
+        o---o
+             \                    "topic" 
+              o---o---o---o---o---o
+
+At this point, "topic" contains something I know I want, but it
+contains two concepts that turned out to be completely independent.
+And often, one topic component is larger than the other.  It may
+contain more than two topics.
+
+In order to rewrite this mess to be more manageable, I would first do
+"diff master..topic", to extract the changes into a single patch, start
+picking pieces from it to get logically self-contained units, and
+start building on top of "master":
+
+        $ git diff master..topic >P.diff
+        $ git checkout -b topicA master
+        ... pick and apply pieces from P.diff to build
+        ... commits on topicA branch.
+                      
+              o---o---o
+             /        "topicA"
+        o---o"master"
+             \                    "topic" 
+              o---o---o---o---o---o
+
+Before doing each commit on "topicA" HEAD, I run "diff HEAD"
+before update-index the affected paths, or "diff --cached HEAD"
+after.  Also I would run "diff --cached master" to make sure
+that the changes are only the ones related to "topicA".  Usually
+I do this for smaller topics first.
+
+After that, I'd do the remainder of the original "topic", but
+for that, I do not start from the patchfile I extracted by
+comparing "master" and "topic" I used initially.  Still on
+"topicA", I extract "diff topic", and use it to rebuild the
+other topic:
+
+        $ git diff -R topic >P.diff ;# --cached also would work fine
+        $ git checkout -b topicB master
+        ... pick and apply pieces from P.diff to build
+        ... commits on topicB branch.
+
+                                "topicB"
+               o---o---o---o---o
+              /
+             /o---o---o
+            |/        "topicA"
+        o---o"master"
+             \                    "topic" 
+              o---o---o---o---o---o
+
+After I am done, I'd try a pretend-merge between "topicA" and
+"topicB" in order to make sure I have not missed anything:
+
+        $ git pull . topicA ;# merge it into current "topicB"
+        $ git diff topic
+                                "topicB"
+               o---o---o---o---o---* (pretend merge)
+              /                   /
+             /o---o---o----------'
+            |/        "topicA"
+        o---o"master"
+             \                    "topic" 
+              o---o---o---o---o---o
+
+The last diff better not to show anything other than cleanups
+for crufts.  Then I can finally clean things up:
+
+        $ git branch -D topic
+        $ git reset --hard HEAD^ ;# nuke pretend merge
+
+                                "topicB"
+               o---o---o---o---o
+              / 
+             /o---o---o
+            |/        "topicA"
+        o---o"master"
+
-- 
1.1.6.g29e5
