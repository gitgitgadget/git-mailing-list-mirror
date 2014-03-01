From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] rewrite finish_bulk_checkin() using strbuf
Date: Sat, 1 Mar 2014 19:03:09 +0800
Message-ID: <CAJr59C2SpT_=-tDq1yQSt8j1TNy9vOugw-tusC=KBUnYfjYfeg@mail.gmail.com>
References: <1393656389-31300-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C2F93qUFk3g201ykmQbbQmPGN60k=9--3rOuYAvdZHapA@mail.gmail.com>
	<CAFbjVcmghtj80NetKoBeCKfMcECotiC=Q7ZmBR9ASuAtT_wiWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Faiz Kothari <faiz.off93@gmail.com>, git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 12:03:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJhhL-000871-Qb
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 12:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbaCALDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 06:03:12 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:47221 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbaCALDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 06:03:11 -0500
Received: by mail-wg0-f45.google.com with SMTP id m15so1463716wgh.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 03:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=h62m96EOCv3bAcXUIXrjcADLj4Di69VHOkGjh8LAhug=;
        b=qqH+FZXNjRxs8NfXGmn5p7ZSyFkYJHRgWa7VQpGBg5OXGkBuA6cry8IVVpJ6Q4So17
         zZVr/3qMjDNz8RKRvvJgk8B9qU4Ih9io2PmLQW18Kbgabvr5yYphMtvs8uFUt7ZyH/05
         rxYMfoAllC8MU6hhlfb+1gSSo8wd6EDOGHRoTkhgMBlx1XNgvWov6/5/8ZZmbhCAdf/4
         wbA+kDgzzDexgq7nSQZADcMriWq/QP+UPpvy/05iGjJRLW7bi71tQofiy75uR3qC3G4N
         g51KLmSAuX2GsTzfUDGCzUQkcB3Ij1AQyrvXPGclovr+VrVTKtqDeh20aYmZKtfaujk/
         1fuA==
X-Received: by 10.194.119.168 with SMTP id kv8mr6946888wjb.41.1393671789322;
 Sat, 01 Mar 2014 03:03:09 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sat, 1 Mar 2014 03:03:09 -0800 (PST)
In-Reply-To: <CAFbjVcmghtj80NetKoBeCKfMcECotiC=Q7ZmBR9ASuAtT_wiWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243059>

2014-03-01 15:18 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
> Hi,
> Yup, at that position.
> I don't know, but it failed a few tests on my machine related to bitmap.
> Another thing to use would be strbuf_splice()

Eric Sunshine<sunshine@sunshineco.com> has came up with a more
elegant way to finish this task. That's using strbuf_setlen() instead of
strbuf_remove(). Because of the unstable network of this afternoon. The
former email is sent without the above information.
Sorry about it.

I find out that you didn't attach strbuf_remove() in your finish_bulk_checkin().
That may cause problems not only related to bitmap, because the input
packname is different from the output packname..

Cheers,
He Sun

