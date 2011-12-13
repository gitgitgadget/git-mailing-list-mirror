From: Jeff King <peff@peff.net>
Subject: Re: [PATCH resend] Do not create commits whose message contains NUL
Date: Tue, 13 Dec 2011 12:59:32 -0500
Message-ID: <20111213175932.GA1663@sigill.intra.peff.net>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 18:59:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaWdf-0002F4-O1
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 18:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab1LMR7f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 12:59:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49665
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042Ab1LMR7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 12:59:35 -0500
Received: (qmail 21660 invoked by uid 107); 13 Dec 2011 18:06:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 13:06:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 12:59:32 -0500
Content-Disposition: inline
In-Reply-To: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187034>

On Tue, Dec 13, 2011 at 06:56:08PM +0700, Nguyen Thai Ngoc Duy wrote:

> We assume that the commit log messages are uninterpreted sequences of
> non-NUL bytes (see Documentation/i18n.txt). However the assumption
> does not really stand out and it's quite easy to set an editor to sav=
e
> in a NUL-included encoding. Currently we silently cut at the first NU=
L
> we see.
>=20
> Make it more obvious that NUL is not welcome by refusing to create
> such commits. Those who deliberately want to create them can still do
> with hash-object.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This is from UTF-16 in commit message discussion [1] a few months
>  ago. I don't want to resurrect the discussion again. However I think
>  it's a good idea to stop users from shooting themselves in this case=
,
>  especially at porcelain level.
>
>  There were no comments on this patch previously. So, any comments
>  this time ? Should I drop it?

I think this is a sane thing to do. Having thought about and
experimented a little with utf-16 in the past few months, I really don'=
t
see how you could be disrupting anybody's workflow. utf-16 messages get
butchered so badly already; we are much better off letting the user kno=
w
of the problem as soon as possible.

It looks like we already have a check for is_utf8, and this is not
failing that check. I guess because is_utf8 takes a NUL-terminated
buffer, so it simply sees the truncated result (i.e., depending on
endianness, "foo" in utf16 is something like "f\0o\0o\0", so we check
only "f"). We could make is_utf8 take a length parameter to be more
accurate, and then it would catch this.

However, I think that's not quite what we want. We only check is_utf8 i=
f
the encoding field is not set. And really, we want to reject NULs no
matter _which_ encoding they've set, because git simply doesn't handle
them properly.

> diff --git a/commit.c b/commit.c
> index d67b8c7..0775eec 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -855,6 +855,9 @@ int commit_tree(const char *msg, size_t msg_len, =
unsigned char *tree,

Hmm. My version of commit_tree does not have a "msg_len" parameter, nor
do I have d67b8c7. Is there some refactoring patch this is based on tha=
t
I missed?

> +	if (strlen(msg) < msg_len)
> +		die(_("cannot commit with NUL in commit message"));
> +

Two nits:

  1. For some reason, checking strlen(msg) seems a subtle way of lookin=
g
     for NULs in a buffer. I would have found:

         if (memchr(msg, '\0', msglen))

     much more obvious. But perhaps it is just me. Certainly not a big
     deal either way.

  2. The error message could be a little friendlier. The likely reason
     for NULs is a bogus encoding setting in the user's editor. We
     already have a nice "your message isn't utf-8" message. Though it
     does suggest setting i18n.commitencoding, which probably _isn't_
     the solution here (since their encoding clearly isn't supported).
     But maybe it would be nicer to say something like:

       error: your commit message contains NUL characters.
       hint: This is often caused by using multibyte encodings such as
       hint: UTF-16. Please check your editor settings.

     We could even go further and detect some common NUL-containing
     encodings, but I don't think it's worth the effort.

> diff --git a/t/t3900/UTF-16.txt b/t/t3900/UTF-16.txt
> new file mode 100644
> index 0000000000000000000000000000000000000000..53296be684253f40964c0=
604be7fa7ff12e200cb
> GIT binary patch
> literal 32
> mcmezOpWz6@X@-jo=3DNYasZ~@^#h9rjP3@HpR7}6Nh8Mpw;r3yp<

I was disappointed not to find a secret message. :)

-Peff
