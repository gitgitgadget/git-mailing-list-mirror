From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/3] filter-branch: use --simplify-merges
Date: Tue, 12 Aug 2008 10:45:59 +0200
Message-ID: <fb479cdb219a3ebbcd19cc864a50dd76c603b38a.1218529494.git.trast@student.ethz.ch>
References: <cover.1218529494.git.trast@student.ethz.ch>
 <b6bda5e5028aea161e5d18e0c70c45d5a94dac82.1218529494.git.trast@student.ethz.ch>
 <2c31171ea3181f9dfe7c96a2af98e1a5bcf1358a.1218529494.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 10:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSpXB-0002oq-Sf
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 10:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbYHLIqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 04:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYHLIqB
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 04:46:01 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:33951 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbYHLIp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 04:45:59 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 10:45:54 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 10:45:53 +0200
X-Mailer: git-send-email 1.6.0.rc2.30.gb6bda
In-Reply-To: <2c31171ea3181f9dfe7c96a2af98e1a5bcf1358a.1218529494.git.trast@student.ethz.ch>
In-Reply-To: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
References: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Aug 2008 08:45:53.0677 (UTC) FILETIME=[D473C3D0:01C8FC57]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92081>

Use rev-list --simplify-merges everywhere.  This changes the behaviour
of --subdirectory-filter in cases such as

  O -- A -\
   \       \
    \- B -- M

where A and B bring the same changes to the subdirectory: It now keeps
both sides of the merge.  Previously, the history would have been
simplified to 'O -- A'.  Merges of unrelated side histories that never
touch the subdirectory are still removed.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-filter-branch.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a140337..2688254 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -232,11 +232,11 @@ mkdir ../map || die "Could not create map/ directory"
 case "$filter_subdir" in
 "")
 	git rev-list --reverse --topo-order --default HEAD \
-		--parents "$@"
+		--parents --simplify-merges "$@"
 	;;
 *)
 	git rev-list --reverse --topo-order --default HEAD \
-		--parents "$@" -- "$filter_subdir"
+		--parents --simplify-merges "$@" -- "$filter_subdir"
 esac > ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
@@ -326,7 +326,8 @@ then
 	do
 		sha1=$(git rev-parse "$ref"^0)
 		test -f "$workdir"/../map/$sha1 && continue
-		ancestor=$(git rev-list -1 $ref -- "$filter_subdir")
+		ancestor=$(git rev-list --simplify-merges -1 \
+				$ref -- "$filter_subdir")
 		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
 	done < "$tempdir"/heads
 fi
-- 
1.6.0.rc2.30.gb6bda
