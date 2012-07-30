From: Jeff King <peff@peff.net>
Subject: Re: bug (?) in send email
Date: Mon, 30 Jul 2012 12:32:40 -0400
Message-ID: <20120730163240.GB16701@sigill.intra.peff.net>
References: <50145A90.1090904@web.de>
 <50166408.8000008@web.de>
 <873949mnx0.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christoph Miebach <christoph.miebach@web.de>, git@vger.kernel.org,
	=?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:32:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svstl-0002Ob-0z
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab2G3Qcn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 12:32:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41469 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379Ab2G3Qcn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:32:43 -0400
Received: (qmail 17164 invoked by uid 107); 30 Jul 2012 16:32:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jul 2012 12:32:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2012 12:32:40 -0400
Content-Disposition: inline
In-Reply-To: <873949mnx0.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202573>

On Mon, Jul 30, 2012 at 02:30:35PM +0200, Thomas Rast wrote:

> > Removing this line
> > s/_/ /g;
> > here
> > https://github.com/git/git/blob/master/git-send-email.perl#L867
> >
> > Solves this problem for me. But I really don't have any clue, what
> > kind of side effects this modification on "sub unquote_rfc2047" mig=
ht
> > have.
>=20
> It would prevent spaces from being decoded correctly if the encoding
> program chooses to make the '_'.  git-format-patch does not actually =
do
> this, see the big comment around pretty.c:304.

Yeah, I think we need to be prepared to decode arbitrary rfc2047. Even
though most of our input will come from format-patch, people can munge
the input between format-patch and send-email.

> I think this patch would be a better match for what RFC2047 specifies=
=2E
> On the one hand it avoids substituting _ outside of encodings, but OT=
OH
> it also handles more than one encoded-word.  It still does not handle
> the case where there are several encoded-words of *different* encodin=
gs,
> but who would do such a crazy thing?
>=20
> diff --git i/git-send-email.perl w/git-send-email.perl
> index ef30c55..88c4758 100755
> --- i/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -862,11 +862,13 @@ sub make_message_id {
>  sub unquote_rfc2047 {
>  	local ($_) =3D @_;
>  	my $encoding;
> -	if (s/=3D\?([^?]+)\?q\?(.*)\?=3D/$2/g) {
> +	s{=3D\?([^?]+)\?q\?(.*)\?=3D}{
>  		$encoding =3D $1;
> -		s/_/ /g;
> -		s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
> -	}
> +		my $e =3D $2;
> +		$e =3D~ s/_/ /g;
> +		$e =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
> +		$e;
> +	}eg;
>  	return wantarray ? ($_, $encoding) : $_;

That is definitely an improvement. The existing code was just plain
wrong to assume that the whole string would be rfc2047 encoded, as that
is never the case (e.g., I don't think it is even legal to encode the
addr-spec part).

You are right that the result does not handle multiple encoded chunks
with different encodings. However, it also does not handle a single
encoded chunk with non-encoded bits. E.g., consider:

  From: =3D?UTF-8?q?Some=3D20N=3DC3=3DA1me?=3D <you@example.com>

We will return:

  ("Some N=C3=A1me <you@example.com>", "UTF-8")

Note that the second half is unencoded ASCII, but we have simply
concatenated it with the encoded bit and claimed the whole thing at
UTF-8. This works for utf-8, of course, because it is an ASCII superset=
=2E
But what about utf-16? You now have incompatible mixed encodings in a
single string. Which of course is only the tip of the iceberg; we later
may stick the author field into the body, which does not necessarily
have the same encoding (and there is a big "uh oh we should reencode"
argument that does not actually do so).

=46urthermore, even if we do use an ASCII superset, the callers do not =
use
the encoding field very well. They do things like:

  if (unquote_rfc2047($addr) eq $sender) {

So we are comparing the unquoted address, in some encoding (that we
throw away) to whatever we have in $sender, which may have come from th=
e
author ident, or the command-line, or the expansion of a MUA alias. So
we would fail to match utf-8 and latin1 versions of the same identity.

I think the only sane thing for unquote_rfc2047 to do would be to
actually return just a string in some canonical encoding (i.e., utf8),
and iconv each of the bits separately from its appropriate
encoding. And then we assume that everything internal is in the same
encoding and we can just compare strings to get the right answer. And
outgoing, we produce encoded utf8 for the headers, or match the body fo=
r
an in-body "From" header.

Of course, that means we would have to start using perl's encoding
functions, which we do not use currently. I think Encode has been in th=
e
perl base system long enough for us to rely on it, but I am not very up
to speed on encoding issues in perl. And nobody has been complaining
about those issues, which I assume means everybody is just using utf8
for outgoing messages.  So it might not be worth the trouble to fix.

I also notice that we do not handle the 'b' rfc2047 encoding at all.
We do handle this in mailinfo for incoming messages, but again, I guess
everybody just uses the more common 'q' for outgoing (since it's mostly
generated by git, anyway). So if nobody is complaining, I'd be inclined
to just leave it.

So after all that rambling, I think my response is "yes, your patch is =
a
step in the right direction, and we should do it". There are still a to=
n
of unsupported setups, but really, if we are going to handle everything=
,
I'd rather see us make the jump to using one of the existing
mail-handling modules rather than reinventing the wheel. And I know
that some people really like the no-dependencies aspect of what we have
currently.

-Peff
