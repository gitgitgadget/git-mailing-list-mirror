From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Tue, 01 Jan 2013 13:30:25 +0100
Message-ID: <50E2D6E1.5030102@kdbg.org>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gpakosz@visionobjects.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 13:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq19x-0003rL-83
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 13:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab3AAMab convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 07:30:31 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:35229 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752089Ab3AAMaa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 07:30:30 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D12B21000F;
	Tue,  1 Jan 2013 13:30:26 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D667719F456;
	Tue,  1 Jan 2013 13:30:25 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212422>

Am 31.12.2012 17:24, schrieb Gr=E9gory Pakosz:
> Please disregard the previous email that contains an incorrect fix
> suggestion. I wish my first contribution was flawless.
>=20
> Here is what's happening.
> git-filter-branch let git-update-ref -d verify that the value for $re=
f
> matches $sha1.
> However, when $ref points to an annotated tag that is being deleted,
> that verification fails because $sha1 is the commit underneath.
>=20
> I think there are two possible fixes:
>   1) either make git-filter-branch dereference annotated tags and do
> the verification itself then use the two arguments version of git
> update-ref
>   2) in the case of an annotated tag, pass another <old value> to git=
 update-ref
>=20
> Please find below a patch that implements solution 1). Please note th=
e
> patch doesn't contain a unit test for this situation as I wasn't sure
> how to provide one. Yet I tested it on the repository I'm working on.
>=20
> Gregory

We write material like this below the three-dash line of the patch.

>=20
> From 9d21960088a61bfbac1ffdb4b13e3038f88ab4d6 Mon Sep 17 00:00:00 200=
1
> From: Gregory Pakosz <gpakosz@visionobjects.com>
> Date: Mon, 31 Dec 2012 15:30:36 +0100

Then you can remove these three lines because they are inferred from th=
e
email message. And you should not attach the patch, only place it
inline, but make sure that it is not line-wrapped and space-mangled on
the mail route.

> Subject: [PATCH] git-filter-branch: support annotated tags deletion
>=20
> git-filter-branch let git-update-ref -d verify that the value for $re=
f matches
> $sha1. However, when $ref is an annotated tag being deleted that verf=
ication
> fails because $sha1 corresponds to a commit object.
>=20
> Instead of asking git-update-ref to verify values actually match, der=
eference
> $ref ourselves and test against $sha1 first. Then invoke git-update-r=
ef with two
> arguments.

It would have been very helpful if you could summarize the conditions
under which the unexpected behavior happens in the commit message. A
test case would also be great; it should be a matter of inserting
another case in t/t7003.

Without that information, I can't decide whether it is a good thing tha=
t
a tag (annotated or not) is deleted, because we have --tag-name-filter
to treat tags (even though you can't delete tags with this feature).

> Signed-off-by: Gregory Pakosz <gpakosz@visionobjects.com>
> ---
>  git-filter-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 5314249..bbee6d0 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -383,7 +383,7 @@ do
>  	case "$rewritten" in
>  	'')
>  		echo "Ref '$ref' was deleted"
> -		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
> +		test $(git rev-parse --verify "$ref^{commit}") =3D $sha1 && git
> update-ref -m "filter-branch: delete" -d "$ref" ||
>  			die "Could not delete $ref"

As written, it counts as error "Could not delete $ref" if the test...
command fails. Is this intended?

-- Hannes
