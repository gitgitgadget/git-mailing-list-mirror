From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH] send-email: do not check for editor until needed
Date: Tue, 23 Mar 2010 10:15:09 +0100
Message-ID: <A612847CFE53224C91B23E3A5B48BAC73EC0B01EE8@xmail3.se.axis.com>
References: <20100322145947.GA1709@pengutronix.de>
 <20100322232531.GA2168@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 10:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu0RD-0005Ip-PI
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 10:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0CWJaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 05:30:09 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:59302 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab0CWJaH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 05:30:07 -0400
X-Greylist: delayed 837 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Mar 2010 05:30:07 EDT
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o2N9FAlP028252;
	Tue, 23 Mar 2010 10:15:10 +0100
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Tue, 23 Mar 2010 10:15:10 +0100
Thread-Topic: [PATCH] send-email: do not check for editor until needed
Thread-Index: AcrKFy7MrpLP3B/LR8OiDfIdHI6uGgAUIt0A
In-Reply-To: <20100322232531.GA2168@progeny.tock>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143000>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Jonathan Nieder
> Sent: den 23 mars 2010 00:26
> To: Uwe Kleine-K=F6nig
> Cc: git@vger.kernel.org; Junio C Hamano; Marc Kleine-Budde; Jay Soffi=
an
> Subject: [PATCH] send-email: do not check for editor until needed
>=20
> Since b4479f074 (add -i, send-email, svn, p4, etc: use "git var
> GIT_EDITOR", 2009-10-30), when called with TERM=3Ddumb and without
> GIT_EDITOR set, git send-email has been failing whether it needs
> an editor or not:
>=20
>  $ ssh localhost git send-email --to=3Dme --suppress-cc=3Dall HEAD^..=
HEAD
>  fatal: Terminal is dumb, but EDITOR unset
>  var GIT_EDITOR: command returned error: 128
>=20
> This breaks use of git send-email in existing hook scripts.
>=20
> So do not check for an editor unless it is needed.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Uwe Kleine-K=F6nig wrote:
>=20
> > since b4479f074760a788dd4e353b8c86a7d735afc53e git send-email (and
> > others) use git var GIT_EDITOR.  This is OK as such but it breaks t=
he
> > post-receive hooks that I use on several repositories.
> [...]
> > IMHO git send-email should only call $(git var GIT_EDITOR) when it
> > actually needs it.
>=20
> Thanks for reporting.  Does this patch work for you?
>=20
> Now if I try without a tty, I get a different error:
>=20
>  $ ssh localhost cd $(pwd) '&&' \
> 	git send-email --to=3Dme --suppress-cc=3Dall HEAD^..HEAD
>  Can't locate object method "IN" via package "FakeTerm" at
>  /home/jrn/tmp-git/libexec/git-core/git-send-email line 645.
>  /tmp/olTiwjzrjx/0001-Git-1.7.0.3.patch
>=20
> I assume I am not using it correctly, since the relevant code has
> been around for a while.
>=20
>  git-send-email.perl |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index e05455f..9406cdd 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -162,9 +162,16 @@ my $compose_filename;
>=20
>  # Handle interactive edition of files.
>  my $multiedit;
> -my $editor =3D Git::command_oneline('var', 'GIT_EDITOR');
>=20
>  sub do_edit {
> +	my $editor;
> +
> +	if ($#_ =3D=3D 0) {
> +		return;
> +	}

Shouldn't that be:

	if ($#_ =3D=3D -1) {
		return;
	}

or more readable:

	return if (!@_);

as I assume you are trying to protect do_edit() from being called=20
without arguments?

> +	git_cmd_try {
> +		$editor =3D Git::command_oneline('var', 'GIT_EDITOR');
> +	} "no suitable text editor configured\n";
>  	if (defined($multiedit) && !$multiedit) {
>  		map {
>  			system('sh', '-c', $editor.' "$@"', $editor, $_);
> --
> 1.7.0.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

//Peter
