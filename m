From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Mon, 17 Aug 2015 11:39:35 -0700
Message-ID: <xmqqa8tpep3s.fsf@gitster.dls.corp.google.com>
References: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
	<CAPig+cR=gCBiEnZbnPfZZs0WmjBsQyL+2BjSHggWWp_43rC9cg@mail.gmail.com>
	<CAOLa=ZRfA-8_w6VKgWQsoL7TrdyjEq5LTHwas=_04tmx9MWhqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:39:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPJv-0006j4-Uy
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbbHQSjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:39:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35496 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbHQSji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:39:38 -0400
Received: by pacgr6 with SMTP id gr6so113858855pac.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=M5yYefOWfe7tXvwATeDQJGrehLMVtw/MeZAhfNvt2Vo=;
        b=NUFxkphctyLHBPhapYqBwufMAo91dAIqMyp3ceA9qFAsWeMo192LIM8g6XvCBEyyHE
         W/uVP4M1XhW9AgwbQgknF02QDQvWWI/Cisku75oNYiLLee7PwGODwgFydcBMkBB0g+SQ
         EbuDNusZpJFLONmbX0OwhLpO84kZAAZRvjO/dzVfvCbp0C+pVB3VFXNzjbtO/GGRywO+
         aeKfLCtLab+lft+Ibe1zB5799WNxmcLFKZHDr8uuha6VIf5pTImHF+qO9o42keyDZi7o
         uEYmJXcbgMxFaVzJzanqZciZAwg9yfuefqV3zSZF4A0uKkwsIe5PV0AAcf8vOvn+az8S
         Yyqw==
X-Received: by 10.68.112.194 with SMTP id is2mr5203363pbb.61.1439836777670;
        Mon, 17 Aug 2015 11:39:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id a2sm15416329pbu.41.2015.08.17.11.39.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 11:39:36 -0700 (PDT)
In-Reply-To: <CAOLa=ZRfA-8_w6VKgWQsoL7TrdyjEq5LTHwas=_04tmx9MWhqA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 17 Aug 2015 19:58:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276070>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Aug 17, 2015 at 7:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> ...
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

I'd imagine the implementation of these to be along the lines of
(thinking aloud):

 - "%(if:[nonempty|empty|...])" pushes a new stack, and sets its
   attend/at_end/end_scope function to signal a syntax error.  It
   also records what condition (e.g. "nonempty") to use in the new
   stack.

 - "%(then)" inspects the top-of-stack output and uses the condition
   recorded by the %(if) that created the stack to decide true or
   false.  The stack element pushed by %(if) is then removed.
   Notice that the end_scope function prepared by %(if) is never
   called.

   Then (no pun intended):

   - If true, that means we would want the (expansion of) text up to
     "%(end)" or "%(else)", whichever comes first, appended to the
     surrounding output.  Push a new stack and set its end_scope
     function to the one that appends the top-of-stack output to the
     surrounding output, expecting %(end) will follow without
     %(else).

   - If false, that means we would want the (expansion of) text up
     to "%(end)" or "%(else)", whichever comes first, discarded.
     Push a new stack and set its end_scope function to the one that
     discards the top-of-stack output, expecting %(end) will follow
     without %(else).

 - "%(else)" inspects the top of the stack, and if it is not left by
   "%(then)", signal a syntax error.

   Else (no pun intended), it runs the end_scope function left by
   "%(then)" on the top-of-stack output (e.g. if "%(then)" found
   that the condition holds true, the accumulated output at this
   point should be appended to the surrounding output, and it was
   expected to be done by "%(end)" if this "%(else)" weren't
   present.  We do it here before waiting for "%(end)").

   Truncate the top-of-stack output, flip the end_scope function to
   the one opposite from the one left by "%(then)".  And let "%(end)"
   take care of it.

 - "%(end)" just unconditionally runs the end_scope function on the
   top of the stack output.

Eric's suggestion is let the caller of the end_scope function to
always append the output of the top-of-stack, and I think it makes
sense.  It makes a common "%(atom)" implementation simpler.  Things
like %(then) and %(else) above need to make sure that they reset the
top-of-stack output to empty as necessary, but that is not such a
huge implementation burden---their operation is already unusual and
needs to be more complex than the plain-vanilla %(atom)s anyway.
