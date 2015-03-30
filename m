From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Mon, 30 Mar 2015 18:16:35 -0400
Message-ID: <20150330221635.GB25212@peff.net>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 00:16:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YchzG-0002M2-Q0
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 00:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbbC3WQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2015 18:16:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:40014 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752661AbbC3WQi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 18:16:38 -0400
Received: (qmail 19600 invoked by uid 102); 30 Mar 2015 22:16:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 17:16:38 -0500
Received: (qmail 17666 invoked by uid 107); 30 Mar 2015 22:16:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 18:16:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 18:16:35 -0400
Content-Disposition: inline
In-Reply-To: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266481>

On Tue, Mar 31, 2015 at 12:55:33AM +0900, Yi EungJun wrote:

> From: Yi EungJun <eungjun.yi@navercorp.com>
>=20
> Highlighted string might be broken if the common subsequence is a pro=
per subset
> of a multibyte character. For example, if the old string is "=EC=A7=84=
" and the new
> string is "=EC=A7=80", then we expect the diff is rendered as follows=
:
>=20
> 	-=EC=A7=84
> 	+=EC=A7=80
>=20
> but actually it was rendered as follows:
>=20
>     -<EC><A7><84>
>     +<EC><A7><80>
>=20
> This fixes the bug by splitting the string by multibyte characters.

Yeah, I agree the current output is not ideal, and this should address
the problem. I was worried that multi-byte splitting would make things
slower, but in my tests, it actually speeds things up!

That surprised me. The big difference is calling $mbcs->strsplit instea=
d
of regular split. Could it be that it's much faster than regular split?
Or is it that the resulting strings are faster for the rest of the
processing (e.g., perl hits a "slow path" on the sheared characters)? I=
t
doesn't really matter, I guess, but certainly I was curious.

> +use File::Basename;
> +use File::Spec::Functions qw( catdir );
> +use String::Multibyte;

Unfortunately, String::Multibyte is not a standard module, and is not
even packed for Debian systems (I got mine from CPAN). Can we make this
a conditional include (e.g., 'eval "require String::Multibyte"' in
get_mbcs, and return undef if that fails?). Then people without it can
still use the script.

> +# Returns an instance of String::Multibyte based on the charset defi=
ned by
> +# i18n.commitencoding or UTF-8, or undef if String::Multibyte doesn'=
t support
> +# the charset.

Hrm. The characters we are processing are not in the commit message, bu=
t
in the files themselves. In fact, there may be many different charsets
(i.e., a different one for each file), and we really don't have a good
way of knowing which is in play. I'd say that using the commit
encoding is our best guess, though. What happens with $mbcs->split when
the input is not a valid character in the charset (i.e., when we guess
wrong)?

If we are going to use the commit encoding, wouldn't
i18n.logOutputEncoding be a better choice?

> +sub get_mbcs {
> +	my $dir =3D catdir(dirname($INC{'String/Multibyte.pm'}), 'Multibyte=
');
> +	opendir my $dh, $dir or return;
> +	my @mbcs_charsets =3D grep s/[.]pm\z//, readdir $dh;

Yuck. This is a lot more intimate with String::Multibyte's
implementation than I'd like to be. Could we perhaps just run the
constructor on any candidates charsets, and then return the first hit
that gives us something besides undef?

-Peff
