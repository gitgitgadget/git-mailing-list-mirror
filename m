From: =?GB2312?B?y++61Q==?= <sunheehnus@gmail.com>
Subject: Re: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to use a
 strbuf for handling packname
Date: Fri, 28 Feb 2014 22:17:47 +0800
Message-ID: <CAJr59C2YTW-k=ujioUDfebf5koT4viB7NLtPk-do4T5Vo1Aqjw@mail.gmail.com>
References: <1393576104-1758-1-git-send-email-sunheehnus@gmail.com>
	<CAPig+cSvkmZH2qEqKd=sjaMO8bfnxiKiuTKtfOuMCDwDfCDciw@mail.gmail.com>
	<CAPig+cSN1WGj9aMKHEo+JO6xN2dT_+0fEjPG3bK=ZsA4dwyWBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:17:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOGD-0007Ic-7O
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbaB1ORw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:17:52 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34010 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbaB1ORv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 09:17:51 -0500
Received: by mail-wi0-f180.google.com with SMTP id hm4so646217wib.13
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 06:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=H5kyvNSkt8HJx4TtRBC2ZQuGiU7gDrSwh+6oIhVLhC0=;
        b=azn7970VlcnQ0M7dDZtQW25LNIRxvLjXZL0LT5GMkoZbSp2RLjfYB4qgIdnSava7NO
         R1V5AMF9GzDflTKacGM+5LWc2bFt7RClP2wyvY1noxQGYv5wAD7MEfr9hsUEUt4Uh1ia
         JJ9LHaseVkhAC581SUfeF5TxwjoZN5/VOn16q3b1YlsUPFNwNwQqM5YAZkUIcvbc1Dv1
         9NVUnS+896orvuGmyry4oyo9Fs/CGnWjjMLfXOxn8SOFmeSchgGD8tF1u1yOD1QKe845
         36KJX8jo+CjKci6wOsFOhl9TApNUJLXj6sQMOao2o6K2btnzlf/Jj6SGpojK1lzvhWC5
         LHmQ==
X-Received: by 10.180.165.174 with SMTP id yz14mr3554536wib.34.1393597067739;
 Fri, 28 Feb 2014 06:17:47 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Fri, 28 Feb 2014 06:17:47 -0800 (PST)
In-Reply-To: <CAPig+cSN1WGj9aMKHEo+JO6xN2dT_+0fEjPG3bK=ZsA4dwyWBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242962>

2014-02-28 21:12 GMT+08:00 Eric Sunshine [via git]
<ml-node+s661346n7604500h1@n2.nabble.com>:
> On Fri, Feb 28, 2014 at 4:46 AM, Eric Sunshine <[hidden email]> wrote:
>
>> On Fri, Feb 28, 2014 at 3:28 AM, Sun He <[hidden email]> wrote:
>>> Signed-off-by: Sun He <[hidden email]>
>>> ---
>>
>> Nicely done.
>>
>> Due to the necessary changes to finish_tmp_packfile(), the focus of
>> this patch has changed slightly from that suggested by the
>> microproject. It's really now about finish_tmp_packfile() rather than
>> finish_bulk_checkin(). As such, it may make sense to adjust the patch
>> subject to reflect this. For instance:
>>
>>   Subject: finish_tmp_packfile(): use strbuf for pathname construction
>
> You may also want your commit message to explain why you chose this
> approach over other legitimate approaches. For instance, your change
> places extra burden on callers of finish_tmp_packfile() by leaking a
> detail of its implementation: namely that it wants to manipulate
> pathnames easily (via strbuf). An equally valid and more encapsulated
> approach would be for finish_tmp_packfile() to accept a 'const char *'
> and construct its own strbuf internally.
>
> If the extra strbuf creation in the alternate approach is measurably
> slower, then you could use that fact to justify your implementation
> choice in the commit message. On the other hand, if it's not
> measurably slower, then perhaps the more encapsulated approach with
> cleaner API might be preferable.
>

Thank you for your explaination. I get the point.
And I think if it is proved that the strbuf way is measurably slower.
We should add a check for the length of string before we sprintf().

