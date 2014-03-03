From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] finish_tmp_packfile():use strbuf for pathname construction
Date: Mon, 3 Mar 2014 02:41:58 -0500
Message-ID: <CAPig+cQvWKuYriXYLESw25LVURR87B8T7n_QE=NXawdJsH6GCg@mail.gmail.com>
References: <1393727375-2899-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:42:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNVl-0005Qg-Ah
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbaCCHmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:42:00 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:38378 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaCCHl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:41:59 -0500
Received: by mail-yk0-f170.google.com with SMTP id 9so9667682ykp.1
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 23:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LSLAeSfBzE32/M0cDXKN4eylW/hraUJWpdLuWVJJ1lA=;
        b=bfC8VjVpdDWgNj7Y4RbVPh0s47eSn1Y1BOlqF1ZtjPqjAAl7CaPbUJ/7lNOsEP5A1w
         hVtP9QHeboYpWvjEo/dm3aap0EzWE5KhjR9xofyW1RKWTM3NDa6CoIm5k5WhHOKKMiF0
         AfrGn8MYs6ofeS0Hv5ZfuQtTTFMoiq0KXWqMR00HB8i8yiKRnvBGIBuLxzvGzDWbFHxr
         wBUrLG6pno+BcOytO8NuLR8BTncIK+hW1pMb4NBWaxz+vDktw6zPUqiTiR5LpQMSrGuK
         ljZK+O69OE+eEU9U1othv667uBIDNewvh3oCvGoYMkrG/KEb8vmuDgHjk/H9OogyUCBV
         XT0g==
X-Received: by 10.236.124.104 with SMTP id w68mr20389478yhh.2.1393832518729;
 Sun, 02 Mar 2014 23:41:58 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 23:41:58 -0800 (PST)
In-Reply-To: <1393727375-2899-1-git-send-email-sunheehnus@gmail.com>
X-Google-Sender-Auth: 5wSkoPaE82X_44mTlQPE84ehA58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243192>

