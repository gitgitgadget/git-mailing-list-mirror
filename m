From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] send-email: add test for duplicate utf8 name
Date: Tue, 18 Jun 2013 15:55:24 +0200
Message-ID: <20130618135524.GC20052@goldbirke>
References: <1371559723-28059-1-git-send-email-mst@redhat.com>
 <1371559723-28059-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 15:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowNf-000459-74
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 15:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809Ab3FRNz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 09:55:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64191 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701Ab3FRNz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 09:55:26 -0400
Received: from localhost6.localdomain6 (g230129165.adsl.alicedsl.de [92.230.129.165])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M5V4W-1U4pyX0TI8-00xbeS; Tue, 18 Jun 2013 15:55:25 +0200
Content-Disposition: inline
In-Reply-To: <1371559723-28059-2-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:G6LSLmdh0IgBtqOMMPV22I9yD+TQ0jzENCwG1oco07b
 lMTScyBUdw2NT7WreivBY7tyjCpAkJ4p3wkJDLTnPmfC2qmgbq
 WELeI291F3odhgH+JdReoT6JTvx5KqedBudOfUqFJPZ2lqTcVV
 EB92fmlTHKoILDNM+Igf+EgpguQxF5+gh50E0fQ/KjlCd79BrK
 c5udvquk7a0xSkxn0r+/i490m2/TFTcAE/uvH0QjzkAz1P1MVw
 6tEN3ks1Eamq66JqjvXRp5mwrTCIbUyUqqFRvPaFiuBpiTEmlk
 vo78Yg5n7S3+xTXCa9GXmVjyCt70PXxebOXC2awuX7+MJJsObQ
 V/Nso/fUb/1iBuFzFIKrWGPGgTDDDnISJz6eKJDwY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228232>

Hi Michael,


thanks for the quick turnaround.

On Tue, Jun 18, 2013 at 03:49:29PM +0300, Michael S. Tsirkin wrote:
> Verify that author name is not duplicated if it matches
> sender, even if it is in utf8.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  t/t9001-send-email.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 9f46f22..cef884f 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -956,6 +956,19 @@ test_expect_success $PREREQ 'utf8 author is corr=
ectly passed on' '
>  	grep "^From: F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@example.com>" msgtx=
t1
>  '
> =20
> +test_expect_success $PREREQ 'utf8 sender is not duplicated' '
> +	clean_fake_sendmail &&
> +	test_commit weird_sender &&
> +	test_when_finished "git reset --hard HEAD^" &&
> +	git commit --amend --author "F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@exa=
mple.com>" &&
> +	git format-patch --stdout -1 >funny_name.patch &&
> +	git send-email --from=3D"F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@example=
=2Ecom>" \
> +	  --to=3Dnobody@example.com \
> +	  --smtp-server=3D"$(pwd)/fake.sendmail" \
> +	  funny_name.patch &&
> +	test `grep "^From:" msgtxt1|wc -l` -eq 1

Perhaps you could use here

  grep "^From:" msgtxt1 >from &&
  test_line_count =3D 1 from

instead, to make it more debugging-friendly.

> +'
> +
>  test_expect_success $PREREQ 'sendemail.composeencoding works' '
>  	clean_fake_sendmail &&
>  	git config sendemail.composeencoding iso-8859-1 &&
> --=20
> MST

I couldn't apply this patch with git am/apply on top of today's master
for some reason, although the context lines seem to match exactly...
in the end had to apply it manually.

Anyway, 1/2 fixes my problem, so:

Tested-by: SZEDER G=E1bor <szeder@ira.uka.de>


Thanks,
G=E1bor
