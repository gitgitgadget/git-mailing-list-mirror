From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Fri, 17 Sep 2010 18:54:03 +0200
Message-ID: <201009171854.03476.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 18:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OweCT-0001Qw-K6
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab0IQQyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 12:54:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57672 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab0IQQyF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 12:54:05 -0400
Received: by bwz11 with SMTP id 11so2810300bwz.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bQqg4CnjNQPFmwZxejzMT0Yaf5lZda+Xw3YgJOpnfmU=;
        b=EoiM8XDsTskpGirfDvhy4obd+M58JIXIhDKxul0vo8DdRmSDNj6TFonWNROrDs5M1p
         t+I4/lMGs98LBiaegxMxr2zhZO271VXY5Qe5IgN+E6B8gOsL5TmSI6VON8usXAWZxjWF
         DEltmgLoN+a29pe4/fh3Kk79vrfsNjvqtExRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=URxiCtzKpOT7j2O2tp3SOL1WCuYvGQhxtIV9U4KbTKv1v5+rFADHLzWVvzoqOxrKPC
         zvOZZs/XfmW/wPIVovChZ7L0ib0dWsQOgJJQyxafFose0hHlvUvp7pTOapZFsMg+t/nf
         ITuW3XCQ1fItdGB/DNKVRDi8YTO1tTFMByDwc=
Received: by 10.204.57.9 with SMTP id a9mr4027365bkh.104.1284742443994;
        Fri, 17 Sep 2010 09:54:03 -0700 (PDT)
Received: from [192.168.1.13] (abvo68.neoplus.adsl.tpnet.pl [83.8.212.68])
        by mx.google.com with ESMTPS id y19sm3804873bkw.6.2010.09.17.09.54.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Sep 2010 09:54:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1284629465-14798-8-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156399>

On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 92551e4..66b5400 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2758,6 +2758,16 @@ sub git_get_last_activity {
>  	return (undef, undef);
>  }
> =20
> +sub git_get_remotes {
> +	my ($limit) =3D @_;

Probably more Perl-ish way would be to use

  +	my $limit =3D shift;

but this version is also all right.

> +	open my $fd, '-|' , git_cmd(), 'remote';
> +	return () unless $fd;

Gitweb usualy uses

  +	open my $fd, '-|' , git_cmd(), 'remote';
  +		or return;

> +	my @remotes =3D map { chomp ; $_ } <$fd>;

About =C6var comment: while

  +	chomp(my @remotes =3D <$fd>);

might be more Perl-ish, the above syntax is used thorough gitweb code.
So I'd leave it as it is now as the matter of code consistency.

> +	close $fd or return ();

  +	close $fd or return;

> +	my @remoteheads =3D git_get_heads_list($limit, 'remotes');
> +	return (\@remotes, \@remoteheads);

Why do you want for git_get_remotes() to also return remote-tracking
branches (refs/remotes/)?  Those are separate issues, and I think it
would be better API for git_get_remotes() to provide only list of
remotes, i.e.

  +	return @remotes;

Especially that we might want in the summary view to only list remotes,
without listing remote-tracking branches.

That would require more changes to the code.

> +}
> +
>  sub git_get_references {
>  	my $type =3D shift || "";
>  	my %refs;
> @@ -4979,7 +4989,7 @@ sub git_heads_body {
>  		      "<td class=3D\"link\">" .
>  		      $cgi->a({-href =3D> href(action=3D>"shortlog", hash=3D>$ref{=
'fullname'})}, "shortlog") . " | " .
>  		      $cgi->a({-href =3D> href(action=3D>"log", hash=3D>$ref{'full=
name'})}, "log") . " | " .
> -		      $cgi->a({-href =3D> href(action=3D>"tree", hash=3D>$ref{'ful=
lname'}, hash_base=3D>$ref{'name'})}, "tree") .
> +		      $cgi->a({-href =3D> href(action=3D>"tree", hash=3D>$ref{'ful=
lname'}, hash_base=3D>$ref{'fullname'})}, "tree") .

This is independent change, and should be in a separate commit, isn't i=
t?

>  		      "</td>\n" .
>  		      "</tr>";
>  	}
> @@ -4991,6 +5001,19 @@ sub git_heads_body {
>  	print "</table>\n";
>  }
> =20
> +sub git_remotes_body {
> +	my ($remotedata, $head) =3D @_;
> +	my @remotenames =3D @{$remotedata->[0]};
> +	my @allheads =3D @{$remotedata->[1]};

Why not

  +	my ($remotenames, $allheads, $head) =3D @_;

Beside, isn't it $remote_heads and not $allheads?

> +	foreach my $remote (@remotenames) {

It would be then

  +	foreach my $remote (@$remotenames) {

> +		my @remoteheads =3D grep { $_->{'name'} =3D~ s!^\Q$remote\E/!! } @=
allheads;

Should we display remote even if it doesn't have any remote heads
associated with it?

> +		git_begin_group("remotes", $remote, "remotes/$remote",$remote);
> +		git_heads_body(\@remoteheads, $head);
> +		git_end_group();

This would have to be modified with change to git_begin_group() /=20
/ git_end_group().

BTW isn't it premature generalization?  It is only place AFAIKS that=20
uses git_*_group() subroutines.

> +	}
> +
> +}
> +
>  sub git_search_grep_body {
>  	my ($commitlist, $from, $to, $extra) =3D @_;
>  	$from =3D 0 unless defined $from;
> @@ -5137,7 +5160,7 @@ sub git_summary {
>  	# there are more ...
>  	my @taglist  =3D git_get_tags_list(16);
>  	my @headlist =3D git_get_heads_list(16, 'heads');
> -	my @remotelist =3D $remote_heads ? git_get_heads_list(16, 'remotes'=
) : ();
> +	my @remotelist =3D $remote_heads ? git_get_remotes(16) : ();

No change of git_get_remotes() does only one thing: returning list
of remotes.

>  	my @forklist;
>  	my $check_forks =3D gitweb_check_feature('forks');
> =20
> @@ -5217,9 +5240,7 @@ sub git_summary {
> =20
>  	if (@remotelist) {
>  		git_print_header_div('remotes');
> -		git_heads_body(\@remotelist, $head, 0, 15,
> -		               $#remotelist <=3D 15 ? undef :
> -		               $cgi->a({-href =3D> href(action=3D>"remotes")}, "..=
=2E"));
> +		git_remotes_body(\@remotelist, $head);

Calling convention would change with my proposed change.

We might want to print only list of remotes (perhaps with number of
tracked branches) in the 'summary' view.  Just an idea...

>  	}
> =20
>  	if (@forklist) {
> @@ -5551,9 +5572,9 @@ sub git_remotes {
>  	git_print_page_nav('','', $head,undef,$head, $heads_nav);
>  	git_print_header_div('summary', $project);
> =20
> -	my @remotelist =3D git_get_heads_list(undef, 'remotes');
> +	my @remotelist =3D git_get_remotes();
>  	if (@remotelist) {
> -		git_heads_body(\@remotelist, $head);
> +		git_remotes_body(\@remotelist, $head);

Same here.

>  	}
>  	git_footer_html();
>  }
> --=20
> 1.7.3.rc1.230.g8b572
>=20
>=20

--=20
Jakub Narebski
Poland
