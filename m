From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 2/3] git-daemon: make the signal handler almost a no-op
Date: Thu, 14 Aug 2008 09:47:17 +0200
Message-ID: <20080814074717.GC9680@cuci.nl>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl> <20080813084331.30845.74788.stgit@aristoteles.cuci.nl> <7v1w0sjw47.fsf@gitster.siamese.dyndns.org> <20080814001858.GB14939@cuci.nl> <7v63q4ieqw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 09:48:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTXZH-0004oT-Au
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 09:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbYHNHrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 03:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYHNHrT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 03:47:19 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:51567 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbYHNHrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 03:47:19 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id F388E5465; Thu, 14 Aug 2008 09:47:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v63q4ieqw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92332>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>>>> -	signal(SIGCHLD, SIG_DFL);
>>>> +	child_handler(0);

>>>After all, we might even want to do something like:

>>>	static void child_handler(int signo)
>>>        {
>>>        	if (USE_SYSV_SIGNAL_SEMANTICS)
>>>                	signal(SIGCHLD, child_handler);

>> In return I ask: why?

>I agree it would be very meaningless change as an optimization, but I am
>concerned more about robustness and what makes sense.

Well, even if robustness and "the principle of least surprise" are
the prime concerns, my change could still be considered worthwhile, but
it depends on your viewpoint.

>Do you agree that "child_handler()" is a signal handler to handle SIGCHLD,
>and such a signal handler conceptually consists of two parts? i.e.

Yes.

>	static void child_handler()
>        {
>        	reap_dead_children();
>                rearm_signal_as_needed();

>Your argument is it is Ok to call this function when you are arming the
>signal for the first time, because reap_dead_children() happens to be
>empty, and your rearm_signal_as_needed() happens to be the same as
>arm_signal_always().

Well, not quite, that is part of the argument, the other parts are
implicit.

>Yes, it happens to be _Ok_ now.  But is it an improvement in the longer
>term?  I do not think so.

>I do not see why you think it is better to rely on these two assumptions
>than being explicit and say "we set up the signal for the first time
>always on any platform", especially when the latter is much more direct
>way to say what your intention is.

Renaming the function could do it.

>  Or are you gaining something by not
>explicitly calling signal() for the first time?  I may be missing some
>benefit for doing so.

Well, strictly speaking the benefits you're overlooking is:

 It centralises the spot where the systemcall is made to arm the
 handler.  This means that if the setup needed to arm the handler
 ever becomes more complicated in future OSes, it only needs to be
 updated in one place.  This is a direct maintainability benefit.

>It is a trade-off between that some benefit I am not seeing, and downside
>that your version can be broken more easily by future changes to
>child_handler(), because you are assuming more about what it happens to do
>currently.

>That's the kind of thing maintainers worry more about.

Well, I see two solutions which increase maintainability:

Solution A:
==================================
void child_handler(int signo) {
  signal(SIGCHLD, child_handler);	/* rearm always for portability */
}

main() {
  ...
  signal(SIGCHLD, child_handler);
  ...
}
==================================

Solution B:
==================================
void setup_child_handler(int signo) {
  signal(SIGCHLD, setup_child_handler);	/* rearm always for portability */
}

main() {
  ...
  setup_child_handler(0);
  ...
}
==================================

Solution C:
==================================
void setup_child_handler(void);

void child_handler(int signo) {
  setup_child_handler();		/* rearm always for portability */
}

void setup_child_handler(void) {
  signal(SIGCHLD, child_handler);
}

main() {
  ...
  setup_child_handler();
  ...
}
==================================

Solution A is what you propose, but which I find less appealing because
any future magic to actually setup the handler needs to be maintained
and updated in two places.

Solution C is what follows your train of thought better, because it
future-proofs the setup as well as the handler.

Solution B is what I consider most elegant and maintainable, because at
this point in time I cannot imagine what extra handling would be
required inside the handler which would require a setup as complicated
as solution C; so in order to keep it as simple as possible and
eliminate forward declarations and minimise systemcalls I suggest we
pick solution B until the need for solution C ever arises (I don't
think it ever will).

But, in any case, you're the maintainer here, not I, so it's your call.
I vote for B, but just tell me which solution you prefer and I'll adapt
the code?
-- 
Sincerely,
           Stephen R. van den Berg.

"Hold still, while I inject you with SQL."
