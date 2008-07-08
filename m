From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Build in merge
Date: Mon, 07 Jul 2008 17:32:50 -0700
Message-ID: <7v63rhz03x.fsf@gitster.siamese.dyndns.org>
References: <7vhcb14l3m.fsf@gitster.siamese.dyndns.org>
 <1215474140-11220-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "To: Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 02:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG19g-0004rv-VP
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 02:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbYGHAdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbYGHAdG
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 20:33:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbYGHAdF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 20:33:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A1F9326D24;
	Mon,  7 Jul 2008 20:33:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 801BD26D1D; Mon,  7 Jul 2008 20:32:52 -0400 (EDT)
In-Reply-To: <1215474140-11220-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Tue, 8 Jul 2008 01:42:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B5B7716-4C85-11DD-A6E9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87671>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Mon, Jul 07, 2008 at 11:15:09AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> I do not get you on this point.  Which one is nicer?
>>
>>  (1) Have two lists, perhaps all_* and user_*.  The logic that finds a
>>      strategy searches in two lists.  The logic that checks if a given
>>      strategy is built-in checks if it is on all_* list.
>>
>>  (2) Have a single list, but add a boolean "unsigned is_builtin:1" to
>>  each
>>      element of it.  The logic that finds a strategy looks in this
>>      single
>>      list.  The logic that checks if a given strategy is built-in
>>      looks at
>>      the strategy instance and it has the bit already.
>>
>> You seem to be advocating (1) but I do not understand why...
>
> Ah, OK. For now, I just added an "unsigned enabled:1;". Later we can add
> an "unsigned is_buildin:1;" as well, but currently we die with earlier
> with a "Could not find merge strategy" error message, so is_builtin
> would be always true.
>
> So here is a version, this time without the use_strategies list.

That is not what I meant.  I am afraid perhaps I misunderstood what you
were talking about.

When/if you allow user defined new strategies, then you have a choice:

 (1) find "git-merge-*" in path, add them to the single all_strategies[]
     list (but you will do the ALLOC_GROW() business so you would need to
     use the one you currently have as static form to prime the real list),
     and look for "foo" strategy when "-s foo" is given from that single
     list, or

 (2) find "git-merge-*" in path, add them to a separate user_strategies[]
     list, and look for "foo" strategy when "-s foo" is given from the
     user_strategies[] list and all_strategies[] list (all_strategies[]
     should perhaps be renamed to builtin_strategies[] if you go that
     route).

The comparison I gave was between the above two.  But the change you are
talking about is completely different, isn't it?

The part that records which strategies were specified from the command
line *in what order* via "-s foo" switches should remain list of pointers
into "struct strategy", which is called "struct strategy **use_strategies"
in the code and corresponds to the $use_strategies variable in the
scripted version.  The order of these is important, as that defines in
which order the strategies are tried [*1*].  If you go route (1), these
pointers will all be pointing at elements in all_strategies[]; with route
(2) they may be pointing at either all_strageties[] element or
user_strategies[] element.

If you are never going to say "available strategies are these" after you
start supporting user-defined strategy, then you do not necessarily need
to do the "find 'git-merge-*' in path, add them to ..." step above, in
which case it would be Ok not to scan the path and add them to
all_strategies[] (in route (1)) nor user_strategies[] (in route (2)).
Instead, you would just create a new "struct strategy" instance lazily
when the user gave "-s foo" and "foo" is not one of the built-in strategy.
You would put that at the tail of "struct strategy **use_strategy" array,
and iterate over use_strategy in the order they are given on the command
line.


[Footnote]

*1* Personally, I find the importance of this dubious in practice, as I
said earlier, I do not think it would work well to try different
strategies and pick the best one --- evaluating which result is the *best*
is difficult.  If you want to stay compatible with the scripted version,
however, you cannot just mark entries in all_strategies[] with boolean and
iterate over them in the order that all_strageties[] define them.  You
need to try them in the order the user specified.
