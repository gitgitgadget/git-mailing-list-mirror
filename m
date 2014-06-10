From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/3] sequencer: Signal failed ff as an aborted, not a conflicted merge
Date: Tue, 10 Jun 2014 12:17:02 -0700
Message-ID: <xmqqvbs88tht.fsf@gitster.dls.corp.google.com>
References: <xmqqvbsrf4hd.fsf@gitster.dls.corp.google.com>
	<5395CD04.2050303@gmail.com>
	<xmqq8up4abs3.fsf@gitster.dls.corp.google.com>
	<539753C3.2020101@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 21:17:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuRXm-0003uz-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 21:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbaFJTRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 15:17:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53782 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbaFJTRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 15:17:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A7D41D6B8;
	Tue, 10 Jun 2014 15:17:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dujS4SFmMLCud2jxY+hip/XwS4Y=; b=qVnjTa
	C3fbwXDrtS3Iv+ZE7FtGYkpkfAfgoG+SumMYGG8GYN7zRoc8obZVvpVNbLOa7nqa
	wgmVZgo+lcgDrLIEjIE28ehXlaQMKJRDWiHdPc3VD33QwPaJsM1Q77iuZpVXkGdH
	Uvk552ZVRru9EQgVZnLvKvQV4iBOVeaVYGNcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NpcqHONzll0uHT2zC8n4txW6HIjElXxt
	VKIhvEuK7UqzOFTsH/D2mKTzkVs0bCoF1HoVA0Aw5OF86PMvBaaZ7dwU3pSMm90U
	xb8Z1URCff99qq9xgJLSo2gEvRuKAybYLcgdahYE8ko7j0TGT8zfS9Ojxy0wMloY
	W9NkHg5ANFw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F9F51D6B7;
	Tue, 10 Jun 2014 15:17:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 33B731D6B3;
	Tue, 10 Jun 2014 15:17:04 -0400 (EDT)
In-Reply-To: <539753C3.2020101@cisco.com> (Phil Hord's message of "Tue, 10 Jun
	2014 14:51:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CE5D83D8-F0D3-11E3-8F4D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251219>

Phil Hord <hordp@cisco.com> writes:

>> In any case, I agree that exiting with 1 that signals "failed with
>> conflict" can be confusing to the caller.  Can we have a test to
>> demonstrate when this fix matters?
>
> I think you are asking for a test and not for clarification.  But a test
> was provided in 3/3 in this series.  Was it not related directly enough?

X-<  Somehow I missed the "3" in "1/3" above and did not look beyond
this first patch.

> For clarification, this tri-state return value matters when the caller
> is planning to do some cleanup and needs to handle the fallout
> correctly.  Maybe changing this return value is not the correct way
> forward, though.  It might be better if the caller could examine the
> result after-the-fact instead.

I am not sure about that.  For merge strategies "exit with 1 iff you
left the conflict in the index" is the contract between "git merge"
frontend and the strategies backend; if a similar contract is needed
between the sequencer and its users, it is good to follow the same
pattern for consistency.  The resulting index and/or the working
tree may or may not match the contents recorded in the HEAD commit
but without the backend telling the caller, the caller cannot tell
if the difference was from before the operation or created by the
operation.
