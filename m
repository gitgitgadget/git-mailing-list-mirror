From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Refactoring tracing code in "git.c" and "exec_cmd.c".
Date: Sun, 27 Aug 2006 21:38:54 +0200
Message-ID: <200608272138.54834.chriscool@tuxfamily.org>
References: <20060824074547.a8fa0005.chriscool@tuxfamily.org> <7vmz9qybs5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 21:33:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHQO4-0007XE-Op
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 21:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWH0Td1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 27 Aug 2006 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWH0Td1
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 15:33:27 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:8616 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932252AbWH0Td1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 15:33:27 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 9B463754EA;
	Sun, 27 Aug 2006 21:33:25 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vmz9qybs5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26109>

Le dimanche 27 ao=FBt 2006 07:42, Junio C Hamano a =E9crit :
> > +char *sq_quote_argv(const char** argv, int count)
> > +{
> > +	char *buf, *to;
> > +	int i;
> > +	size_t len;
> > +
> > +	/* Count argv if needed. */
> > +	if (count < 0) {
> > +		char **p =3D (char **)argv;
> > +		count =3D 0;
> > +		while (*p++) count++;
> > +	}
>
> Wouldn't this be easier to read?
>
> 	if (count < 0)
>         	for (count =3D 0; argv[count]; count++)
>                 	; /* just counting */

Yes, it looks better.

> > +	/* Get destination buffer length. */
> > +	len =3D count ? count : 1;
>
> This confused me quite a bit.  Wouldn't it be simpler to special
> case the count=3D=3D0 case and return xcalloc(1,1) here (this would
> allow you to lose "if (!count)" later as well)?
>
> > +	/* Copy into destination buffer. */
> > +	for (i =3D 0; i < count; ++i) {
> > +		if (i) *to++ =3D ' ';
>
> (style)
> 	if (i)
>         	*to++ =3D ' ';

Ok, I will take care of this.

> > +		to +=3D sq_quote_buf(to, len, argv[i]);
> > +	}
> > +
> > +	if (!count)
> > +		*buf =3D 0;
> > +
> > +	return buf;
> > +}
> >
> > +/* Return a newly allocated copy of "format" where the
> > + * first occurence of "old" has been replaced by "new". */
> > +static char *str_subst(const char *format, const char *old, const =
char
> > *new) +{
>
> I do not think there is anything wrong with this function
> per-se, but...
>
> > +void sq_quote_argv_printf(FILE* out, const char **argv, int count,
> > +			   const char *format, ...)
> > +{
> > +	/* Replace the string "ARGV" in format with the quoted arg values=
=2E */
> > +	char *argv_str =3D sq_quote_argv(argv, count);
> > +	char *new_format =3D str_subst(format, "ARGV", argv_str);
> > +
> > +	/* Print into "out" using the new format. */
> > +	va_list rest;
> > +	va_start(rest, format);
> > +	vfprintf(out, new_format, rest);
> > +	va_end(rest);
>
> this feels wrong.  What happens when the original argv had
> a per-cent in it?

You are right, I will rework this.

Thanks,
Christian.=20
