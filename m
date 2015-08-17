From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Mon, 17 Aug 2015 14:22:16 -0400
Message-ID: <CAPig+cQiPKv15dGFskwxwoJceYevnNy9j-6oW7A3UySadOdBBw@mail.gmail.com>
References: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
	<CAPig+cR=gCBiEnZbnPfZZs0WmjBsQyL+2BjSHggWWp_43rC9cg@mail.gmail.com>
	<CAOLa=ZRfA-8_w6VKgWQsoL7TrdyjEq5LTHwas=_04tmx9MWhqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:22:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRP3D-00077i-HM
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbbHQSWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:22:19 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34459 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbbHQSWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:22:17 -0400
Received: by iodb91 with SMTP id b91so160854010iod.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vmxhXO555+6MnWYLb6sNXv8pNaS7PNzFITHeefncxjw=;
        b=pWnvAA6ucGFBqkHXdBSGC7sb3LG58XMa6fjaCsEHA0gZr/jxXANfgGuEFHlvwD2enY
         3ig59AqfJKQJC8pL3iwo9K+pxtGWMX9f+nStCOY5K15tV5zUv/yPxl8O/7sPnS7B56hz
         4c/wYE/Dd2RoruW+WX9nPVBn277QPZ1DIvuAPZSKy4m5pYVsznHRYOFR8nY4o52PBNwU
         MSZQGrH0wj/EVUVBE2WBjs3MuE8BAOPO7Eoyh307cryFTzl/6OfkGKeAmhu3ZsRrxjPt
         DDuRSEPFvM/PPChTVirIu0z5FT6pDIxZRB2UzgZnp1hik82iF8R+0aapzj4z0z6xQVGl
         qjFw==
X-Received: by 10.107.152.81 with SMTP id a78mr2755754ioe.145.1439835736670;
 Mon, 17 Aug 2015 11:22:16 -0700 (PDT)
Received: by 10.79.79.12 with HTTP; Mon, 17 Aug 2015 11:22:16 -0700 (PDT)
In-Reply-To: <CAOLa=ZRfA-8_w6VKgWQsoL7TrdyjEq5LTHwas=_04tmx9MWhqA@mail.gmail.com>
X-Google-Sender-Auth: FZrOPSWiD6uzvBq7n-TXQLpzzJI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276065>

On Mon, Aug 17, 2015 at 10:28 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Mon, Aug 17, 2015 at 7:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> +{
>>> +       struct strbuf aligned = STRBUF_INIT;
>>> +       struct ref_formatting_state *return_to = state->prev;
>>> +       struct align *align = (struct align *)state->cb_data;
>>> +
>>> +       strbuf_utf8_align(&aligned, align->position, align->width, state->output.buf);
>>> +       strbuf_addbuf(&return_to->output, &aligned);
>>
>> Second, I realize that Junio suggested the 'return_to' idea, but it
>> seems like it could become overly painful since each handler of this
>> sort is going to have to perform the same manipulation to append its
>> collected output to its parent state's output. What if you instead
>> make it the responsibility of pop_state() to append the 'output' from
>> the state being popped to the "prev" state's 'output'? This way, it
>> happens automatically, thus reducing code in each individual handler,
>> and reducing the burden of having to keep writing the same code.
>
> Good question, what if we don't want to append to strbuf at all?
> For e.g., We were discussing an "%(if).....%(then)......%(end)"
> atom structure, here if the if condition isn't met we wouldn't want to
> append to the prev strbuf, hence I thought it's better if the handler
> decided whether or not to append to prev strbuf.

An %(if)/%(then)/%(end) construct should not present a problem. As
long as the processing of the conditional ensures that the current
state's 'output' contains no content, when pop_state() appends that
(empty) content to the parent state's 'output', then the net result is
exactly the desired behavior.

The question of "how" the conditional processing ensures that the
current state's 'output' is empty when the %(if) condition is false is
unimportant (for this discussion). It might be the case that it just
doesn't collect any content at all for a false condition, or it
collects it but throws it away before the state is popped. Either way,
that's an implementation detail which needn't impact the decision to
retire 'return_to' and instead make pop_state() responsible for
appending the current state's output to the parent state's.
