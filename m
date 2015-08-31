From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 15:22:15 -0400
Message-ID: <CAPig+cTFQNcBEJ7QwsLjd1ncmxsG+uZFBkc_uyHzwBkU7a7hMQ@mail.gmail.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	<1440961839-40575-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
	<CANoM8SUoJAPBwEO=udhaR0WcUkZropEJ5G_SESnkHVtAQHxJQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUer-0005mE-KA
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbbHaTWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:22:17 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36843 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbbHaTWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:22:16 -0400
Received: by qkbp67 with SMTP id p67so12693896qkb.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Y+Gv7Qw410veGWJg/wMkrsrksSFTTp3UfqGgagmiWnQ=;
        b=Sfvq90lPv04uDfypOAZeuXPqkjPW//SBIQzmSljH+QU5uq9AmNsuoHCozqPQvgq16Q
         K1LYWouPVBkSmuEUzp3XzdSTEB+pMaZDRAM4fFgW035y9zjiZdUTIwcsAQ7t4+fObE9t
         nsmtPb9Lz4/PbNKGhXYS+55B+l5aXUMpjKv67rqIdm4hm0BSXkoICgUJwDfV8GjzfYKm
         L1velNSj1ZCcfZyqoCf8yeu7O1C3mx53Vao/eMqB3/tgt2tLEJzkAC6Al+n0RULCY5GI
         s8N4Ii30bhlaboWAKsddIsEHLxXXobtfUi8USO0bqUKXppAkteIFg3v83tCX7fWOajR+
         MWng==
X-Received: by 10.129.83.136 with SMTP id h130mr24300244ywb.95.1441048936045;
 Mon, 31 Aug 2015 12:22:16 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 12:22:15 -0700 (PDT)
In-Reply-To: <CANoM8SUoJAPBwEO=udhaR0WcUkZropEJ5G_SESnkHVtAQHxJQQ@mail.gmail.com>
X-Google-Sender-Auth: RINyxwHD1w2Eq32zXnxIpL5qNiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276921>

On Mon, Aug 31, 2015 at 2:57 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> On Mon, Aug 31, 2015 at 1:11 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Aug 30, 2015 at 3:10 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
>> Why does this iteration function specially filter out a bare main
>> worktree? If it instead unconditionally vends the main worktree (bare
>> or not), then the caller can make its own decision about what to do
>> with it, thus empowering the caller, rather than imposing a (possibly)
>> arbitrary restriction upon it.
>>
>> For instance, the "git worktree list" command may very well want to
>> show the main worktree, even if bare (possibly controlled by a
>> command-line option), annotated appropriately ("[bare]"). This may be
>> exactly the sort of information a user wants to know, and by leaving
>> the decision up to the caller, then the caller ("git worktree list" in
>> this example) has the opportunity to act accordingly, whereas if
>> for_each_worktree() filters out a bare main worktree unconditionally,
>> then the caller ("git worktree list") will never be able to offer such
>> an option.
>
> I wasn't sure that a bare repo would be considered a worktree.  I
> don't think that it would be
> a good idea to include it.  In the same vein that I can't checkout a
> branch in a bare repo, it
> figure that it shouldn't be in the list.

This is a mechanism vs. policy issue[1]. Low-level worker code, such
as this iteration function, should concern itself only with the
mechanics of retrieving and vending the worktree meta-data, and should
not make decisions (policy) about how that information is used by the
caller. Policy decisions (how the meta-data is used or displayed)
should be pushed to as high a level as possible, often up to the level
of user-interface (which is what "git worktree list" is).

[1]: http://www.catb.org/esr/writings/taoup/html/ch01s06.html#id2877777

>> Stepping back a bit, is a for-each-foo()-style interface desirable?
>> This sort of interface imposes a good deal of complexity on callers,
>> demanding a callback function and callback data (cb_data), and is
>> generally (at least in C) more difficult to reason about than other
>> simpler interfaces. Is such complexity warranted?
>>
>> An alternate, much simpler interface would be to have a function, say
>> get_worktrees(), return an array of 'worktree' structures to the
>> caller, which the caller would iterate over (which is a common
>> operation in C, thus easily reasoned about).
>>
>> The one benefit of a for-each-foo()-style interface is that it's
>> possible to "exit early", thus avoiding the cost of interrogating
>> meta-data for worktrees in which the caller is not interested,
>> however, it seems unlikely that there will be so many worktrees linked
>> to a repository for this early exit to translate into any real
>> savings.
>
> I am not opposed to making a simple function as you describe.  I think David was
> looking for a callback style function.  I don't think it would be
> terrible to keep the
> callback and then also include the simple function to return the
> struct array.  I like
> the memory management of the callback better than the struct array though.

We should stick with one or the other. Having both complicates the
code unnecessarily and increases maintenance costs. I, personally,
prefer the get_worktrees() approach for its client-side simplicity.
With a corresponding free_worktrees() to dispose of the resources
allocated by get_worktrees(), memory management shouldn't be much of a
burden for callers (other than having to remember to call it).

>> I may have missed some discussion in earlier rounds (or perhaps I'm
>> too simple-minded), but I'm confused about why this logic (and most of
>> the rest of the function) differs so much from existing logic in
>> branch.c:find_shared_symref() and find_linked_symref() for iterating
>> over the worktrees and gleaning information about them. That logic in
>> branch.c seems to do a pretty good job of reporting the worktree in
>> which a branch is already checked out, so it's not clear why the above
>> logic takes a different (and seemingly more complex) approach.
>
> This is due to my unfamiliarity of the code api.  I keep trying to
> look for the right
> functions to use, but I miss them.  Sorry.  I will rework using those functions.

The API is indeed large and complex, and it can be difficult to get a
handle on how to accomplish various tasks. That's also a good argument
for re-using the existing (proven) code in
branch.c:find_shared_symref() and find_linked_symref() rather than
re-inventing it from scratch. In its current form, the branch.c code
doesn't look much like a general-purpose iterator function, but it
should be possible to refactor if over the course of a few patches so
that it does satisfy that goal.

>>> +       if (!main_is_bare) {
>>> +               strbuf_addstr(&worktree_git, "/.git");
>>> +
>>> +               ret = fn(worktree_path.buf, worktree_git.buf, cb_data);
>>> +               if (ret)
>>> +                       goto done;
>>> +       }
>>> +       strbuf_addstr(&worktree_git, "/worktrees");
>>> +
>>> +       if (is_directory(worktree_git.buf)) {
>>
>> As mentioned in my v2 review[1], this is_directory() invocation
>> doesn't buy you anything. The following opendir() will either succeed
>> or fail anyhow, so checking beforehand if 'worktree_git' is a
>> directory is wasted work. If you eliminate is_directory(), you avoid
>> that unnecessary work (and the rest of the code can be less deeply
>> indented).
>
> For some reason, in my testing, calling opendir was giving a
> segmentation fault regardless of how I checked the return value.
> Including the is_directory check allowed me to avoid that.

Was it the opendir() that was crashing or the closedir()? Considering
that the closedir() incorrectly resides outside the `if (dir) {...}'
block, rather than inside, I could easily see the closedir() crashing
when called with NULL.
