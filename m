From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Sat, 29 Jan 2011 21:26:12 +0100
Message-ID: <4D4477E4.6020006@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx> <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com> <4D4063EC.7090509@lsrfire.ath.cx> <4D432735.8000208@lsrfire.ath.cx> <7v1v3wd1al.fsf@alter.siamese.dyndns.org> <4D437CA0.1070006@lsrfire.ath.cx> <7vsjwcb6rh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 21:27:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjHNp-0001Hh-Gw
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 21:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab1A2U0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 15:26:43 -0500
Received: from india601.server4you.de ([85.25.151.105]:60703 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1A2U0m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 15:26:42 -0500
Received: from [192.168.2.104] (p4FFDB056.dip.t-dialin.net [79.253.176.86])
	by india601.server4you.de (Postfix) with ESMTPSA id CBF032F8091;
	Sat, 29 Jan 2011 21:26:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vsjwcb6rh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165671>

Am 29.01.2011 06:47, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Perhaps we should check my underlying assumption first: is it
>> reasonable to expect a git log command to show the same commits
>> with and without a path spec that covers all changed files?
>=20
> The simplest case would be "git log ." vs "git log" from the root
> level of the repository, right?  Traditionally, the former is "please
> show _one_ simplest history that can explain how the current commit
> came to be" (i.e. with merge simplification), while the latter is
> "please list everything that is behind the current commit" (i.e.
> without), I think.
>=20
> It feels unintuitive, but my understanding of the rationale behind
> the design is that, the expectation Linus had when he first did the
> pathspec limited traversal was that most of the time "git log $path"
> is used to get an explanation.  It follows that having to say "git
> log --simplify $path" would have been a nuisance, so "with pathspec,
> we simplify" was thought to be a reasonable default.

I think simplifying the history whenever a pathspec restricts the set o=
f
interesting commits makes sense.

I'm not so sure about "." vs. none, and it feels odd that the only way
to turn off simplification is to not use pathspecs, as --full-history
will still remove merges if tree_same in revision.c is true.
Simplification by default (even without a pathspec) and --full-history
reporting, well, the full history seems more intuitive to me.

So currently pickaxe can't be used reliable to search for strings that
have been removed: either one has to refrain from using pathspecs, whic=
h
is prohibitively slow in the kernel repo, or git is free to take a
short-cut through a branch of history that never contained the string a=
t
all.

Your patch extends --full-history coverage sufficiently to make pickaxe
work in Francis' use case.  One just has to remember to specify this
option if one hunts for removed strings using -S.  Below is an equivale=
nt
patch, only with the simplify_history test moved into the loop and the
needed test script modification.

-- >8 --
Subject: revision: let --full-history keep half-interesting merges

Don't simplify merges away that have at least one parent with changes i=
n
the interesting subset of files if --full-history has been specified.
The previous behaviour hid merges with one uninteresting parent, which
could lead to history that removed code to become undetectable.

E.g., this command run against the Linux kernel repo only found one
merge that brought the specified function in (and the regular commit
which added it in the first place), but missed the 92 merges that
removed it, as well as 67 other merges that added it back:

	$ git log -m --full-history -Sblacklist_iommu \
		v2.6.26..v2.6.29 -- drivers/pci/intel-iommu.c

Reported-by: Francis Moreau <francis.moro@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 revision.c                                 |    2 ++
 t/t6016-rev-list-graph-simplify-history.sh |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 7b9eaef..84c231b 100644
--- a/revision.c
+++ b/revision.c
@@ -434,6 +434,8 @@ static void try_to_simplify_commit(struct rev_info =
*revs, struct commit *commit)
 		case REV_TREE_OLD:
 		case REV_TREE_DIFFERENT:
 			tree_changed =3D 1;
+			if (!revs->simplify_history)
+				return;
 			pp =3D &parent->next;
 			continue;
 		}
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-l=
ist-graph-simplify-history.sh
index f7181d1..50ffcf4 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -168,6 +168,7 @@ test_expect_success '--graph --full-history --simpl=
ify-merges -- bar.txt' '
 	echo "|\\  " >> expected &&
 	echo "| * $C4" >> expected &&
 	echo "* | $A5" >> expected &&
+	echo "* | $A4" >> expected &&
 	echo "* | $A3" >> expected &&
 	echo "|/  " >> expected &&
 	echo "* $A2" >> expected &&
--=20
1.7.3.4
