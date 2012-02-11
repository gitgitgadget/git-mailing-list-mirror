From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/8] gitweb: Format diff lines just before printing
Date: Sat, 11 Feb 2012 09:14:11 -0800 (PST)
Message-ID: <m37gztthrx.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-6-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 18:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwGX5-0007IU-2o
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 18:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab2BKRON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 12:14:13 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41968 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab2BKRON convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 12:14:13 -0500
Received: by eaah12 with SMTP id h12so1249510eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=pZFdrjHsmRqUWLT3fneOleEhT0bc215kwpddiBhhhAQ=;
        b=A5HMUWQdEdlzeA1xvx8ciG0hBK2iUlU+2pycEDGficLLrc2bUUDTHEjeSyknjLbJkW
         0UwUlfCcg3evlsPcY4PbIeYvdgcR7q7+9uCvP+DubhgLlmUzxDU3aSoArXFbiszGm/hN
         i8dYPVmw89Fnp099ytwHhEvW4+BQ+fB6B7AyA=
Received: by 10.213.26.8 with SMTP id b8mr1041598ebc.88.1328980451724;
        Sat, 11 Feb 2012 09:14:11 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id o49sm37648854eei.0.2012.02.11.09.14.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 09:14:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1BHDo7L016815;
	Sat, 11 Feb 2012 18:14:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1BHDd0R016808;
	Sat, 11 Feb 2012 18:13:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-6-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190519>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Now we're ready to insert highlightning to diff output.
>=20
> The call to untabify() remains in the main loop in print_diff_chunk()=
=2E
> The motivation is that it must be called before any call to esc_html(=
)
> (because that converts spaces to &nbsp;) and to call it only once.
>=20
> This is a refactoring patch.  It's not meant to change gitweb output.

I'm not sure about this patch.

=46irst, in my opinion it doesn't make much sense standalone, and not
squashed with subsequent patch.

Second, it makes format_diff_line an odd duck among all other format_*
subroutines in that it post-processes HTML output, rather than
generating HTML from data.
=20
Why "diff refinement highlighting" cannot be part of format_diff_line()=
?
If it does need additional data, just pass it as additional parameters
to this subroutine.

Another solution could be to borrow idea from stalled and inactive
committags feature, namely that parts that are HTML are to be passed
as scalar reference (\$str), while plain text (unescaped yet) is to be
passed as string ($str).

> -# process patch (diff) line (not to be used for diff headers),
> -# returning HTML-formatted (but not wrapped) line
> +# wrap patch (diff) line into a <div> (not to be used for diff heade=
rs),
> +# the line must be esc_html()'ed
>  sub format_diff_line {

I just don't like this error-prone "the line must be esc_html()'ed".

> +# HTML-format diff context, removed and added lines.
> +sub format_ctx_rem_add_lines {
> +	my ($ctx, $rem, $add) =3D @_;
> +	my (@new_ctx, @new_rem, @new_add);
> +
> +	@new_ctx =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'ctx'=
) } @$ctx;
> +	@new_rem =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'rem'=
) } @$rem;
> +	@new_add =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'add'=
) } @$add;
> +
> +	return (\@new_ctx, \@new_rem, \@new_add);
> +}
> +
>  # Print context lines and then rem/add lines.
>  sub print_diff_lines {
>  	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> =20
> +	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add);
> +

Nice trick.

--=20
Jakub Nar=EAbski
