Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC7385D7F
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058315; cv=none; b=CMRhYPRTN+cuYG/p1xeBqClSplXwYvSQXmaFDB2KAsbX4SH8VPi0+DddNYXG7zzvgHFKy8JKTCp+sAutj+8u41QokbCKOpeDA08lEw6rNReFt0x7yTQyKeTopKSBekLvDfKUUckka9nMZSVquReeDtW74B8A39BvkAAH/hBHfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058315; c=relaxed/simple;
	bh=rLw4TrJrCrDZvvhzWExUrXVaDzC+fkur3NCrFxivGg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kz65C+EBO736050yduNm/0ei43AzOFjNIVwdwrWkB7ugYYF9usgUByPKaP5obdkUOelZ0BSKzUDclB/PF6h+q2J+6zLv4h4LkCFbBYUE//WE4VRgOco31OkTEYTu/AQ/8dpM1SJ19nCnIk/7ePcYGANyafMt+PPaBh6vnU4KeTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7V/dEHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7V/dEHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5BF1F0089B;
	Sat,  3 Oct 2026 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791058313;
	bh=JkzvX9WYDAROfbKi3yAr2RmXNpPYWJWy7phYD37z4Tg=;
	h=Date:From:To:Cc:Subject;
	b=d7V/dEHMiCc5bjbDYGDOe0fDDk3tsOPmD46sGzfgu2xrQ4RvNUjIYPOo1hNU/pvAf
	 BXaYqWIVmpAdEkOe1kRJ07SR8eBguP3SSdS50QJbIyvG3SZD+QzFc7s+iuK+A8BSCn
	 7HkbAvb4z4PtzHL/T7s8xuQXtvtn/GYsCN4j+RJ43plZp9+orKkoZHe6SPjTXgRvyB
	 WEUJ/fDqr/775ZOCpqdVjNpoMIz1bF8wG9Rw3fyTIaGGKQ0SxV+W8kQg1SNuqlyoF5
	 L7zDmqiBE3wZRErD3X9gz2Hvb/9TpfAF7FCrJvwLq3PgYjiLjuKAGKM1vYK3TGWu6s
	 l/MOLXlUQOFdA==
Date: Sat, 3 Oct 2026 22:11:47 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, 
	Nico Williams <nico@cryptonector.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: [RFC] git-brebase
Message-ID: <asFRVdMTpshsazgM@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hw4ffy3fb3ra7ngc"
Content-Disposition: inline


--hw4ffy3fb3ra7ngc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, 
	Nico Williams <nico@cryptonector.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: [RFC] git-brebase
Message-ID: <asFRVdMTpshsazgM@debian>
MIME-Version: 1.0

Hi!

I've significantly improved the idea from the original thread, thanks to
suggestions from several people (the most fundamental, by Nico Williams
and Ben Boeckel), and inspired to write it after knowing about the tool
written by Nico Williams and Viktor Dukhovni (but I implemented it from
scratch, without reading their implementation, other than looking at the
file size --which, being under 100 LoC, gave me the confidence that it
could be implemented easily--).

I believe now, after several improvements, it is not only simpler than
git-imerge, but also more powerful.

I've not used git-imerge, but I've watched the youtube video of the talk
in which the author explains how it works (and it's quite nice, to be
fair).  First some similarities between both:

-  Both git-imerge and my tool support --first-parent (per the README of
   git-imerge).  My tool has support for this by using git-bisect(1)
   interally for the bisection.

   This feature was suggested to me by Ben Boeckel.

-  Both git-imerge and my tool reach the same tip after a successful
   session.  They differ in the intermediate history.

Below goes an overview of key limitations of the git-imerge approach
(IMO), and which are not present in mine.  If git-imerge supports any of
this, I'm sorry; I didn't find them in their README.

