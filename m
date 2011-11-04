From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] Add options to specify snapshot file name, prefix
Date: Fri, 04 Nov 2011 09:10:16 -0700 (PDT)
Message-ID: <m3fwi350ou.fsf@localhost.localdomain>
References: <1320302318-28315-1-git-send-email-dermoth@aei.ca>
	<1320367999-24435-1-git-send-email-dermoth@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Thomas Guyot-Sionnest <dermoth@aei.ca>
X-From: git-owner@vger.kernel.org Fri Nov 04 17:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMMLY-0005OG-Mp
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 17:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab1KDQKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 12:10:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50131 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab1KDQKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 12:10:19 -0400
Received: by faao14 with SMTP id o14so2780859faa.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=xLSAt5kZWshKyZV1BdBRPxxNVjah677Nc0bs7kRgVTY=;
        b=FTiUTWjEqQSsEtng2t8H+2ZkMIzkGrZe+rI6nS5QlaeE2OIgHwZ9ndSA9i9am2UQCy
         zZ3Cr8LT4NEaHmN4BFf29KAN6RwYhQCsczMOnjPXAk8cGIpwvaPXoSDLjtOYmMRQ20bM
         TOi38mCYlP/3kKANGRTG6aZcea6FVaLwKD9IE=
Received: by 10.223.77.66 with SMTP id f2mr24896995fak.24.1320423017451;
        Fri, 04 Nov 2011 09:10:17 -0700 (PDT)
Received: from localhost.localdomain (abwn145.neoplus.adsl.tpnet.pl. [83.8.237.145])
        by mx.google.com with ESMTPS id l26sm17382800fad.17.2011.11.04.09.10.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 09:10:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pA4G9rFP029951;
	Fri, 4 Nov 2011 17:10:04 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pA4G9baj029947;
	Fri, 4 Nov 2011 17:09:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1320367999-24435-1-git-send-email-dermoth@aei.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184785>

Thomas Guyot-Sionnest <dermoth@aei.ca> writes:

> commit b629275 implemented "smart" snapshot names and prefixes. I hav=
e
> scripts that used to rely on the old behaviour which allowed in some
> cases to have fixed prefix, and would require modifications to work w=
ith
> newer Gitweb.

If scripts use 'wget' or 'curl' you can always change the name of
saved file:

  wget -O <file> ...
  curl -o <file> ...

If downloaded snapshot is compressed tarfile, you can use
--strip-components=3D1 to strip prefix.
=20
> This patch adds two parameters for overriding the snapshot name and
> prefix, sn and sp respectively. For example, to get a snapshot
> named "myproject.[suffix]" with no prefix one can add this query stri=
ng:
>   ?sn=3Dmyproject;sp=3D

Would you need support for expandable parameters in both (a la
'action' feature)?

[...]=20
> @@ -6684,11 +6686,19 @@ sub git_snapshot {
>  	}
> =20
>  	my ($name, $prefix) =3D snapshot_name($project, $hash);
> +	if (defined($input_params{'snapshot_name'})) {
> +		$name =3D $input_params{'snapshot_name'};
> +	}
> +	if (defined($input_params{'snapshot_prefix'})) {
> +		$prefix =3D $input_params{'snapshot_prefix'};
> +	} else {
> +		$prefix .=3D '/';
> +	}
>  	my $filename =3D "$name$known_snapshot_formats{$format}{'suffix'}";
>  	my $cmd =3D quote_command(
>  		git_cmd(), 'archive',
>  		"--format=3D$known_snapshot_formats{$format}{'format'}",
> -		"--prefix=3D$prefix/", $hash);
> +		"--prefix=3D$prefix", $hash);
>  	if (exists $known_snapshot_formats{$format}{'compressor'}) {
>  		$cmd .=3D ' | ' . quote_command(@{$known_snapshot_formats{$format}=
{'compressor'}});
>  	}

I wonder if you really want to allow prefix which do not end in '/'
(which would be suprising, isn't it), or just allow empty prefix too.

=46or example

  @@ -6684,11 +6686,19 @@ sub git_snapshot {
   	}
  =20
   	my ($name, $prefix) =3D snapshot_name($project, $hash);
  +	if (defined($input_params{'snapshot_name'})) {
  +		$name =3D $input_params{'snapshot_name'};
  +	}
  +	if (defined($input_params{'snapshot_prefix'})) {
  +		$prefix =3D $input_params{'snapshot_prefix'};
  +	}
   	my $filename =3D "$name$known_snapshot_formats{$format}{'suffix'}";
   	my $cmd =3D quote_command(
   		git_cmd(), 'archive',
   		"--format=3D$known_snapshot_formats{$format}{'format'}",
  -		"--prefix=3D$prefix/", $hash);
  +		($prefix eq "" ? () : "--prefix=3D$prefix"), $hash);
   	if (exists $known_snapshot_formats{$format}{'compressor'}) {
   		$cmd .=3D ' | ' . quote_command(@{$known_snapshot_formats{$format}=
{'compressor'}});
   	}

--=20
Jakub Nar=EAbski
