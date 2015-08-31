From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 15:58:35 +0530
Message-ID: <CAOLa=ZQ2=y88rqUuNgPvZvK+sMqbkCuC0hPUoB=5Ku6Wwk_e6g@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-5-git-send-email-Karthik.188@gmail.com> <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
 <xmqq8u8sznyo.fsf@gitster.mtv.corp.google.com> <CAPig+cTqmku5DGm9g1VN8s5sBgkjZTBLyGrFGjU2J099QA32wg@mail.gmail.com>
 <CAOLa=ZSaVttejcGKwq1jzd7deLi-A4=kaJWW0zW4XdYPrsodJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:29:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWML9-0006qj-1u
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbbHaK3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 06:29:06 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33060 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbHaK3F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 06:29:05 -0400
Received: by obcid8 with SMTP id id8so39132717obc.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vwRMHJ9JBvLd5EXUb5JaVxGseIMM7mUOCiyyuCq/Khg=;
        b=pOgDjgjLb4lTsp5skyWiM9j853BJEPf2WO9+2hwSA6dYTqLpDjbOgNYejmVUlVxv7d
         FvusJxQTBP2CuVzFgPUOplhpX2VXrGT4MdGOLQVksctifKgGBzh+2bwzDXuNhVYDVdKa
         kija7HRBy2WGecB3j8VsNu+IzlP++1Tz2AqtoVBUCMeBxPjka/SF4LhtcO1QwS+L82KD
         TKjhr64KVMu4UiDOUtRjgNZRXry7cssp794wqshXKKBzGFEAdsheVXMJza6i0wFLTu7P
         wILVBICzbN/nb+n3G+MQWIHyYFuxJcO19/PNxacWIlc6QEhjc36JP6tzMUtypU7LT+Wp
         0bUQ==
X-Received: by 10.60.81.69 with SMTP id y5mr7676591oex.30.1441016944630; Mon,
 31 Aug 2015 03:29:04 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 31 Aug 2015 03:28:35 -0700 (PDT)
In-Reply-To: <CAOLa=ZSaVttejcGKwq1jzd7deLi-A4=kaJWW0zW4XdYPrsodJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276870>

On Mon, Aug 31, 2015 at 3:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Mon, Aug 31, 2015 at 4:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Aug 30, 2015 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>> With the disclaimer that I wasn't following the quoting discussion
>>>> closely: Is this condition going to be sufficient for all cases, such
>>>> as an %(if:) atom? That is, if you have:
>>>>
>>>>     %(if:notempty)%(bloop)%(then) --option=%(bloop)%(end)
>>>>
>>>> isn't the intention that, %(bloop) within the %(then) section should
>>>> be quoted but not the literal "--option="?
>>>
>>> I think you'll see that the intention of the above is to quote the
>>> entirty of the result of %(if...)...%(end) if you read the previous
>>> discussion.  The "quoting" is used when you say you are making --format
>>> write a script in specified programming language, e.g.
>>>
>>>         for-each-ref --shell --format='
>>>                 a=%(atom) b=%(if...)...%(end)
>>>                 do interesting things using $a and $b here
>>>         ' | sh
>>>
>>> You are correct to point out in the earlier part of your message I
>>> am responding to that %(align) is not special and any nested thing
>>> including %(if) will uniformly trigger the same "usually each atom
>>> is quoted separately, but with this opening atom, everything up to
>>> the matching end atom is evaluated first and then the result is
>>> quoted" logic.
>>
>> So, if I'm understanding correctly, the semantic behavior of the
>> current patch seems to be more or less correct, but the implementation
>> (and commit message) place perhaps too much emphasis on specializing
>> quoting suppression only for %(align:), whereas it could/should be
>> generalized?
>>
>> I am a bit concerned about this code from end_atom_handler():
>>
>>     /*
>>      * Whenever we have more than one stack element that means we
>>      * are using a certain modifier atom. In that case we need to
>>      * perform quote formatting.
>>      */
>>     if (state->stack->prev) {
>>         quote_formatting(&s, current->output.buf, state->quote_style);
>>         strbuf_reset(&current->output);
>>         strbuf_addbuf(&current->output, &s);
>>     }
>>
>> Aren't both the comment and the condition backward? Shouldn't quoting
>> be done only for the top-most state on the stack rather than every
>> state other than the top-most? That is, shouldn't the condition be
>> `!state->stack->prev' as it is in append_atom()?
>
> After seeing the example of quote usage given by Junio, yes you're right.
> `!state->stack->prev` is the way to go.
>

Also I think you mean `!state->stack->prev->prev` as we push a new
element on the stack when an atom such as %(align) is encountered. And
this quoting done at the end should be only for such atoms. Hence it should be
`!state->stack->prev->prev` and not `!state->stack->prev`.

-- 
Regards,
Karthik Nayak
