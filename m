From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] Documentation: pruning recipe for destructive filter-branch
Date: Sat, 14 Feb 2009 15:22:08 +0100
Message-ID: <1234621328-8998-1-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0902141248220.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 15:27:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYLTv-0007Lo-CQ
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 15:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbZBNOWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 09:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbZBNOWU
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 09:22:20 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:40336 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbZBNOWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 09:22:19 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 15:22:17 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 15:22:16 +0100
X-Mailer: git-send-email 1.6.2.rc0.283.g181d4
In-Reply-To: <alpine.DEB.1.00.0902141248220.10279@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Feb 2009 14:22:16.0537 (UTC) FILETIME=[A3354C90:01C98EAF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109870>

Add a section about how to shrink a repository's size after running
git-filter-branch to remove large blobs from history.

This comes up every week or so on IRC, and the commands required to
handle every case are not very newbie-friendly, so hopefully writing
them down somewhere leads to fewer questions.

It may seem contradictory to document fallbacks for older Gits in
newer docs, but we want to point people at this as a FAQ answer, and
they will frequently not have the newest version installed.

Thanks to Bj=C3=B6rn Steinbrink and Junio C Hamano for comments and
corrections.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Johannes Schindelin wrote:
> On Sat, 14 Feb 2009, Jan Kr=C3=BCger wrote:
>=20
> > Subject: [PATCH] gc: add --prune-expire option equivalent to gc.pru=
neExpire
>=20
> I like it, and if nobody beats me to it, I will add a test for this=20
> option tonight.

Cool, then let's use that in the docs.


 Documentation/git-filter-branch.txt |   36 +++++++++++++++++++++++++++=
++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index 1fbbbb4..d148e58 100644
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
+* Make sure you really removed all variants of a filename, if a blob
+  was moved over its lifetime.  `git log \--name-only \--follow \--all
+  \-- filename` can help you find renames.
+
+* Make sure you really filtered all refs: use `\--tag-name-filter cat
+  \-- \--all` when calling git-filter-branch.
+
+* Clone it with `git clone file:///path/to/repo`.  The clone will not
+  have the removed objects.  See linkgit:git-clone[1].  (Note that
+  cloning with a plain path just hardlinks everything!)
+
+If you really don't want to clone it, for whatever reasons, check the
+following points instead (in this order).  This is a very destructive
+approach, so *make a backup* or go back to cloning it.  You have been
+warned.
+
+* Remove the original refs backed up by git-filter-branch: say `git
+  for-each-ref \--format=3D"%(refname)" refs/original/ | xargs -n 1 gi=
t
+  update-ref -d`.
+
+* Expire all reflogs with `git reflog expire \--expire=3Dnow \--all`.
+
+* Garbage collect all unreferenced objects with `git gc
+  \--prune-expire=3Dnow` (or if your git-gc is not new enough to have
+  that option, `git repack -ad; git prune`).
+
+
 Author
 ------
 Written by Petr "Pasky" Baudis <pasky@suse.cz>,
--=20
1.6.2.rc0.283.g181d4
