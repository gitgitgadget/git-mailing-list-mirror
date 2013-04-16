From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Mon, 15 Apr 2013 19:34:07 -0700
Message-ID: <CA+sFfMdzTNjH10FKxhvJy+7hZg+0=1Wrqy9k8KaPoJg1DuDpmg@mail.gmail.com>
References: <20130415230651.GA16670@sigill.intra.peff.net>
	<20130415230802.GA11267@sigill.intra.peff.net>
	<CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
	<20130416004228.GA14995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 04:34:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URvio-00054o-2K
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 04:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935272Ab3DPCeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 22:34:09 -0400
Received: from mail-vb0-f44.google.com ([209.85.212.44]:45918 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935111Ab3DPCeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 22:34:08 -0400
Received: by mail-vb0-f44.google.com with SMTP id e12so15569vbg.31
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 19:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=FBefuYZL6sALKilqA7dujH110HKHbmAf2mUTtcbg3+g=;
        b=Xj9GVuvi5XgSOlxl1X7W2vBmZrszh1gcn0tIWhFEf7eHODV1xgnGe7cjZNZuyMLUcE
         al7iHs/cL5nf4BYo8BzT+dYpxNNoGQx1YERde9nWD30UAh2UEKaNBeSjV4L3+Hkcq852
         qH7K9zVh7vz1HbYi0rsNMwnaoSI2tM8dpAIo8UNsVL62z1ZdpN+6Hz8guPjkU+WUSTiJ
         NNMgs0lKLjQuJ0mR8CpplZwh39SGhgwmowVj/ZIc9gTX49OUmbnahj6oXPC6jhK6q0mh
         baTsgsbR50gPvRCm+lOWxUIL8DJnp2KLSWs4Jw4fxijjqKbmK95bgf8aNLAV0CSYjybp
         CDSA==
X-Received: by 10.52.32.230 with SMTP id m6mr173464vdi.83.1366079647210; Mon,
 15 Apr 2013 19:34:07 -0700 (PDT)
Received: by 10.58.50.74 with HTTP; Mon, 15 Apr 2013 19:34:07 -0700 (PDT)
In-Reply-To: <20130416004228.GA14995@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221346>

On Mon, Apr 15, 2013 at 5:42 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 15, 2013 at 05:11:36PM -0700, Brandon Casey wrote:
>
>> > +static void check_die_recursion(const char *fmt, va_list ap)
>> > +{
>> > +       static int dying;
>> > +
>> > +       if (!dying++)
>> > +               return;
>> > +
>> > +       vreportf("fatal: ", fmt, ap);
>>
>> How do you know it's safe to call vreportf() ?
>
> Because I hand-audited it.

:)

> But I think the more important question you
> are getting at is: how do I know that it will remain safe to call
> vreportf?

Right.

>> If the bug is in the vreportf code path, we will recurse infinitely
>> (at least until the stack is used up). An implementation of vsnprintf
>> exists in compat/snprintf.c for example.
>
> Right. My assumption was that we are primarily interested in protecting
> against the die_routine. Compat functions should never be calling die.

I think the rule we have been enforcing is less strict than that.  We
have only said that any compat function in a die handler path should
never call die.  But maybe that's what you meant.

> Of course that is assuming nobody violates that rule, which is part of
> the point of the check.
>
>> It's nice to print out the error message here, but I think doing so
>> defeats the purpose of this "dying" check.  Better to get the stack
>> trace from a core dump.
>
> Easier said than done, sometimes, if you are debugging somebody else's
> problem from a dump of a terminal session. :)
>
> But I can live with dropping this patch; my primary goal is the bug-fix
> in patch three.
>
> I was also tempted to suggest just dropping the recursion check
> altogether. While it is neat to detect such things, it's a "should never
> happen" bug situation, and an infinite loop of printing out the same
> message is pretty easy to notice. Do you remember what spurred the
> original check? The message in cd163d4 doesn't say.

That's a valid option.

The primary motivation was that Hannes Sixt had to step in and point
out yet again that the high-level memory allocators should not be
called in anything that could be in a die handler code path.  I was on
the thread, but I don't remember the topic (ah, Jonathan has stepped
in with the answer).  I do remember that I was not the only one who
had forgotten about that rule though.

We didn't actually have someone report that they encountered infinite
recursion, but it seemed easy enough to add a check for it, so...

Unfortunately, I didn't realize that the async functions installed
their own die handler which may not exit the process, allowing die to
be called multiple times.

To implement this check correctly/completely (i.e. detect recursion in
the main thread as well as in any child threads), I think you really
do need to use thread-local storage as you mentioned in 3/3 which
could look something like:

   static pthread_key_t dying;
   static pthread_once_t dying_once = PTHREAD_ONCE_INIT;

   void setup_die_counter(void)
   {
           pthread_key_create(&dying, NULL);
   }

   check_die_recursion(void)
   {
           pthread_once(&dying_once, setup_die_counter);
           if (pthread(getspecific(dying)) {
                   puts("BUG: recursion...");
                   exit(128);
           }

           pthread_setspecific(dying, &dying);
   }

or maybe the setup could be performed in set_die_routine(), but it
does kinda seem like overkill for a "nicety" like this.  So maybe
checking for recursion in just the main thread as this series does is
better than nothing.

-Brandon
