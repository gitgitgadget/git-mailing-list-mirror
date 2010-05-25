From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3] git-instaweb: Add support for running gitweb via  'plackup'
Date: Tue, 25 May 2010 02:11:02 +0200
Message-ID: <201005250211.04469.jnareb@gmail.com>
References: <1274356584-2400-1-git-send-email-jnareb@gmail.com> <201005222330.43532.jnareb@gmail.com> <AANLkTikSXOrF-mS3XzVAohgoNXXNZwN3jBw6Sh4TnK6M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 02:09:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGhi0-0003s1-KN
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 02:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308Ab0EYAJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 20:09:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48237 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab0EYAJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 20:09:18 -0400
Received: by fxm5 with SMTP id 5so2753669fxm.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 17:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3xJrcKPLlgw1z6aSPEl6qwASmeRbRhucrcpG00vdNgU=;
        b=JN9gGjJRtj2GVE+TB81x3Jl2P1eT0xBTPgygsxVlv5BK0FWe+JmvAHQMhtib2ic68I
         DCQFnffz6zmGBPCuTGLGnYcmRVZcMw8sgcllx0yTTEbSjlYCexYLGkoa4zTBcB6VC9MC
         Ggo1+DhMyX/pc646gjvuZSVBpUygmTmLNJlXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MTl2dGrA/BYtlnDFwAbbiKksqrLjx+uKfXFWfq5ZI1x4qCl7eTQ5IK2gkWOPkF6W1+
         LIBifkPiJo2Y/MXTTb8WPjhTJGbPtklcMpY62Ykc2Ra/SlrTIjgJMUB276tTxIcrpKBz
         xaLVnt7kNXl4QQfss7ziYLWXBsIGi955bnpwQ=
Received: by 10.87.68.26 with SMTP id v26mr9296556fgk.40.1274746156418;
        Mon, 24 May 2010 17:09:16 -0700 (PDT)
Received: from [192.168.1.15] (abvf124.neoplus.adsl.tpnet.pl [83.8.203.124])
        by mx.google.com with ESMTPS id e3sm7807255fga.24.2010.05.24.17.09.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 17:09:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikSXOrF-mS3XzVAohgoNXXNZwN3jBw6Sh4TnK6M@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147654>

On Sun, 23 May 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> 2010/5/22 Jakub Narebski <jnareb@gmail.com>:
> >
> > Webrick, which is in similar situation, uses httpd.conf config file=
 in
> > YAML.  Unfortunately there is no config / serialization reader in P=
erl
> > core, so if we have to go this route either the config file would h=
ave
> > to be in Perl, or gitweb.psgi wrapper would have to include some si=
mple
> > config file parsing.
>=20
> You could easily do (pseudocode):
>=20
>     unless (eval { require Config::Any; 1 }) {
>     	do $conf_file;
>     } else {
>     	my $parser =3D Config::Any->new( ... );
>     	$parser->docnf( $conf_file );
>     }
>=20
> Then you'd read (eval) a perl config file by default, but remain
> compatible with saner config formats for users prepared to install
> things from the CPAN.

I was thinking more about something like that:

  my @opts =3D qw(--env deployment);
  while (<>) {
  	chomp;
  	next unless $_;  # skip empty lines
  	next if /^\s*#/; # skip comments
  	if (/^\s*(.*?)\s*=3D\s*(.*)\s*$/) {
  		push @opts, '--'.lc($1), $2;
  	}
  }

where httpd.conf would look like this:

  port =3D 1234
  host =3D 127.0.0.1

Anyway, if such code is to be be added, it would be added in a separate
commit.
--=20
Jakub Narebski
Poland
