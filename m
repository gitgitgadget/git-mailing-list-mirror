From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] strbuf_grow(): maintain nul-termination even for new buffer
Date: Tue, 30 Aug 2011 00:41:28 +0200
Message-ID: <CABPQNSZmMPSbjECJTAiDZ4OVf2Yue=eDnx1q178aDaNeJ52n1w@mail.gmail.com>
References: <c8d8686c1813885a36d8f4cada218686989df236.1314651926.git.trast@student.ethz.ch>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 30 00:42:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyAX2-00081H-I4
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 00:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab1H2WmM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 18:42:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36175 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab1H2WmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 18:42:09 -0400
Received: by fxh19 with SMTP id 19so4899331fxh.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=jL9WchYOHs0COfhCKiWnvvupN5wMvJvlYxoiQYk7hug=;
        b=c5xtEFRVBXYbChvPNUVZ+1Cua7R113SM/3Xk3VqGW35/jcJqMkm0Ay3bTgim7fc0pD
         +t+5VS8mx99WymXsvNK2C4wfYT6dnc1xRkWU2yDxATSd37q6Hhvh/vOW1KWPZhnkrZkq
         9wyyDNHnyZQSmCSlVpxROPlZoUOhMevjQ9bQs=
Received: by 10.223.6.214 with SMTP id a22mr4241562faa.99.1314657728250; Mon,
 29 Aug 2011 15:42:08 -0700 (PDT)
Received: by 10.152.28.200 with HTTP; Mon, 29 Aug 2011 15:41:28 -0700 (PDT)
In-Reply-To: <c8d8686c1813885a36d8f4cada218686989df236.1314651926.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180371>

On Mon, Aug 29, 2011 at 11:16 PM, Thomas Rast <trast@student.ethz.ch> w=
rote:
> In the case where sb is initialized to the slopbuf (through
> strbuf_init(sb,0) or STRBUF_INIT), strbuf_grow() loses the terminatin=
g
> nul: it grows the buffer, but gives ALLOC_GROW a NULL source to avoid
> it being freed. =A0So ALLOC_GROW does not copy anything to the new
> memory area.
>
> This subtly broke the call to strbuf_getline in read_next_command()
> [fast-import.c:1855], which goes
>
> =A0 =A0strbuf_detach(&command_buf, NULL); =A0# command_buf is now =3D=
 STRBUF_INIT
> =A0 =A0stdin_eof =3D strbuf_getline(&command_buf, stdin, '\n');
> =A0 =A0if (stdin_eof)
> =A0 =A0 =A0 =A0 =A0 =A0return EOF;
>
> In strbuf_getwholeline, this did
>
> =A0 =A0strbuf_grow(sb, 0); =A0# loses nul-termination
> =A0 =A0if (feof(fp))
> =A0 =A0 =A0 =A0 =A0 =A0return EOF;
> =A0 =A0strbuf_reset(sb); =A0 =A0# this would have nul-terminated!
>
> Valgrind found this because fast-import subsequently uses prefixcmp()
> on command_buf.buf, which after the EOF exit contains only
> uninitialized memory.
>
> Arguably strbuf_getwholeline is also broken, in that it touches the
> buffer before deciding whether to do any work. =A0However, it seems m=
ore
> futureproof to not let the strbuf API lose the nul-termination by its
> own fault.
>
> So make sure that strbuf_grow() puts in a nul even if it has nowhere
> to copy it from. =A0This makes strbuf_grow(sb, 0) a semantic no-op as
> far as readers of the buffer are concerned.
>
> Also remove the nul-termination added by strbuf_init, which is made
> redudant.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Only found this now because the bug is only triggered by the tests
> added in 4cedb78 (fast-import: add input format tests, 2011-08-11).
>
>
> =A0strbuf.c | =A0 =A09 +++++----
> =A01 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 1a7df12..4556f96 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -30,10 +30,8 @@ void strbuf_init(struct strbuf *sb, size_t hint)
> =A0{
> =A0 =A0 =A0 =A0sb->alloc =3D sb->len =3D 0;
> =A0 =A0 =A0 =A0sb->buf =3D strbuf_slopbuf;
> - =A0 =A0 =A0 if (hint) {
> + =A0 =A0 =A0 if (hint)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_grow(sb, hint);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sb->buf[0] =3D '\0';
> - =A0 =A0 =A0 }
> =A0}
>
> =A0void strbuf_release(struct strbuf *sb)

This gave me a bit of deja-vu, and indeed:
5e7a5d9 strbuf: make sure buffer is zero-terminated

> @@ -65,12 +63,15 @@ void strbuf_attach(struct strbuf *sb, void *buf, =
size_t len, size_t alloc)
>
> =A0void strbuf_grow(struct strbuf *sb, size_t extra)
> =A0{
> + =A0 =A0 =A0 int new_buf =3D !sb->alloc;
> =A0 =A0 =A0 =A0if (unsigned_add_overflows(extra, 1) ||
> =A0 =A0 =A0 =A0 =A0 =A0unsigned_add_overflows(sb->len, extra + 1))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("you want to use way too much memo=
ry");
> - =A0 =A0 =A0 if (!sb->alloc)
> + =A0 =A0 =A0 if (new_buf)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sb->buf =3D NULL;
> =A0 =A0 =A0 =A0ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> + =A0 =A0 =A0 if (new_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sb->buf[0] =3D '\0';
> =A0}
>
> =A0void strbuf_trim(struct strbuf *sb)

Looks sensible to me.
