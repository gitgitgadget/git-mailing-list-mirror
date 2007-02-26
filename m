From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: RFC: [PATCH] Support incremental pack files
Date: Mon, 26 Feb 2007 22:45:52 +0100
Message-ID: <20070226214552.GA13402@auto.tuwien.ac.at>
References: <20070223071344.GA21107@auto.tuwien.ac.at> <7vfy8x9tvo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 22:46:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLnfU-0000e8-8q
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 22:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbXBZVp5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 26 Feb 2007 16:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbXBZVp5
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 16:45:57 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:38523 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161224AbXBZVpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 16:45:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 76ACD68006A7;
	Mon, 26 Feb 2007 22:45:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yhFgo2uq+7hV; Mon, 26 Feb 2007 22:45:52 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id E23B06800672; Mon, 26 Feb 2007 22:45:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfy8x9tvo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40667>

On Fri, Feb 23, 2007 at 12:10:35AM -0800, Junio C Hamano wrote:
> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
>=20
> > Commiting a new version in GIT increases the storage by the compres=
sed
> > size of each changed blob. Packing all unpacked objects decreases t=
he
> > required storage, but does not generate deltas against objects in
> > packs. You need to repack all objects to get around this.
> >
> > For normal source code, this is not a problem.  But if you want to =
use
> > git for big files, you waste storage (or CPU time for everything
> > repacking).
>=20
> Three points that might help you without any code change.
>=20
>  - Have you run "git repack -a -d" without "-f"?  Reusing of
>    existing delta is specifically designed to avoid the "CPU
>    time for everything repacking" problem.
>=20
>  - If you are dealing with something other than "normal source
>    code", do you know if your objects delta against each other
>    well?  If not, turning core.legacyheaders off might be a
>    win.  It allows the objects that are recorded as non-delta in
>    resulting pack to be copied straight from loose objects.

I currently use CVS to save the daily changes in database dumps (files
mostly containing INSERT INTO xx (...) VALUES (...);). I'm trying to
switch this to git.

A commit typically consists of some files with a size of > 100 MB and
are growing every day. (All unpacked blob objects of) A commit require
currently about 60 MB. A incremental pack file containing one commit
is smaller than 1 MB, so the delta works well.

>  - Once you accumulated large enough packs with existing
>    objects, marking them with .keep would leave them untouched
>    during subsequent repack.  When "git repack -a -d" repacks
>    "everything", its definition of "everything" becomes "except
>    things that are in packs marked with .keep files".
>=20
> Side note: Is the .keep mechanism sufficiently documented?  I am
> too lazy to check that right now, but here is a tip.  After
> releasing the big one, line v1.5.0, I do:

I have not found any notice of this in the git documentation.

>   $ P=3D.git/objects/pack
>   $ git rev-list --objects v1.5.0 |
>     git pack-objects --delta-base-offset \
>           --depth=3D30 --window=3D100 --no-reuse-delta pack
>   ...
>   6fba5cb8ed92dfef71ff47def9f95fa1e703ba59
>   $ mv pack-6fba5cb8ed92dfef71ff47def9f95fa1e703ba59.* $P/
>   $ echo 'Post 1.5.0' >$P/pack-6fba5cb8ed92dfef71ff47def9f95fa1e703ba=
59.keep
>   $ git gc --prune
>=20
> This does three things:
>=20
>  - It packs everything reachable from v1.5.0 with delta chain
>    that is deeper than the default.
>=20
>  - The pack is installed in the object store; the presence of
>    .keep file (the contents of it does not matter) tells
>    subsequent repack not to touch it.
>=20
>  - Then the remaining objects are packed into different pack.
>=20
> With this, the repository uses two packs, one is what I'll keep
> until it's time to do the big repack again, another is what's
> constantly recreated by repacking but contains only "recent"
> object.

This could be a practical solution for me. The biggest disadvantage
of this solution is, that each pack file is at least >=3D 60 MB.

A nice feature of git is, that it normally does not change files,
which keeps incremental backups small. I want to retain this, so I
want avoid uncessary repacking.

As I have no tags, I can base the repacking decision only on file
size:

  * Daily: Mark all packs >=3D eg. 100 MB as keep and repack the
           repository.
  * Weekly/Monthly/Yearly: repack repository including packs of the
           next size class.

My first idea was to write a script, which delete all keep files,
recreates them for packs bigger than a specified size and the starts
git-repack.

As git-repack already calls find, this could be easly added to the
script:

--- git-repack  2007-02-17 18:06:09.000000000 +0100
+++ git-repack1 2007-02-26 22:09:12.000000000 +0100
@@ -8,11 +8,12 @@
 . git-sh-setup

 no_update_info=3D all_into_one=3D remove_redundant=3D
-local=3D quiet=3D no_reuse_delta=3D extra=3D
+local=3D quiet=3D no_reuse_delta=3D extra=3D sizearg=3D
 while case "$#" in 0) break ;; esac
 do
        case "$1" in
        -n)     no_update_info=3Dt ;;
+       -s)     sizearg=3D"-size -${2}k" ; shift; ;;
        -a)     all_into_one=3Dt ;;
        -d)     remove_redundant=3Dt ;;
        -q)     quiet=3D-q ;;
@@ -46,7 +47,7 @@
        ;;
 ,t,)
        if [ -d "$PACKDIR" ]; then
-               for e in `cd "$PACKDIR" && find . -type f -name '*.pack=
' \
+               for e in `cd "$PACKDIR" && find . -type f $sizearg -nam=
e '*.pack' \
                        | sed -e 's/^\.\///' -e 's/\.pack$//'`
                do
                        if [ -e "$PACKDIR/$e.keep" ]; then


> > It only permits, that the base commit of a delta is located in a
> > different pack or as unpacked object.
>=20
> This "only" change needs to be done _very_ carefully, since
> self-containedness of pack files is one of the important
> elements of the stability of a git repository.

I understand the problems. GIT would need at least a list of external
base objects in the pack to speed up things like eg. git-prune.

mfg Martin K=F6gler
