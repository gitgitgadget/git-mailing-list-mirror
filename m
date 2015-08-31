From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 15:44:56 +0530
Message-ID: <CAOLa=ZSaVttejcGKwq1jzd7deLi-A4=kaJWW0zW4XdYPrsodJg@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-5-git-send-email-Karthik.188@gmail.com> <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
 <xmqq8u8sznyo.fsf@gitster.mtv.corp.google.com> <CAPig+cTqmku5DGm9g1VN8s5sBgkjZTBLyGrFGjU2J099QA32wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:15:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWM7e-0003iy-7U
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbHaKP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 06:15:27 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33131 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbHaKP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 06:15:26 -0400
Received: by obcid8 with SMTP id id8so38927517obc.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qqP/XyKgNwOWIXD+9F53jGuQzi8iOzi9D7r7JWgRsFQ=;
        b=EYjMIbY+N2fZWr/2B8iGnPmuGlGfGS1YCKN8Xbgqn5XYvctJ7vEF6AJPKlfQIBJ8Kw
         Vup/kFIT4rcKah4BQ1l/qqlNJdbEGmyI49ebwPaNySRyKtQliHSFPNxbtXzq8spdUyVK
         /BwqPq8HG4jXjVL/WOpGVstMgYkhQ14UAoh3SBT88DE4lA41BZXXXNcf5BRl69J6Ygje
         QbGGvzqXnFCs/jKusLjUTip8LETowNvECYHX1duzJVTK5/i1yPws+geEKV/jhgz+8ROT
         s1i4bsKC/XR4FW6KBCl4iwLrwC0bcVOj+Zl6W3pOTU6OFTE2FcdwgWxnNQfRWDSnCxDb
         5BPw==
X-Received: by 10.60.92.199 with SMTP id co7mr7237968oeb.37.1441016125888;
 Mon, 31 Aug 2015 03:15:25 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 31 Aug 2015 03:14:56 -0700 (PDT)
In-Reply-To: <CAPig+cTqmku5DGm9g1VN8s5sBgkjZTBLyGrFGjU2J099QA32wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276867>

On Mon, Aug 31, 2015 at 4:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 30, 2015 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> With the disclaimer that I wasn't following the quoting discussion
>>> closely: Is this condition going to be sufficient for all cases, such
>>> as an %(if:) atom? That is, if you have:
>>>
>>>     %(if:notempty)%(bloop)%(then) --option=%(bloop)%(end)
>>>
>>> isn't the intention that, %(bloop) within the %(then) section should
>>> be quoted but not the literal "--option="?
>>
>> I think you'll see that the intention of the above is to quote the
>> entirty of the result of %(if...)...%(end) if you read the previous
>> discussion.  The "quoting" is used when you say you are making --format
>> write a script in specified programming language, e.g.
>>
>>         for-each-ref --shell --format='
>>                 a=%(atom) b=%(if...)...%(end)
>>                 do interesting things using $a and $b here
>>         ' | sh
>>
>> You are correct to point out in the earlier part of your message I
>> am responding to that %(align) is not special and any nested thing
>> including %(if) will uniformly trigger the same "usually each atom
>> is quoted separately, but with this opening atom, everything up to
>> the matching end atom is evaluated first and then the result is
>> quoted" logic.
>
> So, if I'm understanding correctly, the semantic behavior of the
> current patch seems to be more or less correct, but the implementation
> (and commit message) place perhaps too much emphasis on specializing
> quoting suppression only for %(align:), whereas it could/should be
> generalized?
>
> I am a bit concerned about this code from end_atom_handler():
>
>     /*
>      * Whenever we have more than one stack element that means we
>      * are using a certain modifier atom. In that case we need to
>      * perform quote formatting.
>      */
>     if (state->stack->prev) {
>         quote_formatting(&s, current->output.buf, state->quote_style);
>         strbuf_reset(&current->output);
>         strbuf_addbuf(&current->output, &s);
>     }
>
> Aren't both the comment and the condition backward? Shouldn't quoting
> be done only for the top-most state on the stack rather than every
> state other than the top-most? That is, shouldn't the condition be
> `!state->stack->prev' as it is in append_atom()?

After seeing the example of quote usage given by Junio, yes you're right.
`!state->stack->prev` is the way to go.

-- 
Regards,
Karthik Nayak
