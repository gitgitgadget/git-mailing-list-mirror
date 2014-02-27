From: Faiz Kothari <faiz.off93@gmail.com>
Subject: Re: [PATCH] GSoC2014 Microproject rewrite finish_bulk_checkin()
Date: Fri, 28 Feb 2014 04:05:00 +0530
Message-ID: <CAFbjVcm2us9QfR4qfr14MxRUmv03RN1C5NjyYVzVRw7bKoNrEg@mail.gmail.com>
References: <1393527740-16765-1-git-send-email-faiz.off93@gmail.com>
	<530FB96F.5080406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:35:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ9Xw-0007KY-SN
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaB0WfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 17:35:05 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:49206 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbaB0WfC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 17:35:02 -0500
Received: by mail-lb0-f178.google.com with SMTP id s7so2120345lbd.23
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Zvt1O6MAxxqaRffy18SmwJfAR97l04dSlARngr8LhLQ=;
        b=cKXvD7tisDOib6UBSYjsn+szeYbnIQh7aPw9ia+XPAE2YFakKsJJmrOzIdR4OjLoQi
         saj8cy7CO15Tyac6uvvhRup33sknC5dIfyp0QwkkZBvpgtufGVeXRzSfCdCZDQYm6Pk9
         AqFIknnB3sAue4uNJIAFwOpFaACS8o4ObZMFqkilNRXYz0V61BMeBJxvK0HJJbKSTStl
         cEXUSHQtPi3mbRU9UBtsAqqMujCroQqMo/saCJ7Ipj3TqRHr2v4zJnCaoxL+4OgXcwtk
         ko78qAmYTuNmS83v1f2PPMSyBJkRYYdPn/d7801ItiqC6sO5oAAZnVc4eauuvHNUKB4y
         VGfA==
X-Received: by 10.152.87.228 with SMTP id bb4mr8456736lab.15.1393540500637;
 Thu, 27 Feb 2014 14:35:00 -0800 (PST)
Received: by 10.114.186.35 with HTTP; Thu, 27 Feb 2014 14:35:00 -0800 (PST)
In-Reply-To: <530FB96F.5080406@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242870>

Hi,
Thanks for the remarks.
I'll stick to this micro project and follow the guidelines.
Yes, the strbuf API is perfectly OK. I was not getting to work it
properly, so I used malloc() / free() instead. My bad.
I'll resubmit the patch.
Thanks.

On Fri, Feb 28, 2014 at 3:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 02/27/2014 08:02 PM, Faiz Kothari wrote:
>> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
>> ---
>>  bulk-checkin.c |   12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/bulk-checkin.c b/bulk-checkin.c
>> index 118c625..feeff9f 100644
>> --- a/bulk-checkin.c
>> +++ b/bulk-checkin.c
>> @@ -23,7 +23,7 @@ static struct bulk_checkin_state {
>>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>  {
>>       unsigned char sha1[20];
>> -     char packname[PATH_MAX];
>> +     struct strbuf packname;
>>       int i;
>>
>>       if (!state->f)
>> @@ -42,9 +42,11 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>                                        state->offset);
>>               close(fd);
>>       }
>> -
>> -     sprintf(packname, "%s/pack/pack-", get_object_directory());
>> -     finish_tmp_packfile(packname, state->pack_tmp_name,
>> +
>> +     packname.len = packname.alloc = 64 + strlen(get_object_directory());
>> +     packname.buf = (char *)malloc(packname.len * sizeof(char));
>> +     sprintf(packname.buf, "%s/pack/pack-", get_object_directory());
>> +     finish_tmp_packfile(packname.buf, state->pack_tmp_name,
>>                           state->written, state->nr_written,
>>                           &state->pack_idx_opts, sha1);
>>       for (i = 0; i < state->nr_written; i++)
>> @@ -53,7 +55,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>>  clear_exit:
>>       free(state->written);
>>       memset(state, 0, sizeof(*state));
>> -
>> +     free(packname.buf);
>>       /* Make objects we just wrote available to ourselves */
>>       reprepare_packed_git();
>>  }
>> -- 1.7.9.5
>>> Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for handling packname, and explain why this is useful.
>>> Also check if the first argument of pack-write.c:finish_tmp_packfile() can be made const.
>>
>> Adding 64 to strlen(get_object_directory()) to accomodate sha1_to_hex(sha1) and itself.
>> Using the APIs for strbuf is giving me test failures(12/15) during t1050-large.sh
>> So, I used the malloc() and free() instead.
>
> This is not OK.  I promise you, the strbuf API works correctly if it is
> used correctly.  (And if it really *were* broken, you should fix the
> problem or at least diagnose and document it rather than working around it.)
>
>> Instead of having packname on stack and cause stackoverflow because of MAX_PATH ~ 4KB, have it on heap.
>> Can have first parameter to pack-write.c:finish_tmp_packfile() as const because packname is not required to be modified.
>>
>> I apologise for my two earlier patches not being in proper format. I have finally got it working properly. Will make sure,
>> it does not happen again.
>
> Almost.  This last set of comments should be moved to directly after the
> "---" line.
>
> But: please rather stick to *one* microproject and get it perfect, and
> leave the others to other students.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
