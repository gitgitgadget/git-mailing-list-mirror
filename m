From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [BUGFIX PATCH 2/2] fast-export: use an unsorted string list for
 extra_refs
Date: Sun, 23 Nov 2008 12:55:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811231255380.30769@pacific.mpi-cbg.de>
References: <1227378168-14992-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0811231254580.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 12:49:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4DSm-00048A-UD
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 12:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619AbYKWLrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 06:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757634AbYKWLrw
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 06:47:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:42808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757029AbYKWLrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 06:47:51 -0500
Received: (qmail invoked by alias); 23 Nov 2008 11:47:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 23 Nov 2008 12:47:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hwBsxyJ8h2PVCU0VaoSPD1/NR2rbvCRgnZrsQTg
	q3RH/8/QOvHISD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0811231254580.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101569>


The list extra_refs contains tags and the objects referenced by them,
so that they can be handled at the end.  When a tag references a
commit, that commit is added to the list using the same name.

Also, the function handle_tags_and_duplicates() relies on the order
the items were added to extra_refs, so clearly we do not want to
use a sorted list here.

Noticed by Miklos Vajna.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	My bad.  Sorry.

 builtin-fast-export.c  |    4 ++--
 t/t9301-fast-export.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 7c93eb8..7d5d57a 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -354,7 +354,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		case OBJ_TAG:
 			tag = (struct tag *)e->item;
 			while (tag && tag->object.type == OBJ_TAG) {
-				string_list_insert(full_name, extra_refs)->util = tag;
+				string_list_append(full_name, extra_refs)->util = tag;
 				tag = (struct tag *)tag->tagged;
 			}
 			if (!tag)
@@ -374,7 +374,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		}
 		if (commit->util)
 			/* more than one name for the same object */
-			string_list_insert(full_name, extra_refs)->util = commit;
+			string_list_append(full_name, extra_refs)->util = commit;
 		else
 			commit->util = full_name;
 	}
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 9af50b5..2057435 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -231,7 +231,7 @@ test_expect_success 'fast-export -C -C | fast-import' '
 
 '
 
-test_expect_failure 'fast-export | fast-import when master is tagged' '
+test_expect_success 'fast-export | fast-import when master is tagged' '
 
 	git tag -m msg last &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
-- 
1.6.0.2.749.g0cc32
