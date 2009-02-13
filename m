From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: pruning recipe for destructive filter-branch
Date: Fri, 13 Feb 2009 18:14:39 +0100
Message-ID: <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 18:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY1eC-0004wB-6p
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 18:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbZBMROt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2009 12:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbZBMROt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 12:14:49 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:57246 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbZBMROs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 12:14:48 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 18:14:47 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 18:14:46 +0100
X-Mailer: git-send-email 1.6.2.rc0.274.g97213
X-OriginalArrivalTime: 13 Feb 2009 17:14:46.0356 (UTC) FILETIME=[91C49940:01C98DFE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109761>

Add a section about how to shrink a repository's size after running
git-filter-branch to remove large blobs from history.

This comes up every week or so on IRC, and the commands required to
handle every case are not very newbie-friendly, so hopefully writing
them down somewhere leads to fewer questions.

Thanks to doener (Bj=C3=B6rn Steinbrink) for comments and corrections.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Or we could just add an option --prune-everything-I-have-a-backup-I-pro=
mise
to git-filter-branch, so that users can get the same result with less e=
ffort.


 Documentation/git-filter-branch.txt |   36 +++++++++++++++++++++++++++=
++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index 1fbbbb4..737c555 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -339,6 +339,42 @@ git filter-branch --index-filter \
 ---------------------------------------------------------------
=20
=20
+
+Checklist for Shrinking a Repository
+------------------------------------
+
+git-filter-branch is often used to get rid of a subset of files,
+usually with some combination of `\--index-filter` and
+`\--subdirectory-filter`.  If you want to physically shrink the
+repository afterwards, you have some choices:
+
+* Clone it with `git clone file:///path/to/repo`.  The clone will not
+  have the removed objects.  See linkgit:git-clone[1].  (Note that
+  cloning with a plain path just hardlinks everything!)
+
+If you really don't want to clone it, for whatever reasons, check the
+following points (in this order).  This is a very destructive
+approach, so *make a backup* or go back to cloning it.  You have been
+warned.
+
+* Make sure you really removed all variants of a filename, if a blob
+  was moved over its lifetime.  `git log \--follow \--all \-- foo` can
+  help you find renames.
+
+* Make sure you really filtered all refs: use `\--tag-name-filter cat
+  \-- \--all` when calling git-filter-branch.
+
+* Make sure you remove the original refs backed up by
+  git-filter-branch: say `git for-each-ref \--format=3D"%(refname)"
+  refs/original/ | xargs -n 1 git update-ref -d`.
+
+* Expire all reflogs with `git reflog expire \--expire=3Dnow \--all`.
+
+* Repack to remove packed objects with `git repack -ad`.
+
+* Prune unpacked unreferenced objects with `git prune \--expire=3Dnow`=
=2E
+
+
 Author
 ------
 Written by Petr "Pasky" Baudis <pasky@suse.cz>,
--=20
1.6.2.rc0.274.g97213
