From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Teach for-each-ref about a little language called Tcl.
Date: Sat, 27 Jan 2007 14:30:56 +0300
Message-ID: <20070127143056.d19e80da.vsu@altlinux.ru>
References: <20070127072258.GA10512@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__27_Jan_2007_14_30_56_+0300_hZ4efRaSNO7QgzB4"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 12:32:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAln0-0000Vu-2F
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 12:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbXA0LcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 06:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbXA0LcF
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 06:32:05 -0500
Received: from master.altlinux.org ([62.118.250.235]:1419 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXA0LcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 06:32:04 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 348BEE36F6; Sat, 27 Jan 2007 14:32:01 +0300 (MSK)
In-Reply-To: <20070127072258.GA10512@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; x86_64-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37947>

--Signature=_Sat__27_Jan_2007_14_30_56_+0300_hZ4efRaSNO7QgzB4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2007 02:22:58 -0500 Shawn O. Pearce wrote:

> Love it or hate it, some people actually still program in Tcl.  Some
> of those programs are meant for interfacing with Git.  Programs such as
> gitk and git-gui.  It may be useful to have Tcl-safe output available
> from for-each-ref, just like shell, Perl and Python already enjoy.
[...]
> +void tcl_quote_print(FILE *stream, const char *src)
> +{
> +	const char lb = '{';
> +	const char rb = '}';
> +	const char bq = '\\';
> +	char c;
> +
> +	fputc(lb, stream);
> +	while ((c = *src++)) {
> +		if (c == lb || c == rb || c == bq)
> +			fputc(bq, stream);
> +		fputc(c, stream);
> +	}
> +	fputc(rb, stream);
> +}

No, this is broken - backslashes cannot be used to quote special
characters in braces.

      If  the  first character of a word is an open brace (``{'') then
      the word is terminated by  the  matching  close  brace  (``}'').
      Braces  nest  within  the  word:  for each additional open brace
      there must be an additional close brace  (however,  if  an  open
      brace  or close brace within the word is quoted with a backslash
      then it is not counted in locating the  matching  close  brace).
      No  substitutions  are  performed  on the characters between the
      braces  except  for  backslash-newline  substitutions  described
      below,  nor  do  semi-colons, newlines, close brackets, or white
      space receive any special interpretation.  The word will consist
      of  exactly the characters between the outer braces, not includ-
      ing the braces themselves.

The problem is that using '\{' will protect from nonmatching braces,
but the backslash will stay in the resulting string - it will not be
removed.  Similarly for '\}' and '\\'.

Tcl itself checks whether using braces is safe (it could be safe if
the text does not have nonmatching braces and does not have an odd
number of backslash characters at end of line), and uses just
backslashes if braces cannot be used.  See tclUtil.c,
Tcl_ScanCountedElement() and Tcl_ConvertCountedElement().
This code adds a backslash before ']', '[', '$', ';', ' ', '\\', '"',
'{', '}', and also converts special characters '\f', '\n', '\r', '\t',
'\v' to C-style escape sequences.

Untested code (output will not look very nice, but it is not intended
for human consumption anyway):

void tcl_quote_print(FILE *stream, const char *src)
{
	char c;

	while ((c = *src++)) {
		switch (c) {
		case ']':
		case '[':
		case '$':
		case ';':
		case ' ':
		case '\\':
		case '"':
		case '{':
		case '}':
			fputc('\\', stream);
		default:
			fputc(c, stream);
			break;

		case '\f':
			fputs("\\f", stream);
			break;
		case '\n':
			fputs("\\n", stream);
			break;
		case '\r':
			fputs("\\r", stream);
			break;
		case '\t':
			fputs("\\t", stream);
			break;
		case '\v':
			fputs("\\v", stream);
			break;
		}
	}
}

--Signature=_Sat__27_Jan_2007_14_30_56_+0300_hZ4efRaSNO7QgzB4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFuzfzW82GfkQfsqIRAu+FAJ9exPdsUx5ktOrsE3sVBdRMWVjCAACeNoIE
82fhOQN8jXAWOABSP6AMVjE=
=v0tq
-----END PGP SIGNATURE-----

--Signature=_Sat__27_Jan_2007_14_30_56_+0300_hZ4efRaSNO7QgzB4--
