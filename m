From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 5/9] ref-filter: add option to match literal pattern
Date: Wed, 22 Jul 2015 00:57:21 +0530
Message-ID: <CAOLa=ZTaNcaiVt02BE4JukSj-ADeoQByWtH1jBvn5XUrVUztEQ@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437246749-14423-6-git-send-email-Karthik.188@gmail.com> <CAPig+cSTQgaL-nYfOCWdTaCEpM_23E5TZOPQpnWXEZ8YCcvbZg@mail.gmail.com>
 <CAP8UFD0kaqSUGMbWrim+59H8CweO-MKSyeQr+3q2cYdJ-+D-Mw@mail.gmail.com> <CAPig+cSu7-wegGd90WHeppt8inHSBxrakzuJSvcRV7OocJHAgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:27:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdCl-0002v2-KW
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbbGUT1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:27:51 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35237 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbGUT1v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:27:51 -0400
Received: by oihq81 with SMTP id q81so130375285oih.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hNojW4dHTstXTV6bQWPqtQqE8/lRdfYBCVRPQ5v9mvQ=;
        b=fP78PWSWELMTUXKqFcc8+WoIWWXrjSA5twapj+VsVI6rqMVvHUWUCdTJGTdcO0xrwr
         uhpUwWB4YxsVL1pOcFuy5vK/u48wuOJ8O+rFkHdV3ssjjaf6GtL3tqLlZUGwEAJZHhur
         lQISKxdRsfjAhS+2n7Zepu0H3vUAXg58p2ZU020xLmMgJffhgp/aBILrTHbKQNK1w/uv
         Ug6I7hg0OvjRBgdQchRJXd3/14MBq73/NCUBLGq2ZKQUoCDilwe4uxCMjvNAHqKcFdU5
         A9G/S8YpqZQBgs5edp8ocCqiadg2lHxpAeYV+stpVWBcWNScFDvsb3MQEcNTdnnXGyFc
         LAWg==
X-Received: by 10.202.73.198 with SMTP id w189mr31712670oia.102.1437506870650;
 Tue, 21 Jul 2015 12:27:50 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 21 Jul 2015 12:27:21 -0700 (PDT)
In-Reply-To: <CAPig+cSu7-wegGd90WHeppt8inHSBxrakzuJSvcRV7OocJHAgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274400>

On Mon, Jul 20, 2015 at 11:42 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jul 20, 2015 at 4:01 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Mon, Jul 20, 2015 at 8:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> +static int filter_pattern_match(struct ref_filter *filter, const char *refname)
>>>> +{
>>>> +       if (!*filter->name_patterns)
>>>> +               return 1;
>>>> +       if (filter->match_as_path)
>>>> +               return match_name_as_path(filter->name_patterns, refname);
>>>> +       return match_pattern(filter->name_patterns, refname);
>>>> +}
>>>> @@ -1034,7 +1057,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>>>> -       if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
>>>> +       if (!filter_pattern_match(filter, refname))
>>>>                 return 0;
>>>
>>> I find it much more difficult to grok the new logic due to
>>> '*filter->name_patterns' having moved into the called function and its
>>> negation inside the function returning 1 which is then negated (again)
>>> upon return here. This sort of twisty logic places a higher cognitive
>>> load on the reader. Retaining the original logic makes the code far
>>> simpler to understand:
>>>
>>>     if (*filter->name_patterns &&
>>>         !filter_pattern_match(filter, refname))
>>>         return 0;
>>>
>>> although it's a bit less nicely encapsulated, so I dunno...
>>
>> I think a comment before filter_pattern_match() and perhaps also one
>> inside it might help. For example something like:
>>
>> /* Return 1 if the refname matches one of the patterns, otherwise 0. */
>> static int filter_pattern_match(struct ref_filter *filter, const char *refname)
>> {
>>        if (!*filter->name_patterns)
>>                return 1; /* No pattern always matches */
>>        if (filter->match_as_path)
>>                return match_name_as_path(filter->name_patterns, refname);
>>        return match_pattern(filter->name_patterns, refname);
>> }
>
> Yes, the comments do improve the situation and may be a reasonable compromise...

Yes, these comments would help, thanks :D

-- 
Regards,
Karthik Nayak