On Sat, Mar 1, 2014 at 9:29 PM, Sun He <sunheehnus@gmail.com> wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> This patch has assumed that you have already fix the bug of
> tmpname in builtin/pack-objects.c:write_pack_file() warning()
>
>
>  builtin/pack-objects.c | 15 ++++++---------
>  bulk-checkin.c         |  8 +++++---
>  pack-write.c           | 18 ++++++++++--------
>  pack.h                 |  2 +-
>  4 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..099d6ed 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -803,7 +803,7 @@ static void write_pack_file(void)
>
>                 if (!pack_to_stdout) {
>                         struct stat st;
> -                       char tmpname[PATH_MAX];
> +                       struct strbuf tmpname = STRBUF_INIT;
>
>                         /*
>                          * Packs are runtime accessed in their mtime
> @@ -826,23 +826,19 @@ static void write_pack_file(void)
>                                                 tmpname, strerror(errno));
>                         }
>
> -                       /* Enough space for "-<sha-1>.pack"? */
> -                       if (sizeof(tmpname) <= strlen(base_name) + 50)
> -                               die("pack base name '%s' too long", base_name);
> -                       snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
> +                       strbuf_addf(&tmpname, "%s-", base_name);
>
>                         if (write_bitmap_index) {
>                                 bitmap_writer_set_checksum(sha1);
>                                 bitmap_writer_build_type_index(written_list, nr_written);
>                         }
>
> -                       finish_tmp_packfile(tmpname, pack_tmp_name,
> +                       finish_tmp_packfile(&tmpname, pack_tmp_name,
>                                             written_list, nr_written,
>                                             &pack_idx_opts, sha1);
>
>                         if (write_bitmap_index) {
> -                               char *end_of_name_prefix = strrchr(tmpname, 0);
> -                               sprintf(end_of_name_prefix, "%s.bitmap", sha1_to_hex(sha1));
> +                               strbuf_addf(&tmpname, "%s.bitmap" ,sha1_to_hex(sha1));

Transpose the space and comma before the third argument.

Other than this, the patch looks reasonable.

>                                 stop_progress(&progress_state);
>
> @@ -851,10 +847,11 @@ static void write_pack_file(void)
>                                 bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
>                                 bitmap_writer_build(&to_pack);
>                                 bitmap_writer_finish(written_list, nr_written,
> -                                                    tmpname, write_bitmap_options);
> +                                                    tmpname.buf, write_bitmap_options);
>                                 write_bitmap_index = 0;
>                         }
>
> +                       strbuf_release(&tmpname);
>                         free(pack_tmp_name);
>                         puts(sha1_to_hex(sha1));
>                 }
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 118c625..98e651c 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -4,6 +4,7 @@
>  #include "bulk-checkin.h"
>  #include "csum-file.h"
>  #include "pack.h"
> +#include "strbuf.h"
>
>  static int pack_compression_level = Z_DEFAULT_COMPRESSION;
>
> @@ -23,7 +24,7 @@ static struct bulk_checkin_state {
>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  {
>         unsigned char sha1[20];
> -       char packname[PATH_MAX];
> +       struct strbuf packname = STRBUF_INIT;
>         int i;
>
>         if (!state->f)
> @@ -43,8 +44,8 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>                 close(fd);
>         }
>
> -       sprintf(packname, "%s/pack/pack-", get_object_directory());
> -       finish_tmp_packfile(packname, state->pack_tmp_name,
> +       strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
> +       finish_tmp_packfile(&packname, state->pack_tmp_name,
>                             state->written, state->nr_written,
>                             &state->pack_idx_opts, sha1);
>         for (i = 0; i < state->nr_written; i++)
> @@ -54,6 +55,7 @@ clear_exit:
>         free(state->written);
>         memset(state, 0, sizeof(*state));
>
> +       strbuf_release(&packname);
>         /* Make objects we just wrote available to ourselves */
>         reprepare_packed_git();
>  }
> diff --git a/pack-write.c b/pack-write.c
> index 9b8308b..9ccf804 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -336,7 +336,7 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
>         return sha1fd(fd, *pack_tmp_name);
>  }
>
> -void finish_tmp_packfile(char *name_buffer,
> +void finish_tmp_packfile(struct strbuf *name_buffer,
>                          const char *pack_tmp_name,
>                          struct pack_idx_entry **written_list,
>                          uint32_t nr_written,
> @@ -344,7 +344,7 @@ void finish_tmp_packfile(char *name_buffer,
>                          unsigned char sha1[])
>  {
>         const char *idx_tmp_name;
> -       char *end_of_name_prefix = strrchr(name_buffer, 0);
> +       int basename_len = name_buffer->len;
>
>         if (adjust_shared_perm(pack_tmp_name))
>                 die_errno("unable to make temporary pack file readable");
> @@ -354,17 +354,19 @@ void finish_tmp_packfile(char *name_buffer,
>         if (adjust_shared_perm(idx_tmp_name))
>                 die_errno("unable to make temporary index file readable");
>
> -       sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
> -       free_pack_by_name(name_buffer);
> +       strbuf_addf(name_buffer, "%s.pack", sha1_to_hex(sha1));
> +       free_pack_by_name(name_buffer->buf);
>
> -       if (rename(pack_tmp_name, name_buffer))
> +       if (rename(pack_tmp_name, name_buffer->buf))
>                 die_errno("unable to rename temporary pack file");
>
> -       sprintf(end_of_name_prefix, "%s.idx", sha1_to_hex(sha1));
> -       if (rename(idx_tmp_name, name_buffer))
> +       strbuf_setlen(name_buffer, basename_len);
> +
> +       strbuf_addf(name_buffer, "%s.idx", sha1_to_hex(sha1));
> +       if (rename(idx_tmp_name, name_buffer->buf))
>                 die_errno("unable to rename temporary index file");
>
> -       *end_of_name_prefix = '\0';
> +       strbuf_setlen(name_buffer, basename_len);
>
>         free((void *)idx_tmp_name);
>  }
> diff --git a/pack.h b/pack.h
> index 12d9516..3223f5a 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -91,6 +91,6 @@ extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned ch
>  extern int read_pack_header(int fd, struct pack_header *);
>
>  extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
> -extern void finish_tmp_packfile(char *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
> +extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
>
>  #endif
> --
> 1.9.0.138.g2de3478.dirty