>> More comments below.
>>
>> ]> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>> index c733379..72fb82b 100644
>>> --- a/builtin/pack-objects.c
>>> +++ b/builtin/pack-objects.c
>>> @@ -803,7 +803,7 @@ static void write_pack_file(void)
>>>
>>>                 if (!pack_to_stdout) {
>>>                         struct stat st;
>>> -                       char tmpname[PATH_MAX];
>>> +                       struct strbuf tmpname = STRBUF_INIT;
>>>
>>>                         /*
>>>                          * Packs are runtime accessed in their mtime
>>> @@ -823,26 +823,22 @@ static void write_pack_file(void)
>>>                                 utb.modtime = --last_mtime;
>>>                                 if (utime(pack_tmp_name, &utb) < 0)
>>>                                         warning("failed utime() on %s:
>>> %s",
>>> -                                               tmpname,
>>> strerror(errno));
>>> +                                               pack_tmp_name,
>>> strerror(errno));
>>
>> Good catch finding this bug (as your commentary below states).
>> Ideally, each conceptual change should be presented distinctly from
>> others, so this bug should have its own patch (even though it's just a
>> one-liner).
>>
>>>                         }
>>>
>>> -                       /* Enough space for "-<sha-1>.pack"? */
>>> -                       if (sizeof(tmpname) <= strlen(base_name) + 50)
>>> -                               die("pack base name '%s' too long",
>>> base_name);
>>> -                       snprintf(tmpname, sizeof(tmpname), "%s-",
>>> base_name);
>>> +                       strbuf_addf(&tmpname, "%s-", base_name);
>>>
>>>                         if (write_bitmap_index) {
>>>                                 bitmap_writer_set_checksum(sha1);
>>>
>>> bitmap_writer_build_type_index(written_list, nr_written);
>>>                         }
>>>
>>> -                       finish_tmp_packfile(tmpname, pack_tmp_name,
>>> +                       finish_tmp_packfile(&tmpname, pack_tmp_name,
>>>                                             written_list, nr_written,
>>>                                             &pack_idx_opts, sha1);
>>>
>>>                         if (write_bitmap_index) {
>>> -                               char *end_of_name_prefix =
>>> strrchr(tmpname, 0);
>>> -                               sprintf(end_of_name_prefix, "%s.bitmap",
>>> sha1_to_hex(sha1));
>>> +                               strbuf_addf(&tmpname, "%s.bitmap"
>>> ,sha1_to_hex(sha1));
>>>
>>>                                 stop_progress(&progress_state);
>>>
>>> diff --git a/pack-write.c b/pack-write.c
>>> index 9b8308b..2204aa9 100644
>>> --- a/pack-write.c
>>> +++ b/pack-write.c
>>> @@ -336,7 +336,7 @@ struct sha1file *create_tmp_packfile(char
>>> **pack_tmp_name)
>>>         return sha1fd(fd, *pack_tmp_name);
>>>  }
>>>
>>> -void finish_tmp_packfile(char *name_buffer,
>>> +void finish_tmp_packfile(struct strbuf *name_buffer,
>>>                          const char *pack_tmp_name,
>>>                          struct pack_idx_entry **written_list,
>>>                          uint32_t nr_written,
>>> @@ -344,7 +344,7 @@ void finish_tmp_packfile(char *name_buffer,
>>>                          unsigned char sha1[])
>>>  {
>>>         const char *idx_tmp_name;
>>> -       char *end_of_name_prefix = strrchr(name_buffer, 0);
>>> +       int pre_len = name_buffer->len;
>>
>> Minor: Perhaps basename_len (or some such) would convey a bit more
>> meaning than pre_len.
>>
>>>         if (adjust_shared_perm(pack_tmp_name))
>>>                 die_errno("unable to make temporary pack file readable");
>>> @@ -354,17 +354,21 @@ void finish_tmp_packfile(char *name_buffer,
>>>         if (adjust_shared_perm(idx_tmp_name))
>>>                 die_errno("unable to make temporary index file
>>> readable");
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
>>> +       /* remove added suffix string(sha1.pack) */
>>> +       strbuf_remove(name_buffer, pre_len, name_buffer->len - pre_len);
>>
>> Since you are merely truncating the buffer back to pre_len, perhaps
>>
>>     strbuf_setlen(name_buffer, pre_len)
>>
>> would be more idiomatic and easier to read (and would allow you to
>> drop the comment).
>>
>>> +
>>> +       strbuf_addf(name_buffer, "%s.idx", sha1_to_hex(sha1));
>>> +       if (rename(idx_tmp_name, name_buffer->buf))
>>>                 die_errno("unable to rename temporary index file");
>>>
>>> -       *end_of_name_prefix = '\0';
>>> +       /* remove added suffix string(sha1.idx) */
>>> +       strbuf_remove(name_buffer, pre_len, name_buffer->len - pre_len);
>>
>> Ditto.
>>
>>>         free((void *)idx_tmp_name);
>>>  }
>>> --
>>> 1.9.0.138.g2de3478.dirty
>>>
>>> Hello,
>>> This is my patch for the GSoC microproject #2
>>>
>>> I follow the suggestion of Junio to use the strbuf_addf to deal with this
>>> thing.
>>> And the usage of strbuf_addf needs to change the function
>>> finish_tmp_packfile, I search all over the source code ($ find .| xargs grep
>>> "finish_tmp_packfile")
>>> The following files contains finish_tmp_packfile:
>>>         bulk-checkin.c
>>>         builtin/pack-object.c
>>>         pack-write.c
>>>         pack.h
>>> And I do some change to fix them.
>>> I changed my vimrc so that tabs will not be changed into spaces
>>> automatically.
>>>
>>> And I came across a bug when I was doing my microproject.
>>> position:  builtin/pack-objects.c: write_pack_file: if(!pack_to_stdout):
>>> first else in it
>>>  warning() function used an uninitialized array, and I changed it to
>>> pack_tmp_name.
>>>
>>> Thank you all for all your suggestions.
>>
>> This section explaining your changes is important for the ongoing
>> email discussion, however, it is customary (and "git am"-friendly) to
>> place these notes just below the "---" line following your signoff
>> near the top of the email.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to [hidden email]
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> ________________________________
> If you reply to this email, your message will be added to the discussion
> below:
> http://git.661346.n2.nabble.com/PATCH-Rewrite-bulk-checkin-c-finish-bulk-checkin-to-use-a-strbuf-for-handling-packname-tp7604449p7604500.html
> To start a new topic under git, email
> ml-node+s661346n661346h27@n2.nabble.com
> To unsubscribe from git, click here.
> NAML
Cheers,
He Sun
