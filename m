From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/9] --left/right-only and --cherry-mark
Date: Thu, 10 Mar 2011 01:56:50 -0800
Message-ID: <7vd3lz5me5.fsf@alter.siamese.dyndns.org>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
 <7vtyfc7ymk.fsf@alter.siamese.dyndns.org>
 <4D7886FD.60109@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 10:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxccI-0001JF-E5
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 10:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab1CJJ5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 04:57:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab1CJJ5B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 04:57:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A40013414;
	Thu, 10 Mar 2011 04:58:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ilOePRbPXoVqH14CPQle45KTWCI=; b=DKZMH1
	pvxDaGuII2XfzzP1MhhD9fmA7qf2hDK6QVLxp2VlUbW6k4Y293XPvVFzoOLj/DJY
	4h+J30UicfIlUdPVHoMyf2bWGa6YR1W+64fSyXQkJaB5mxRqH15jY1tZ+YSQsM2E
	9VoqblaMBv5R3Vc6htc5zI8mu05lQYMYYbygc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q4lKcvhC4eRmjMqAB35wKso9P6RiwOxn
	fz/hFUcN2BuvCA318/ToBTvS7oY98rEMWUHS/dTp/uKi5zW8GYT0jkORC6ZeMvHC
	gU25XeUEEHSH6dcKxaWRQ7F280u2hB/MoQWv9eaxK8DkAmlrfVVw1VbGogHQ4uFu
	8LTZqqeO56U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7DC893413;
	Thu, 10 Mar 2011 04:58:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D3FB23412; Thu, 10 Mar 2011
 04:58:21 -0500 (EST)
In-Reply-To: <4D7886FD.60109@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 10 Mar 2011 09:08:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1753CEC-4AFC-11E0-B8E0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168804>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 09.03.2011 22:49:
> ...
>> Conceptually revs->cherry_mark ought to be a subset of revs->cherry_pick
>> and the code shouldn't have to do something like this:
>> 
>> 	if (revs->cherry_pick || revs->cherry_mark)
>>         	cherry_pick_list();
>> 
>> Instead, the code should arrange that revs->cherry_pick is always set
>> when revs->cherry_mark is set before the calling application enters the
>> loop to call get_revision().
>> 
>> But that would make the command line parsing more cumbersome (you would
>> either waste one bit so that you can tell if you saw --cherry-pick on the
>> command line, or keep the version of parser in this series as-is, and add
>> postprocessing code to flip revs->cherry_pick on when revs->cherry_mark
>> was given in prepare_revision_walk()), and I understand that is why you
>> did it that way?
>
> Yes, I think so :) Another reason is that even cherry_pick_list() needs
> to know which object flag it should set.

I didn't have trouble with "if (revs->cherry_mark)" used for that purpose
at all.

That is what I meant by "cherry-mark is a _subset_ of cherry-pick".  In
other words, if you are marking the cherry-pick result, you must be doing
a cherry-pick to begin with, so having to say "cherry-pick || cherry-mark"
is a bad taste.

But that does not contradict with the need to do something differently
between the case where you are cherry-marking and where you are not
cherry-marking.

> - leave the parser as is
> - set cherry_pick when cherry_mark is set
> - if (revs->cherry_pick) cherry_pick_list();
> - leave cherry_pick_list() as is

I think that essentially is what I speculated in "either X or Y" part as
solution Y.

> Would that be better? I didn't do that because it changes the meaning of
> cherry_pick (it can mean two things then). It would introduce the
> assumption "pick is set when mark is" instead of "at most one is set"

Well, as I said earlier, my suggestion was coming from "if you are
cherry-marking, you must be cherry-picking in the first place", so yes, I
am saying that "at most one is set" is a bad taste.  If the assumption has
to change to match the better taste, that can only be a good thing ;-).

> Any thoughts on the actual marks ('+' vs. ' ' vs. '*')?
> I also feel like we could use a space between the mark and the sha1
> (like git cherry does) to ease copy and paste but that is an orthogonal
> issue applying to all marks (<>-^+=).

I personally don't care very much and also choose not to say much on it
too early even if I had opinion on the choice, because I know there are
many people with better visual tastes than I on the list and I am sure
they will voice their opinion once they see sample output.
