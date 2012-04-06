From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu, 5 Apr 2012 21:12:52 -0400
Message-ID: <20120406011252.GA7204@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
 <20120406001942.GA14224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Phil Hord <phil.hord@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 03:13:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFxji-00045O-NL
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 03:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757045Ab2DFBND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 21:13:03 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:60392 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039Ab2DFBNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 21:13:02 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SFxjS-000718-7r; Thu, 05 Apr 2012 21:12:56 -0400
Content-Disposition: inline
In-Reply-To: <20120406001942.GA14224@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194831>

On Thu, Apr 05, 2012 at 08:19:42PM -0400, Jeff King wrote:
> On Thu, Apr 05, 2012 at 07:24:29PM -0400, Neil Horman wrote:
> 
> > > > CC: Jeff King <peff@peff.net>
> > > > CC: Phil Hord <phil.hord@gmail.com>
> > > > CC: Junio C Hamano <gitster@pobox.com>
> > > > ---
> > > 
> > > Please don't do "Cc:" here; they belong to your e-mail header.
> > > 
> > You mean place them below the snip line?  I can do that.
> 
> No, I think he means to drop them entirely; that information is already
> in the list of people you have cc'd in the email.
> 
No, its not, thats what I'm saying.  git send-email parses the above information
to build the CC list.  I can take it out and add the cc's to the command line of
git-send-email, but if parsing the above info is incorrect, that seems like a
bug that needs fixing, one which will get resistance, because its the standard
way alot of other lists use the CC: tag.

> > > > +int argv_array_pop(struct argv_array *array, unsigned int num)
> > > > +{
> > > > +	if (num > array->argc)
> > > > +		return -1;
> > > 
> > > If your use case is "After using an argv_array for the first invocation,
> > > truncate it while keeping the common ones that appear early, so that ones
> > > that are specific to the second invocation can be pushed", it strikes me
> > > somewhat odd why you would want to specify "how many to pop".
> > > 
> > Why?  It seems perfectly logical to me to be able to, as a convienience, specify
> > how many items to pop, and the api call seems pleasantly symmetric to the
> > push[f] calls.
> 
> I don't mind a "pop" call if there is a good use, but personally I find
> your use case to be hard to read. Your patch 3/5 does this:
> 
>   /* make a partial argv */
>   argv_array_init(&array);
>   argv_array_push(&array, "commit");
>   argv_array_push(&array, "-n");
> 
>   /* now do some speculative command */
>   if (some_logic) {
>           argv_array_push(&array, "--porcelain");
>           if (run_command(array.argv)) {
>               argv_array_clear(&array);
>               return 0;
>           }
>           argv_array_pop(&array, 1);
>   }
> 
>   /* and then possibly proceed to reuse part of the array */
>   argv_array_push(&array, ...);
>   argv_array_push(&array, ...);
>   run_command(array.argv);
> 
> It saves you having to repeat "commit -n", but at the expense of making
> the logic much harder to read. I think this is much easier to read:
> 
>   if (some_logic) {
>           const char *argv[] = { "commit", "-n", "--porcelain", NULL };
>           if (run_command(argv))
>                   return 0;
>   }
> 
>   argv_array_init(&array);
>   argv_array_push(&array, "commit");
>   argv_array_push(&array, "-n");
>   argv_array_push(&array, /* other options */);
>   run_command(array.argv);
> 
> You repeat "-n", but it is very clear what goes into the speculative
> command and what goes into the final command (and there is no chance of
> the "1" in your pop becoming stale and sending cruft to the real command).
> 
Ok, I can see the use of the argv array above being more readable, but (I think
your) comment from the first iteration of this patch, suggested re-doing this
logic to use struct argv_array.  I do like the above better.  I'll redo that.
 
> That being said, I think Junio commented on 3/5 that "git commit
> --porcelain" is not the right way of doing your speculative command
> anyway, so the two commands would not end up sharing any argv anyway.
>
I'm still not completely convinced about that, given that commit --porcelain
effectively does a git diff-index, but I'll defer to the experts on that,
diff-index works just as well for this.  And if I use your above static array
implementation instead, I can get rid of the pop api addition entirely.
 
> > > > +	for(num--; num>0; num--) {
> > > 
> > > Gaah.
> > > 
> > Eeek :).  If you want something else equally....equal here, please ask for it.
> > I prefer for loops, but if you would rather have a while loop here, I'm fine
> > with that.
> 
> I think he may have been responding to the style (lack of whitespace). I
That was really my problem with it.  I appreciate the direct comment.  A note
about lack of whitespace is something I can work with, Gaah is not :)

> also find a side-effecting initializer a little non-idiomatic. And
> indeed, I think it causes a bug in this case. "num" is an unsigned int.
> So what happens to the loop when num is 0 coming in?
> 
That should be caught by the case checking logic at the top of the function.
Although I think you're right, the 1 case I think has an OBO error.  Its moot
anyway, if I use your static array approach above, I'll remove all of this.

> I think a more traditional way of writing this would be:
> 
>   while (num--) {
>           free((char **)array->argv[num);
>           array->argv[num] = NULL;
>   }
> 
Thats certainly another way to do it, and I'm happy to do that if its the
consensus.  I just happen to prefer for loops (for no particular reason, its
just me).  But again, using your approach above, this will all get removed.

Thanks for the review.  I'll fix this up, and have a new version in a few days.


Best
Neil
> -Peff
> 
