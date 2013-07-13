From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sat, 13 Jul 2013 22:17:31 +0200
Message-ID: <51E1B5DB.9080904@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org> <51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org> <7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org> <7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org> <7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org> <7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org> <7vwqougwec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 22:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy6GQ-0006NJ-GS
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 22:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255Ab3GMURh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 16:17:37 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:17836 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758238Ab3GMURg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 16:17:36 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2FAAC1000B;
	Sat, 13 Jul 2013 22:17:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CCA8C19F61C;
	Sat, 13 Jul 2013 22:17:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vwqougwec.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230290>

Am 13.07.2013 20:14, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>>> Your table above makes this fail:
>>>
>>>         git push --lockref topic
>>>
>>> and the user has to force it,
>>
>> Of course.
>>
>>> like this?
>>>
>>> 	git push --lockref --force topic ;# or alternatively
>>>         git push --lockref +topic
>>>
>>> Why is it even necessary?
> 
>> Because it is no-ff. How do you achieve the push today (without
>> --lockref)? You use one of these two options. It does not change with
>> --lockref.
> 
> But by going that route, you are making --lockref _less_ useful, no?
> 
> "git push topic" in no-ff/match case fails as it should.  The whole
> purpose of "--lockref" is to make this case easier and safer than
> the today's system, where the anything-goes "--force" is the only
> way to make this push.  We want to give a user who
> 
>  - rebased the topic, and
> 
>  - knows where the topic at the remote should be
> 
> a way to say "I know I am pushing a no-ff, and I want to make sure
> the current value is this" in order to avoid losing somebody else's
> work queued on top of the topic at the remote while he was rebasing.
> 
> You _CAN_ introduce a new --allow-no-ff at the same time and fail a
> no-ff/match push:
> 
> 	git push --lockref topic
> 
> and then allow it back with:
> 
> 	git push --lockref --allow-no-ff topic
> 	git push --lockref +topic ;# +topic is now --allow-no-ff topic
> 
> but why _SHOULD_ we?  As soon as the user _says_ --lockref, the user
> is telling us he is pushing a no-ff.  If that is not the case, the
> user can push without --lockref in the first place.
> 
> The only potential thing you are gaining with such a change is that
> you are allowing people to say "this will fast-forward _and_ the I
> know the current value; if either of these two assumptions is
> violated, please fail this push".
> 
> If "--lockref" automatically implies "--allow-no-ff" (the design in
> the reposted patch), you cannot express that combination.  But once
> you use "--lockref" in such a situation , for the push to succeed,
> you know that the push replaces not just _any_ ancestor of what you
> are pushing, but replaces the exact current value.  So I do not think
> your implicit introduction of --allow-no-ff via redefining the
> semantics of the plus prefix is not adding much value (if any),
> while making the common case less easy to use.
> 
>> No; --lockref only adds the check that the destination is at the
>> expected revision, but does *NOT* override the no-ff check.
> 
> You _could_ do it in that way, but that is less useful.

All you have been saying is that you find your

   git push --lockref there topic

is more useful than my

   git push --lockref there +topic

You are trading crystal clear semantics to save users ONE character to
type. IMO, it's a bad deal.

The crystal clear semantics would be:

 - to override no-ff safety, use +refspec;

 - to override "mismatch" safety, do not use --lockref/use --no-lockref;

 - do not use --force unless you know the consequences.

I actually think that by implying allow-no-ff in --lockref, you are
hurting users who have configured a push refspec without a + prefix:
They suddenly do not get the push denied when it is not a fast-forward
anymore. For example, when you have

    [remote "ko"]
        push = master
        push = +pu

and you accidentally rewound master before the point that is already
published, then

   git push --lockref ko

will happily push the rewound master.

-- Hannes
