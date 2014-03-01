From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Sat, 1 Mar 2014 20:51:58 +0800
Message-ID: <CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Faiz Kothari <faiz.off93@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 13:52:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJjOh-0007Pk-7f
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbaCAMwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 07:52:00 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:58454 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbaCAMwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:52:00 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm4so1740268wib.2
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=cJRaZxEQ/jOmnb4lsursbq+W2Z10r8A6zabBCnnu3mY=;
        b=Mxswck0/H18iBSGI4BGn0jseDGQ/5Ls52+NjOUDLitJmiew+vT3AG1att1I3KZX0av
         4+evzKdifKtzoqGym7t/0nVKvl0x/p49jrYn8DcqqQ9aeV3HNun8BGc/ddkdrwH14W2R
         S/O6P2CEc3H77gGV2R+E2BiY5y/iuIOIc6nxaX/c+jBcKWgUvAwHZ/L+U3iAjYU47Pb8
         lIkucA/EjEt9e5iiZBPhoGTBGj8lUh9r3/dHh3y7E08qqnVF+6jA5XxYu3kTAd6FWtKE
         7se8HY/DZ4fDik63Izy/P7/TgRVprTD2+LikF0l+Z5f005EN9Ok3sXgqtnbYfjSBSoW+
         sTlA==
X-Received: by 10.180.189.139 with SMTP id gi11mr7502169wic.53.1393678318422;
 Sat, 01 Mar 2014 04:51:58 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sat, 1 Mar 2014 04:51:58 -0800 (PST)
In-Reply-To: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243095>

