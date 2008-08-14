From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-daemon: make the signal handler almost a no-op
Date: Wed, 13 Aug 2008 18:09:43 -0700
Message-ID: <7v63q4ieqw.fsf@gitster.siamese.dyndns.org>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
 <20080813084331.30845.74788.stgit@aristoteles.cuci.nl>
 <7v1w0sjw47.fsf@gitster.siamese.dyndns.org> <20080814001858.GB14939@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Aug 14 03:11:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTRMg-0006ea-0W
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 03:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYHNBJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740AbYHNBJv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 21:09:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYHNBJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 21:09:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D7FCC58D15;
	Wed, 13 Aug 2008 21:09:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D921A58D14; Wed, 13 Aug 2008 21:09:45 -0400 (EDT)
In-Reply-To: <20080814001858.GB14939@cuci.nl> (Stephen R. van den Berg's
 message of "Thu, 14 Aug 2008 02:18:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B1711E7E-699D-11DD-ABF6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92303>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

>>> @@ -1036,10 +1034,7 @@ int main(int argc, char **argv)
>>>  	gid_t gid = 0;
>>>  	int i;
>
>>> -	/* Without this we cannot rely on waitpid() to tell
>>> -	 * what happened to our children.
>>> -	 */
>>> -	signal(SIGCHLD, SIG_DFL);
>>> +	child_handler(0);
>
>>Why?
>
> child_handler() now does barely more than setup the signal handler,
> which is exactly what we want to do here.
>
>>With your change, the first part happens to be almost no-op, but I do not
>>think it justifies this hunk.
>
>>After all, we might even want to do something like:
>
>>	static void child_handler(int signo)
>>        {
>>        	if (USE_SYSV_SIGNAL_SEMANTICS)
>>                	signal(SIGCHLD, child_handler);
>
>>and have the compiler optimize out the signal rearming with
>
>>	cc CFLAGS=-DUSE_SYSV_SIGNAL_SEMANTICS=0
>
> In return I ask: why?

Please read the part you omitted from your quote again.

I agree it would be very meaningless change as an optimization, but I am
concerned more about robustness and what makes sense.

Do you agree that "child_handler()" is a signal handler to handle SIGCHLD,
and such a signal handler conceptually consists of two parts? i.e.

	static void child_handler()
        {
        	reap_dead_children();
                rearm_signal_as_needed();
	}

Your argument is it is Ok to call this function when you are arming the
signal for the first time, because reap_dead_children() happens to be
empty, and your rearm_signal_as_needed() happens to be the same as
arm_signal_always().

Yes, it happens to be _Ok_ now.  But is it an improvement in the longer
term?  I do not think so.

I do not see why you think it is better to rely on these two assumptions
than being explicit and say "we set up the signal for the first time
always on any platform", especially when the latter is much more direct
way to say what your intention is.  Or are you gaining something by not
explicitly calling signal() for the first time?  I may be missing some
benefit for doing so.

It is a trade-off between that some benefit I am not seeing, and downside
that your version can be broken more easily by future changes to
child_handler(), because you are assuming more about what it happens to do
currently.

That's the kind of thing maintainers worry more about.
