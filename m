From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 0/9] --left/right-only and --cherry-mark
Date: Thu, 10 Mar 2011 11:48:43 +0100
Message-ID: <4D78AC8B.7010308@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net> <7vtyfc7ymk.fsf@alter.siamese.dyndns.org> <4D7886FD.60109@drmicha.warpmail.net> <7vd3lz5me5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 11:53:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxdVE-0003Ua-Mf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 11:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab1CJKxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 05:53:16 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52351 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752324Ab1CJKwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 05:52:16 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F2E4C20BA1;
	Thu, 10 Mar 2011 05:52:15 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 10 Mar 2011 05:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Bmnk/85uDrYzmV40QHJM9eLh9x0=; b=Dlfol/ScNPr2sKLKl/G9ytkTC4GIoIhMwX5gHHKzhDpQpKt0rLxws2X2nfCBzD1ZFjM6PkbnRRgnMM2JkdJqNveR3IAUoXa7lPUG+AqCfrgmM5xBl/3xWvcL8NzlFD/0SJFSOZFIPzUjYOa/8i2f9D0mvcnd2uy/n9bEeuxyltQ=
X-Sasl-enc: 3ei0lyxhELaRIU8XmUtBZnvplJ8uPi5zJ8LSZoT3y+xf 1299754335
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 705C54406FE;
	Thu, 10 Mar 2011 05:52:15 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <7vd3lz5me5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168808>

Junio C Hamano venit, vidit, dixit 10.03.2011 10:56:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 09.03.2011 22:49:
>> ...
>>> Conceptually revs->cherry_mark ought to be a subset of revs->cherry_pick
>>> and the code shouldn't have to do something like this:
>>>
>>> 	if (revs->cherry_pick || revs->cherry_mark)
>>>         	cherry_pick_list();
>>>
>>> Instead, the code should arrange that revs->cherry_pick is always set
>>> when revs->cherry_mark is set before the calling application enters the
>>> loop to call get_revision().
>>>
>>> But that would make the command line parsing more cumbersome (you would
>>> either waste one bit so that you can tell if you saw --cherry-pick on the
>>> command line, or keep the version of parser in this series as-is, and add
>>> postprocessing code to flip revs->cherry_pick on when revs->cherry_mark
>>> was given in prepare_revision_walk()), and I understand that is why you
>>> did it that way?
>>
>> Yes, I think so :) Another reason is that even cherry_pick_list() needs
>> to know which object flag it should set.
> 
> I didn't have trouble with "if (revs->cherry_mark)" used for that purpose
> at all.
> 
> That is what I meant by "cherry-mark is a _subset_ of cherry-pick".  In
> other words, if you are marking the cherry-pick result, you must be doing
> a cherry-pick to begin with, so having to say "cherry-pick || cherry-mark"
> is a bad taste.
> 
> But that does not contradict with the need to do something differently
> between the case where you are cherry-marking and where you are not
> cherry-marking.
> 
>> - leave the parser as is
>> - set cherry_pick when cherry_mark is set
>> - if (revs->cherry_pick) cherry_pick_list();
>> - leave cherry_pick_list() as is
> 
> I think that essentially is what I speculated in "either X or Y" part as
> solution Y.
> 
>> Would that be better? I didn't do that because it changes the meaning of
>> cherry_pick (it can mean two things then). It would introduce the
>> assumption "pick is set when mark is" instead of "at most one is set"
> 
> Well, as I said earlier, my suggestion was coming from "if you are
> cherry-marking, you must be cherry-picking in the first place", so yes, I
> am saying that "at most one is set" is a bad taste.  If the assumption has
> to change to match the better taste, that can only be a good thing ;-).

Being half-way through doing "Y" I remember why I really disliked "Y":
because it breaks the association between option names (--cherry-pick,
--cherry-mark) and rev flags (cherry_pick, cherry_mark). With "Y",
cherry_pick would mean --cherry-pick or --cherry-mark. (Also, as
mentioned, we're not "picking" when marking.)

Additionally, since parse_revision_opt (which calls handle_revision_opt)
is called from other sites for individual args we would need to do the
handling in the Y case (set pick when marking) right in
handle_revision_opt, not just in setup_revisions. It's a matter of a few
more if's and or's, but still.

Taking these together, I wonder whether we shouldn't leave it as in v2.

Michael
