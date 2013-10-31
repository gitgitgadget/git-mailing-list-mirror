From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 09/10] fast-export: add support to delete refs
Date: Thu, 31 Oct 2013 13:53:15 -0600
Message-ID: <CAMP44s2n-dDEcY8Ds+0z0sys1q_Y60s7KOCs5VvO0tAWG3iLpQ@mail.gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-8-git-send-email-felipe.contreras@gmail.com>
	<6F276334-DFDB-40B8-8B24-38FFB6DBED9B@quendi.de>
	<CAMP44s3vxfN5Wc+S+VjimisUgZGQMzR7Z2YkO8J4UEk7+cPy_Q@mail.gmail.com>
	<78D9AAB6-09EC-4E81-A7BE-D36B9A9869D1@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbyIz-00071C-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab3JaTxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:53:17 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:42101 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab3JaTxR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 15:53:17 -0400
Received: by mail-la0-f46.google.com with SMTP id hp15so2676748lab.5
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RaqO0SFksE/7zAxUjzLLTyyii/uHFIi13BXyHmh6U/Y=;
        b=O1bcKsWkV6UYDViJ3JsOY2sLmc7sgcljLD01sJM4sH7tQpSFIESwcKd85bDWVOpmUs
         YvPMy0JazlkL1xT0EeBvcunnRN6ko9M16xWBvIfADs/YSrnKk9fiy2Z3Vi1HBk5541Hp
         TeTiBjHZREPR6r/UG0e5Cr/Njiy75zVV4S0PWRpRlgroa4WrvMhcexJ03TTpwo2mXiWB
         YkAPm/+wzu2+0R31wEU+Wwoun2oG+q4CCm1IO1vHwgyhCOugPZcYaToctfTKmZN23eXb
         dBUz5gTFLozwd7bs0zyae/n8aLKDtf96gdwkkZHB+/lLrRng8E15CxzG5WaC/dBDTHze
         Wy4Q==
X-Received: by 10.152.180.139 with SMTP id do11mr3072666lac.23.1383249195874;
 Thu, 31 Oct 2013 12:53:15 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 12:53:15 -0700 (PDT)
In-Reply-To: <78D9AAB6-09EC-4E81-A7BE-D36B9A9869D1@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237173>

On Thu, Oct 31, 2013 at 1:47 PM, Max Horn <max@quendi.de> wrote:
>
> On 31.10.2013, at 20:41, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>
>> On Thu, Oct 31, 2013 at 1:29 PM, Max Horn <max@quendi.de> wrote:
>>> Actually, I just noticed one thing that I *do* have a question about:
>>>
>>> On 31.10.2013, at 10:36, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>> builtin/fast-export.c  | 14 ++++++++++++++
>>>> t/t9350-fast-export.sh | 11 +++++++++++
>>>> 2 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>>>> index b6f623e..8ed41b4 100644
>>>> --- a/builtin/fast-export.c
>>>> +++ b/builtin/fast-export.c
>>>> @@ -673,6 +673,19 @@ static void import_marks(char *input_file)
>>>>      fclose(f);
>>>> }
>>>>
>>>> +static void handle_deletes(void)
>>>> +{
>>>> +     int i;
>>>> +     for (i = 0; i < refspecs_nr; i++) {
>>>> +             struct refspec *refspec = &refspecs[i];
>>>> +             if (*refspec->src)
>>>> +                     continue;
>>>> +
>>>> +             printf("reset %s\nfrom %s\n\n",
>>>> +                             refspec->dst, sha1_to_hex(null_sha1));
>>>
>>> If I understand it right, this issues a "reset" command in the fast-import stream, resetting a ref to an all-zero SHA1. I had a look at the git-fast-import documentation, but I found that it does not explicitly cover this case. In particular, the "reset" command does not specify that an all-zero SHA1 should be treated as "delete this ref".
>>
>> That's what the previous patch does.
>
> Right *facepalm*.
>
> But then this should be documented in git-fast-import.txt, shouldn't it?

It is... in the previous patch.

-- 
Felipe Contreras
