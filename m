From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv14 5/7] git submodule update: have a dedicated helper for
 cloning
Date: Fri, 19 Feb 2016 16:32:24 -0800
Message-ID: <20160220003224.GN28749@google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
 <1455905833-7449-6-git-send-email-sbeller@google.com>
 <20160219230740.GM28749@google.com>
 <CAGZ79kZjD_hRBFEVpj-80NpaYR2qRvnLbBb+9kR4x7MKoRX+UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 01:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWvTO-00040P-VY
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 01:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426791AbcBTAca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 19:32:30 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36810 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425394AbcBTAc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 19:32:29 -0500
Received: by mail-pf0-f170.google.com with SMTP id e127so59510041pfe.3
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 16:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4AFqxjT09PS55RdwtaN/SqFYvNqjCDLG+8l9u9AovdM=;
        b=AnzWWzuFyPP6knIJ0LT5wjtkLwRDDk6oEOtbzgQTzcMvmSqLW37nSdgiC05vLy1APO
         JFEykHGnRi0vv3yKG5J2rl+Kz/BaF2IsOY+OP7yK+qpMvgbMkmD+1j8m0T7Vw0O1mi9B
         QZgHKWHvRKmpTzVB4zPr4TXVxhKdNMDwToygZlxaBwonC01ZhJB3F+EmND/EYMJxTN9U
         AiIoNyGSTBX8RWQPCJrSwL0nij0DI1ZIFWm9vcST8uiuY8NY2S5Rueg1Z4UILQSzJi9X
         qjr84sFm6vRUETNvjBh3SEGDbp9oe1LAgUtDy4I/DCpXDJTjkX1T3L3Q8Dcvq3/vb577
         Bt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4AFqxjT09PS55RdwtaN/SqFYvNqjCDLG+8l9u9AovdM=;
        b=LK36meVROSxSvW4GGy+M8Qt7273XRWhYMpEpsjSep7uL5RdALFO81rGrKV3bwEijcR
         e+BMD5ik1WSwbu/E9ycpNFwjhrj4nG/Uqx4uZCB2pF2OY13ph9vj2B1Pzese7bEjYxV/
         FQsXMR4SIjaZOCYg0Bdu50QFzrDIgdTj3oy1NAsiPHUD+Lf9S/S8Ut/mnmOBgIyIGcnU
         3z440YZwI8NrR4My0lBjip6v7Cw3RuuAIBrNT1DoLAJ7bxHFTPXLeZg4NYzMA4kLQFy3
         +S/YAU0WMn0x0BVlDG9psKO4mbakaQKAzfALZZOvvqTO0kF2t/wA5SaeKrSrVmfh9Hvh
         Wf0w==
X-Gm-Message-State: AG10YOQI1lMynFR/1yNfygbCr+tSVVNLdDZfnhgDztKb85hSzd3c/rQCotOK6S4yWWjYug==
X-Received: by 10.98.93.211 with SMTP id n80mr22270723pfj.61.1455928348084;
        Fri, 19 Feb 2016 16:32:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c115:884b:f4c6:61dc])
        by smtp.gmail.com with ESMTPSA id qy7sm17388566pab.34.2016.02.19.16.32.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Feb 2016 16:32:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZjD_hRBFEVpj-80NpaYR2qRvnLbBb+9kR4x7MKoRX+UQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286763>

Stefan Beller wrote:
> On Fri, Feb 19, 2016 at 3:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

[...]
>>> +             strbuf_addf(err, "Skipping submodule '%s'\n",
>>> +                         displaypath);
>>
>> Does the caller expect a newline at the end of err?
>>
>> In the refs code that uses an err strbuf, the convention is to
>> not end the message with a newline.  That way, a function like
>> die() can insert a newline and messages are guaranteed to be
>> newline-terminated even if someone is sloppy and does the wrong thing
>> when generating an error.
>
> Oh! So we need to add new lines ourselves here.

Now I'm confused.  The code in this patch is inconsistent.  I was
recommending consistently leaving out the \n.

It looks like pp_start_one takes the content of err without adding
a \n.  That's a bug in pp_start_one and pp_collect_finished IMHO.

For example, default_task_finished and default_start_failure don't
put a newline don't put a newline at the end of the message.  I
don't think that's a bug --- they're doing the right thing, but
pp_start_one and pp_collect_finished is just not handling it
correctly.

>>> +             if (pp->reference)
>>> +                     argv_array_push(&cp->args, pp->reference);
>>> +             if (pp->depth)
>>> +                     argv_array_push(&cp->args, pp->depth);
>>
>> What does 'cp' stand for mean?  Would a name like 'child' work?
>
> child process ? (any code which had a struct child_process referred to
> it as *cp)

Output from 'git grep --F -e "child_process *"' finds variables with
various names, corresponding to what kind of child it is.

[...]
>> Is this the 'list' subcommand?
>
> no. :(

No problem --- that's what review is for.

[...]
>>> +     if (pp.print_unmatched) {
>>> +             printf("#unmatched\n");
>>
>> I'm still confused about this.  I think a comment where
>> 'print_unmatched' is declared would probably clear it up.
>
> Probably this is a too literal translation from shell to C.
> By printing #unmatched the shell on the other end of the pipe
> of this helper program knows to just stop and error out.
>
> So this is telling the downstream program to stop.
>
> Maybe we can name the variable 'quickstop' ?
> 'abort_and_exit' ?

Interesting.

Would it work for the helper to exit at that point with nonzero status?

Lacking "set -o pipefail", it's a little messy to handle in the shell,
but it's possible:

	{
		git submodule--helper \
			--foo \
			--bar \
			--baz ||
		... handle error, e.g. by printing something
		that the other end of the pipe wants to see ...
	} |
	...

[...]
>> (just curious) why are these saved up and printed all at once instead
>> of being printed as it goes?
>
> To have a clean abort path, i.e. we need to be done with all the parallel stuff
> before we start on doing local on-disk stuff.

Interesting.

That's subtle.  Probably worth a comment so people know not to break
it.  (E.g.

	/*
	 * We saved the output and splat it all at once now.
	 * That means:
	 * - the listener does not have to interleave their (checkout)
	 *   work with our fetching.  The writes involved in a
	 *   checkout involve more straightforward sequential I/O.
	 * - the listener can avoid doing any work if fetching failed.
	 */

).

Thinking out loud: the other side could write their output to a
temporary file (e.g.  under .git) and save us the trouble of buffering
it.  But the list of submodules and statuses is not likely to be huge
--- buffering doesn't hurt much.

[...]
> In a next step, we can do the checkout in parallel if there is nothing to assume
> to lead to trouble. i.e. update strategy is checkout and the submodule is
> in a clean state at the tip of a branch.

Somebody tried parallelizing file output during checkout and found it
sped up the checkout on some systems by a small amount.  But then
later operations to read back the files were much slower.  It seems
that the output pattern affected the layout of the files on disk in a
bad way.

I'm not too afraid.  Just saying that the benefit of parallel checkout
would be something to measure.

A bigger worry is that checkout might be I/O bound and not benefit
much from parallelism.

> All problems which need to be solved by the user should be presented in
> a sequential way, i.e. present one problem and then full stop.
> That seems to be more encouraging as if we'd throw a "Here are a dozen
> broken submodule repositories which we expect the user fixes up".

It depends on the problem --- sometimes people want to see a list of
errors and fix them all (hence tools like "make -k").  I agree that
stop-on-first-error is a good default and that it's not worth worrying
about introducing --keep-going until someone asks for it.

Thanks for your thoughtfulness,
Jonathan
