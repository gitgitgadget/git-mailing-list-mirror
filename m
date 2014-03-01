From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] rewrite bulk-checkin.c:finish_bulk_checkin() using strbuf
Date: Sat, 1 Mar 2014 09:34:23 +0800
Message-ID: <CAJr59C12U0A2bOjD62RLS-wws0SePT8kd3bUhxh0NMi5aapVQQ@mail.gmail.com>
References: <1393574305-24015-1-git-send-email-faiz.off93@gmail.com>
	<CAPig+cTXK6=LDPDii6RQyO1fiMCq0Rai5uO0JYOzunM=4c_nUw@mail.gmail.com>
	<CAFbjVcnx41CTOV-SCGC9a91b9weNTgYoRP1+uVDukp6Z+0F_yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Faiz Kothari <faiz.off93@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 02:34:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJYp9-0005qG-F8
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 02:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbaCABeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 20:34:25 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:47705 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbaCABeY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 20:34:24 -0500
Received: by mail-wi0-f176.google.com with SMTP id hi5so1424558wib.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 17:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=5Ow3dHFyjJuli0yDS+pfULyAbKRkCgod680TMdZypPY=;
        b=TEerI0hTIQp1uaE4ze9HAiuLmzjmHeUb+0/LU4UtrbuXwxtcXK0phJqMFVNMnHFIOt
         RUaULFpwE0QpwoQ2urWwMit0CJnFtpfiVL7L+dUfzei/x+IRxpBPS5wZiVh+lZamqpw2
         HVh+YR8ESVyUcc2C8grk1m0jsaP+xRxmIR0o0Jnp0mcD/kfC8IGurWvOOcAYx1tRbf6N
         z2lSv9AitWlvGrzzkheKYbevNXedkqBZOJExV2txbiuBNfDaUkvBoqh0gB3ArVPsfi7h
         0fk6NwlMYvIps7vBC7lcVhMEizYlq2xJJm28LCuOV6GBo9w6yX5pvRp2ZaCuJAUTCG6o
         CIHQ==
X-Received: by 10.194.60.103 with SMTP id g7mr5512331wjr.37.1393637663263;
 Fri, 28 Feb 2014 17:34:23 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Fri, 28 Feb 2014 17:34:23 -0800 (PST)
In-Reply-To: <CAFbjVcnx41CTOV-SCGC9a91b9weNTgYoRP1+uVDukp6Z+0F_yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243035>

2014-03-01 2:27 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
> Hi,
> Thanks for the suggestions and remarks.
> I rewrote bulk-checkin.c:finish_bulk_checkin() using strbuf. But saw
> that Sun He has already implemented the same way I have done.
> Should I submit my implementation as a patch?
>
> Secondly,
> I tried implementing this WITHOUT changing the prototype of the
> function pack-write.c:finish_tmp_packfile().
>

I used to think the same as you.

> For this I detached the buffer from strbuf in finish_bulk_checkin()
> using strbuf_detach() and passed it to finish_tmp_packfile().
>
> Inside finish_tmp_packfile, I attached the same buffer to a local
> struct strbuf using strbuf_attach().
> Now the problem is, two of the arguments to strbuf_attach() are
> 'alloc' and 'len' which are private members of the struct strbuf.
> But since I am just passing the detached buffer, the information of
> alloc and len is lost which is required at the time of attaching.

One stupid solution may be that, alloc 8 byte that attached to strbuf's buf,
and fill in the len and alloc. We can take them out in finish_tmp_packfile.

But this may cause potential problems, that functions should have as rare
relationship as they could.
The goal of limiting the changes in one function is for this purpose.

So may be change the first paramater of finish_tmp_packfile is the best way
to deal with this situation.