-  git-imerge creates a 2D matrix of conflict resolutions.  This is nice
   for the case of two flat branches.  However, the branch to be rebased
   might also contain merge commits.  This is less common than having
   merge commits in the target branch, but it happens, and in those
   cases, it's frequent to want to keep the structure of the branch,
   with --rebase-merges.  My tool has support for this by using
   git-rebase(1) internally for the rebases.

-  One may want to skip arbitrary commits (because they're known to be
   broken, and possibly immediately reverted).  For that, I've provided
   a specific flag, --pre-exec, which is similar to git-rebase(1)'s
   --exec, but which is executed before each rebase operation, at the
   BISECT_HEAD commit.  An exit code of 125 skips that revision
   immediately, without trying to do any rebases.

   This feature was suggested to me by Ben Boeckel.

-  One may also want to find and resolve semantic conflicts that do not
   appear as physical text conflicts.  For that, I've provided a
   specific flag, --post-exec, which is similar to --pre-exec, but runs
   after each successful git-rebase(1) operation.  This would usually
   build and test the software itself.

   This feature was suggested to me by Ben Boeckel.

-  git-imerge is limited when rebasing trees of branches.  Let's
   consider something more complex:

	*---*---*---*---*---M
	 \
	  *---*---A---*---B
	   \ /     \
	    *       *---C---D

   Let's say M is master, to which we want to rebase the tree composed
   of branches A, B, and C, so that it results in this:

	*---*---*---*---*---M
	                     \
	                      *---*---A'--*---B'
	                       \ /     \
	                        *       *---C'--D'

   With my tool, this becomes trivial (I've been doing this all day
   earlier today, resolving in a few hours what would have taken me
   days).  The approach in this case would be to rebase from root to
   leaves, but to solve conlicts from leaves to root:

	1)  Use git-brebase to rebase A until the first conflict with M.

	2)  Abort the conflicting rebase.  We don't want to resolve the
	    conflict yet, or we'd have to repeat the same resolution
	    later.

	3)  Rebase all its direct descendants into the new A, by
	    performing operations 1 and 2 but with the descendant
	    branches.  Do this recursively with children of children.

	4)  Once all descendants have been moved below the new A, it's
	    time to solve the conflicts in A.  This will result in
	    advancing A by just one commit of M, since we had aborted
	    exactly at the conflicting rebase.

	5)  Rebase the direct descendants on top of the new A, this time
	    with git-rebase(1) --not brebase!-- with --interactive,
	    dropping all commits that exist in A.  This avoids resolving
	    the same conflicts again.  Do this recursively with children
	    of children.

	6)  Rinse and repeat since step 1, until everything is
	    successful.  At that point, we have reached the end of the
	    session.

   This approach is different from git-imerge, in that git-imerge
   manages in a single session the entire rebase operation until
   success, while my tool performs each conflict resolution in a single
   step, and they are entirely independent, and can be interrupted to do
   other work.  My tool requires repeated invocations until reaching the
   end point, denoted by a successful exit status.

Something that git-imerge has that my tool hasn't is the ability to do
merge commits.  My tool exclusively does rebases.  However, once the end
commit is reached, creating that could be used to produce a merge
commit.  It could be done by first reaching the rebase tip in a
disposable branch, then perform a regular merge commit with
git-merge(1), and resolve conflicts by doing something like
	$ git checkout disposable -- .
and then finish the merge.  It's not a critical limitation of my tool,
IMO.  (Although, admittedly, it's a trick that not everyone would know
to do.)

Another difference is that, by doing rebases, my tool doesn't remember
the entire history matrix that git-imerge holds while doing the work.
I see this as an advantage, as once we've finished one conflict step,
and we've verified with git-range-diff(1) and with proper testing that
it's correct, the extra history would clutter the
'git log --graph --oneline HEAD target current' (something essential
when doing these operations).  Having a lean history in the process
helps get it right, being able to check important commits in the log.

Now about details of the implementaion:

-  The tool supports --first-parent, and passes it transparently to
   git-bisect(1).

