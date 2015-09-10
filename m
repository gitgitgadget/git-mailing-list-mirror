From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 22:30:46 +0530
Message-ID: <CAOLa=ZQM77+EzbHbY24nvu=hgNCa9MJ3wyz1XhFjk+3HdDd_Hg@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441900110-4015-6-git-send-email-Karthik.188@gmail.com> <xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5Dv-000096-BT
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbbIJRBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:01:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34011 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbbIJRBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:01:18 -0400
Received: by obbda8 with SMTP id da8so39797429obb.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nJcSV4HzpbnAI7TuvH1LPfKkC+VAkUSJZmFveLjgZoE=;
        b=Mf5lUEOdxqN0zE4y+dF62lxY/TsW1568Zo6vnTxQbc0tZ9q2kjbbt/s7rcV9kM2jud
         iNW9EGpWb3/RROgCY0e31vlfIo9NL9FsF10kPxDyMABDCZP1uH7vOKgStCWVox+4o/Jv
         J4iUUg1cHJxi5PW3io3zBASt6V1nqIyo34Rnj1b39xxr6ae4iHZPvHm3wlzgiRT+YrZe
         zbvuechKEfKh06T2xs8Zge6aWpc4Sd8HR4dASHkEkzyd8gUYrRBpuG5K85aSmduZSnNY
         kdhgla9hveW8DxF+PxGrYkv4jTiWDAznuOLO+7Yp1vfr2CYFMmxXrmrtedBW3NApPWNh
         6TEg==
X-Received: by 10.60.159.166 with SMTP id xd6mr16875345oeb.1.1441904476834;
 Thu, 10 Sep 2015 10:01:16 -0700 (PDT)
Received: by 10.182.231.166 with HTTP; Thu, 10 Sep 2015 10:00:46 -0700 (PDT)
In-Reply-To: <xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277607>

On Thu, Sep 10, 2015 at 10:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Introduce match_atom_name() which helps in checking if a particular
>> atom is the atom we're looking for and if it has a value attached to
>> it or not.
>>
>> Use it instead of starts_with() for checking the value of %(color:...)
>> atom. Write a test for the same.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Thanks-to: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  ref-filter.c                   | 23 +++++++++++++++++++++--
>>  t/t6302-for-each-ref-filter.sh |  4 ++++
>>  2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index a993216..70d36fe 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -189,6 +189,22 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
>>       *stack = prev;
>>  }
>>
>> +static int match_atom_name(const char *name, const char *atom_name, const char **val)
>> +{
>> +     const char *body;
>> +
>> +     if (!skip_prefix(name, atom_name, &body))
>> +             return 0; /* doesn't even begin with "atom_name" */
>> +     if (!body[0] || !body[1]) {
>> +             *val = NULL; /* %(atom_name) and no customization */
>
> Why do we check body[1] here?  I do not understand why you are not
> checking !body[0] alone nothing else in this if condition.
>
> For (atom_name="align", name="aligna"), should the function say that
> "%(aligna)" is an "%(align)" with no customization?
>

The check was for checking if there is anything after the colon,
Matthieu's modified version seems better though.

>
> Why use the helper only for this one?  Aren't existing calls to
> starts_with() in the same if/else if/... cascade all potential bugs
> that the new helper function is meant to help fixing?  For example,
> the very fist one in the cascade:
>
>         if (starts_with(name, "refname"))
>                 refname = ref->refname;
>
> is correct *ONLY* when name is "refname" or "refname:" followed by
> something, and it should skip "refnamex" when such a new atom is
> added to valid_atom[] list, i.e. a bug waiting to happen.  I think
> the new helper is designed to prevent such a bug from happening.
>

Yes definitely, but it would work with only refname, whereas
the color atom had no check before this patch, I didn't want to introduce
those patches in this series.

-- 
Regards,
Karthik Nayak
