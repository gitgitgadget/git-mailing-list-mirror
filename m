From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 5/8] gitweb: Format diff lines just before printing
Date: Sun, 12 Feb 2012 00:38:21 +0100
Message-ID: <20120212003821.276f2c5a@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-6-git-send-email-michal.kiedrowicz@gmail.com>
	<m37gztthrx.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 00:38:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMWV-0005YT-D2
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 00:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab2BKXi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 18:38:26 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36618 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab2BKXi0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 18:38:26 -0500
Received: by eekc14 with SMTP id c14so1398732eek.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 15:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=7jJX6CWzp1G6opO0YmWweYGsr2hpsELA/gSpg1IoQa0=;
        b=YgUauQHMRUlAlRIJqarZPJR3YGSO20iDJ1q+XmodryjN3E1fRv3rOLYK/vnk1krSN+
         yy+rD74pAvxRtBz9c5XnQGPkY3oAimxwxOMqOFcX31qm3XsnUxjsTGeRxyansjVT704X
         tqX72Bq38rPiXIDaxdB0CGzdK/5lpq7CtUi30=
Received: by 10.213.28.5 with SMTP id k5mr1176611ebc.35.1329003504975;
        Sat, 11 Feb 2012 15:38:24 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n58sm41315324een.10.2012.02.11.15.38.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 15:38:24 -0800 (PST)
In-Reply-To: <m37gztthrx.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190542>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > Now we're ready to insert highlightning to diff output.
> >=20
> > The call to untabify() remains in the main loop in print_diff_chunk=
().
> > The motivation is that it must be called before any call to esc_htm=
l()
> > (because that converts spaces to &nbsp;) and to call it only once.
> >=20
> > This is a refactoring patch.  It's not meant to change gitweb outpu=
t.
>=20
> I'm not sure about this patch.
>=20
> First, in my opinion it doesn't make much sense standalone, and not
> squashed with subsequent patch.

True. I wanted to separate "preparation" from "adding new feature" but
maybe went few steps too far.

>=20
> Second, it makes format_diff_line an odd duck among all other format_=
*
> subroutines in that it post-processes HTML output, rather than
> generating HTML from data.
> =20
> Why "diff refinement highlighting" cannot be part of format_diff_line=
()?
> If it does need additional data, just pass it as additional parameter=
s
> to this subroutine.
>=20
> Another solution could be to borrow idea from stalled and inactive
> committags feature, namely that parts that are HTML are to be passed
> as scalar reference (\$str), while plain text (unescaped yet) is to b=
e
> passed as string ($str).

I'll look into it.

>=20
> > -# process patch (diff) line (not to be used for diff headers),
> > -# returning HTML-formatted (but not wrapped) line
> > +# wrap patch (diff) line into a <div> (not to be used for diff hea=
ders),
> > +# the line must be esc_html()'ed
> >  sub format_diff_line {
>=20
> I just don't like this error-prone "the line must be esc_html()'ed".
>=20
> > +# HTML-format diff context, removed and added lines.
> > +sub format_ctx_rem_add_lines {
> > +	my ($ctx, $rem, $add) =3D @_;
> > +	my (@new_ctx, @new_rem, @new_add);
> > +
> > +	@new_ctx =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'ct=
x') } @$ctx;
> > +	@new_rem =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 're=
m') } @$rem;
> > +	@new_add =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'ad=
d') } @$add;
> > +
> > +	return (\@new_ctx, \@new_rem, \@new_add);
> > +}
> > +
> >  # Print context lines and then rem/add lines.
> >  sub print_diff_lines {
> >  	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> > =20
> > +	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add)=
;
> > +
>=20
> Nice trick.
>=20
