From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] write_sha1_file_prepare: fix buffer overrun with
 extra-long object type
Date: Tue, 5 May 2015 14:49:50 -0400
Message-ID: <CAPig+cSZ0ggYJkKoeHZeh5vSVfuzZ54pxx8jYXNOm_wCr8KKPA@mail.gmail.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
	<1430775451-31130-1-git-send-email-gitster@pobox.com>
	<1430775451-31130-3-git-send-email-gitster@pobox.com>
	<CAPig+cS3f2XggxqbvX6Z2Da24QKLOg915Bf-bTVa+4oVzfhA1A@mail.gmail.com>
	<xmqqvbg7dja6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 20:50:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yphv6-0002Qy-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 20:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030952AbbEESuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 14:50:08 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33990 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbbEEStv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 14:49:51 -0400
Received: by iedfl3 with SMTP id fl3so172625239ied.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lgVR3Dn+AFWeLsaxVX7Tn+coK7T/xA2qUUaU3BZ+7aE=;
        b=uaUAffYcq1falD9XMWJeMK3HzD4nz9zfk3LxV1pdGXwPkN9FcSAg5nv1AVtzlJWo1n
         wF/S3RIFLFOfPZRE2C99WyDO081Es0cXg/+XhofJFBPK5U8x9J83krBeiuVySsAKkDNn
         cU6wx9Lj/jWjD46xVEcyLXLsDOp4XoQRnjSyBfW4Wm3DCpbagTS4vkH+Fs4VvWi2KXbM
         6RCOauEpt9V5Jo64gxK1CP+/VXPB+Y8f0MDq1MrHuNP8sYegHgai+DUv0s7KMEZKSNPK
         6SmRENkMShdpAyjytdGkdjyZ+YkcXj+M05+OMw82z23E7GUIIht4Rr4Rp6a2PFha+H33
         mjKQ==
X-Received: by 10.50.43.169 with SMTP id x9mr3638386igl.7.1430851790845; Tue,
 05 May 2015 11:49:50 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 5 May 2015 11:49:50 -0700 (PDT)
In-Reply-To: <xmqqvbg7dja6.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: K2r0VlpNrHdADFFRGg0M00YR3AM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268413>

On Tue, May 5, 2015 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> Date: Mon, 4 May 2015 03:25:15 -0400
> Subject: [PATCH] hash-object --literally: fix buffer overrun with extra-long object type
>
> "hash-object" learned in 5ba9a93 (hash-object: add --literally
> option, 2014-09-11) to allow crafting a corrupt/broken object of
> unknown type.
>
> When the user-provided type is particularly long, however, it can
> overflow the relatively small stack-based character array handed to
> write_sha1_file_prepare() by hash_sha1_file() and write_sha1_file(),
> leading to stack corruption (and crash).  Introduce a custom helper
> to allow arbitrarily long typenames just for "hash-object --literally".
>
> [jc: Eric's original used a strbuf in the more common codepaths, and
> I rewrote it to avoid penalizing the non-literally code. Bugs are mine]

Thanks for re-rolling again. The amended Subject: works nicely now,
and the addition to the commit message makes sense. Also, the code
changes in response to the minor questions I raised[1] all look good.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/268306/focus=268374

(rest of patch left unsnipped)

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 6158363..17e8bfdc 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -22,10 +22,8 @@ static int hash_literally(unsigned char *sha1, int fd, const char *type, unsigne
>
>         if (strbuf_read(&buf, fd, 4096) < 0)
>                 ret = -1;
> -       else if (flags & HASH_WRITE_OBJECT)
> -               ret = write_sha1_file(buf.buf, buf.len, type, sha1);
>         else
> -               ret = hash_sha1_file(buf.buf, buf.len, type, sha1);
> +               ret = hash_sha1_file_literally(buf.buf, buf.len, type, sha1, flags);
>         strbuf_release(&buf);
>         return ret;
>  }
> diff --git a/cache.h b/cache.h
> index dfa1a56..e037cad 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -888,6 +888,7 @@ static inline const unsigned char *lookup_replace_object_extended(const unsigned
>  extern int sha1_object_info(const unsigned char *, unsigned long *);
>  extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
>  extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
> +extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
>  extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
>  extern int force_object_loose(const unsigned char *sha1, time_t mtime);
>  extern int git_open_noatime(const char *name);
> diff --git a/sha1_file.c b/sha1_file.c
> index c08c0cb..dc940e6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2962,6 +2962,27 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
>         return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
>  }
>
> +int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
> +                            unsigned char *sha1, unsigned flags)
> +{
> +       char *header;
> +       int hdrlen, status = 0;
> +
> +       /* type string, SP, %lu of the length plus NUL must fit this */
> +       header = xmalloc(strlen(type) + 32);
> +       write_sha1_file_prepare(buf, len, type, sha1, header, &hdrlen);
> +
> +       if (!(flags & HASH_WRITE_OBJECT))
> +               goto cleanup;
> +       if (has_sha1_file(sha1))
> +               goto cleanup;
> +       status = write_loose_object(sha1, header, hdrlen, buf, len, 0);
> +
> +cleanup:
> +       free(header);
> +       return status;
> +}
> +
>  int force_object_loose(const unsigned char *sha1, time_t mtime)
>  {
>         void *buf;
> --
> 2.4.0-311-gf1d9b8d
