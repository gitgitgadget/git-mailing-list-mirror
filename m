From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Tue, 18 Aug 2015 00:42:27 +0530
Message-ID: <CAOLa=ZQqE4xF_NDahy5T+d5B0k0yNPFjY=qrmLoi3URekZ+QmA@mail.gmail.com>
References: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
 <CAPig+cR=gCBiEnZbnPfZZs0WmjBsQyL+2BjSHggWWp_43rC9cg@mail.gmail.com>
 <CAOLa=ZRfA-8_w6VKgWQsoL7TrdyjEq5LTHwas=_04tmx9MWhqA@mail.gmail.com> <xmqqa8tpep3s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPqE-0006eK-OK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbbHQTM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:12:59 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33405 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbHQTM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:12:57 -0400
Received: by obbhe7 with SMTP id he7so121105934obb.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c0tnuDdObx26r1mxnJiJpQKvNHibZv01WuTza+93aDo=;
        b=ipE33pWHX5vsgcUhn0eyTrlh2pKoYpJRuPvczAeypkOAQraz7MJ0BVqVXSV7IQazp/
         0cZ8Nooi8rQJG3xxLJ8tkN1V+vNlOYRSlSr8emGhL4O2RlhSGCIck3ywmsTbIGYHkaBw
         z1/1adHIy94zZhMpOFW5a4U53w7VOWT5rxPaxO2bwSpV5BZ+vFzPXvSR+FwYhbwO0dyn
         xtj6owJc0GMiBDnZPo359/q+QoycaKhwCDfUC/DeSAunxys+k65+nBx5es1ruS4J7KT9
         8rAqhiObM0ADEmMep0Vy7ff1MQADCbAw+pVYOhIo3yhZ2H5aUOzCJ7ddyutNIEBAc0v3
         Ne2A==
X-Received: by 10.182.29.68 with SMTP id i4mr2431696obh.57.1439838776568; Mon,
 17 Aug 2015 12:12:56 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 17 Aug 2015 12:12:27 -0700 (PDT)
In-Reply-To: <xmqqa8tpep3s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276077>

On Mon, Aug 17, 2015 at 11:52 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 17, 2015 at 10:28 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Mon, Aug 17, 2015 at 7:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> +{
>>>> +       struct strbuf aligned = STRBUF_INIT;
>>>> +       struct ref_formatting_state *return_to = state->prev;
>>>> +       struct align *align = (struct align *)state->cb_data;
>>>> +
>>>> +       strbuf_utf8_align(&aligned, align->position, align->width, state->output.buf);
>>>> +       strbuf_addbuf(&return_to->output, &aligned);
>>>
>>> Second, I realize that Junio suggested the 'return_to' idea, but it
>>> seems like it could become overly painful since each handler of this
>>> sort is going to have to perform the same manipulation to append its
>>> collected output to its parent state's output. What if you instead
>>> make it the responsibility of pop_state() to append the 'output' from
>>> the state being popped to the "prev" state's 'output'? This way, it
>>> happens automatically, thus reducing code in each individual handler,
>>> and reducing the burden of having to keep writing the same code.
>>
>> Good question, what if we don't want to append to strbuf at all?
>> For e.g., We were discussing an "%(if).....%(then)......%(end)"
>> atom structure, here if the if condition isn't met we wouldn't want to
>> append to the prev strbuf, hence I thought it's better if the handler
>> decided whether or not to append to prev strbuf.
>
> An %(if)/%(then)/%(end) construct should not present a problem. As
> long as the processing of the conditional ensures that the current
> state's 'output' contains no content, when pop_state() appends that
> (empty) content to the parent state's 'output', then the net result is
> exactly the desired behavior.
>
> The question of "how" the conditional processing ensures that the
> current state's 'output' is empty when the %(if) condition is false is
> unimportant (for this discussion). It might be the case that it just
> doesn't collect any content at all for a false condition, or it
> collects it but throws it away before the state is popped. Either way,
> that's an implementation detail which needn't impact the decision to
> retire 'return_to' and instead make pop_state() responsible for
> appending the current state's output to the parent state's.

I guess what you're saying also makes sense. We could make it common
for pop to push the strbuf into the prev state.

On Tue, Aug 18, 2015 at 12:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Aug 17, 2015 at 7:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> ...
>>> Second, I realize that Junio suggested the 'return_to' idea, but it
>>> seems like it could become overly painful since each handler of this
>>> sort is going to have to perform the same manipulation to append its
>>> collected output to its parent state's output. What if you instead
>>> make it the responsibility of pop_state() to append the 'output' from
>>> the state being popped to the "prev" state's 'output'? This way, it
>>> happens automatically, thus reducing code in each individual handler,
>>> and reducing the burden of having to keep writing the same code.
>>
>> Good question, what if we don't want to append to strbuf at all?
>> For e.g., We were discussing an "%(if).....%(then)......%(end)"
>> atom structure, here if the if condition isn't met we wouldn't want to
>> append to the prev strbuf, hence I thought it's better if the handler
>> decided whether or not to append to prev strbuf.
>
> I'd imagine the implementation of these to be along the lines of
> (thinking aloud):
>
>  - "%(if:[nonempty|empty|...])" pushes a new stack, and sets its
>    attend/at_end/end_scope function to signal a syntax error.  It
>    also records what condition (e.g. "nonempty") to use in the new
>    stack.
>
>  - "%(then)" inspects the top-of-stack output and uses the condition
>    recorded by the %(if) that created the stack to decide true or
>    false.  The stack element pushed by %(if) is then removed.
>    Notice that the end_scope function prepared by %(if) is never
>    called.
>
>    Then (no pun intended):
>
>    - If true, that means we would want the (expansion of) text up to
>      "%(end)" or "%(else)", whichever comes first, appended to the
>      surrounding output.  Push a new stack and set its end_scope
>      function to the one that appends the top-of-stack output to the
>      surrounding output, expecting %(end) will follow without
>      %(else).
>
>    - If false, that means we would want the (expansion of) text up
>      to "%(end)" or "%(else)", whichever comes first, discarded.
>      Push a new stack and set its end_scope function to the one that
>      discards the top-of-stack output, expecting %(end) will follow
>      without %(else).
>
>  - "%(else)" inspects the top of the stack, and if it is not left by
>    "%(then)", signal a syntax error.
>
>    Else (no pun intended), it runs the end_scope function left by
>    "%(then)" on the top-of-stack output (e.g. if "%(then)" found
>    that the condition holds true, the accumulated output at this
>    point should be appended to the surrounding output, and it was
>    expected to be done by "%(end)" if this "%(else)" weren't
>    present.  We do it here before waiting for "%(end)").
>
>    Truncate the top-of-stack output, flip the end_scope function to
>    the one opposite from the one left by "%(then)".  And let "%(end)"
>    take care of it.
>
>  - "%(end)" just unconditionally runs the end_scope function on the
>    top of the stack output.
>

That seems like the way to go, thanks for summing it up. Will follow this
when implementing the %(if) %(then) %(else) %(end) atom series.

> Eric's suggestion is let the caller of the end_scope function to
> always append the output of the top-of-stack, and I think it makes
> sense.  It makes a common "%(atom)" implementation simpler.  Things
> like %(then) and %(else) above need to make sure that they reset the
> top-of-stack output to empty as necessary, but that is not such a
> huge implementation burden---their operation is already unusual and
> needs to be more complex than the plain-vanilla %(atom)s anyway.

Yea, I get why you're suggesting it too, It'd remove that extra work each
handler has to do and make sure is done. By moving it to pop_state()
we don't have to leave it to the handler to be taken care of.

-- 
Regards,
Karthik Nayak
