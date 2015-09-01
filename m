From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 00/13] Port tag.c to use ref-filter.c
Date: Tue, 1 Sep 2015 23:07:45 +0530
Message-ID: <CAOLa=ZS3jt57zMwKcWYF6Nfa=n4-rjCbhq9QSeo91hAsN3F2PA@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <vpqa8t7j4nf.fsf@anie.imag.fr> <CAOLa=ZRJC5FD08Ljh=exM5GU8vzDAo2YnjQpScB8nwa9qDdTeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:38:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpVk-0008Tn-Lj
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbbIARiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 13:38:17 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36431 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbbIARiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:38:16 -0400
Received: by obqa2 with SMTP id a2so5566778obq.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oNHVDL6ZGPcsrMSBQFT89OxOo7nRZe0JbJyPmKLXnrA=;
        b=EWW2SsBeG11O40N5z0s+eHOrriAoviugXV2vXa+tO64TYZm4XAfuo3L1SWtFrcPvR8
         aobaH6QuHn/Sgegcs/4dWsbSld6Doc8cRBNY/NTXNm9p5RMrVcF4LIyvBYNO2AKm/iRc
         fF27toOqi66TaRn+jenj45ox0b8Wy5tL6RIxwTWZlRY72Kgrt8+PhZrcuVixlZTeWqKN
         pBRR5iaDU6yyDxKcJN16NfWI6FH9Ue6lt4CL9/AS67b2Ni93davl7mEpQU0p3VqIBi8+
         0AiDLFOVxqlLIcAHQVnAzHFX8WpGYNNLbpoDhBawn9pyM+EOzkHMbO9GjKBcB5EBHObb
         VmOA==
X-Received: by 10.182.33.39 with SMTP id o7mr17249648obi.42.1441129094969;
 Tue, 01 Sep 2015 10:38:14 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 1 Sep 2015 10:37:45 -0700 (PDT)
In-Reply-To: <CAOLa=ZRJC5FD08Ljh=exM5GU8vzDAo2YnjQpScB8nwa9qDdTeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277000>

On Mon, Aug 31, 2015 at 5:06 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Mon, Aug 31, 2015 at 1:01 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> * We perform quoting on each layer of nested alignment.
>>
>> I do not understand why.
>>
>> For example, using the tip of karthik/exp on GitHub (on top of this
>> series, d91419b (ref-filter: adopt get_head_description() from branch.c,
>> 2015-08-23)):
>>
>> git for-each-ref --shell \
>>   --format 'x=%(if)foo%(then)%(align:10)XXX%(end)%(else) not foo %(end)'
>>
>> I'd expect an output like:
>>
>> x='XXX      '
>>
>> and instead I get:
>>
>> x=''\''XXX       '\'''
>>
>> which assigns the value 'XXX       ' (including the quotes) to $x. I do
>> not see a use-case for this (well, I could imagine one where we would
>> later call eval "$x", that seems rather far-fetched).
>>
>> I think the quoting should be:
>>
>> 1) When the stack contains only the initial element, quote individual
>>    atoms.
>>
>> 2) When the stack contains exactly two elements and encountering a %(end)
>>    or %(else), quote the entire strbuf of the 2nd level when appending to
>>    the 1st level.
>>
>> 3) When the stack contains more than two elements, perform no quoting at
>>    all. The quoting will be done later by #2.
>>
>
> Yea, That's what Eric was saying, I even made changes which sum up to
> what you're saying :)
>
>> I found a segfault while testing:
>>
>> $ git for-each-ref --format 'x=%(if)%(align:10)%(end)%(then)%(align:10)XXX%(end)%(else)%(end)' --shell
>> zsh: segmentation fault
>>
>
> I wouldn't worry about this ATM, I have made so many changes that the
> tip is barely changed to reflect those, though I'll have a look at it
> :)
>

Was a dereferencing error, fixed it now :)

-- 
Regards,
Karthik Nayak
