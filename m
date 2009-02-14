From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3] Documentation: pruning recipe for destructive filter-branch
Date: Sat, 14 Feb 2009 21:56:51 +0100
Message-ID: <1234645011-8092-1-git-send-email-trast@student.ethz.ch>
References: <7vab8ou89h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 21:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRan-0006qI-MA
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZBNU5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 15:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZBNU5B
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:57:01 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:30681 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbZBNU5A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:57:00 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:56:59 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:56:58 +0100
X-Mailer: git-send-email 1.6.2.rc0.296.ge2122
In-Reply-To: <7vab8ou89h.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 14 Feb 2009 20:56:58.0787 (UTC) FILETIME=[C6EDDF30:01C98EE6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109925>

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

Junio C Hamano wrote:
> I am sorry, but the above does not flow well.  The first two common
> preparatory steps appear as if it is only for the "clone" method.

You're absolutely right.  I should have re-read it more thoroughly
after the rearrangement...

I also changed the --prune-expire to --prune, and changed the
surrounding wording since it's now not a new option any more, just new
semantics for an old one.

=46urthermore, I noticed that asciidoc tries to turn file:///... into a
link, mangling the entire paragraph's formatting in the process.
Apparently +++quoting+++ helps.


 Documentation/git-filter-branch.txt |   41 +++++++++++++++++++++++++++=
++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index 1fbbbb4..7ffe03f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -339,6 +339,47 @@ git filter-branch --index-filter \
 ---------------------------------------------------------------
=20
=20
+
+Checklist for Shrinking a Repository
+------------------------------------
+
+git-filter-branch is often used to get rid of a subset of files,
+usually with some combination of `\--index-filter` and
+`\--subdirectory-filter`.  People expect the resulting repository to
+be smaller than the original, but you need a few more steps to
+actually make it smaller, because git tries hard not to lose your
+objects until you tell it to.  First make sure that:
+
+* You really removed all variants of a filename, if a blob was moved
+  over its lifetime.  `git log \--name-only \--follow \--all \--
+  filename` can help you find renames.
+
+* You really filtered all refs: use `\--tag-name-filter cat \--
+  \--all` when calling git-filter-branch.
+
+Then there are two ways to get a smaller repository.  A safer way is
+to clone, that keeps your original intact.
+
+* Clone it with `git clone +++file:///path/to/repo+++`.  The clone
+  will not have the removed objects.  See linkgit:git-clone[1].  (Note
+  that cloning with a plain path just hardlinks everything!)
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
+* Garbage collect all unreferenced objects with `git gc \--prune=3Dnow=
`
+  (or if your git-gc is not new enough to support arguments to
+  `\--prune`, use `git repack -ad; git prune` instead).
+
+
 Author
 ------
 Written by Petr "Pasky" Baudis <pasky@suse.cz>,
--=20
1.6.2.rc0.296.ge2122
