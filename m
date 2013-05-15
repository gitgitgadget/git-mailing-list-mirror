From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Lines missing from git diff-tree -p -c output?
Date: Wed, 15 May 2013 16:35:08 +0200
Message-ID: <20130515143508.GO25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 15 16:35:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UccnV-0005Ep-TA
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 16:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759068Ab3EOOfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 10:35:11 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:34093 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758970Ab3EOOfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 10:35:10 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UccnM-0007B7-F1
	for git@vger.kernel.org; Wed, 15 May 2013 16:35:09 +0200
Received: (nullmailer pid 27593 invoked by uid 1000);
	Wed, 15 May 2013 14:35:08 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224410>

Hi folks,

while trying to parse git diff-tree output, I found out that in some
cases it appears to generate an incorrect diff (AFAICT). I orginally
found this in a 5-way merge commit in the Linux kernel, but managed to
reduce this to something a lot more managable (an ordinary 2-way merge
on a 6-line file).

To start with the wrong-ness, this is the diff generated:

$ git diff-tree -p -c HEAD
d945a51b6ca22e6e8e550c53980d026f11b05158
diff --combined file
index 3404f54,0eab113..e8c8c18
--- a/file
+++ b/file
@@@ -1,7 -1,5 +1,6 @@@
 +LEFT
  BASE2
  BASE3
  BASE4
- BASE5
+ BASE5MODIFIED
  BASE6

Here, the header claims that the first head has 7 lines, but there really are
only 6 (5 lines of context and one delete line). The numbers for the others
heads are incorrect. In the original diff, the difference was bigger
(first head was stated to have 28 lines, while the output was similar to
the above).

To find out what's going on, we can look at the -m output, which is
correct (or look at the original file contents at the end of this mail).

$ git diff-tree -m -p HEAD
d945a51b6ca22e6e8e550c53980d026f11b05158
diff --git a/file b/file
index 3404f54..e8c8c18 100644
--- a/file
+++ b/file
@@ -1,7 +1,6 @@
 LEFT
-BASE1
 BASE2
 BASE3
 BASE4
-BASE5
+BASE5MODIFIED
 BASE6
d945a51b6ca22e6e8e550c53980d026f11b05158
diff --git a/file b/file
index 0eab113..e8c8c18 100644
--- a/file
+++ b/file
@@ -1,3 +1,4 @@
+LEFT
 BASE2
 BASE3
 BASE4

As you can see here, first head added "LEFT", and the second head removed
"BASE1" and modified "BASE5". In the -c diff-tree output above, this removal of
"BASE1" is not shown, but it is counted in the number of lines, causing this
breakage.


Note that to trigger this behaviour, the number of context lines between the
BASE1 and BASE5 must be _exactly_ 3, more or less prevents this bug from
occuring. Also, the "LEFT" line introduced does not seem to be
essential, but there needed to be some change from both sides in order
to generate a diff at all.

I haven't looked into the code, though I might give that a go later.
Anyone got any clue why this is happening? Is this really a bug, or am I
misunderstanding here?

To recreate the above situation, you can use the following commands:

git init
cat > file <<EOF
BASE1
BASE2
BASE3
BASE4
BASE5
BASE6
EOF
git add file
git commit -m BASE
git checkout -b RIGHT
cat > file <<EOF
BASE2
BASE3
BASE4
BASE5MODIFIED
BASE6
EOF
git commit -m RIGHT file
git checkout -b LEFT master
cat > file <<EOF
LEFT
BASE1
BASE2
BASE3
BASE4
BASE5
BASE6
EOF
git commit -m LEFT file
git merge RIGHT
cat > file <<EOF
LEFT
BASE2
BASE3
BASE4
BASE5MODIFIED
BASE6
EOF
git add file
git commit --no-edit
git diff-tree -p -c HEAD


Gr.

Matthijs
