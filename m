From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu, 5 Apr 2012 20:19:42 -0400
Message-ID: <20120406001942.GA14224@sigill.intra.peff.net>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 02:19:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFwu6-00082m-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 02:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab2DFATq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 20:19:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49382
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344Ab2DFATp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 20:19:45 -0400
Received: (qmail 29114 invoked by uid 107); 6 Apr 2012 00:19:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 20:19:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 20:19:42 -0400
Content-Disposition: inline
In-Reply-To: <20120405232429.GA8654@hmsreliant.think-freely.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194824>

On Thu, Apr 05, 2012 at 07:24:29PM -0400, Neil Horman wrote:

> > > CC: Jeff King <peff@peff.net>
> > > CC: Phil Hord <phil.hord@gmail.com>
> > > CC: Junio C Hamano <gitster@pobox.com>
> > > ---
> > 
> > Please don't do "Cc:" here; they belong to your e-mail header.
> > 
> You mean place them below the snip line?  I can do that.

No, I think he means to drop them entirely; that information is already
in the list of people you have cc'd in the email.

> > > +int argv_array_pop(struct argv_array *array, unsigned int num)
> > > +{
> > > +	if (num > array->argc)
> > > +		return -1;
> > 
> > If your use case is "After using an argv_array for the first invocation,
> > truncate it while keeping the common ones that appear early, so that ones
> > that are specific to the second invocation can be pushed", it strikes me
> > somewhat odd why you would want to specify "how many to pop".
> > 
> Why?  It seems perfectly logical to me to be able to, as a convienience, specify
> how many items to pop, and the api call seems pleasantly symmetric to the
> push[f] calls.

I don't mind a "pop" call if there is a good use, but personally I find
your use case to be hard to read. Your patch 3/5 does this:

  /* make a partial argv */
  argv_array_init(&array);
  argv_array_push(&array, "commit");
  argv_array_push(&array, "-n");

  /* now do some speculative command */
  if (some_logic) {
          argv_array_push(&array, "--porcelain");
          if (run_command(array.argv)) {
              argv_array_clear(&array);
              return 0;
          }
          argv_array_pop(&array, 1);
  }

  /* and then possibly proceed to reuse part of the array */
  argv_array_push(&array, ...);
  argv_array_push(&array, ...);
  run_command(array.argv);

It saves you having to repeat "commit -n", but at the expense of making
the logic much harder to read. I think this is much easier to read:

  if (some_logic) {
          const char *argv[] = { "commit", "-n", "--porcelain", NULL };
          if (run_command(argv))
                  return 0;
  }

  argv_array_init(&array);
  argv_array_push(&array, "commit");
  argv_array_push(&array, "-n");
  argv_array_push(&array, /* other options */);
  run_command(array.argv);

You repeat "-n", but it is very clear what goes into the speculative
command and what goes into the final command (and there is no chance of
the "1" in your pop becoming stale and sending cruft to the real command).

That being said, I think Junio commented on 3/5 that "git commit
--porcelain" is not the right way of doing your speculative command
anyway, so the two commands would not end up sharing any argv anyway.

> > > +	for(num--; num>0; num--) {
> > 
> > Gaah.
> > 
> Eeek :).  If you want something else equally....equal here, please ask for it.
> I prefer for loops, but if you would rather have a while loop here, I'm fine
> with that.

I think he may have been responding to the style (lack of whitespace). I
also find a side-effecting initializer a little non-idiomatic. And
indeed, I think it causes a bug in this case. "num" is an unsigned int.
So what happens to the loop when num is 0 coming in?

I think a more traditional way of writing this would be:

  while (num--) {
          free((char **)array->argv[num);
          array->argv[num] = NULL;
  }

-Peff
