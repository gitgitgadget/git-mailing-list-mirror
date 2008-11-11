From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/9 v4] Documentation: add "git bisect replace"
 documentation
Date: Tue, 11 Nov 2008 06:39:52 +0100
Message-ID: <20081111063952.a970fe4a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 06:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzlxk-00044M-Rp
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 06:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbYKKFhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 00:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbYKKFhi
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 00:37:38 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:57802 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbYKKFhi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 00:37:38 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 3EA2A3EA0BC;
	Tue, 11 Nov 2008 06:37:36 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id EC2713EA0B0;
	Tue, 11 Nov 2008 06:37:35 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100618>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   61 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 39034ec..3834a34 100644
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
+and a branch will be created that points to commit Yn and that has a
+special name like: "bisect-replace-B"
+
+When bisecting, the branch names will be scanned and each branch named
+"bisect-replace-X" and pointing to commit Y will be grafted so that X
+will only have Y as parent.
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
+As the branches created by "git bisect replace" can be shared between
+developers, this feature might be especially usefull on big projects
+where many people often bisect the same code base.
+
 Bisect run
 ~~~~~~~~~~
 
-- 
1.6.0.3.614.g0f3b9
