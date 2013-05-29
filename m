From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating diff
Date: Wed, 29 May 2013 11:48:53 -0700
Message-ID: <7vy5axsju2.fsf@alter.siamese.dyndns.org>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
	<20130529062007.GA11955@sigill.intra.peff.net>
	<7vip21u09d.fsf@alter.siamese.dyndns.org>
	<20130529183658.GA15616@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Kevin Bracey <kevin@bracey.fi>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 29 20:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlQi-00075o-Jh
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965651Ab3E2Ss5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 14:48:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965602Ab3E2Ss4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 14:48:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2E9722E9A;
	Wed, 29 May 2013 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BF18EzdU91CToIInTl4HLku4hsk=; b=ZEcak/
	FkEG5yBYihD0vVX1Hbozb9cUEevsZuvgpxKCyDX3XwDgaNYktSKgAMtmE4zzTLhp
	c1Q0R5zjlajJe7eyVAiwKi+bD3igVkwQOPWYxaWFnjiW3i7sylktb/UlsGOqEdUO
	ezLubtrpmZSX0Q0QoXZIUgX3+zzUzGQmJ6reg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vn11MKtj536Dz5JgdM32u5fl901Eeldq
	31+/QUOR1XPRmsEAjBIFONNcwL13k1th9fvEmJS312VIMSM5TJ+r9A1Suft1gCVu
	xOsXD/H4gvsr6rjgzDfBQdjo0YHZ0bUj5r0JwYCaIJVICrv6f11D7OcAeXuDHCCQ
	phyYVqjkpz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A557C22E98;
	Wed, 29 May 2013 18:48:55 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0565422E97;
	Wed, 29 May 2013 18:48:54 +0000 (UTC)
In-Reply-To: <20130529183658.GA15616@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 29 May 2013 14:36:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69CBA90C-C890-11E2-A64D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225865>

Jeff King <peff@peff.net> writes:

> On Wed, May 29, 2013 at 11:08:46AM -0700, Junio C Hamano wrote:
>
>> This has rather interesting ramifications on cherry-pick and rebase,
>> though.  Both command can handle changes that come from an old tree
>> before some paths were renamed, but strict patch-id would not spot
>> equivalent changes we already have in our history if our change
>> happened after a rename, i.e.
>> 
>>    Z
>>   /
>>  O---R---X---Y
>> 
>> where Z updates path F, R moves F to G and X changes G the same way
>> as Z changes F, and we are trying to cherry-pick Z on top of Y.  The
>> cherry-pick filter will see different patch-id for Z and X.
>
> True. That is a problem with the current patch-id system, no?

Correct.  That is why I suggested not to change the external
interface (i.e. what is shown from patch-id command) as people may
have kept them, but wondered if a possible improvement may be to
exclude the name from ids when we internally generate two sets of
Ids and intersect them, i.e. log --cherry.
