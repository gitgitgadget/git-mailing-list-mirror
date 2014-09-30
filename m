From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 27/39] try_merge_strategy(): use a statically-allocated lock_file object
Date: Tue, 30 Sep 2014 11:08:47 -0700
Message-ID: <xmqqiok5rnf4.fsf@gitster.dls.corp.google.com>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
	<1411726119-31598-28-git-send-email-mhagger@alum.mit.edu>
	<xmqqh9zu8ax5.fsf@gitster.dls.corp.google.com>
	<542AB853.5000303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 30 20:08:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ1r5-0002hV-4S
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 20:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaI3SIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 14:08:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61759 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbaI3SIu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 14:08:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD1443FB2F;
	Tue, 30 Sep 2014 14:08:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KC/mta4dS6ABTWI2cN0mjViNDWY=; b=MeTtc6
	YYeKSkRIK0OytKf38xbcGR6/Mt8NupevQgPN8qPCHa6iF7b4JF7laF2LBJvb8n1M
	769Zqim1kxkU8cW+dq0Qv+7gMsfj83gOK15IsCCM1Jr/B8J/qaL1J7Co0phZTaIC
	w6dJ6E3CQNsj9dYL2ftfYLBLiOEHBWZ7bReqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KGXARVN+NQ+yzgvCzLpbYaDEzaULXAe2
	neNYkk0DPCQmS2v3gOwo7TmBVTt92PvTP5ZHFO5Y1eN51lw8/qnj76jOONfxhEOm
	lRQVMBzd/XpvRjGY3XrfSIgl7yBQNKO20KDVZejlGJ955u611pEAY8DRL4Bp6qmw
	JNdj2ZlrQtc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1F3D3FB2E;
	Tue, 30 Sep 2014 14:08:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1CCED3FB2D;
	Tue, 30 Sep 2014 14:08:49 -0400 (EDT)
In-Reply-To: <542AB853.5000303@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 30 Sep 2014 16:04:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D3CDB18E-48CC-11E4-AB05-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257677>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/26/2014 09:00 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> Even the one lockfile object needn't be allocated each time the
>>> function is called.  Instead, define one statically-allocated
>>> lock_file object and reuse it for every call.
>>>
>>> Suggested-by: Jeff King <peff@peff.net>
>>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>>> ---
>>> ...
>>> -	hold_locked_index(lock, 1);
>>> +	hold_locked_index(&lock, 1);
>>>  	refresh_cache(REFRESH_QUIET);
>>>  	if (active_cache_changed &&
>>> -	    write_locked_index(&the_index, lock, COMMIT_LOCK))
>>> +	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
>> 
>> I wondered if the next step would be to lose the "lock" parameter
>> from {hold,write}_locked_index() and have them work on a
>> process-global lock, but that would not work well.
>> 
>> The reason why this patch works is because we are only working with
>> a single destination (i.e. $GIT_INDEX_FILE typically .git/index),
>> right?
>> 
>> Interesting.
>
> Ummm, this patch wasn't supposed to be interesting. If it is then maybe
> I made a mistake...

Well, Interesting is very different from Questionable.

This lock can never have multiple active instances, as you
mentioned.

We didn't have to change this for so long since the function was
written; that probably is because this sequence:

	lock = hold_lock();
        use(lock);
        commit(lock); /* or rollback(lock) */

is so obviously natural to callers of the API, and commit/rollback
looks very much like a declaration that we are done with the object
and its resource can be freed.

This change makes sense because the API does not actually allow us
to free the resource held to use this lock, so reducing the number
of "struct lock_file" ever used during the life of the program makes
difference, especially when you use many, even when not many of them
you need to hold at the same time.

Which was counter-intuitive to me, and the realization did not hit
me until I thought about it, which made it an "Interesting" change.

It may at the same be suggesting that "once in the lockfile subsystem,
the resource becomes reclaimable" may be something we would want to
fix, though.
