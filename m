From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/9 v5] Documentation: add "git bisect replace"
 documentation
Date: Mon, 24 Nov 2008 22:14:40 +0100
Message-ID: <20081124221440.e68654a7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4ilG-0003ID-Ni
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 22:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbYKXVNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 16:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYKXVNL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 16:13:11 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:39286 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbYKXVNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 16:13:10 -0500
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 3A66C32A7B4;
	Mon, 24 Nov 2008 22:13:08 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp8-g19.free.fr (Postfix) with SMTP id 835CD32A8AC;
	Mon, 24 Nov 2008 22:12:56 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101623>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   61 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 39034ec..be7518c 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -24,6 +24,7 @@ on the subcommand:
  git bisect visualize
  git bisect replay <logfile>
  git bisect log
+ git bisect replace <rev> [<rev>]
  git bisect run <cmd>...
 
 This command uses 'git rev-list --bisect' to help drive the
@@ -186,6 +187,66 @@ $ git bisect start v2.6.20-rc6 v2.6.20-rc4 v2.6.20-rc1 --
                    # v2.6.20-rc4 and v2.6.20-rc1 are good
 ------------
 
+Bisect replace
+~~~~~~~~~~~~~~
+
+This subcommand should be used when you have a branch or a part of a
+branch that isn't easily bisectable because of a bug that has been
+fixed latter.
+
+We suppose that a bug as been introduced at some point, say A, and
+that it has been fixed latter at another point, say B, but that
+between these points the code is not easily testable because of the
+bug, so it's not easy to bisect between these points.
+
+In this case you can create a branch starting at the parent of A, say
+O, that has a fixed history. In this fixed history for example, there
+could be first a commit C that is the result of squashing A and B
+together and then all the commits between A and B that have been cherry
+picked.
+
+For example, let's say the commits between A and B are X1, X2, ... Xn
+and they have been cherry picked after C as Y1, Y2, ... Yn:
+
+------------
+       C--Y1--Y2--...--Yn
+      /
+...--O--A--X1--X2--...--Xn--B--...
+------------
+
+By design, the last cherry picked commit (Yn) should point to the same
+tree as commit B.
+
+So in this case you can say:
+
+------------
+$ git bisect replace B Yn
+------------
+
+and a special ref will be created that points to commit Yn. This ref
+will be named: "refs/replace/bisect/B"
+
+When bisecting, the refs in "refs/replace/bisect/" will be scanned and
+each ref named X found there and pointing to commit Y will be grafted
+so that X will only have Y as parent.
+
+In the example above, that means that instead of the above graph, the
+following graph will be bisected:
+
+------------
+       C--Y1--Y2--...--Yn
+      /                  \
+...--O                    B--...
+------------
+
+This means that the bisections on this branch may be much easier
+because the bug introduced by commit A and fixed by commit B will not
+annoy you anymore.
+
+As the refs created by "git bisect replace" can be shared between
+developers, this feature might be especially usefull on big projects
+where many people often bisect the same code base.
+
 Bisect run
 ~~~~~~~~~~
 
-- 
1.5.6.1.1657.g6a50