-  The tool supports the flags --pre-exec and --post-exec, which are
   interpreted especially by the tool.

-  The tool accepts other flags, and passes them transparently to
   git-rebase(1).  If some flag isn't supported by git-rebase(1), it
   will be that program which will complain.  Also, I haven't made an
   attempt to validate that the flags passed make sense with this tool
   (for example, passing --abort would be accepted by git-rebase(1), but
    it wouldn't make sense, and would probably fail at some point).

   It would be good to curate a list of flags that make sense.

-  My tool, being a simple shell script with rudimentary option parsing,
   only accepts flags that take a single shell argument.  That is,
   --foo=3Dbar is ok, but --foo bar is not okay (and will probably result
   in parsing errors).

-  The tool is meant to be used almost as a drop-in of git-rebase(1).
   It does the same thing, except that instead of rebasing on the
   target, it rebases on the first commit of the target branch which
   has conflicts.

(It has grown a bit fatter than it was, but it's still way below
 git-imerge.)

	$ wc -l <src/bin/git-brebase=20
	164

We'll discuss the exact way it should be integrated within git(1), but
first it'd be interesting to get feedback about the tool itself,
regardless of the actual form.  Actually, because of the specialized
flags --pre-exec and --post-exec, and the --first-parent flag from
git-bisect(1) --and the fact that it runs git-bisect(1) machinery--, I'm
not entirely sure that it should be just a new flag to git-rebase(1).
It might be confusing to have these three flags being dependent on
another flag, and not being able to use this within a git-bisect(1)
session, unlike other git-rebase(1) operations.  That might call for
a new git command.

Please let me know any feedback!  :)

Junio, since you seemed to love git-imerge, I wonder what you'll think
of this tool.  :-)

Having presented the tool, below goes the implementation.


Have a lovely day!
Alex

---
#!/bin/bash
# Copyright 2026, Alejandro Colomar <alx@kernel.org>
# SPDX-License-Identifier: GPL-3.0-or-later

set -Eeufo pipefail;
shopt -s lastpipe;

err()
{
	>&2 printf '%s\n' "$(basename "$0"): error: $*";
	exit 1;
}

fp=3D'';
other=3D'';
pre=3D'';
post=3D'';
while test $# -ge 1; do
	case "$1" in
	--first-parent)
		fp=3D'--first-parent';
		;;
	--pre-exec=3D*)
		echo "$1" \
		| sed 's/--pre-exec=3D//' \
		| read -r pre;
		;;
	--post-exec=3D*)
		echo "$1" \
		| sed 's/--post-exec=3D//' \
		| read -r post;
		;;
	-*)
		other=3D"$other $1";
		;;
	*)
		break;
		;;
	esac;
	shift;
done;
gbopts=3D"$fp";
gropts=3D"$other";

if test $# -lt 1; then
	err 'Missing target commit.';
fi;
if test $# -gt 1; then
	err 'Too many arguments.';
fi;
git rev-list -1 "$1" \
| read -r tgt;
git rev-parse --abbrev-ref HEAD \
| read -r branch;

