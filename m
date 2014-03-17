From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: feature-request: git notes copy --to <ref>
Date: Mon, 17 Mar 2014 11:11:44 +0100
Message-ID: <20140317101144.GO15674@pengutronix.de>
References: <20140220210334.GM6988@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de, Johan Herland <johan@herland.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 11:12:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPUWW-0002yc-QU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 11:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbaCQKL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 06:11:56 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43425 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbaCQKLz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 06:11:55 -0400
Received: from ptx.hi.pengutronix.de ([2001:6f8:1178:2:5054:ff:fec0:8e10] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1WPUWK-0005dx-D3; Mon, 17 Mar 2014 11:11:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1WPUWG-0000ad-Eb; Mon, 17 Mar 2014 11:11:44 +0100
Content-Disposition: inline
In-Reply-To: <20140220210334.GM6988@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:5054:ff:fec0:8e10
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244239>

Hello again,

On Thu, Feb 20, 2014 at 10:03:34PM +0100, Uwe Kleine-K=F6nig wrote:
> I'm playing around with git-notes and want to share some of my notes
> with my co-workers. We have a central repository for our various topi=
c
> branches and want to track upstream inclusion in git-notes. So we hav=
e
> to share our notes branch somehow.
>=20
> The workflow I think makes sense here is (untested):
>=20
> 	### hack hack, add notes bla blub
> 	### -> nice topic branch with some notes
>=20
> 	git fetch serverrepo refs/notes/commits:refs/notes/servercommits
> 	git notes merge refs/notes/servercommits
> 	git rev-list origin/master.. | awk '{print $1 " " $1}' | git notes c=
opy --to refs/notes/servercommits --stdin
> 	git push serverrepo refs/notes/servercommits:refs/notes/commits
>=20
> Then maybe:
>=20
> 	git notes merge refs/notes/servercommits
>=20
> again.
>=20
> The idea here is to only include notes in refs/notes/servercommits th=
at
> are relevant for my coworkers and not all intermediate notes that wer=
e
> created during development or while working on other branches.
>=20
> Does this make sense? Do you have better ideas or suggestions how to
> improve the workflow?
>=20
> The only problem now is that git notes copy doesn't take a --to
> parameter. Maybe there is a volunteer to implement it? Then I'd
> volunteer to test it :-)
I have implemented something now to copy notes to another branch. Here
is it for reference:

--->8---
#! /bin/sh

set -e

=2E git-sh-setup

# for now the remote notes rev must be a ref below refs/notes
# see id:20140220153045.GI6988@pengutronix.de for the respective plea.
remote_notes=3D"refs/notes/servercommits"
local_notes=3D"$(git notes get-ref)"

remote_notes_ref=3D$(git rev-parse --verify "$remote_notes^{commit}")

tmpfile=3D$(mktemp)
trap "rm \"$tmpfile\"" EXIT

git rev-list "$@" | sed 's/^/100644 blob [0-9a-f]{40}\t/' > $tmpfile

GIT_DIR=3D$(git rev-parse --git-dir)

GIT_INDEX_FILE=3D"$GIT_DIR/index-rnotes" git read-tree "$remote_notes"
git ls-tree "$local_notes" | grep -E -f "$tmpfile" | GIT_INDEX_FILE=3D"=
$GIT_DIR/index-rnotes" git update-index --index-info

tree=3D$(GIT_INDEX_FILE=3D"$GIT_DIR/index-rnotes" git write-tree)

if test "x$tree" =3D "x$(git rev-parse "$remote_notes_ref^{tree}")"; th=
en
	echo "empty commit"
	exit 0
fi

commit=3D$(git commit-tree "$tree" -p "$remote_notes_ref" << EOF
Notes added by 'git notes-copy'

source notes: $(git rev-parse $local_notes)
EOF
)

git update-ref "$remote_notes" $commit $remote_notes_ref
--->8---

It still has some edges, but I think it will do for me. Enhancements
welcome.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
