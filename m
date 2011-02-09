From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Add column layout
Date: Wed, 9 Feb 2011 01:36:55 -0600
Message-ID: <20110209073655.GA2135@elie>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <1297178541-31124-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 08:37:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn4bx-0001f7-9g
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 08:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab1BIHhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 02:37:06 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45905 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab1BIHhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 02:37:04 -0500
Received: by gyb11 with SMTP id 11so2660999gyb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JKTWGDW8v/oKm9VC3IAoCMC/vZYdSgfAsvm8jl34+pQ=;
        b=jHsi9hTUW7BgS/3yTnDbiDKiBqqoVkgDPw1K3lPmYcwAAFOEh+rnak3eOU8CB0Ptbo
         YXIFTT7OQ1d80tmeVQTMBgqCTZxS447kT47+8KXRJQ/jHXdY/jPvzsSnMiw8AoT36iFY
         rPUviB2a584e+t/HMrmMzF+zYPPcD6FQHeRU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ADD9mgcmj/Uf7UL/aoQNbOAsH0AOWHrudAa0XJnNI26V6o7q45G3oomCLAgBTRyjI1
         DLsA6l2O0wpJQ6MvD5uwiRHk47x/B60FiVYu8lT/Yn46rjZB6ePzUOwI8c5n5X8MMzPY
         ESKmx6aZrVXC0t+xGs9DnRUNIZPRZCkiXGcnA=
Received: by 10.150.219.15 with SMTP id r15mr161729ybg.302.1297237022581;
        Tue, 08 Feb 2011 23:37:02 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id k1sm3481ybj.0.2011.02.08.23.37.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 23:37:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297178541-31124-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166394>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> +++ b/column.c
> @@ -0,0 +1,177 @@
[...]
> +static int item_length(const struct column_layout *c, const char *s)
> +{
> +	int a_len =3D 0;
> +
> +	if (!(c->mode & COL_ANSI))
> +		return strlen(s);
> +
> +	while ((s =3D strstr(s, "\033[")) !=3D NULL) {
> +		int len =3D strspn(s+2, "0123456789;");
> +		s +=3D len+3; /* \033[<len><func char> */
> +		a_len +=3D len+3;
> +	}
> +	return a_len;
> +}

I think you mean "return strlen(orig_s) - a_len".

Something like the following could be more obvious, though
it is unfortunately verbose.

	int len =3D 0;
	while (*s) {
		const char *next;

		/* \033[<len><func char> */
		if (!prefixcmp(s, "\033[")) {
			s +=3D strlen("\033[");
			s +=3D strspn(s, "0123456789;");
			if (!*s)
				... handle somehow ...
			s++;
		}

		next =3D strchrnul(s, '\033');
		len +=3D next - s;
		s =3D next;
	}

Both miscompute the width of "D=C3=A9p=C3=B4t".  Something like this ca=
n do ok
if the string is modifiable and we know it is UTF-8:

		char save;
		...
		next =3D strchrnul(s, '\033');

		/*
		 * NEEDSWORK: a utf8_strwidth variant that
		 * accepts a memory area not terminated by \0
		 * would avoid this ugliness.
		 */
		save =3D *next;
		*next =3D '\0';
		len +=3D utf8_strwidth(s);
		*next =3D save;

POSIX does not provide a strwidth function, so if we want to handle
encodings like SHIFT-JIS then something uglier[1] might come to life.

> +static void layout(const struct column_layout *c,
> +		   int total_width, int padding,
> +		   int *width,
> +		   int *rows, int *cols)
> +{
[...]
> +	*rows =3D c->items.nr / *cols;
> +	if (c->items.nr > *rows * *cols)
> +		(*rows)++;

Maybe
	*rows =3D DIV_ROUND_UP(c->items.nr, *cols);
?

> +static int squeeze_columns(const struct column_layout *c,
> +			   int *width, int padding,
> +			   int rows, int cols)

What does this function do?

Ah, it is for computing smaller, unequal column widths.

> +{
> +	int x, y, i, len, item_len, spare =3D 0;
> +	const char *s;
> +
> +	for (x =3D 0; x < cols; x++) {

		/* Find minimum width for column. */
		int len =3D 0;

> +		for (y =3D len =3D 0; y < rows; y++) {
[...]
> +		len +=3D padding;
> +		if (len < width[x]) {
> +			spare +=3D width[x] - len;
> +			width[x] =3D len;
> +		}

This "if" is unnecessary, I hope.  A simple

		assert(len <=3D width[x]);

would check that.

[...]
> +static void relayout(const struct column_layout *c,
> +		     int padding, int spare,
> +		     int *initial_width, int **width,
> +		     int *rows, int *cols)
> +{
> +	int new_rows, new_cols, new_initial_width;
> +	int i, *new_width, new_spare, total_width;
> +
> +	/*
> +	 * Assume all columns have same width, we would need
> +	 * initial_width*cols. But then after squeezing, we have
> +	 * "spare" more chars. Assume a new total_width with
> +	 * additional chars, then re-squeeze to see if it fits
> +	 * c->width.
> +	 */

Might be easier to debug if this part were deferred to a separate
patch. :)

> +	total_width =3D (*initial_width)*(*cols) + spare;

An odd heuristic.  Does it work well in practice?

> +static void display_columns_first(const struct column_layout *c,
> +				  int padding, const char *indent)
> +{
[...]
> +	for (y =3D 0; y < rows; y++) {
> +		for (x =3D 0; x < cols; x++) {
[...]
> +			const char *s;
> +			int len;
> +
> +			i =3D x * rows + y;
> +			if (i >=3D c->items.nr)
> +				break;
> +			s =3D c->items.items[i].string;
> +			len =3D item_length(c, s);
> +			if (width[x] < initial_width)
> +				len +=3D initial_width - width[x];

The "if" is unnecessary, I hope.  (With that hope being checkable
by assert(width[x] <=3D initial_width).)

> +
> +			printf("%s%s%s",
> +			       x =3D=3D 0 ? indent : "",
> +			       c->items.items[i].string,
> +			       /* If the next column at same row is
> +				  out of range, end the line. Else pad
> +				  some space.  */
> +			       i + rows >=3D c->items.nr ? "\n" : empty_cell + len);

Nice.  The loop body could be a separate display_cell() function for
easier contemplation.

[...]
> +++ b/column.h
> @@ -0,0 +1,20 @@
[...]
> +#define COL_DENSE         (1 << 5) /* "Ragged-right" mode, relayout =
if enough space */

I might be confused, but would it not be clearer to call it "unequal
column width" mode?  In other words, is it about columns not all
having the same width as one another or about having a ragged right
margin?

Thanks for a pleasant read.
Jonathan

[1] Based on tuklib_mbstr_width:

	size_t remaining =3D strlen(s);
	size_t len =3D 0;
	mbstate_t state;

	memset(&state, 0, sizeof(state));
	while (remaining) {
		wchar_t ch;
		size_t nbytes;
		int width;

		if (!prefixcmp(s, "\033["))
			...
		nbytes =3D mbrtowc(&ch, s, remaining, &state);
		if (!nbytes || nbytes > remaining)
			... handle error ...
		s +=3D nbytes;
		remaining -=3D nbytes;
		width =3D wcwidth(ch);
		if (width < 0)
			... handle nonprintable character ...
		len +=3D width;
	}