# Set up the callback script for 'git rebase run'.
mktemp \
| read -r callback;
cat >"$callback" <<__EOF__
#!/bin/bash

	set -Eeufo pipefail;
	shopt -s lastpipe;

	git rev-list -1 HEAD \
	| read -r bisect_head;

	if test -n '$pre'; then
		printf '%s' 'Pre-rebase exec: ';
		pre=3D'$pre';
		if
			\$pre;
			x=3D"\$?";
			true;
		then
			case "\$x" in
			0)
				echo 'success';
				;;
			125)
				echo 'skip';
				git checkout --detach "\$bisect_head" 2>/dev/null;
				exit 125;
				;;
			*)
				echo "failure (\$x)";
				git checkout --detach "\$bisect_head" 2>/dev/null;
				exit "\$x";
				;;
			esac;
		fi;
	fi;

	git switch '$branch' >/dev/null 2>/dev/null;
	git rev-list -1 HEAD \
	| read -r old_head;
	printf '%s' 'Rebase: ';
	if git rebase $gropts "\$bisect_head" >/dev/null 2>/dev/null; then
		echo 'success';
	else
		echo 'conflict';
		git rebase --abort >/dev/null;
		git checkout --detach "\$bisect_head" 2>/dev/null;
		exit 1;
	fi;

	if test -n '$post'; then
		printf '%s' 'Post-rebase exec: ';
		post=3D'$post';
		if
			\$post;
			x=3D"\$?";
			true;
		then
			case "\$x" in
			0)
				echo 'success';
				;;
			125)
				echo 'skip';
				git reset --hard "\$old_head";
				git checkout --detach "\$bisect_head" 2>/dev/null;
				exit 125;
				;;
			*)
				echo "failure (\$x)";
				git reset --hard "\$old_head";
				git checkout --detach "\$bisect_head" 2>/dev/null;
				exit "\$x";
				;;
			esac;
		fi;
	fi;
	git checkout --detach "\$bisect_head" 2>/dev/null;
	exit 0;
__EOF__
chmod +x "$callback";

# Try the target first.
git checkout --detach "$tgt" 2>/dev/null;
if "$callback"; then
	exit 0;
fi;
git status;

# Bisect.
# shellcheck disable=3DSC2248  # gbopts may hold multiple options
git bisect start $gbopts >/dev/null;
git bisect bad "$tgt" >/dev/null;
git merge-base "$branch" "$tgt" \
| xargs -I{} git bisect good {};
git bisect run "$callback";
git rev-list -1 bisect/bad \
| read -r bad;
git bisect reset >/dev/null 2>/dev/null;

# Perform the conflicting rebase
git switch "$branch";
# shellcheck disable=3DSC2086  # gropts may hold multiple options
git rebase $gropts "$bad";
if test -v post; then
	echo 'Running post-rebase exec.';
	$post;
fi;


--=20
<https://www.alejandro-colomar.es>

--hw4ffy3fb3ra7ngc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBYXwACgkQ64mZXMKQ
wqnX+A//Xq9HhJvBF0Si+xN+VtLOpPeF39JYjbf/G08kh6/m15fDxT4q95jU9151
/kxGLS14+xGXHhenr4np7vReTJ/fgPXN5OVP6sPrjw+4zyuidZg/xUlGLerdiw8b
ZeqmwYrx6XhPbijaVsb0xAwd32RCz/swwgF6nFP8myiO/X5dkVlMuPO0KDRtid0S
qZOYVdEsv6gWJ7sg4M/KvzuaFWIkeJ43y4/YtpOMw/hkNAOfA/Ocgos31WiijeZC
rfsmYm3LuYA0mzjqpN2cLrJJb5xY97BajtliMpLZwM0Q0UxNtkAattNFWIT2q9mw
sZjeqMdYDicii+Sqx2xXSsqCFRbgT56rJdWKLvfLcBDxybzpaa1jj8hGdTs/gVrT
KUm8JKBSlJa15Z+AophQ+0Jk76Fv2m5vm44wXJOX/vxNaWg7MiCItLGLdRCQT0XF
FiIxPgHl0e6EoEBt5nClF07Bs6dFuUH1Gght5Had5sRPtVyJ5FJLq9E6M4DIAyCd
+cXM3G1qXnWb3p8YC/ts5Gd486zISBlsNTgU2ADlNCLo6QBk/Ki4c5BskP9hjUYW
ujsYk51CQwlSShTpZ5KZOm5qtHpfZsMm+XneOYRn4AGCQLXd7JI0MMArS2Isd0QD
Gd7lmYL22i00Js0Nla5EdfwLlbKS5r0bUa7NuW/TUhh7LJ8TlFQ=
=apEd
-----END PGP SIGNATURE-----

--hw4ffy3fb3ra7ngc--
