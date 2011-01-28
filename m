From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Fri, 28 Jan 2011 21:29:41 +0100
Message-ID: <4D432735.8000208@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com> <4D4063EC.7090509@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 21:30:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piuxz-0003MC-3s
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 21:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab1A1Uam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 15:30:42 -0500
Received: from india601.server4you.de ([85.25.151.105]:40362 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1A1Ual (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 15:30:41 -0500
Received: from [192.168.2.104] (p4FFD9AF7.dip.t-dialin.net [79.253.154.247])
	by india601.server4you.de (Postfix) with ESMTPSA id AAE6F2F8091;
	Fri, 28 Jan 2011 21:30:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D4063EC.7090509@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165639>

Am 26.01.2011 19:11, schrieb Ren=E9 Scharfe:
> So far we have two action items, I think:
>=20
> - Make git grep report non-matching path specs (new feature).
>=20
> - Find out why removing the last path component made a difference in
> the case above (looks like a bug, but I don't understand what's going
> on).

OK, regarding the second point:

Merges that have at least one parent without changes in the selected
subset of files won't be displayed, not even with --full-history.  That
explains why removing the last path component made a difference: all th=
e
merges ended up with a version of the file that matched one of their
parents, but there were other changes in the directory.

This is a feature: since the version of the file picked by the merge
must have been introduced by an earlier commit (a regular one,
presumably), you'll find it there anyway.

And this history simplification takes precedence over pickaxe (-S).

The patch below turns down its aggressiveness when the pickaxe is swung
at the same time.  Here's what it does to your use case:

	$ revs=3D"v2.6.26..v2.6.29"
	$ opts=3D"-Sblacklist_iommu --oneline -m --full-history"

	# This takes quite a while...
	$ git log $opts $revs | wc -l
	160

	# Without the patch:
	$ git log $opts $revs -- drivers/pci/intel-iommu.c | wc -l
	2

	# With the patch (really just its first hunk):
	$ git log $opts $revs -- drivers/pci/intel-iommu.c | wc -l
	160

	$ opts=3D"-Sblacklist_iommu --oneline -m"

	# This takes quite a while...
	$ git log $opts $revs | wc -l
	160

	# Without the patch:
	$ git log $opts $revs -- drivers/pci/intel-iommu.c | wc -l
	0

	# With the patch:
	$ git log $opts $revs -- drivers/pci/intel-iommu.c | wc -l
	160

	$ opts=3D"-Sblacklist_iommu --oneline"

	# This takes a bit, but not too long.
	$ git log $opts $revs | wc -l
	1

	# Without the patch:
	$ git log $opts $revs -- drivers/pci/intel-iommu.c | wc -l
	0

	# With the patch:
	$ git log $opts $revs -- drivers/pci/intel-iommu.c | wc -l
	1

The full output matches exactly if the number of lines match.  That's t=
o
be expected, as the string "blacklist_iommu" only ever appears in the
file drivers/pci/intel-iommu.c.

It wasn't mentioned before v2.6.26 or after v2.6.29.

There is only one regular commit, namely the initial one that introduce=
d
the function.  Some merges are reported more than once, each for every
parent where -S hit.  135 unique commits are reported.

-- >8 --
Subject: pickaxe: don't simplify history too much

If pickaxe is used, turn off history simplification and make sure to ke=
ep
merges with at least one interesting parent.

If path specs are used, merges that have at least one parent whose file=
s
match those in the specified subset are edited out.  This is good in
general, but leads to unexpectedly few results if used together with
pickaxe.  Merges that also have an interesting parent (in terms of -S o=
r
-G) are dropped, too.

This change makes sure pickaxe takes precedence over history
simplification.  This means path specs won't change the results as long
as they contain all the files that pickaxe turns up.  E.g. these two
commands now report the same single commit that added the function
blacklist_iommu to the specified file in the Linux kernel repo:

   $ git log -Sblacklist_iommu v2.6.26..v2.6.29 --
   $ git log -Sblacklist_iommu v2.6.26..v2.6.29 -- drivers/pci/intel-io=
mmu.c

Previously the second one came up empty.

Reported-by: Francis Moreau <francis.moro@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 revision.c                   |    5 +++++
 t/t6012-rev-list-simplify.sh |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 7b9eaef..cacf60c 100644
--- a/revision.c
+++ b/revision.c
@@ -441,6 +441,8 @@ static void try_to_simplify_commit(struct rev_info =
*revs, struct commit *commit)
 	}
 	if (tree_changed && !tree_same)
 		return;
+	if (tree_changed && revs->diffopt.pickaxe)
+		return;
 	commit->object.flags |=3D TREESAME;
 }
=20
@@ -1647,6 +1649,9 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 	    revs->diffopt.filter ||
 	    DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 		revs->diff =3D 1;
+
+	if (revs->diffopt.pickaxe)
+		revs->simplify_history =3D 0;
=20
 	if (revs->topo_order)
 		revs->limited =3D 1;
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.s=
h
index af34a1e..b4fb8d0 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -86,5 +86,7 @@ check_result 'I H E C B A' --full-history --date-orde=
r -- file
 check_result 'I E C B A' --simplify-merges -- file
 check_result 'I B A' -- file
 check_result 'I B A' --topo-order -- file
+check_result 'I C B' -SHello
+check_result 'I C B' -SHello -- file
=20
 test_done
--=20
1.7.3.4
