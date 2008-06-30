From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/13] Build in merge
Date: Sun, 29 Jun 2008 22:40:53 -0700
Message-ID: <7vlk0n4h0a.fsf@gitster.siamese.dyndns.org>
References: <20080628023355.GH2058@genesis.frugalware.org>
 <ed4b7f44474d6b9398fb0752740ede264bea25b2.1214620551.git.vmiklos@frugalware.org> <7vprq0fzum.fsf@gitster.siamese.dyndns.org> <20080630013612.GY2058@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 07:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDC9O-00017W-TD
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 07:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbYF3FlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 01:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbYF3FlK
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 01:41:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbYF3FlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 01:41:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E5C1A498;
	Mon, 30 Jun 2008 01:41:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8AE36A493; Mon, 30 Jun 2008 01:41:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22710E7C-4667-11DD-902F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86877>

Miklos Vajna <vmiklos@frugalware.org> writes:

>> > +		if (!remote_head)
>> > +			die("%s - not something we can merge", argv[0]);
>> > +		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
>> > +				DIE_ON_ERR);
>> > +		reset_hard(remote_head->sha1, 0);
>> > +		return 0;
>> 
>> Makes one wonder reset_hard() (aka "read-tree --reset -u HEAD") ever fail
>> and return here (iow, without calling die()).  The answer is luckily no
>> in this case, but it is somewhat unnerving to reviewers.
>
> Actually reset_hard does not return if an error occures:

I know that; didn't I already say "Luckily no"?  The point was it was not
apparent from the above 6 lines alone.

>> > +	for (i = 0; i < use_strategies.nr; i++) {
>> > +		if ((unsigned int)use_strategies.items[i].util &
>> > +			NO_FAST_FORWARD)
>> > +			allow_fast_forward = 0;
>> > +		if ((unsigned int)use_strategies.items[i].util & NO_TRIVIAL)
>> > +			allow_trivial = 0;
>> 
>> Can we abstract out these ugly casts?  Any code that use path_list to
>> store anything but list of paths (i.e. some value keyed with string) tends
>> to have this readability issue.
>
> If you don't cast, you can't use the & operator. If I change the
> path_list_item's util to be an unsigned number then I break fast-export.
> I think if we _really_ want to get rid of those casts, we could have
> something like:

No, no, no.  That is not what I meant.

The places that use use_strategies in your code knows too much about the
internal implementation detail of path_list, while path_list pretends to
be a general purpose "table keyed with string" facility.  The fact is that
the table is not a very useful general purpose abstraction unless you are
pointing at some structures that exist regardless of your use of path_list
(e.g. you have some "struct object" and you hold pointers in a path_list).
It does not work very well as an abstraction for use case like yours.

With something like:

        static inline unsigned nth_strategy_flags(struct path_list *s, int nth)
        {
                return (unsigned) s->items[nth].util;
        }

the checks would be more like:

	if (nth_strategy_flags(&use_strategies, i) & NO_FAST_FORWARD)
		...

or even:

        static inline check_nth_strategy_flags(struct path_list_item *i, unsigned flags)
        {
        	return !((unsigned) i->util & flags);
        }

        if (check_nth_strategy_flags(&use_strategies,items[i], NO_FAST_FORWARD)
        	...	

either of which would be much easier on the eye.


> Actually the shell version did not check here, either, but yes, I would
> have to. Now I do.

The scripted did not have to do so explicitly, as the one before that have
already caught "more than one common" case in the case arm before this
part.  It is already known that "have only one common" condition is true
when you reached the corresponding part of the scripted version.