> Anyways, no worries :)
>
> Cheers,
> Faiz
>
> On Sat, Mar 1, 2014 at 12:40 PM, He Sun <sunheehnus@gmail.com> wrote:
>> 2014-03-01 14:46 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
>>> From: Faiz Kotahri <faiz.off93@gmail.com>
>>>
>>> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
>>> ---
>>> Sticking with implementation involving changing the prototype for
>>> pack-write.c:finish_tmp_packfile()
>>> Fixing a small bug in Sun He's implementation which caused a fail in some tests.
>>>
>>>  builtin/pack-objects.c |   25 ++++++++++++-------------
>>>  bulk-checkin.c         |    9 ++++++---
>>>  pack-write.c           |   19 ++++++++++---------
>>>  pack.h                 |    3 ++-
>>>  4 files changed, 30 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>> index c733379..4b59bba 100644
>>> --- a/builtin/pack-objects.c
>>> +++ b/builtin/pack-objects.c
>>> @@ -20,6 +20,7 @@
>>>  #include "streaming.h"
>>>  #include "thread-utils.h"
>>>  #include "pack-bitmap.h"
>>> +#include "strbuf.h"
>>>
>>>  static const char *pack_usage[] = {
>>>         N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
>>> @@ -803,8 +804,8 @@ static void write_pack_file(void)
>>>
>>>                 if (!pack_to_stdout) {
>>>                         struct stat st;
>>> -                       char tmpname[PATH_MAX];
>>> -
>>> +                       struct strbuf tmpname = STRBUF_INIT;
>>> +                       int ini_length;
>>>                         /*
>>>                          * Packs are runtime accessed in their mtime
>>>                          * order since newer packs are more likely to contain
>>> @@ -823,26 +824,24 @@ static void write_pack_file(void)
>>>                                 utb.modtime = --last_mtime;
>>>                                 if (utime(pack_tmp_name, &utb) < 0)
>>>                                         warning("failed utime() on %s: %s",
>>> -                                               tmpname, strerror(errno));
>>> +                                               pack_tmp_name, strerror(errno));
>>>                         }
>>>
>>> -                       /* Enough space for "-<sha-1>.pack"? */
>>> -                       if (sizeof(tmpname) <= strlen(base_name) + 50)
>>> -                               die("pack base name '%s' too long", base_name);
>>> -                       snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
>>> +                       strbuf_addf(&tmpname, "%s-", base_name);
>>> +                       ini_length = tmpname.len;
>>>
>>>                         if (write_bitmap_index) {
>>>                                 bitmap_writer_set_checksum(sha1);
>>>                                 bitmap_writer_build_type_index(written_list, nr_written);
>>>                         }
>>> -
>>> -                       finish_tmp_packfile(tmpname, pack_tmp_name,
>>> +
>>> +                       finish_tmp_packfile(&tmpname, pack_tmp_name,
>>>                                             written_list, nr_written,
>>>                                             &pack_idx_opts, sha1);
>>>
>>>                         if (write_bitmap_index) {
>>> -                               char *end_of_name_prefix = strrchr(tmpname, 0);
>>> -                               sprintf(end_of_name_prefix, "%s.bitmap", sha1_to_hex(sha1));
>>> +                               strbuf_remove(&tmpname, ini_length, tmpname.len - ini_length);
>>
>> Is this the position where you think may import bugs?
>> I think it should be the duty of finish_tmp_packfile to ensure that the tmpname
>> is the same as it is input as a param.
>> And in my original code, I have used strbuf_remove() at the end of
>> finish_tmp_packfile.
>> There is a more elegant way to finish this task.[According to ]
>>
>>
>>> +                               strbuf_addf(&tmpname, "%s.bitmap", sha1_to_hex(sha1));
>>>
>>>                                 stop_progress(&progress_state);
>>>
>>> @@ -851,10 +850,10 @@ static void write_pack_file(void)
>>>                                 bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
>>>                                 bitmap_writer_build(&to_pack);
>>>                                 bitmap_writer_finish(written_list, nr_written,
>>> -                                                    tmpname, write_bitmap_options);
>>> +                                                    tmpname.buf, write_bitmap_options);
>>>                                 write_bitmap_index = 0;
>>>                         }
>>> -
>>> +                       strbuf_release(&tmpname);
>>>                         free(pack_tmp_name);
>>>                         puts(sha1_to_hex(sha1));
>>>                 }
>>> diff --git a/bulk-checkin.c b/bulk-checkin.c
>>> index 118c625..248454c 100644
>>> --- a/bulk-checkin.c
>>> +++ b/bulk-checkin.c
>>> @@ -4,6 +4,7 @@
>>>  #include "bulk-checkin.h"
>>>  #include "csum-file.h"
>>>  #include "pack.h"
>>> +#include "strbuf.h"
>>>
>>>  static int pack_compression_level = Z_DEFAULT_COMPRESSION;
>>>
>>> @@ -23,7 +24,7 @@ static struct bulk_checkin_state {
>>>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>>  {
>>>         unsigned char sha1[20];
>>> -       char packname[PATH_MAX];
>>> +       struct strbuf packname = STRBUF_INIT;
>>>         int i;
>>>
>>>         if (!state->f)
>>> @@ -43,16 +44,18 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>>                 close(fd);
>>>         }
>>>
>>> -       sprintf(packname, "%s/pack/pack-", get_object_directory());
>>> -       finish_tmp_packfile(packname, state->pack_tmp_name,
>>> +       strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
>>> +       finish_tmp_packfile(&packname, state->pack_tmp_name,
>>>                             state->written, state->nr_written,
>>>                             &state->pack_idx_opts, sha1);
>>> +
>>>         for (i = 0; i < state->nr_written; i++)
>>>                 free(state->written[i]);
>>>
>>>  clear_exit:
>>>         free(state->written);
>>>         memset(state, 0, sizeof(*state));
>>> +       strbuf_release(&packname);
>>>
>>>         /* Make objects we just wrote available to ourselves */
>>>         reprepare_packed_git();
>>> diff --git a/pack-write.c b/pack-write.c
>>> index 9b8308b..60f5734 100644
>>> --- a/pack-write.c
>>> +++ b/pack-write.c
>>> @@ -1,6 +1,7 @@
>>>  #include "cache.h"
>>>  #include "pack.h"
>>>  #include "csum-file.h"
>>> +#include "strbuf.h"
>>>
>>>  void reset_pack_idx_option(struct pack_idx_option *opts)
>>>  {
>>> @@ -336,7 +337,7 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
>>>         return sha1fd(fd, *pack_tmp_name);
>>>  }
>>>
>>> -void finish_tmp_packfile(char *name_buffer,
>>> +void finish_tmp_packfile(struct strbuf *name_buffer,
>>>                          const char *pack_tmp_name,
>>>                          struct pack_idx_entry **written_list,
>>>                          uint32_t nr_written,
>>> @@ -344,7 +345,7 @@ void finish_tmp_packfile(char *name_buffer,
>>>                          unsigned char sha1[])
>>>  {
>>>         const char *idx_tmp_name;
>>> -       char *end_of_name_prefix = strrchr(name_buffer, 0);
>>> +       int ini_length = name_buffer->len;
>>>
>>>         if (adjust_shared_perm(pack_tmp_name))
>>>                 die_errno("unable to make temporary pack file readable");
>>> @@ -354,17 +355,17 @@ void finish_tmp_packfile(char *name_buffer,
>>>         if (adjust_shared_perm(idx_tmp_name))
>>>                 die_errno("unable to make temporary index file readable");
>>>
>>> -       sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
>>> -       free_pack_by_name(name_buffer);
>>> +       strbuf_addf(name_buffer, "%s.pack", sha1_to_hex(sha1));
>>> +       free_pack_by_name(name_buffer->buf);
>>>
>>> -       if (rename(pack_tmp_name, name_buffer))
>>> +       if (rename(pack_tmp_name, name_buffer->buf))
>>>                 die_errno("unable to rename temporary pack file");
>>>
>>> -       sprintf(end_of_name_prefix, "%s.idx", sha1_to_hex(sha1));
>>> -       if (rename(idx_tmp_name, name_buffer))
>>> +       strbuf_remove(name_buffer, ini_length, name_buffer->len - ini_length);
>>> +       strbuf_addf(name_buffer, "%s.idx", sha1_to_hex(sha1));
>>> +
>>> +       if (rename(idx_tmp_name, name_buffer->buf))
>>>                 die_errno("unable to rename temporary index file");
>>>
>>> -       *end_of_name_prefix = '\0';
>>> -
>>>         free((void *)idx_tmp_name);
>>>  }
>>> diff --git a/pack.h b/pack.h
>>> index 12d9516..0afe8d1 100644
>>> --- a/pack.h
>>> +++ b/pack.h
>>> @@ -3,6 +3,7 @@
>>>
>>>  #include "object.h"
>>>  #include "csum-file.h"
>>> +#include "strbuf.h"
>>>
>>>  /*
>>>   * Packed object header
>>> @@ -91,6 +92,6 @@ extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned ch
>>>  extern int read_pack_header(int fd, struct pack_header *);
>>>
>>>  extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
>>> -extern void finish_tmp_packfile(char *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
>>> +extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
>>>
>>>  #endif
>>> --
>>> 1.7.9.5
>>>
