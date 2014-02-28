From: =?GB2312?B?y++61Q==?= <sunheehnus@gmail.com>
Subject: Fwd: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to use a
 strbuf for handling packname
Date: Fri, 28 Feb 2014 23:54:44 +0800
Message-ID: <CAJr59C1ezbeG5+x2VHCnxbfATXgVO1gq9+b3amgvKUqZa0Swkg@mail.gmail.com>
References: <1393576104-1758-1-git-send-email-sunheehnus@gmail.com>
	<CAPig+cSvkmZH2qEqKd=sjaMO8bfnxiKiuTKtfOuMCDwDfCDciw@mail.gmail.com>
	<CAJr59C2Uw+tnRSuHbMnyJjGSE+XNpepPdode5MvcHb4X31e+qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 16:54:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJPlz-0002If-Ri
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 16:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaB1Pyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 10:54:47 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62819 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbaB1Pyq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 10:54:46 -0500
Received: by mail-wi0-f172.google.com with SMTP id r20so910351wiv.5
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 07:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=XvOVTuuxFRxWFmsvWHUJdvPOlv0S84ZEEpRgLFCpZhU=;
        b=o9uHJiUGV2zVJa5fWNIzuv3WUI/f4AorBdqXF+0g3sb7O3ltPLt376wbSlq4sQmfaI
         9HVVXisagTf0ZO1pcrGumZWUpX9nQCLMUmUTUx9G2AXPe/TAcMzn+CW116KkP5hLYG7a
         Og0xRZ3L0lt0Mc4vlj/ygQ7fWb8F8rwPZi0LU5rH7Vcqxq+qas+ODZh5KXPeVe++e30D
         w/pLbv6bReM0MMh94l/kam6DIJDdEpPUixoDHTl84UZXX/ZM9k4q2loKph/DuJLX3deE
         c4yZWlS4cUhmFNmJDeSYcbFCVgCTTF3jJYLrvvpP0tXCFzCX7lwciOatpgnWra3SFh2e
         aRqw==
X-Received: by 10.180.165.174 with SMTP id yz14mr3998104wib.34.1393602884817;
 Fri, 28 Feb 2014 07:54:44 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Fri, 28 Feb 2014 07:54:44 -0800 (PST)
In-Reply-To: <CAJr59C2Uw+tnRSuHbMnyJjGSE+XNpepPdode5MvcHb4X31e+qQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242978>

---------- Forwarded message ----------
=46rom: =CB=EF=BA=D5 <sunheehnus@gmail.com>
Date: 2014-02-28 21:37 GMT+08:00
Subject: Re: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to
use a strbuf for handling packname
To: "Eric Sunshine [via git]" <ml-node+s661346n7604473h64@n2.nabble.com=
>


2014-02-28 17:47 GMT+08:00 Eric Sunshine [via git]
<ml-node+s661346n7604473h64@n2.nabble.com>:
> On Fri, Feb 28, 2014 at 3:28 AM, Sun He <[hidden email]> wrote:
>> Signed-off-by: Sun He <[hidden email]>
>> ---
>
> Nicely done.
>
> Due to the necessary changes to finish_tmp_packfile(), the focus of
> this patch has changed slightly from that suggested by the
> microproject. It's really now about finish_tmp_packfile() rather than
> finish_bulk_checkin(). As such, it may make sense to adjust the patch
> subject to reflect this. For instance:
>
>   Subject: finish_tmp_packfile(): use strbuf for pathname constructio=
n
>

That's great, I will adjust it as you suggested.

