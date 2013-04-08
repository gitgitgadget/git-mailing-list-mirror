From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 8 Apr 2013 09:38:28 -0500
Message-ID: <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
	<1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
	<20130408005155.GA24030@sigill.intra.peff.net>
	<CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
	<20130408023351.GA32558@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:33:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEzp-0003oz-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016Ab3DHOib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 10:38:31 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:61975 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964984Ab3DHOia (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 10:38:30 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so2341459lab.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1IFj0v8Fzf8cMejZO8KzjlLnoqYj4+Njo9dSprftNTc=;
        b=1BERba3GiiHBKmcSycHBSKi5GDsnjQ97cc2csM/I79/IyI0o/5JIZDE5qc5X5mPb7M
         F3kiBC6cyiigvINhxSW2ngVCjJrRaasR+YivXUhw9exVZDVf6sNfWFp9Lg3xPYycWKSm
         OH5wMsJOUtxNMnbd7bjLdPjX6clXVXexgjRzUncUkjAC55+mhuUvoKKG9KYGTnHcfRtv
         /mqPqcUiTZKlSQ62lDKXH4cvLtslBisfpDCCy13beHeicQ48JLwG+9pJeQmG5cgS7boB
         1/I3DkGsf0H0K0+YO8Sm3HQm9j2jhla6opgbSh2V4llbCiVx7fR8g6HiMMxYIr+tctSy
         SB5Q==
X-Received: by 10.112.145.8 with SMTP id sq8mr11724274lbb.55.1365431908386;
 Mon, 08 Apr 2013 07:38:28 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 8 Apr 2013 07:38:28 -0700 (PDT)
In-Reply-To: <20130408023351.GA32558@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220426>

On Sun, Apr 7, 2013 at 9:33 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 07, 2013 at 09:03:25PM -0500, Felipe Contreras wrote:

>> And you think that is desirable? User-friendly?
>
> No, as you probably realized if you read the rest of my email. My point
> in bringing it up was to try to explain exactly what is going on in each
> case. Your commit message provided zero explanation of what the current
> problem is, nor why your fix is the right thing to do.

I have explained this many times, I wonder why when the patch is close
to be merged does this become important, and not before.

>> That's a comprehensive essay, unfortunately, it's not correct. The
>> exit status of the remote-helper is not important, it's the one of
>> fast-import that we really care about.
>
> Nowhere does it say that we should not check fast-import's exit value,
> and indeed, the patch does not replace that check at all. It comes
> immediately after. It replaces the WNOHANG check of the helper's exit
> code (i.e., check_command) with a synchronous check.

Yeah, and in the process it's changing the design of transport-helper,
where the pipes are closed only at the very end.

> The argument that the exit status of remote-helper is not important
> would mean your series is pointless, too, no?

The main point of my patch was not to add a check for import, but for
export. Adding such a check here is not important, but it doesn't hurt
either, as it would improve the situation if the remote-helper is not
using the "done" feature, which at the moment is a possibility.

>> > +       if (disconnect_helper(transport) != 0)
>> >                 die("Error while running helper");
>>
>> Yeah, that's good, *if* the remote-helper is implemented correctly,
>> but try this:
>>
>>                if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
>>                then
>>                        exit 0
>>                fi
>
> I don't see your point. If a helper reports success when it has failed,
> and doesn't feed anything to fast-import, we can do nothing. That case
> is indistinguishable from a helper which has nothing to fetch from the
> remote, and exits. My patch doesn't help with such a broken helper, but
> neither does yours, because they check the exact same thing.

No, my code checks that the remote-helper is *still running*, you code
doesn't. And after all, that is the design of transport-helper.

>> >         argv_array_free_detached(fastimport.argv);
>> >
>> > which passes both your original test and the more strict one above. Of
>> > course adding a done-import capability would be nice to fix the protocol
>> > deficiency, but it is more code.
>>
>> The done-import capability *is already there*. The remote helper fails
>> to say "done", fast-import detects that there was a problem and exits
>> with -1 (or whatever), but it doesn't matter, because we
>> (transport-helper) are oblivious of that return status until it's too
>> late.
>
> Wait, then why is this a problem at all? We check the exit code of
> fast-import right before the code in question.

It's not, *If* the remote-helper is using "done", and a small one if it's not.

>> Yeah, I already explored this option, and I said it was possible on
>> pushing, but now the problem is fetching.
>>
>> http://article.gmane.org/gmane.comp.version-control.git/219760
>>
>> And to be frank, I'm tired of this. I keep repeating the same things
>> over and over, when I ask for input on different ways to achieve this
>> I get nothing, and when the patch is getting closer to be merged, then
>> I receive criticism, only so I can repeat the same again.
>
> I don't even know what to say to this. I reviewed your original patch,
> raised some concerns. You responded. I had not yet responded back,
> because I have many other things to work on. In the meantime you
> submitted another round. Now I have the opportunity to respond and did
> so, having read both threads.

I sent the first version of this patch series on October of last year.

> Why is your patch to recvline so much more complicated than my
> one-liner? Why do you go to lengths to pass out an error code from it
> just so that we can end up dying anyway?

Because I think dying inside a generic function is bad design. I think
the error should be returned, and let the caller decide what to do
with it. In the current version of the code we seem to receive lines
only from the remote-helper, so I guess your patch is fine and works.
But I still think the current code is not good.

> Why do you need a done
> capability for push when the blank line already signals the end of the
> status?

I suppose we don't.

> I did not respond to 219760 separately because those are all questions
> that _don't matter_ if you follow the analysis in my last email that
> lead to my one-liner. Maybe there are interesting answers to those
> questions, and my one-liner isn't sufficient. But I'll never know
> because instead of pointing them out, you are complaining that I didn't
> respond fast enough.

That's not what I said. My complaint is why _now_, and not six months ago.

>> If this current patch series is not good enough, I think it's best to
>> leave things as they are for me.
>
> That's certainly your choice. It just seems like we can be more robust
> while adding less code, as I tried to show.

After reading back all the mails and checking all the different
situations, I think my main problem was that my test was not for the
right thing. The test for import should be using the 'done' feature,
and we should mostly ignore the rest.

While my patch does improve the situation when the remote-helper is
not using the 'done' feature, it's probably not worth the effort, and
we might want to enforce the remote helpers to implement this somehow.

In the meantime, your patch should probably deal with all the real
world situations, so I've updated the tests and I'll resend.

Cheers.

--
Felipe Contreras
