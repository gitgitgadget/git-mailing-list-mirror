From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix install-doc-quick target
Date: Sun, 05 Aug 2007 00:07:40 -0700
Message-ID: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
References: <46B49617.3070402@gmail.com>
	<Pine.LNX.4.64.0708041637450.14781@racer.site>
	<46B4A2B0.9080208@gmail.com>
	<Pine.LNX.4.64.0708041704040.14781@racer.site>
	<46B4A5FD.3070107@gmail.com>
	<Pine.LNX.4.64.0708041719490.14781@racer.site>
	<46B4BDCF.9060809@gmail.com>
	<Pine.LNX.4.64.0708042229130.14781@racer.site>
	<46B4F91D.1070907@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 05 09:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHaDK-0004q2-4J
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 09:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbXHEHHn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 03:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbXHEHHn
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 03:07:43 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57843 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbXHEHHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 03:07:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805070742.IRJU14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 03:07:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y77g1X00A1kojtg0000000; Sun, 05 Aug 2007 03:07:41 -0400
In-Reply-To: <46B4F91D.1070907@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Sun, 05 Aug 2007 00:09:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54959>

The script starts in a subdirectory of the source directory to
muck with a branch whose structure does not have anything to
do with the actual work tree.  Go up to the top to make it clear
that we operate on the whole tree.

It also exported GIT_DIR without any good reason.  Remove it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am getting the impression that the semantics of the updated
   work-tree support is as broken as the original, although the
   code that implements it is easier to read.  

   Admittedly, this is an unorthodox corner case usage, that
   deals with a tree structure that does not have any relation
   with the current project state, and the script is started
   with a subdirectory of the current project.  What is needed
   is a way to tell git that "we may be in a subdirectory but
   the tree structure we are dealing with does not have anything
   to do with the current work tree structure -- ignore the fact
   that we are not at the toplevel", and exporting of GIT_DIR
   was the way to do so in the old world order.

   Another way to do this in the new world order would be to
   pass "--work-tree=.", but this has its own problems it
   seems.  You can try commenting out cd_to_toplevel this patch
   introduces, then rewrite checkout-index part with:

    git --git-dir="$GIT_DIR" --work-tree=. checkout-index -a...

   which seems to work, but if you drop --git-dir="$GIT_DIR"
   from the above (without reintroducing the export of GIT_DIR),
   you get "fatal: Could not switch to '.git'" which seems quite
   bogus.  If you say:

	git --work-tree=. foo

   without saying anything about GIT_DIR, shouldn't we run the
   usual .git/ discovery, going up the directories? 

 Documentation/install-doc-quick.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
index e6601bd..07d227f 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -7,7 +7,7 @@ mandir="$2"
 SUBDIRECTORY_OK=t
 USAGE='<refname> <target directory>'
 . git-sh-setup
-export GIT_DIR
+cd_to_toplevel
 
 test -z "$mandir" && usage
 if ! git rev-parse --verify "$head^0" >/dev/null; then
@@ -18,6 +18,8 @@ fi
 GIT_INDEX_FILE=`pwd`/.quick-doc.index
 export GIT_INDEX_FILE
 rm -f "$GIT_INDEX_FILE"
+trap 'rm -f "$GIT_INDEX_FILE"' 0
+
 git read-tree $head
 git checkout-index -a -f --prefix="$mandir"/
 
-- 
1.5.3.rc4.8.ga120
