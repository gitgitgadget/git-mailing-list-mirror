From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Fri, 16 Oct 2015 09:51:35 +0200
Message-ID: <20151016075134.GM11304@distanz.ch>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
 <1444911524-14504-3-git-send-email-tklauser@distanz.ch>
 <xmqqoag0ggjh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 09:51:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmznk-0001eG-DK
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 09:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbbJPHvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2015 03:51:39 -0400
Received: from sym2.noone.org ([178.63.92.236]:60439 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbbJPHvj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 03:51:39 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ncfnN3ph5zQWbs; Fri, 16 Oct 2015 09:51:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqoag0ggjh.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279736>

On 2015-10-15 at 19:58:26 +0200, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tobias Klauser <tklauser@distanz.ch> writes:
>=20
> > diff --git a/Documentation/git-stripspace.txt b/Documentation/git-s=
tripspace.txt
> > index 60328d5..411e17c 100644
> > --- a/Documentation/git-stripspace.txt
> > +++ b/Documentation/git-stripspace.txt
> > @@ -9,7 +9,7 @@ git-stripspace - Remove unnecessary whitespace
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git stripspace' [-s | --strip-comments] < input
> > +'git stripspace' [-s | --strip-comments] [-C | --count-lines] < in=
put
> >  'git stripspace' [-c | --comment-lines] < input
> > =20
> >  DESCRIPTION
> > @@ -44,6 +44,11 @@ OPTIONS
> >  	be terminated with a newline. On empty lines, only the comment ch=
aracter
> >  	will be prepended.
> > =20
> > +-C::
> > +--count-lines::
> > +	Output the number of resulting lines after stripping. This is equ=
ivalent
> > +	to calling 'git stripspace | wc -l'.
>=20
> I agree with Matthieu that squatting on a short-and-sweet -C is
> unwanted here.

Will drop it in v2.

> > diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> > index f677093..7882edd 100644
> > --- a/builtin/stripspace.c
> > +++ b/builtin/stripspace.c
> > @@ -1,5 +1,6 @@
> >  #include "builtin.h"
> >  #include "cache.h"
> > +#include "parse-options.h"
> >  #include "strbuf.h"
> > =20
> >  static void comment_lines(struct strbuf *buf)
> > @@ -12,45 +13,51 @@ static void comment_lines(struct strbuf *buf)
> >  	free(msg);
> >  }
> > =20
> > -static const char *usage_msg =3D "\n"
> > -"  git stripspace [-s | --strip-comments] < input\n"
> > -"  git stripspace [-c | --comment-lines] < input";
> > +static const char * const usage_msg[] =3D {
> > +	N_("git stripspace [-s | --strip-comments] [-C | --count-lines] <=
 input"),
> > +	N_("git stripspace [-c | --comment-lines] < input"),
> > +	NULL
> > +};
> > =20
> >  int cmd_stripspace(int argc, const char **argv, const char *prefix=
)
> >  {
> >  	struct strbuf buf =3D STRBUF_INIT;
> > -	int strip_comments =3D 0;
> > -	enum { INVAL =3D 0, STRIP_SPACE =3D 1, COMMENT_LINES =3D 2 } mode=
 =3D STRIP_SPACE;
> > -
> > -	if (argc =3D=3D 2) {
> > -		if (!strcmp(argv[1], "-s") ||
> > -		    !strcmp(argv[1], "--strip-comments")) {
> > -			strip_comments =3D 1;
> > -		} else if (!strcmp(argv[1], "-c") ||
> > -			   !strcmp(argv[1], "--comment-lines")) {
> > -			mode =3D COMMENT_LINES;
> > -		} else {
> > -			mode =3D INVAL;
> > -		}
> > -	} else if (argc > 1) {
> > -		mode =3D INVAL;
> > -	}
> > +	int comment_mode =3D 0, count_lines =3D 0, strip_comments =3D 0;
> > +	size_t lines =3D 0;
> > +
> > +	const struct option options[] =3D {
> > +		OPT_BOOL('s', "strip-comments", &strip_comments,
> > +			 N_("skip and remove all lines starting with comment character"=
)),
> > +		OPT_BOOL('c', "comment-lines", &comment_mode,
> > +			 N_("prepend comment character and blank to each line")),
> > +		OPT_BOOL('C', "count-lines", &count_lines, N_("print line count"=
)),
> > +		OPT_END()
> > +	};
>=20
> I think -s and -c are incompatible, so OPT_CMDMODE() might be a
> better fit for them if you are going to switch the command line
> parser to use parse-options.

Ok, will change to OPT_CMDMODE()

> Which makes me strongly suspect that this should be done in at least
> two separate steps.  (1) Use parse-options to parse command line
> without adding the counting at all, followed by (2) Add counting.

Ok, will split the patch as you suggest for v2 (or more if it makes it
easier to review).

> > +	if (!count_lines)
> > +		write_or_die(1, buf.buf, buf.len);
> > +	else {
> > +		struct strbuf tmp =3D STRBUF_INIT;
> > +		strbuf_addf(&tmp, "%zu\n", lines);
> > +		write_or_die(1, tmp.buf, tmp.len);
> > +	}
>=20
> So this is your output code, which gives only the number of lines
> without the cleaned up result.

This should better be a simple printf("%zu\n", lines) I guess?

> > @@ -797,15 +799,19 @@ void strbuf_stripspace(struct strbuf *sb, int=
 skip_comments)
> > =20
> >  		/* Not just an empty line? */
> >  		if (newlen) {
> > -			if (empties > 0 && j > 0)
> > +			if (empties > 0 && j > 0) {
> >  				sb->buf[j++] =3D '\n';
> > +				lines++;
> > +			}
> >  			empties =3D 0;
> >  			memmove(sb->buf + j, sb->buf + i, newlen);
> >  			sb->buf[newlen + j++] =3D '\n';
> > +			lines++;
> >  		} else {
> >  			empties++;
> >  		}
> >  	}
>=20
> I cannot say that the above is one of the better possible
> implementations of this feature I would think of.
>=20
>  (1) If this is performance sensitive, then you do not want to do
>      memmove() etc. to actually touch the contents of the *sb and
>      only increment lines++, because you are not going to show that
>      in the output anyway.
>=20
>  (2) If this feature is not performance sensitive, then the best
>      implementation would be not to touch strbuf_stripspace() at all
>      to realize this change, and count the number of '\n' in the
>      cmd_stripspace() just before you use printf("%d\n", lines).
>      That is best from maintainability's point-of-view, because it
>      makes it infinitely less error-prone for future changes of
>      strbuf_stripspace() to forget incrementing lines++ when it adds
>      a newline to the output.
>=20
>  (3) If you are going to still munge *sb, even if you are not going
>      to show it at the end, perhaps because that would make it
>      easier to keep track of where the code is scanning to find when
>      you need to increment lines++, then at least the patch should
>      devise a mechanism to make it less likely that the future
>      changes to strbuf_stripspace() would make 'lines' and the
>      number of '\n' in the *sb out-of-sync (hint: perhaps a macro
>      called APPEND_LF(sb, line) or something).  It is easy to append
>      '\n' to sb->buf without incrementing lines++ as the code stands
>      with this patch applied---the patch makes the code less
>      maintainable.
>=20
> My gut feeling is that you should do (2), which is the cleanest from
> the maintainability's point-of-view.

Thank you for outlining and assessing these possible implementations. I
agree that my suggested implementation is probably the most na=EFve one=
 :)
and think that (2) would less intrusive and better to maintain. Will
change the patch accordingly.
>=20
