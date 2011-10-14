From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH 1/2] bundle: allowing to read from an unseekable fd
Date: Fri, 14 Oct 2011 08:31:25 -0400
Message-ID: <CABURp0qnhNQ06pNHw_6_PkT2+WNPdQ1WzUHF8p6q3Hx3JkoC8A@mail.gmail.com>
References: <7vpqi034l0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 14:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REgva-0004ds-5k
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 14:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741Ab1JNMbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 08:31:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33775 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab1JNMbq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 08:31:46 -0400
Received: by wyg36 with SMTP id 36so14735wyg.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6jrCt0XlW0588WTykU1dJ25c4C+2P5SIYLjBAHhfRa0=;
        b=gBJvA1oVMQ4sonpzygqZa3J7QbWhpvyATmHx5ar66PxUqfL/Tjt8zpbWtb7n3AWoaz
         BGZiCtIMgJicj/BUxpp8wfvS1l6UdRHHO7aA87jX++lKbXwVNSxJ3gz27mnOcY4QzJas
         oDIUYgr3VGUlwG4+R5iuXdqrW+jxLDeq+OLZE=
Received: by 10.216.159.12 with SMTP id r12mr1648003wek.87.1318595505333; Fri,
 14 Oct 2011 05:31:45 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Fri, 14 Oct 2011 05:31:25 -0700 (PDT)
In-Reply-To: <7vpqi034l0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183568>

On Thu, Oct 13, 2011 at 6:32 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> The current code opens a given file with fopen(), reads it until the =
end
> of the header and runs ftell(), and reopens the same file with open()=
 and
> seeks to skip the header. This structure makes it hard to retarget th=
e
> code to read from input that is not seekable, such as a network socke=
t.
>
> This patch by itself does not reach that goal yet, but I think it is =
a
> right step in that direction.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =A0* It would be nice if we can avoid byte-by-byte reading from the f=
ile
> =A0 descriptor by over-reading into the strbuf and pass the remainder=
 to
> =A0 the caller of read_bundle_header(), but I suspect that it would r=
equire
> =A0 us to carry the "here is the remainder from the previous read" bu=
ffer
> =A0 around throughout the transport layer. Parsing of the header woul=
dn't
> =A0 be performance critical compared to the computation cost of actua=
lly
> =A0 reading the rest of the bundle, hopefully, so...
>
> =A0bundle.c | =A0 99 ++++++++++++++++++++++++++++++++++++++++--------=
--------------
> =A01 files changed, 64 insertions(+), 35 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index f48fd7d..3aa715c 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -23,49 +23,78 @@ static void add_to_ref_list(const unsigned char *=
sha1, const char *name,
> =A0 =A0 =A0 =A0list->nr++;
> =A0}
>
> -/* returns an fd */
> +/* Eventually this should go to strbuf.[ch] */
> +static int strbuf_readline_fd(struct strbuf *sb, int fd)

A size limiter would be useful here.  Since it's readline, maybe the
limit can even be hardcoded.

Without a limit, calling this with something stupid like "/dev/zero"
will consume all memory and never return.


Phil
