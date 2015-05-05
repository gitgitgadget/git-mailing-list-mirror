From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] write_sha1_file_prepare: fix buffer overrun with
 extra-long object type
Date: Mon, 4 May 2015 20:13:18 -0400
Message-ID: <CAPig+cS3f2XggxqbvX6Z2Da24QKLOg915Bf-bTVa+4oVzfhA1A@mail.gmail.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
	<1430775451-31130-1-git-send-email-gitster@pobox.com>
	<1430775451-31130-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 02:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpQUR-0003DU-KC
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 02:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbbEEANY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 20:13:24 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37040 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbbEEANT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 20:13:19 -0400
Received: by igblo3 with SMTP id lo3so96266123igb.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=se213ANKU+/mAyXbEZyhLSonosUj7mV9AtcD1ybL7tM=;
        b=Yc0wHRTyI+xt2KkTkgnHwM/sDDYfpDSipll8rnDMXWY9LqDMAjR8m/bOOdD4V+nvuj
         bbBj8V66wTobuiEGpVYpxrBXitd99wxSP/sdEyjrhan+bWZkoLFYnQ3XiIen786oagkj
         z8TvwCbWrsc2GXhAWxrjWJvQ6veTr/sPvAJ1PuNOdfJpZVKC5Dnpous3fSZylccwe9pF
         x9jl6gmLjxduyL6q+RKQdvs6kflDmiCpWMLsb4CaXi+Do7C/bf+IaT+t2XbtL9B1I/hC
         ATWeu47OrwJhDNgFvmIr3hMF/KHBQJ6q5zOgWyA/Z5DHI1bjG4Y1g5FsnWhFWs5Mn8bF
         03Zw==
X-Received: by 10.107.31.134 with SMTP id f128mr31280789iof.19.1430784799029;
 Mon, 04 May 2015 17:13:19 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 4 May 2015 17:13:18 -0700 (PDT)
In-Reply-To: <1430775451-31130-3-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: KpxYiDFoKyyb-nHUry90L9qlygc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268374>

On Mon, May 4, 2015 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>

Thanks for re-rerolling this series. Considering that the only bits
left from me are the diagnosis and the (mostly intact) commit message,
perhaps the authorship should be changed, or at the very least a big
"Helped-by: Junio" added? Anyhow, a few minor comments below...

> write_sha1_file_prepare: fix buffer overrun with extra-long object type

Although the overrun happened in write_sha1_file_prepare(), that
function is no longer the focus of the patch. Would make sense to
rephrase the subject more generally as:

    sha1_file: fix buffer overrun with extra-long object type

or something.

More below.

> git-hash-object learned --literally in 5ba9a93 (hash-object: add
> --literally option, 2014-09-11) which can be used to craft a
> corrupt/broken object of unknown type.
>
> When the user-provided type is particularly long, however, it can
> overflow the relatively small stack-based character array handed to
> write_sha1_file_prepare() by hash_sha1_file() and write_sha1_file(),
> leading to stack corruption (and crash).
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/cache.h b/cache.h
> index dfa1a56..2da7740 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -888,6 +888,7 @@ static inline const unsigned char *lookup_replace_object_extended(const unsigned
>  extern int sha1_object_info(const unsigned char *, unsigned long *);
>  extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
>  extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
> +extern int hash_sha1_file_literally(struct strbuf *buf, const char *type, unsigned char *return_sha1, unsigned flags);

A few questions:

What's the value of making the first argument of
hash_sha1_file_literally() a strbuf rather than the two-argument buf &
len accepted by hash_sha1_file() and write_sha1_file()? Is the
inconsistency warranted?

Would it make sense to name the third argument "sha1" instead of
"return_sha1" to match the argument name of hash_sha1_file()?

And, as an aside, should your new patch 4/4 rename "return_sha1" to
"sha1" in the write_sha1_file() prototype also?

>  extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
>  extern int force_object_loose(const unsigned char *sha1, time_t mtime);
>  extern int git_open_noatime(const char *name);
> diff --git a/sha1_file.c b/sha1_file.c
> index c08c0cb..0fe3f29 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2962,6 +2962,31 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
>         return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
>  }
>
> +int hash_sha1_file_literally(struct strbuf *buf, const char *type,
> +                            unsigned char *sha1, unsigned flags)
> +{
> +       struct strbuf header = STRBUF_INIT;
> +       int hdrlen, status = 0;
> +
> +       /* type string, SP, %lu of the length plus NUL must fit this */
> +       strbuf_grow(&header, strlen(type) + 20);

A couple comments:

First, given that the largest 64-bit unsigned long value
(18,446,744,073,709,551,615) is 20 characters, do we want to be really
pedantic and add 22 instead of 20?

Second, is strbuf overkill in this situation when a simple
xmalloc()/free() would do?

> +       write_sha1_file_prepare(buf->buf, buf->len, type, sha1,
> +                               header.buf, &hdrlen);
> +
> +       if (!(flags & HASH_WRITE_OBJECT))
> +               goto cleanup;
> +
> +       if (has_sha1_file(sha1))
> +               goto cleanup;
> +       status = write_loose_object(sha1, header.buf, hdrlen,
> +                                   buf->buf, buf->len, 0);
> +
> +cleanup:
> +       strbuf_release(&header);
> +       return status;
> +}
> +
>  int force_object_loose(const unsigned char *sha1, time_t mtime)
>  {
>         void *buf;
> --
> 2.4.0-302-g6743426
