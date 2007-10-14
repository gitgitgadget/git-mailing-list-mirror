From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Add color to git-add--interactive diffs (Take 2: now without spurious line break!)
Date: Sun, 14 Oct 2007 13:36:32 +0200
Message-ID: <EFADE863-FC59-4A50-B165-9D30D9648B97@wincent.com>
References: <1192351494.7226.18.camel@athena>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tom Tobin <korpios@korpios.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:37:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih1mZ-0003RA-PD
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 13:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbXJNLhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 07:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801AbXJNLhJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 07:37:09 -0400
Received: from wincent.com ([72.3.236.74]:48101 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbXJNLhI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 07:37:08 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9EBaxKM014448;
	Sun, 14 Oct 2007 06:37:00 -0500
In-Reply-To: <1192351494.7226.18.camel@athena>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60832>

El 14/10/2007, a las 10:44, Tom Tobin escribi=F3:

> After banging my head against parsing colorized output of git-add-=20
> files,
> I gave up and implemented internal colorization keying off of the
> color.diff configuration.

Great!

> +sub parse_color {

You could simplify the manual escape sequence construction that =20
you're doing here by using Term::ANSIColor like the other patches =20
did. I see that git-send-email.perl uses that module too, so I guess =20
depending on that module is ok.

I also wonder whether the config code should be using the git.pm =20
module like git-send-email.perl and a couple others do (although it =20
would be slower than slurping in all the config in one shot like you =20
do; perhaps there's justification for a new function in git.pm that =20
wraps git-config --get-regexp...).

> +sub colorize_head_line {
> +	my $line =3D shift @_;
> +	if ($use_color) {
> +		# git doesn't colorize these by default, soooo
> +		# if ($line =3D~ /^\+/) {
> +		#	 return parse_color($colorconfig{'color.diff.new'}) . "$line\e=20
> [m";
> +		# }
> +		# if ($line =3D~ /^-/) {
> +		#	 return parse_color($colorconfig{'color.diff.old'}) . "$line\e=20
> [m";
> +		# }
> +		return parse_color($colorconfig{'color.diff.meta'}) . "$line\e[m";
> +	}
> +	return $line;
> +}
> +
> +sub colorize_hunk_line {
> +	my $line =3D shift @_;
> +	if ($use_color) {
> +		if ($line =3D~ /^\+/) {
> +			return parse_color($colorconfig{'color.diff.new'}) . "$line\e[m";
> +		}
> +		if ($line =3D~ /^-/) {
> +			return parse_color($colorconfig{'color.diff.old'}) . "$line\e[m";
> +		}
> +		if ($line =3D~ /^@@ /) {
> +			return parse_color($colorconfig{'color.diff.frag'}) . "$line\e[m"=
;
> +		}
> +	}
> +	return $line;
> +}

This is a good start but to completely match the colorized output =20
produced by diff it will need some additional logic; for example, =20
highlighting spurious whitespace. Search for =20
need_highlight_leading_space in diff.c and you'll see that the test =20
is basically for any space which precedes a tab in the leading =20
whitespace on newly inserted lines. In this case the spaces are =20
highlighted using the whitespace color (normally red background).

I don't know when color.diff.commit is ever used in diff output, but =20
perhaps that would need to be handled as well.

Cheers,
Wincent
