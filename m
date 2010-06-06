From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH/RFC v2] gitweb: Run in FastCGI mode if gitweb script has 
	.fcgi extension
Date: Mon, 7 Jun 2010 01:48:03 +0530
Message-ID: <AANLkTimApmqQmbsIkfKmgXAMTaoQqDV5fU3S7SwXoScY@mail.gmail.com>
References: <1275772278-14709-1-git-send-email-jnareb@gmail.com>
	<201006062209.53176.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 22:18:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLMIS-0004K7-JX
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 22:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab0FFUSG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 16:18:06 -0400
Received: from mail-yw0-f187.google.com ([209.85.211.187]:47496 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0FFUSE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jun 2010 16:18:04 -0400
Received: by ywh17 with SMTP id 17so145385ywh.1
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FRFOBoyHBqerZ+TmVmDg7/8TeeHeSxlSa7LGMMrJqYw=;
        b=HSLsIfoYKmh/pz70ISXd3jEzuKt64QFVCeOQeLTALEmvjDDJwFTnn6hJkqmCnUSysu
         u9hQXOgHAbEYTsEX806mmKk9dpY2sd6RO/Qdd6yNlQ89Vln7BYXuMM0v1Mr9eMDhlxRy
         r4R27GyHaihCoOZf9hiAUmsq2tViUss1g+t5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lvAuG7f5IwkS0K6MSzrwobCzMXVhZ/vB00AJQiFl8Mjm1veCaM/gPzKeOVFgTYKazE
         brrXkUYJzuZX/sCvzbVqE7woyXFkfZ6dxzME7Y4g9o6dv2+18ERixGCTqq3JPNSG3HfK
         y/96m4+m2X8FJ00YNSfych0uyoSqv6hTdH04E=
Received: by 10.101.6.1 with SMTP id j1mr14331050ani.200.1275855483235; Sun, 
	06 Jun 2010 13:18:03 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Sun, 6 Jun 2010 13:18:03 -0700 (PDT)
In-Reply-To: <201006062209.53176.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148541>

> @@ -1056,19 +1056,24 @@ our $is_last_request =3D sub { 1 };
> =A0our ($pre_dispatch_hook, $post_dispatch_hook, $pre_listen_hook);
> =A0our $CGI =3D 'CGI';
> =A0our $cgi;
> +sub configure_as_fcgi {
> + =A0 =A0 =A0 require CGI::Fast;
> + =A0 =A0 =A0 our $CGI =3D 'CGI::Fast';
> +
> + =A0 =A0 =A0 my $request_number =3D 0;
> + =A0 =A0 =A0 # let each child service 100 requests
> + =A0 =A0 =A0 our $is_last_request =3D sub { ++$request_number > 100 =
};
> +}

You missed to put a new line in here.

> =A0sub evaluate_argv {
> + =A0 =A0 =A0 my $script_name =3D $ENV{'SCRIPT_NAME'} || $ENV{'SCRIPT=
_FILENAME'} || __FILE__;
> + =A0 =A0 =A0 configure_as_fcgi()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if $script_name =3D~ /\.fcgi$/;
> +
> =A0 =A0 =A0 =A0return unless (@ARGV);
>
> =A0 =A0 =A0 =A0require Getopt::Long;
> =A0 =A0 =A0 =A0Getopt::Long::GetOptions(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 'fastcgi|fcgi|f' =3D> sub {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 require CGI::Fast;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 our $CGI =3D 'CGI::Fast=
';
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $request_number =3D =
0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # let each child servic=
e 100 requests
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 our $is_last_request =3D=
 sub { ++$request_number > 100 };
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 'fastcgi|fcgi|f' =3D> \&configure_as_fc=
gi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'nproc|n=3Di' =3D> sub {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my ($arg, $val) =3D @_=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return unless eval { r=
equire FCGI::ProcManager; 1; };
> --
> 1.7.0.1

Thanks,
Pavan.
