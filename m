From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 09:13:40 -0700
Message-ID: <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcboh-0005iV-Is
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbbIQQNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2015 12:13:43 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33319 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbbIQQNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:13:42 -0400
Received: by pacex6 with SMTP id ex6so23810287pac.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=yeWfANLqa+wzxh5EyA6HWDiqSA2qLIRFOMVMTGLXq5s=;
        b=Y8A6+TVUZhykB/oEsyrI8BIPhWvdIonELEfru677uowPNEOULhapAVufEbM1qKpAi9
         As+t8el3plI1EKA9sVvQjVLt7eebyJU7oH3Yxs6WlLHMtQf9pYejmHno48ZWpj2LM2BO
         DR7preQKxEaU5iT8/vIKHDMR+fjTfVcjXByOwJc0X3DXJkjqphNKEqB4kI3Y580U5LoB
         J3beBQaBiMpjxOdG9QQn4jvJtojkq4Ypq38BhTDj90b80M/p9XV6eqIErarq9Odi5urc
         WtMlpSa0TAnjEeQGvllcOKpCMKeCmhkM06OgROtY533Gsiwz/MJTAy455YMDw42HYHFI
         YEgQ==
X-Received: by 10.66.232.102 with SMTP id tn6mr74566511pac.47.1442506422082;
        Thu, 17 Sep 2015 09:13:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id u1sm4269060pbz.56.2015.09.17.09.13.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 09:13:41 -0700 (PDT)
In-Reply-To: <1442453948-9885-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 16 Sep 2015 18:38:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278128>

Stefan Beller <sbeller@google.com> writes:

> Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock

s/Add/add/;

> We need to read from pipes without blocking in a later patch.

I am hoping that you are at least not spinning---i.e. do a poll=20
first to make sure there is at least some progress to be made
before calling this.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  strbuf.c | 25 +++++++++++++++++++++++--
>  strbuf.h |  6 ++++++
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index cce5eed..4130ee2 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -357,7 +357,10 @@ size_t strbuf_fread(struct strbuf *sb, size_t si=
ze, FILE *f)
>  	return res;
>  }
> =20
> -ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
> +#define IGNORE_EAGAIN (1)
> +
> +static ssize_t strbuf_read_internal(struct strbuf *sb, int fd,
> +				    size_t hint, int flags)
>  {
>  	size_t oldlen =3D sb->len;
>  	size_t oldalloc =3D sb->alloc;
> @@ -366,8 +369,16 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, s=
ize_t hint)
>  	for (;;) {
>  		ssize_t cnt;
> =20
> -		cnt =3D xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
> +		cnt =3D read(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
>  		if (cnt < 0) {
> +			if (errno =3D=3D EINTR)
> +				continue;
> +			if (errno =3D=3D EAGAIN) {
> +				if (flags & IGNORE_EAGAIN)
> +					break;
> +				else
> +					continue;
> +			}

In order to ensure that this is not breaking the normal case, I had
to look at the implementation of xread() to see it behaves identically
when the flags is not passed.  That one-time review burden implies
that this is adding a maintenance burden to keep this copied function
in sync.

We should also handle EWOULDBLOCK not just EAGAIN.

More importantly, I am not sure if this helper is even necessary.

Looking at xread (reproduced in its full glory):

/*
 * xread() is the same a read(), but it automatically restarts read()
 * operations with a recoverable error (EAGAIN and EINTR). xread()
 * DOES NOT GUARANTEE that "len" bytes is read even if the data is avai=
lable.
 */
ssize_t xread(int fd, void *buf, size_t len)
{
	ssize_t nr;
	if (len > MAX_IO_SIZE)
	    len =3D MAX_IO_SIZE;
	while (1) {
		nr =3D read(fd, buf, len);
		if ((nr < 0) && (errno =3D=3D EAGAIN || errno =3D=3D EINTR))
			continue;
		return nr;
	}
}

Are we doing the right thing for EAGAIN here?

Now, man read(2) says this:

       EAGAIN=20
		The file descriptor fd refers to a file other than a
                socket and has been marked nonblocking (O_NONBLOCK),
                and the read would block.

       EAGAIN or EWOULDBLOCK
		The file descriptor fd refers to a socket and has
                been marked nonblocking (O_NONBLOCK), and the read
                would block.  POSIX.1-2001 allows either error to be
                returned for this case, and does not require these
                con=E2=80=90 stants to have the same value, so a portab=
le
                application should check for both possibilities.

If the fd is not marked nonblocking, then we will not get EAGAIN (or
EWOULDBLOCK).

When fd is set to nonblocking, the current xread() spins if read()
says that the operation would block.  What would we achieve by
spinning ourselves here, though?  The caller must have set the fd to
be nonblocking for a reason, and that reason cannot be "if the data
is not ready, we do not have anything better than just spinning for
new data to arrive"---if so, the caller wouldn't have set the fd to
be nonblocking in the first place.

Even if there is such a stupid caller that only wants us to loop,
because we explicitly allow xread() to return a short read, all of
our callers must call it in a loop if they know how much they want
to read.  We can just return from here and let them loop around us.

And your new caller that does O_NONBLOCK wants to do more than
looping upon EWOULDBLOCK.  It certainly would not want us to loop
here.

So I wonder if you can just O_NONBLOCK the fd and use the usual
strbuf_read(), i.e. without any change in this patch, and update
xread() to _unconditionally_ return when read(2) says EAGAIN or
EWOULDBLOCK.

What would that break?

>  			if (oldalloc =3D=3D 0)
>  				strbuf_release(sb);
>  			else
> @@ -384,6 +395,16 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, s=
ize_t hint)
>  	return sb->len - oldlen;
>  }
> =20
> +ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
> +{
> +	return strbuf_read_internal(sb, fd, hint, 0);
> +}
> +
> +ssize_t strbuf_read_noblock(struct strbuf *sb, int fd, size_t hint)
> +{
> +	return strbuf_read_internal(sb, fd, hint, IGNORE_EAGAIN);
> +}
> +
>  #define STRBUF_MAXLINK (2*PATH_MAX)
> =20
>  int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint=
)
> diff --git a/strbuf.h b/strbuf.h
> index aef2794..23ca7aa 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -367,6 +367,12 @@ extern size_t strbuf_fread(struct strbuf *, size=
_t, FILE *);
>  extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
> =20
>  /**
> + * Same as strbuf_read, just returns non-blockingly by ignoring EAGA=
IN.
> + * The fd must have set O_NONBLOCK.
> + */
> +extern ssize_t strbuf_read_noblock(struct strbuf *, int fd, size_t h=
int);
> +
> +/**
>   * Read the contents of a file, specified by its path. The third arg=
ument
>   * can be used to give a hint about the file size, to avoid reallocs=
=2E
>   */