> More comments below.
>
> ]> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>
>> index c733379..72fb82b 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -803,7 +803,7 @@ static void write_pack_file(void)
>>
>>                 if (!pack_to_stdout) {
>>                         struct stat st;
>> -                       char tmpname[PATH_MAX];
>> +                       struct strbuf tmpname =3D STRBUF_INIT;
>>
>>                         /*
>>                          * Packs are runtime accessed in their mtime
>> @@ -823,26 +823,22 @@ static void write_pack_file(void)
>>                                 utb.modtime =3D --last_mtime;
>>                                 if (utime(pack_tmp_name, &utb) < 0)
>>                                         warning("failed utime() on %=
s:
>> %s",
>> -                                               tmpname, strerror(er=
rno));
>> +                                               pack_tmp_name,
>> strerror(errno));
>
> Good catch finding this bug (as your commentary below states).
> Ideally, each conceptual change should be presented distinctly from
> others, so this bug should have its own patch (even though it's just =
a
> one-liner).
>

OK. Should I send this patch?

>>                         }
>>
>> -                       /* Enough space for "-<sha-1>.pack"? */
>> -                       if (sizeof(tmpname) <=3D strlen(base_name) +=
 50)
>> -                               die("pack base name '%s' too long",
>> base_name);
>> -                       snprintf(tmpname, sizeof(tmpname), "%s-",
>> base_name);
>> +                       strbuf_addf(&tmpname, "%s-", base_name);
>>
>>                         if (write_bitmap_index) {
>>                                 bitmap_writer_set_checksum(sha1);
>>
>> bitmap_writer_build_type_index(written_list, nr_written);
>>                         }
>>
>> -                       finish_tmp_packfile(tmpname, pack_tmp_name,
>> +                       finish_tmp_packfile(&tmpname, pack_tmp_name,
>>                                             written_list, nr_written=
,
>>                                             &pack_idx_opts, sha1);
>>
>>                         if (write_bitmap_index) {
>> -                               char *end_of_name_prefix =3D
>> strrchr(tmpname, 0);
>> -                               sprintf(end_of_name_prefix, "%s.bitm=
ap",
>> sha1_to_hex(sha1));
>> +                               strbuf_addf(&tmpname, "%s.bitmap"
>> ,sha1_to_hex(sha1));
>>
>>                                 stop_progress(&progress_state);
>>
>> diff --git a/pack-write.c b/pack-write.c
>> index 9b8308b..2204aa9 100644
>> --- a/pack-write.c
>> +++ b/pack-write.c
>> @@ -336,7 +336,7 @@ struct sha1file *create_tmp_packfile(char
>> **pack_tmp_name)
>>         return sha1fd(fd, *pack_tmp_name);
>>  }
>>
>> -void finish_tmp_packfile(char *name_buffer,
>> +void finish_tmp_packfile(struct strbuf *name_buffer,
>>                          const char *pack_tmp_name,
>>                          struct pack_idx_entry **written_list,
>>                          uint32_t nr_written,
>> @@ -344,7 +344,7 @@ void finish_tmp_packfile(char *name_buffer,
>>                          unsigned char sha1[])
>>  {
>>         const char *idx_tmp_name;
>> -       char *end_of_name_prefix =3D strrchr(name_buffer, 0);
>> +       int pre_len =3D name_buffer->len;
>
> Minor: Perhaps basename_len (or some such) would convey a bit more
> meaning than pre_len.
>

It's pretty good to work with you next suggestion. THX

>>         if (adjust_shared_perm(pack_tmp_name))
>>                 die_errno("unable to make temporary pack file readab=
le");
>> @@ -354,17 +354,21 @@ void finish_tmp_packfile(char *name_buffer,
>>         if (adjust_shared_perm(idx_tmp_name))
>>                 die_errno("unable to make temporary index file reada=
ble");
>>
>> -       sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
>> -       free_pack_by_name(name_buffer);
>> +       strbuf_addf(name_buffer, "%s.pack", sha1_to_hex(sha1));
>> +       free_pack_by_name(name_buffer->buf);
>>
>> -       if (rename(pack_tmp_name, name_buffer))
>> +       if (rename(pack_tmp_name, name_buffer->buf))
>>                 die_errno("unable to rename temporary pack file");
>>
>> -       sprintf(end_of_name_prefix, "%s.idx", sha1_to_hex(sha1));
>> -       if (rename(idx_tmp_name, name_buffer))
>> +       /* remove added suffix string(sha1.pack) */
>> +       strbuf_remove(name_buffer, pre_len, name_buffer->len - pre_l=
en);
>
> Since you are merely truncating the buffer back to pre_len, perhaps
>
>     strbuf_setlen(name_buffer, pre_len)
>
> would be more idiomatic and easier to read (and would allow you to
> drop the comment).
>

Yeah, yeah. It's more elegent. I will fix it later.

>> +
>> +       strbuf_addf(name_buffer, "%s.idx", sha1_to_hex(sha1));
>> +       if (rename(idx_tmp_name, name_buffer->buf))
>>                 die_errno("unable to rename temporary index file");
>>
>> -       *end_of_name_prefix =3D '\0';
>> +       /* remove added suffix string(sha1.idx) */
>> +       strbuf_remove(name_buffer, pre_len, name_buffer->len - pre_l=
en);
>
> Ditto.
>
>>         free((void *)idx_tmp_name);
>>  }
>> --
>> 1.9.0.138.g2de3478.dirty
>>
>> Hello,
>> This is my patch for the GSoC microproject #2
>>
>> I follow the suggestion of Junio to use the strbuf_addf to deal with=
 this
>> thing.
>> And the usage of strbuf_addf needs to change the function
>> finish_tmp_packfile, I search all over the source code ($ find .| xa=
rgs grep
>> "finish_tmp_packfile")
>> The following files contains finish_tmp_packfile:
>>         bulk-checkin.c
>>         builtin/pack-object.c
>>         pack-write.c
>>         pack.h
>> And I do some change to fix them.
>> I changed my vimrc so that tabs will not be changed into spaces
>> automatically.
>>
>> And I came across a bug when I was doing my microproject.
>> position:  builtin/pack-objects.c: write_pack_file: if(!pack_to_stdo=
ut):
>> first else in it
>>  warning() function used an uninitialized array, and I changed it to
>> pack_tmp_name.
>>
>> Thank you all for all your suggestions.
>
> This section explaining your changes is important for the ongoing
> email discussion, however, it is customary (and "git am"-friendly) to
> place these notes just below the "---" line following your signoff
> near the top of the email.
> --
Got it.
Thank you very very much for your code review and great suggestions.

He Sun
