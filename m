From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to use a
 strbuf for handling packname
Date: Fri, 28 Feb 2014 04:46:55 -0500
Message-ID: <CAPig+cSvkmZH2qEqKd=sjaMO8bfnxiKiuTKtfOuMCDwDfCDciw@mail.gmail.com>
References: <1393576104-1758-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJK25-0002pU-IP
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbaB1Jq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:46:59 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:51203 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaB1Jq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:46:56 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so395165yha.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 01:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FVpNDBe/are16T3Fw1ampxhrdNMz2xP+2NVCLWaqqB8=;
        b=SixfgLEZ/8AQH/GknNNa6OcX+Dr4kXW4GhihS+CaGct2lfyvL6fHflhrIs9s9t8bww
         AR/dPgAk3YQ2Oa9/cuw1QpgLoK8+lQCbVhKhzPNY6rJwJyQPOfhT30uSOWA5E7ygHt8c
         V7ZUSwqOqLKUicFUZHaFMZ2JnTr3xAKJL6MsTdi8oskAovdJpTtbBWirN0IWiPix16lH
         WPgTpUFtocMNf4MBIKOPFGN8UaSdN4MrrAy/H9a8Paiuf6LgOyPQclvN+fA2O2I1p+0Q
         M/cHUyMIpJlpuYnwCfy0Yh3OnPr1Ziy2K0xUPdtkV2mlwDw0G+1mJOTVy6l/3HWiRhbl
         2oLg==
X-Received: by 10.236.83.194 with SMTP id q42mr832574yhe.56.1393580816004;
 Fri, 28 Feb 2014 01:46:56 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Fri, 28 Feb 2014 01:46:55 -0800 (PST)
In-Reply-To: <1393576104-1758-1-git-send-email-sunheehnus@gmail.com>
X-Google-Sender-Auth: qtzCCG8NS5T5mSJVy9AiWbAIlZI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242928>

On Fri, Feb 28, 2014 at 3:28 AM, Sun He <sunheehnus@gmail.com> wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---

Nicely done.

Due to the necessary changes to finish_tmp_packfile(), the focus of
this patch has changed slightly from that suggested by the
microproject. It's really now about finish_tmp_packfile() rather than
finish_bulk_checkin(). As such, it may make sense to adjust the patch
subject to reflect this. For instance:

  Subject: finish_tmp_packfile(): use strbuf for pathname construction

More comments below.

]> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..72fb82b 100644
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
> @@ -823,26 +823,22 @@ static void write_pack_file(void)
>                                 utb.modtime = --last_mtime;
>                                 if (utime(pack_tmp_name, &utb) < 0)
>                                         warning("failed utime() on %s: %s",
> -                                               tmpname, strerror(errno));
> +                                               pack_tmp_name, strerror(errno));

Good catch finding this bug (as your commentary below states).
Ideally, each conceptual change should be presented distinctly from
others, so this bug should have its own patch (even though it's just a
one-liner).

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
>
>                                 stop_progress(&progress_state);
>
> diff --git a/pack-write.c b/pack-write.c
> index 9b8308b..2204aa9 100644
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
> +       int pre_len = name_buffer->len;

Minor: Perhaps basename_len (or some such) would convey a bit more
meaning than pre_len.

>         if (adjust_shared_perm(pack_tmp_name))
>                 die_errno("unable to make temporary pack file readable");
> @@ -354,17 +354,21 @@ void finish_tmp_packfile(char *name_buffer,
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
> +       /* remove added suffix string(sha1.pack) */
> +       strbuf_remove(name_buffer, pre_len, name_buffer->len - pre_len);

Since you are merely truncating the buffer back to pre_len, perhaps

    strbuf_setlen(name_buffer, pre_len)

would be more idiomatic and easier to read (and would allow you to
drop the comment).

> +
> +       strbuf_addf(name_buffer, "%s.idx", sha1_to_hex(sha1));
> +       if (rename(idx_tmp_name, name_buffer->buf))
>                 die_errno("unable to rename temporary index file");
>
> -       *end_of_name_prefix = '\0';
> +       /* remove added suffix string(sha1.idx) */
> +       strbuf_remove(name_buffer, pre_len, name_buffer->len - pre_len);

Ditto.

>         free((void *)idx_tmp_name);
>  }
> --
> 1.9.0.138.g2de3478.dirty
>
> Hello,
> This is my patch for the GSoC microproject #2
>
> I follow the suggestion of Junio to use the strbuf_addf to deal with this thing.
> And the usage of strbuf_addf needs to change the function finish_tmp_packfile, I search all over the source code ($ find .| xargs grep "finish_tmp_packfile")
> The following files contains finish_tmp_packfile:
>         bulk-checkin.c
>         builtin/pack-object.c
>         pack-write.c
>         pack.h
> And I do some change to fix them.
> I changed my vimrc so that tabs will not be changed into spaces automatically.
>
> And I came across a bug when I was doing my microproject.
> position:  builtin/pack-objects.c: write_pack_file: if(!pack_to_stdout): first else in it
>  warning() function used an uninitialized array, and I changed it to pack_tmp_name.
>
> Thank you all for all your suggestions.

This section explaining your changes is important for the ongoing
email discussion, however, it is customary (and "git am"-friendly) to
place these notes just below the "---" line following your signoff
near the top of the email.