> I cannot think of any better way of using strbuf and NOT modify the
> prototype of finish_tmp_packfile()
>
> As a workaround, I can determine alloc = (strlen(buf) + 1) and len =
> strlen(buf) but AFAIK this is not always true and may break.
> Any suggestions?
>
> Thanks.
>
> On Fri, Feb 28, 2014 at 2:45 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, Feb 28, 2014 at 2:58 AM, Faiz Kothari <faiz.off93@gmail.com> wrote:
>>> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
>>>
>>> Notes:
>>>     I finally got what's happening, and why the errors were caused.
>>>     packname is supposed to contain the complete path to the .pack file.
>>>     Packs are stored as /path/to/<SHA1>.pack which I overlooked earlier.
>>>     After inspecting what is happening in pack-write.c:finish_tmp_packfile()
>>>     which indirectly modifies packname by appending the SHA1 and ".pack" to packname
>>>     This is happening in these code snippets:
>>>         char *end_of_name_prefix = strrchr(name_buffer, 0);
>>>
>>>     and later
>>>         sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
>>>
>>>     name_buffer is packname.buf
>>>     Using const for the first argument of pack-write.c:finish_tmp_packfile()
>>>     doesnot raise any compile time warning or error and not any runtime errors,
>>>     since the packname.buf is on heap and has extra space to which more char can be written.
>>>     If this was not the case,
>>>         for e.g. passing a constant string and modifying it.
>>>         This will result in a segmentation fault.
>>> ---
>>
>> This notes section is important to the ongoing email discussion,
>> however, it should be placed below the "---" line so that it does not
>> become part of the recorded commit message when the patch is applied
>> via "git am".
>>
>>>  bulk-checkin.c |    8 +++++---
>>>  pack-write.c   |    2 +-
>>>  pack.h         |    2 +-
>>>  3 files changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/bulk-checkin.c b/bulk-checkin.c
>>> index 118c625..bbdf1ec 100644
>>> --- a/bulk-checkin.c
>>> +++ b/bulk-checkin.c
>>> @@ -23,7 +23,7 @@ static struct bulk_checkin_state {
>>>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>>  {
>>>         unsigned char sha1[20];
>>> -       char packname[PATH_MAX];
>>> +       struct strbuf packname = STRBUF_INIT;
>>>         int i;
>>>
>>>         if (!state->f)
>>> @@ -42,9 +42,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>>                                          state->offset);
>>>                 close(fd);
>>>         }
>>> +       strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
>>> +       strbuf_grow(&packname, 40 + 5);
>>
>> There are several problems with this. First, magic numbers 40 and 5
>> convey no meaning to the reader. At the very least, they should be
>> named constants or a comment should explain them. More seriously,
>> though, this code is fragile since it has far too intimate knowledge
>> of the inner workings of finish_tmp_packfile(). If the implementation
>> of finish_tmp_packfile() changes in the future such that it writes
>> more than 45 additional characters to the incoming buffer, this will
>> break.
>>
>> Rather than coupling finish_bulk_checkin() and finish_tmp_packfile()
>> so tightly, consider finish_tmp_packfile() a black box which just
>> "does its job" and then propose ways to make things work without
>> finish_bulk_checkin() having to know how that job is done.
>>
>>> -       sprintf(packname, "%s/pack/pack-", get_object_directory());
>>> -       finish_tmp_packfile(packname, state->pack_tmp_name,
>>> +       finish_tmp_packfile(packname.buf, state->pack_tmp_name,
>>>                             state->written, state->nr_written,
>>>                             &state->pack_idx_opts, sha1);
>>>         for (i = 0; i < state->nr_written; i++)
>>> diff --git a/pack-write.c b/pack-write.c
>>> index 605d01b..ac38867 100644
>>> --- a/pack-write.c
>>> +++ b/pack-write.c
>>> @@ -336,7 +336,7 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
>>>         return sha1fd(fd, *pack_tmp_name);
>>>  }
>>>
>>> -void finish_tmp_packfile(char *name_buffer,
>>> +void finish_tmp_packfile(const char *name_buffer,
>>
>> This is misleading and fragile. By specifying 'const',
>> finish_tmp_packfile() promises not to modify the content of the
>> incoming name_buffer, yet it breaks this promise by modifying the
>> buffer through the non-const end_of_name_prefix variable (after
>> dropping the 'const' via strrchr()).
>>
>>>                          const char *pack_tmp_name,
>>>                          struct pack_idx_entry **written_list,
>>>                          uint32_t nr_written,
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Cheers,
He Sun
