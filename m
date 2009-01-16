From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] checkout: implement "-" shortcut name for last branch
Date: Fri, 16 Jan 2009 10:08:13 +0100
Message-ID: <200901161008.16234.trast@student.ethz.ch>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <200901151501.26394.trast@student.ethz.ch> <alpine.DEB.1.00.0901151510340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart26788117.urRsDEe27F";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 10:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNkhv-0005sw-0a
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 10:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758444AbZAPJIC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 04:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759507AbZAPJIB
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 04:08:01 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:15141 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277AbZAPJH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 04:07:58 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 10:07:56 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 10:07:56 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901151510340.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 16 Jan 2009 09:07:56.0778 (UTC) FILETIME=[EBEFB4A0:01C977B9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105931>

--nextPart26788117.urRsDEe27F
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> - AFAICT your version could never be convinced to resurrect deleted=20
>   branches, without resorting to reflogs anyway.

Speaking of resurrection, there are other possible sources that a
branch tip could be gleaned from.  How about the script below?  The
advantage is that it can even be used to recover Junio's topic
branches by looking at the merges in 'pu'.

(I'll answer the rest later.)

=2D-- 8< ---
#!/bin/sh

=2E git-sh-setup

USAGE=3D"<branch>"

test "$#" =3D 1 || usage

branch=3D"$1"
candidates=3D

search_reflog () {
	next=3D
	git reflog show HEAD |
	while read sha ref msg; do
		if test -n "$next"; then
			next=3D
			echo ${sha%...}
		fi
		if echo "$msg" | grep -q "^checkout: moving from $branch "; then
			next=3Dt
		fi
		if echo "$msg" | grep -q "^merge $branch:"; then
			git rev-list --parents -1 ${sha%...} \
				| cut -d' ' -f3
		fi
	done
}

search_merges () {
	git rev-list --pretty=3Dtformat:"%h %p:%s" --all |
	grep "Merge branch.*'$branch'.*into" |
	while read sha rest; do
		parents=3D"$(echo "$rest" | cut -d: -f1)"
		case "$parents" in
		    *' '*' '*)
			warn "$branch took part in octopus merge $sha"
			warn "check manually!"
			;;
		    *' '*)
			echo "$parents" | cut -d' ' -f2
			;;
		esac
	done
}

search_merge_targets () {
	git rev-list --pretty=3Dtformat:"%h %s" --all |
	grep "Merge branch '[^']*' into $branch$" |
	cut -d' ' -f1
}

candidates=3D"$(search_reflog | sort -u)"
if test -z "$candidates"; then
	echo "** Searching merges... **"
	candidates=3D"$( (search_merges;search_merge_targets) | sort -u)"
fi

echo "** Candidates **"
for cmt in $candidates; do
	git --no-pager log --pretty=3Doneline --abbrev-commit -1 $cmt
done

newest=3D$(git rev-list -1 $candidates)

if ! git rev-parse --verify --quiet $branch >/dev/null; then
	printf "** Restoring $branch to "
	git --no-pager log -1 --pretty=3Dtformat:"%h %s" $newest
	git branch $branch $newest
else
	printf "Most recent among them: "
	git --no-pager log -1 --pretty=3Dtformat:"%h %s" $newest
	echo "** $branch already exists, doing nothing"
fi


--nextPart26788117.urRsDEe27F
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklwToAACgkQqUud07tmzP1lvQCgh16OUlqj2QBC/CKLdCUi9THC
KrcAn01h/lecCXEbSySm5Bm6NxTE0J90
=1sVw
-----END PGP SIGNATURE-----

--nextPart26788117.urRsDEe27F--
