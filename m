From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Sat, 03 Oct 2015 10:01:15 -0700
Message-ID: <xmqqpp0v3mzo.fsf@gitster.mtv.corp.google.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-2-git-send-email-Karthik.188@gmail.com>
	<vpq8u7kb89o.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 03 19:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiQBV-0003F2-RZ
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 19:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbbJCRBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 13:01:18 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36154 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbJCRBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 13:01:17 -0400
Received: by pablk4 with SMTP id lk4so133995272pab.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=InGD/XO9Z2jMN8yqboQ4Q2QM0HO400qeCoukM+q6aNw=;
        b=ZKIspVxRdWViwGMCNuXKfQL9bg1cCWu0VNtbhVMR0T/o6zKMfDBT9SGpSFn7Hmwc7L
         YS3cFcZ7HgsmzyI8pYyVr/3QQoPx8Fey/rsTvGSPNaTKb082lL8kDqqoy5gX81z8qPAK
         6CauVqCvwwiEEBiEij33ZuUEJH4Qwc61oxR3cOnHg1GcE2YXPPd/7Wpc2MF3P2fxYE4V
         qY6NIp0sHiOsD3mJjY6BAZwdgaLrgy59kFn76DYphsTTedI4PH6EEz745gEEe7UJ8jw2
         qXEZwQ5sKUf2TklJkztklU6c9SSY++LRENFEZuuQJiCsQJTvSXz8gEs92U9GO+YyTfYy
         PtcA==
X-Received: by 10.68.135.136 with SMTP id ps8mr27789774pbb.123.1443891676867;
        Sat, 03 Oct 2015 10:01:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6403:45be:a5c3:ebf3])
        by smtp.gmail.com with ESMTPSA id ol3sm18352390pbb.49.2015.10.03.10.01.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Oct 2015 10:01:16 -0700 (PDT)
In-Reply-To: <vpq8u7kb89o.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Sat, 03 Oct 2015 11:39:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278976>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> My take on it:
>
> Implement %(if), %(then) and %(else) atoms. Used as
> %(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
> format string between %(if) and %(then) expands to an empty string, or
> to only whitespaces, then the string following %(then) is printed.
> Otherwise, the string following %(else), if any, is printed.
>
>> +When a scripting language specific quoting is in effect,
>
> This may not be immediately clear to the reader. I'd add explicitly:
>
> When a scripting language specific quoting is in effect (i.e. one of
> `--shell`, `--perl`, `--python`, `--tcl` is used), ...

I found all the suggestions very good, except that the distinction
between "expands to" and "is printed" bothers me a bit, as they want
to mean exactly the same thing (imagine this whole thing were inside
another %(if)...%(then)).

>>  EXAMPLES
>>  --------
>
> This is just the context of the patch, but I read it as a hint that we
> could add some examples with complex --format usage to illustrate the
> theory above.

Yes ;-)

>> +static int is_empty(const char * s){
>
> char * s -> char *s

Also "{" must sit alone on the next line.

>> +static void then_atom_handler(struct atom_value *atomv, struct
>> ref_formatting_state *state)
>> +{
>> +	struct ref_formatting_stack *cur = state->stack;
>> +	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
>> +
>> +	if (!if_then_else)
>> +		die(_("format: %%(then) atom used without an %%(if) atom"));
>
> You've just casted at_end_data to if_then_else. if_then_else being not
> NULL does not mean that it is properly typed. It can be the at_end_data
> of another opening atom. What happens if you use
> %(align)foo%(then)bar%(end)?
>
> One way to be safer would be to check that cur->at_end does point to
> if_then_else_handler.

Good eyes.  Thanks.

> So, while parsing the %(else)...%(end), the stack contains both the
> %(then)...%(else) part, and the %(else)...%(end).
>
> I'm wondering if we can simplify this. We already know if the condition
> is satisfied, and if it's not, we can just drop the %(then) part right
> now, and write to the top of the stack normally (the %(end) atom will
> only have to pop the string normally). But if the condition is not
> satisfied, we need to preserve the %(then) part and need to do something
> about the %(else).

Good suggestion.

Thanks.
