From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2] describe: Make --tags and --all match lightweight tags
	more often
Date: Mon, 13 Oct 2008 07:39:46 -0700
Message-ID: <20081013143946.GP4856@spearce.org>
References: <20080930083940.GA11453@artemis.corp> <20081010165952.GI8203@spearce.org> <20081010171217.GB29028@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 16:41:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpObV-00015r-Ov
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 16:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbYJMOjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Oct 2008 10:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbYJMOjs
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 10:39:48 -0400
Received: from george.spearce.org ([209.20.77.23]:54290 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbYJMOjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 10:39:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A1F1A3835F; Mon, 13 Oct 2008 14:39:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081010171217.GB29028@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98117>

If the caller supplies --tags they want the lightweight, unannotated
tags to be searched for a match.  If a lightweight tag is closer
in the history, it should be matched, even if an annotated tag is
reachable further back in the commit chain.

The same applies with --all when matching any other type of ref.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Acked-By: Uwe Kleine-K=EF=BF=BDnig <ukleinek@strlen.de>
---
 Changes since v1 of this patch:

 - Documentation updates were added.
 - Comment for "tags" flag modified per Uwe's suggestion.

 Documentation/git-describe.txt |    9 +++++++--
 builtin-describe.c             |    6 ++----
 t/t6120-describe.sh            |    8 ++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describ=
e.txt
index c4dbc2a..40e061f 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -18,6 +18,9 @@ shown.  Otherwise, it suffixes the tag name with the =
number of
 additional commits on top of the tagged object and the
 abbreviated object name of the most recent commit.
=20
+By default (without --all or --tags) `git describe` only shows
+annotated tags.  For more information about creating annoated tags
+see the -a and -s options to linkgit:git-tag[1].
=20
 OPTIONS
 -------
@@ -26,11 +29,13 @@ OPTIONS
=20
 --all::
 	Instead of using only the annotated tags, use any ref
-	found in `.git/refs/`.
+	found in `.git/refs/`.  This option enables matching
+	any known branch, remote branch, or lightweight tag.
=20
 --tags::
 	Instead of using only the annotated tags, use any tag
-	found in `.git/refs/tags`.
+	found in `.git/refs/tags`.  This option enables matching
+	a lightweight (non-annotated) tag.
=20
 --contains::
 	Instead of finding the tag that predates the commit, find
diff --git a/builtin-describe.c b/builtin-describe.c
index ec404c8..d2cfb1b 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -15,8 +15,8 @@ static const char * const describe_usage[] =3D {
 };
=20
 static int debug;	/* Display lots of verbose info */
-static int all;	/* Default to annotated tags only */
-static int tags;	/* But allow any tags if --tags is specified */
+static int all;	/* Any valid ref can be used */
+static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
@@ -112,8 +112,6 @@ static int compare_pt(const void *a_, const void *b=
_)
 {
 	struct possible_tag *a =3D (struct possible_tag *)a_;
 	struct possible_tag *b =3D (struct possible_tag *)b_;
-	if (a->name->prio !=3D b->name->prio)
-		return b->name->prio - a->name->prio;
 	if (a->depth !=3D b->depth)
 		return a->depth - b->depth;
 	if (a->found_order !=3D b->found_order)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 16cc635..e6c9e59 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -91,10 +91,10 @@ check_describe D-* HEAD^^
 check_describe A-* HEAD^^2
 check_describe B HEAD^^2^
=20
-check_describe A-* --tags HEAD
-check_describe A-* --tags HEAD^
-check_describe D-* --tags HEAD^^
-check_describe A-* --tags HEAD^^2
+check_describe c-* --tags HEAD
+check_describe c-* --tags HEAD^
+check_describe e-* --tags HEAD^^
+check_describe c-* --tags HEAD^^2
 check_describe B --tags HEAD^^2^
=20
 check_describe B-0-* --long HEAD^^2^
--=20
1.6.0.2.706.g340fc

--=20
Shawn.