2014-03-01 19:21 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
> ---
> Implemented write_or_die.c:strbuf_write_or_die() and used in relevant places
> to substitute write_or_die(). I spotted other places where strbuf can be used
> in place of buf[MAX_PATH] but that would require a change in prototype of a
> lot of functions and functions calling them and so on....
> I'll look for more places where strbuf can be used safely.
>
> Thanks.
>
>  builtin/cat-file.c     |    2 +-
>  builtin/notes.c        |    4 ++--
>  builtin/receive-pack.c |    2 +-
>  builtin/send-pack.c    |    2 +-
>  builtin/stripspace.c   |    2 +-
>  builtin/tag.c          |    2 +-
>  bundle.c               |    2 +-
>  cache.h                |    1 +
>  credential-store.c     |    2 +-
>  fetch-pack.c           |    2 +-
>  http-backend.c         |    2 +-
>  remote-curl.c          |    8 +++++---
>  write_or_die.c         |    9 +++++++++
>  13 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index d5a93e0..c756cd5 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -255,7 +255,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
>
>         strbuf_expand(&buf, opt->format, expand_format, data);
>         strbuf_addch(&buf, '\n');
> -       write_or_die(1, buf.buf, buf.len);
> +       strbuf_write_or_die(1, &buf);
>         strbuf_release(&buf);
>
>         if (opt->print_contents) {
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 2b24d05..ef40183 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -140,7 +140,7 @@ static void write_commented_object(int fd, const unsigned char *object)
>         if (strbuf_read(&buf, show.out, 0) < 0)
>                 die_errno(_("could not read 'show' output"));
>         strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
> -       write_or_die(fd, cbuf.buf, cbuf.len);
> +       strbuf_write_or_die(fd, &cbuf);
>
>         strbuf_release(&cbuf);
>         strbuf_release(&buf);
> @@ -174,7 +174,7 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
>                 strbuf_addch(&buf, '\n');
>                 strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
>                 strbuf_addch(&buf, '\n');
> -               write_or_die(fd, buf.buf, buf.len);
> +               strbuf_write_or_die(fd, &buf);
>
>                 write_commented_object(fd, object);
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 85bba35..9434516 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1114,7 +1114,7 @@ static void report(struct command *commands, const char *unpack_status)
>         if (use_sideband)
>                 send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>         else
> -               write_or_die(1, buf.buf, buf.len);
> +               strbuf_write_or_die(1, &buf);
>         strbuf_release(&buf);
>  }
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index f420b74..d053f0a 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -86,7 +86,7 @@ static void print_helper_status(struct ref *ref)
>                 }
>                 strbuf_addch(&buf, '\n');
>
> -               write_or_die(1, buf.buf, buf.len);
> +               strbuf_write_or_die(1, &buf);
>         }
>         strbuf_release(&buf);
>  }
> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index 1259ed7..cf5c876 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -115,7 +115,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>         else
>                 comment_lines(&buf);
>
> -       write_or_die(1, buf.buf, buf.len);
> +       strbuf_write_or_die(1, &buf);
>         strbuf_release(&buf);
>         return 0;
>  }
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 74d3780..5af6ea3 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -349,7 +349,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>                                 strbuf_commented_addf(&buf, _(tag_template), comment_line_char);
>                         else
>                                 strbuf_commented_addf(&buf, _(tag_template_nocleanup), comment_line_char);
> -                       write_or_die(fd, buf.buf, buf.len);
> +                       strbuf_write_or_die(fd, &buf);
>                         strbuf_release(&buf);
>                 }
>                 close(fd);
> diff --git a/bundle.c b/bundle.c
> index e99065c..435505d 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -279,7 +279,7 @@ int create_bundle(struct bundle_header *header, const char *path,
>         while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {
>                 unsigned char sha1[20];
>                 if (buf.len > 0 && buf.buf[0] == '-') {
> -                       write_or_die(bundle_fd, buf.buf, buf.len);
> +                       strbuf_write_or_die(bundle_fd, &buf);
>                         if (!get_sha1_hex(buf.buf + 1, sha1)) {
>                                 struct object *object = parse_object_or_die(sha1, buf.buf);
>                                 object->flags |= UNINTERESTING;
> diff --git a/cache.h b/cache.h
> index db223e8..8f953a2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1227,6 +1227,7 @@ extern int copy_fd(int ifd, int ofd);
>  extern int copy_file(const char *dst, const char *src, int mode);
>  extern int copy_file_with_time(const char *dst, const char *src, int mode);
>  extern void write_or_die(int fd, const void *buf, size_t count);
> +extern void strbuf_write_or_die(int fd, const struct strbuf *sbuf);
>  extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
>  extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
>  extern void fsync_or_die(int fd, const char *);
> diff --git a/credential-store.c b/credential-store.c
> index f9146e5..5d2f211 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -48,7 +48,7 @@ static void print_entry(struct credential *c)
>  static void print_line(struct strbuf *buf)
>  {
>         strbuf_addch(buf, '\n');
> -       write_or_die(credential_lock.fd, buf->buf, buf->len);
> +       strbuf_write_or_die(credential_lock.fd, buf);
>  }
>
>  static void rewrite_credential_file(const char *fn, struct credential *c,
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f061f1f..a2bf881 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -216,7 +216,7 @@ static void send_request(struct fetch_pack_args *args,
>                 send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
>                 packet_flush(fd);
>         } else
> -               write_or_die(fd, buf->buf, buf->len);
> +               strbuf_write_or_die(fd, buf);
>  }
>
>  static void insert_one_alternate_ref(const struct ref *ref, void *unused)
> diff --git a/http-backend.c b/http-backend.c
> index d2c0a62..0204529 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -157,7 +157,7 @@ static void send_strbuf(const char *type, struct strbuf *buf)
>         hdr_int(content_length, buf->len);
>         hdr_str(content_type, type);
>         end_headers();
> -       write_or_die(1, buf->buf, buf->len);
> +       strbuf_write_or_die(1, buf);
>  }
>
>  static void send_local_file(const char *the_type, const char *name)
> diff --git a/remote-curl.c b/remote-curl.c
> index 10cb011..dee8716 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>         if (start_command(&client))
>                 exit(1);
>         if (preamble)
> -               write_or_die(client.in, preamble->buf, preamble->len);
> +               strbuf_write_or_die(client.in, preamble);
>         if (heads)
>                 write_or_die(client.in, heads->buf, heads->len);

This should be changed. May be you can use Ctrl-F to search write_or_die().
Or if you are using vim, use "/ and n" to find all.

>
> @@ -767,7 +767,8 @@ static int fetch_git(struct discovery *heads,
>
>         err = rpc_service(&rpc, heads);
>         if (rpc.result.len)
> -               write_or_die(1, rpc.result.buf, rpc.result.len);
> +               strbuf_write_or_die(1, &(rpc.result.buf));

May be this should be
strbuf_write_or_die(1, &(rpc.result));

> +
>         strbuf_release(&rpc.result);
>         strbuf_release(&preamble);
>         free(depth_arg);
> @@ -889,7 +890,8 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
>
>         err = rpc_service(&rpc, heads);
>         if (rpc.result.len)
> -               write_or_die(1, rpc.result.buf, rpc.result.len);
> +               strbuf_write_or_die(1, &(rpc.result.buf));

Same as above

> +
>         strbuf_release(&rpc.result);
>         argv_array_clear(&args);
>         return err;
> diff --git a/write_or_die.c b/write_or_die.c
> index b50f99a..5fb309b 100644
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "strbuf.h"
>
>  static void check_pipe(int err)
>  {
> @@ -64,6 +65,14 @@ void write_or_die(int fd, const void *buf, size_t count)
>         }
>  }
>
> +void strbuf_write_or_die(int fd, const struct strbuf *sbuf)
> +{
> +       if(write_in_full(fd, sbuf->buf, sbuf->len) < 0){
> +               check_pipe(errno);
> +               die_errno("write error");
> +       }
> +}
> +

Maybe we just call write_or_die() in strbuf_write_or_die(), in case that if we
wanna change something in write_or_dir(), we don't have to do duplicate jobs.

>  int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
>  {
>         if (write_in_full(fd, buf, count) < 0) {
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
