From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Sun, 30 Aug 2015 18:56:14 -0400
Message-ID: <CAPig+cTqmku5DGm9g1VN8s5sBgkjZTBLyGrFGjU2J099QA32wg@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
	<xmqq8u8sznyo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 00:56:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWBWP-0002VM-2x
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 00:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbbH3W4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 18:56:16 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34013 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbH3W4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 18:56:15 -0400
Received: by ykfw127 with SMTP id w127so11164486ykf.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1Icg6uddmOi5/G0qtnbGoNjZ9Q9Pv7DpBSC4KamxJRk=;
        b=AxA8R+SewqanYcu6OVXy6Uhap82Mz26BllLoC2QkLuTBCg1PfArNOf3aJrb0Xqn/91
         U9fYPRGZ4yH/5sD6RUjbvA2pHXvv9hj83zLgnR18I9tHj2f9picB/xnl48XLZchdWhqb
         uJJCY2JRHnDY48XU45sASV6o+KbYNFe07Ydfj2FYM2H6mo6HBXQfOfArH9uAmvfqESYj
         dNnnmPCKmJor7C/9bR6x4RFz8E5bDfP2EQEnyZUn+fdyydNHFxGA4/jjrcdTMCbpeOt9
         E7eKqglnybPFRNnky2TQETgj/gl9b0UPELLuNaJWbI/3bVAqw8dK3OMSDZqK0++TdeiV
         mMeQ==
X-Received: by 10.170.136.17 with SMTP id d17mr18067076ykc.127.1440975375051;
 Sun, 30 Aug 2015 15:56:15 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 15:56:14 -0700 (PDT)
In-Reply-To: <xmqq8u8sznyo.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: y-LvRLqTwboqrQxXxa5hwMopeEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276843>

On Sun, Aug 30, 2015 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> With the disclaimer that I wasn't following the quoting discussion
>> closely: Is this condition going to be sufficient for all cases, such
>> as an %(if:) atom? That is, if you have:
>>
>>     %(if:notempty)%(bloop)%(then) --option=%(bloop)%(end)
>>
>> isn't the intention that, %(bloop) within the %(then) section should
>> be quoted but not the literal "--option="?
>
> I think you'll see that the intention of the above is to quote the
> entirty of the result of %(if...)...%(end) if you read the previous
> discussion.  The "quoting" is used when you say you are making --format
> write a script in specified programming language, e.g.
>
>         for-each-ref --shell --format='
>                 a=%(atom) b=%(if...)...%(end)
>                 do interesting things using $a and $b here
>         ' | sh
>
> You are correct to point out in the earlier part of your message I
> am responding to that %(align) is not special and any nested thing
> including %(if) will uniformly trigger the same "usually each atom
> is quoted separately, but with this opening atom, everything up to
> the matching end atom is evaluated first and then the result is
> quoted" logic.

So, if I'm understanding correctly, the semantic behavior of the
current patch seems to be more or less correct, but the implementation
(and commit message) place perhaps too much emphasis on specializing
quoting suppression only for %(align:), whereas it could/should be
generalized?

I am a bit concerned about this code from end_atom_handler():

    /*
     * Whenever we have more than one stack element that means we
     * are using a certain modifier atom. In that case we need to
     * perform quote formatting.
     */
    if (state->stack->prev) {
        quote_formatting(&s, current->output.buf, state->quote_style);
        strbuf_reset(&current->output);
        strbuf_addbuf(&current->output, &s);
    }

Aren't both the comment and the condition backward? Shouldn't quoting
be done only for the top-most state on the stack rather than every
state other than the top-most? That is, shouldn't the condition be
`!state->stack->prev' as it is in append_atom()?
