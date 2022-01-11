Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9C6C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 10:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349259AbiAKKeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 05:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349197AbiAKKeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 05:34:04 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A77C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 02:34:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d3so28314561lfv.13
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 02:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J+tFj+Gmse7idEO0YzDAklpEf59kn+MqaZjH+WYXWVk=;
        b=eag+NQ5XmAVnr40lqCFoc2kw76ZkPs3aV9wkq4ul6DaRljhx3pOU1T+YRWCFa7lbOE
         kyfoOlE61M2vluHHoB3qKsd6xtF+A/amEAcAtKoZ0W7heZpvSwhzep+2tiDdULnTv4Kz
         xgcoip4gWQPA6KZE2OyHsq7CbQ1527tyTNoRfL8mkOpjitLyhvV9Pq9K33hS5uMIQQTW
         2AFMbkaaCIl5dA5NB1Y3abGpjJWu2K0mFy09859I6WJBvMFe8b/x0OuUwaQH60IYB8Mo
         DFSQcEOEKU/GPjaIaY58z2+2ZS/TZBn6fp1FsuYWcRPTks8rjvbcVzgxg806fWEm266I
         FKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J+tFj+Gmse7idEO0YzDAklpEf59kn+MqaZjH+WYXWVk=;
        b=FiziCDjNHK6rbNRQGYdDcS7GRbWVWHtHmsgwS1dg1pZnsuOGaeHwzvfuzUAUnW9GGe
         +TyprERzPHIFExwZJtWu8r7UolJ6maq94EkCq6evSm2BH3XJ4/1pCs+to9rriOb3KORk
         /WBcg8yhbohM7EEmCqAHawnurN8Lhyox6sDRy5qt78AGLtNi0p3F4SWXzFa9LRTkGRY4
         l8nPpV4oELGukScfrVPPkLVp9Ee37344sq3fpNoLlg+hnHqFnUACN9ZwKSuUYkf1xx8E
         DwT72clkLh1I1YAQoiqnuWRqGIVEqHJNqFXRA/Wxobt1lCt2lIxxeYpj24GpYhow0vnR
         Pdig==
X-Gm-Message-State: AOAM5309k69c5V4MUWKmetFen9fzmQ4yk9qgSdM9bOSjFYGyaxyhH1Sa
        tQBlQV0tnJinLCLGhAeQAD3XnRd+ZQyx/rqidWc=
X-Google-Smtp-Source: ABdhPJzqLwpmjm4Mp0hgJ4kJ/MeyIFBN1MKhNMcAjuDqr3jZylPgq8UqSEsj9FjVwxxLw5QJ0lZxRnDkFOHbMvrGB2Y=
X-Received: by 2002:a05:651c:54f:: with SMTP id q15mr2411767ljp.319.1641897242172;
 Tue, 11 Jan 2022 02:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20220108085419.79682-3-chiyutianyi@gmail.com>
 <d4b89182-1b8e-3af9-ed33-e95171285ec4@web.de>
