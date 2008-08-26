From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Tue, 26 Aug 2008 16:04:36 -0700
Message-ID: <7v3akr2xa3.fsf@gitster.siamese.dyndns.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
 <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
 <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
 <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
 <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>
 <7vsksrad7o.fsf@gitster.siamese.dyndns.org> <48B44C61.2020206@gnu.org>
 <7vabez2yac.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 01:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY7bg-0003P1-4z
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 01:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYHZXEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 19:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbYHZXEp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 19:04:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYHZXEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 19:04:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 35E155CF9F;
	Tue, 26 Aug 2008 19:04:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 10BB95CF8F; Tue, 26 Aug 2008 19:04:38 -0400 (EDT)
In-Reply-To: <7vabez2yac.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 26 Aug 2008 15:42:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5F161F14-73C3-11DD-BABB-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93831>

Junio C Hamano <gitster@pobox.com> writes:

> Paolo Bonzini <bonzini@gnu.org> writes:
>
>> Junio C Hamano wrote:
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> 
>>>> Paolo Bonzini schrieb:
>>>>> +	/*
>>>>> +	 * Always open file descriptors 0/1/2 to avoid clobbering files
>>>>> +	 * in die().  It also avoids not messing up when the pipes are
>>>>> +	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
>>>>> +	 */
>>>> I see your point, but I don't have an opinion whether this stretch is
>>>> necessary.
>>> 
>>> This is going too far.  Have you seen any other sane program that do this?
>>
>> Busybox.  But it runs setuid, as Steven pointed out.
>>
>> I say it's all (i.e. be this paranoid), or nothing.
>
> I tend to agree, and I think what Stephen R. van den Berg said earlier in
> the thread makes perfect sense.

So going back to the very original in the thread.

I think

	$ git fetch 0<&-

from the command line is a mere user stupidity.

On the other hand, if a cron/at job that contains "git fetch" is launched
in an environment with fd#0 (or #1 or #2 for that matter) closed, it would
certainly be problematic.  It can easily be worked around by redirecting
file descriptors appropriately in the script that is launched, though.

On a related note, we should make sure that we run our hooks with the set
of low file descriptors opened sensibly.  It would be a bug if we are
running them in a weird environment and forcing them to do funky
redirection themselves.  I think we are already Ok in this regard, but I
didn't check.
