From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-recursive: mark rename/delete conflict as unmerged
Date: Mon, 22 Dec 2008 23:10:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812222308410.30769@pacific.mpi-cbg.de>
References: <85647ef50812220629o46134a70waf159bb6cd6d6e72@mail.gmail.com> <7v4p0whr7a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEsuO-0002LJ-R5
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 23:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759037AbYLVWEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 17:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756351AbYLVWEX
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 17:04:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:59079 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759030AbYLVWEU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 17:04:20 -0500
Received: (qmail invoked by alias); 22 Dec 2008 22:04:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 22 Dec 2008 23:04:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kMBEjXmJkDJgWWjTEr1oPxgbjIc/1Ke5dWl3QKS
	eqXwTC2UVCQSe2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v4p0whr7a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103776>


When a file was renamed in one branch, but deleted in the other, one
should expect the index to contain an unmerged entry, namely the
target of the rename.  Make it so.

Noticed by Constantine Plotnikov.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 22 Dec 2008, Junio C Hamano wrote:

	> "Constantine Plotnikov" <constantine.plotnikov@gmail.com> writes:
	> 
	> > I think that if git merge reports the conflicts, such 
	> > conflicts should be discoverable using git ls-files and prevent 
	> > commit with resolving the conflict like it is done with
	> > modify-delete conflicts.
	> 
	> Yeah, I think so, too.

	A test case would have been nice.

 merge-recursive.c          |    5 +++++
 t/t6024-recursive-merge.sh |   23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a0c804c..69e7152 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -902,6 +902,11 @@ static int process_renames(struct merge_options *o,
 				       ren1_src, ren1_dst, branch1,
 				       branch2);
 				update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
+				update_stages(ren1_dst, NULL,
+						branch1 == o->branch1 ?
+						ren1->pair->two : NULL,
+						branch1 == o->branch1 ?
+						NULL : ren1->pair->two, 1);
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
 				const char *new_path;
 				clean_merge = 0;
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 802d0d0..129fa30 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -97,4 +97,27 @@ test_expect_success 'refuse to merge binary files' '
 		merge.err
 '
 
+test_expect_success 'mark rename/delete as unmerged' '
+
+	git reset --hard &&
+	git checkout -b delete &&
+	git rm a1 &&
+	test_tick &&
+	git commit -m delete &&
+	git checkout -b rename HEAD^ &&
+	git mv a1 a2
+	test_tick &&
+	git commit -m rename &&
+	test_must_fail git merge delete &&
+	test 1 = $(git ls-files --unmerged | wc -l) &&
+	git rev-parse --verify :2:a2 &&
+	test_must_fail git rev-parse --verify :3:a2 &&
+	git checkout -f delete &&
+	test_must_fail git merge rename &&
+	test 1 = $(git ls-files --unmerged | wc -l) &&
+	test_must_fail git rev-parse --verify :2:a2 &&
+	git rev-parse --verify :3:a2
+
+'
+
 test_done
-- 
1.6.1.rc3.412.ga72b
