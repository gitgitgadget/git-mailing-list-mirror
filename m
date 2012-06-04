From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] Export file attachements in git-remote-mediawiki
Date: Mon, 04 Jun 2012 23:34:29 +0200
Message-ID: <vpqvcj6lq1m.fsf@bauges.imag.fr>
References: <1338842961-3477-1-git-send-email-nguyenkimthuat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, nguyenkimthuat <nguyenkimthuat@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: NGUYEN Kim Thuat <kim-thuat.nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 23:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbev9-0000Hc-09
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 23:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab2FDVee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 17:34:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40635 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754771Ab2FDVed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 17:34:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q54LPn1u011398
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 23:25:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sbev0-0001L7-U4; Mon, 04 Jun 2012 23:34:31 +0200
In-Reply-To: <1338842961-3477-1-git-send-email-nguyenkimthuat@gmail.com>
	(NGUYEN Kim Thuat's message of "Mon, 4 Jun 2012 22:49:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jun 2012 23:25:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54LPn1u011398
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339449950.00722@O0+/mK6m3HwyrRY/xBNHyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199191>

NGUYEN Kim Thuat <kim-thuat.nguyen@ensimag.imag.fr> writes:

> +# Get the list of file extensions supported by the current version o=
f mediawiki=20
> +my @list_file_extensions =3D get_file_extensions();

You should do it only on demand (like $mediawiki is created lazily).

> +        open(my $g,"-|","git " . $_[0]);  =20

Space after ",".

> @@ -642,8 +651,14 @@ sub mw_push_file {
>  	my $old_sha1 =3D $diff_info_split[2];
>  	my $page_created =3D ($old_sha1 eq NULL_SHA1);
>  	my $page_deleted =3D ($new_sha1 eq NULL_SHA1);
> +	my $file_deleted =3D ($new_sha1 eq NULL_SHA1);

This line looks suspiciously similar to the previous one. Do you need
another variable for the same value?

> +	my @extensions =3D split(/\./,$complete_file_name);

Space after "," (many more instances after).

> -	} else {
> -		print STDERR "$complete_file_name not a mediawiki file (Not pushab=
le on this version of git-remote-mediawiki).\n"
> +	} elsif (exists($hashFiles{$extension})) {
> +		# Deleting and uploading a file require the priviledge of the user
> +		if ($file_deleted) {
> +			mw_connect_maybe();
> +			my $res =3D $mediawiki->edit( {
> +			action =3D> 'delete',
> +			title =3D> $path,
> +			reason =3D> $summary } )

Indent the body of {} please.

> +		} else {
> +			my $content =3D run_git_raw("cat-file blob $new_sha1");
> +			mw_connect_maybe();
> +				$mediawiki->{config}->{upload_url} =3D "$url/index.php/Special:U=
pload";

Broken indentation.

Does this work on wiki configured in foreign languages, like french tha=
t
has Sp=E9cial:T=E9l=E9verser instead?

> +			} ) || die $mediawiki-> {error}->{code} . ':' . $mediawiki->{erro=
r}->{details};
> +			$newrevid =3D get_reviId_filepage();

This queries the wiki to get the last revision id. The existing code (t=
o
deal with page) could get this from the response of the API to the edit
request, like this:

		$newrevid =3D $result->{edit}->{newrevid};

Your version is much more inefficient (many requests each time you
upload a file), and has a race condition (what happens if someone else
creates a revision at the same time?). Isn't there a better way?

> +			print STDERR "Pushed file: $new_sha1 - $complete_file_name\n";
> +			 }

Broken indentation.

> +	else {
> +		print STDERR "$complete_file_name is not supported on this version=
 of Mediawiki.\n"

It's not a matter of version, it's a matter of configuration.

> +sub get_reviId_filepage() {

Strange name (two consecutive i?). If this function fetches the last
wiki revision, why not call it get_last_mw_revid or something like this=
?

> +	mw_connect_maybe();
> +
> +	my $max_rev_num_file =3D 0;
> +
> +	my @list_file_pages =3D get_mw_media_pages();
> +
> +	foreach my $file_page (@list_file_pages) {
> +	my $id =3D $file_page->{pageid};

Broken indentation.

> +	my $query =3D {
> +		action =3D> 'query',
> +		prop =3D> 'revisions',
> +		rvprop =3D> 'ids',
> +		pageids =3D> $id,
> +		};
> +
> +		my $result =3D $mediawiki->api($query);

Broken indentation.

> +sub get_file_extensions {
> +	mw_connect_maybe();
> +
> +	my $query =3D {
> +	action =3D> 'query',
> +	meta =3D> 'siteinfo',
> +	siprop =3D> 'fileextensions'
> +	};

Broken indentation.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