In-Reply-To: <d4b89182-1b8e-3af9-ed33-e95171285ec4@web.de>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 11 Jan 2022 18:33:50 +0800
Message-ID: <CAO0brD3drqKfTV=oRTNHncR2tg9nQnr_zycV+X4MccRagBYDSw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] object-file.c: refactor write_loose_object() to
 several steps
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 8, 2022 at 8:28 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 08.01.22 um 09:54 schrieb Han Xin:
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > When writing a large blob using "write_loose_object()", we have to pass
> > a buffer with the whole content of the blob, and this behavior will
> > consume lots of memory and may cause OOM. We will introduce a stream
> > version function ("stream_loose_object()") in latter commit to resolve
> > this issue.
> >
> > Before introducing a stream vesion function for writing loose object,
> > do some refactoring on "write_loose_object()" to reuse code for both
> > versions.
> >
> > Rewrite "write_loose_object()" as follows:
> >
> >  1. Figure out a path for the (temp) object file. This step is only
> >     used in "write_loose_object()".
> >
> >  2. Move common steps for starting to write loose objects into a new
> >     function "start_loose_object_common()".
> >
> >  3. Compress data.
> >
> >  4. Move common steps for ending zlib stream into a new funciton
> >     "end_loose_object_common()".
> >
> >  5. Close fd and finalize the object file.
> >
> > Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> > Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> > ---
> >  object-file.c | 149 +++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 105 insertions(+), 44 deletions(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index eb1426f98c..5d163081b1 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1743,6 +1743,25 @@ static void write_object_file_prepare(const stru=
ct git_hash_algo *algo,
> >       algo->final_oid_fn(oid, &c);
> >  }
> >
> > +/*
> > + * Move the just written object with proper mtime into its final resti=
ng place.
> > + */
> > +static int finalize_object_file_with_mtime(const char *tmpfile,
> > +                                        const char *filename,
> > +                                        time_t mtime,
> > +                                        unsigned flags)
>
> This function is called only once after your series.  Should it be used b=
y
> stream_loose_object()?  Probably not -- the latter doesn't have a way to
> force a certain modification time and its caller doesn't need one.  So
> creating finalize_object_file_with_mtime() seems unnecessary for this
> series.
>

After accepting the suggestion by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason[1]=
 to remove
finalize_object_file_with_mtime() from stream_loose_object() , it seems to
be an overkill for write_loose_object() now. I'll put it back into
write_loose_object() .

1. https://lore.kernel.org/git/211221.86pmpqq9aj.gmgdl@evledraar.gmail.com/

Thanks
-Han Xin

> > +{
> > +     struct utimbuf utb;
> > +
> > +     if (mtime) {
> > +             utb.actime =3D mtime;
> > +             utb.modtime =3D mtime;
> > +             if (utime(tmpfile, &utb) < 0 && !(flags & HASH_SILENT))
> > +                     warning_errno(_("failed utime() on %s"), tmpfile)=
;
> > +     }
> > +     return finalize_object_file(tmpfile, filename);
> > +}
> > +
> >  /*
> >   * Move the just written object into its final resting place.
> >   */
> > @@ -1828,7 +1847,8 @@ static inline int directory_size(const char *file=
name)
> >   * We want to avoid cross-directory filename renames, because those
> >   * can have problems on various filesystems (FAT, NFS, Coda).
> >   */
> > -static int create_tmpfile(struct strbuf *tmp, const char *filename)
> > +static int create_tmpfile(struct strbuf *tmp, const char *filename,
> > +                       unsigned flags)
>
> create_tmpfile() is not mentioned in the commit message, yet it's
> changed here.  Hrm.
>
> >  {
> >       int fd, dirlen =3D directory_size(filename);
> >
> > @@ -1836,7 +1856,9 @@ static int create_tmpfile(struct strbuf *tmp, con=
st char *filename)
> >       strbuf_add(tmp, filename, dirlen);
> >       strbuf_addstr(tmp, "tmp_obj_XXXXXX");
> >       fd =3D git_mkstemp_mode(tmp->buf, 0444);
> > -     if (fd < 0 && dirlen && errno =3D=3D ENOENT) {
> > +     do {
> > +             if (fd >=3D 0 || !dirlen || errno !=3D ENOENT)
> > +                     break;
>
> Why turn this branch into a loop?  Is this done to mkdir multiple
> components, e.g. with filename being "a/b/c/file" to create "a", "a/b",
> and "a/b/c"?  It's only used for loose objects, so a fan-out directory
> (e.g. ".git/objects/ff") can certainly be missing, but can their parent
> be missing as well sometimes?  If that's the point then such a fix
> would be worth its own patch.  (Which probably would benefit from using
> safe_create_leading_directories()).
>
> >               /*
> >                * Make sure the directory exists; note that the contents
> >                * of the buffer are undefined after mkstemp returns an
> > @@ -1846,17 +1868,72 @@ static int create_tmpfile(struct strbuf *tmp, c=
onst char *filename)
> >               strbuf_reset(tmp);
> >               strbuf_add(tmp, filename, dirlen - 1);
> >               if (mkdir(tmp->buf, 0777) && errno !=3D EEXIST)
> > -                     return -1;
> > +                     break;
> >               if (adjust_shared_perm(tmp->buf))
> > -                     return -1;
> > +                     break;
>
> Or is it just to replace these returns with a jump to the new error
> reporting section?
>
> >
> >               /* Try again */
> >               strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
> >               fd =3D git_mkstemp_mode(tmp->buf, 0444);
>
> In that case a break would be missing here.
>
> > +     } while (0);
> > +
> > +     if (fd < 0 && !(flags & HASH_SILENT)) {
> > +             if (errno =3D=3D EACCES)
> > +                     return error(_("insufficient permission for addin=
g an "
> > +                                    "object to repository database %s"=
),
> > +                                  get_object_directory());
> > +             else
> > +                     return error_errno(_("unable to create temporary =
file"));
> >       }
>
> Why move this error reporting code into create_tmpfile()?  This function
> has a single caller both before and after your series, so the code could
> just as well stay at its call-site, avoiding the need to add the flags
> parameter.
>

Here is a legacy from v7, now there is no step called "Figuring out a path
for the (temp) object file.", and it's only used in start_loose_object_comm=
on().
I will bring it back to what it was.

Thanks
-Han Xin
> > +
> >       return fd;
> >  }
> >
> > +static int start_loose_object_common(struct strbuf *tmp_file,
> > +                                  const char *filename, unsigned flags=
,
> > +                                  git_zstream *stream,
> > +                                  unsigned char *buf, size_t buflen,
> > +                                  git_hash_ctx *c,
> > +                                  enum object_type type, size_t len,
>
> The parameters type and len are not used by this function and thus can
> be dropped.
>

*nod*

> > +                                  char *hdr, int hdrlen)
> > +{
> > +     int fd;
> > +
> > +     fd =3D create_tmpfile(tmp_file, filename, flags);
> > +     if (fd < 0)
> > +             return -1;
> > +
> > +     /*  Setup zlib stream for compression */
> > +     git_deflate_init(stream, zlib_compression_level);
> > +     stream->next_out =3D buf;
> > +     stream->avail_out =3D buflen;
> > +     the_hash_algo->init_fn(c);
> > +
> > +     /*  Start to feed header to zlib stream */
> > +     stream->next_in =3D (unsigned char *)hdr;
> > +     stream->avail_in =3D hdrlen;
> > +     while (git_deflate(stream, 0) =3D=3D Z_OK)
> > +             ; /* nothing */
> > +     the_hash_algo->update_fn(c, hdr, hdrlen);
> > +
> > +     return fd;
> > +}
> > +
> > +static void end_loose_object_common(int ret, git_hash_ctx *c,
> > +                                 git_zstream *stream,
> > +                                 struct object_id *parano_oid,
> > +                                 const struct object_id *expected_oid,
> > +                                 const char *die_msg1_fmt,
> > +                                 const char *die_msg2_fmt)
>
> Hmm, the signature needs as many lines as the function body.
>
> > +{
> > +     if (ret !=3D Z_STREAM_END)
> > +             die(_(die_msg1_fmt), ret, expected_oid);
> > +     ret =3D git_deflate_end_gently(stream);
> > +     if (ret !=3D Z_OK)
> > +             die(_(die_msg2_fmt), ret, expected_oid);
>
> These format strings cannot be checked by the compiler.
>
> Considering those two together I think I'd either unify the error
> messages and move their strings here (losing the ability for users
> to see if streaming was used) or not extract the function and
> duplicate its few shared lines.  Just a feeling, though.
>
> > +     the_hash_algo->final_oid_fn(parano_oid, c);
> > +}
> > +
> >  static int write_loose_object(const struct object_id *oid, char *hdr,
> >                             int hdrlen, const void *buf, unsigned long =
len,
> >                             time_t mtime, unsigned flags)
> > @@ -1871,28 +1948,18 @@ static int write_loose_object(const struct obje=
ct_id *oid, char *hdr,
> >
> >       loose_object_path(the_repository, &filename, oid);
> >
> > -     fd =3D create_tmpfile(&tmp_file, filename.buf);
> > -     if (fd < 0) {
> > -             if (flags & HASH_SILENT)
> > -                     return -1;
> > -             else if (errno =3D=3D EACCES)
> > -                     return error(_("insufficient permission for addin=
g an object to repository database %s"), get_object_directory());
> > -             else
> > -                     return error_errno(_("unable to create temporary =
file"));
> > -     }
> > -
> > -     /* Set it up */
> > -     git_deflate_init(&stream, zlib_compression_level);
> > -     stream.next_out =3D compressed;
> > -     stream.avail_out =3D sizeof(compressed);
> > -     the_hash_algo->init_fn(&c);
> > -
> > -     /* First header.. */
> > -     stream.next_in =3D (unsigned char *)hdr;
> > -     stream.avail_in =3D hdrlen;
> > -     while (git_deflate(&stream, 0) =3D=3D Z_OK)
> > -             ; /* nothing */
> > -     the_hash_algo->update_fn(&c, hdr, hdrlen);
> > +     /* Common steps for write_loose_object and stream_loose_object to
> > +      * start writing loose oject:
> > +      *
> > +      *  - Create tmpfile for the loose object.
> > +      *  - Setup zlib stream for compression.
> > +      *  - Start to feed header to zlib stream.
> > +      */
> > +     fd =3D start_loose_object_common(&tmp_file, filename.buf, flags,
> > +                                    &stream, compressed, sizeof(compre=
ssed),
> > +                                    &c, OBJ_NONE, 0, hdr, hdrlen);
> > +     if (fd < 0)
> > +             return -1;
> >
> >       /* Then the data itself.. */
> >       stream.next_in =3D (void *)buf;
> > @@ -1907,30 +1974,24 @@ static int write_loose_object(const struct obje=
ct_id *oid, char *hdr,
> >               stream.avail_out =3D sizeof(compressed);
> >       } while (ret =3D=3D Z_OK);
> >
> > -     if (ret !=3D Z_STREAM_END)
> > -             die(_("unable to deflate new object %s (%d)"), oid_to_hex=
(oid),
> > -                 ret);
> > -     ret =3D git_deflate_end_gently(&stream);
> > -     if (ret !=3D Z_OK)
> > -             die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(=
oid),
> > -                 ret);
> > -     the_hash_algo->final_oid_fn(&parano_oid, &c);
> > +     /* Common steps for write_loose_object and stream_loose_object to
> > +      * end writing loose oject:
> > +      *
> > +      *  - End the compression of zlib stream.
> > +      *  - Get the calculated oid to "parano_oid".
> > +      */
> > +     end_loose_object_common(ret, &c, &stream, &parano_oid, oid,
> > +                             N_("unable to deflate new object %s (%d)"=
),
> > +                             N_("deflateEnd on object %s failed (%d)")=
);
> > +
> >       if (!oideq(oid, &parano_oid))
> >               die(_("confused by unstable object source data for %s"),
> >                   oid_to_hex(oid));
> >
> >       close_loose_object(fd);
> >
> > -     if (mtime) {
> > -             struct utimbuf utb;
> > -             utb.actime =3D mtime;
> > -             utb.modtime =3D mtime;
> > -             if (utime(tmp_file.buf, &utb) < 0 &&
> > -                 !(flags & HASH_SILENT))
> > -                     warning_errno(_("failed utime() on %s"), tmp_file=
.buf);
> > -     }
> > -
> > -     return finalize_object_file(tmp_file.buf, filename.buf);
> > +     return finalize_object_file_with_mtime(tmp_file.buf, filename.buf=
,
> > +                                            mtime, flags);
> >  }
> >
> >  static int freshen_loose_object(const struct object_id *oid)
