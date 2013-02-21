From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Infinite make recursion when configure.ac changes
Date: Wed, 20 Feb 2013 22:10:42 -0800
Message-ID: <7vk3q2w61p.fsf@alter.siamese.dyndns.org>
References: <51248D0A.50603@gmail.com>
 <20130221060401.GC25943@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 07:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8PNB-0004gU-4J
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 07:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab3BUGKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 01:10:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab3BUGKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 01:10:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4B288E55;
	Thu, 21 Feb 2013 01:10:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eHSoxAkk8BVH5lHme3vw6cGp9R0=; b=dDyDZI
	L9sIuO5pg5tu6pF3hndIpiSlPjCMMMDMs0Ep16LqJH2y7+hxWvSRFg3tzUEqzLQq
	4oJUDBMk6y4TywqO6Oj1WXKAzJmWRZ5OJNHPbOQ2R+N7IPBj4DtxJ59SEKbfkCQn
	jITSURQDM4fDfXLsatUm7InAzGR0IrCFxI78Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lKkw9/G3uXhUG26MUD9k2acYV9wLR/bE
	fXZj9PGYQNNhtpMi9I07aOfZwkZBwtT7TSPpvr7xgMHe6+8dOWdX2NhTvJQemSvS
	wp+vP6iypgXhkaTmGsffgFU+UyyyW9A2IFmlFm/DXw0zuV8Z4Aeia5Va2r4JjOp6
	qqbvENarTVU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A82708E54;
	Thu, 21 Feb 2013 01:10:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 291628E53; Thu, 21 Feb 2013
 01:10:44 -0500 (EST)
In-Reply-To: <20130221060401.GC25943@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 21 Feb 2013 01:04:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D100BFC-7BED-11E2-90BE-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216756>

Jeff King <peff@peff.net> writes:

> I can easily replicate it here.
>
>> This seems due to the change in commit v1.7.12.4-1-g1226504: the
>> issue is still present there, but no longer is in the preceding
>> commit 7e201053 (a.k.a. v1.7.12.4).
>> 
>> I haven't investigated this any further for the moment.
>
> Hmm. It looks like config.status depends on configure.ac. So make
> rebuilds config.status, which runs "make configure", which includes
> "config.mak.autogen", leading "make" to think that it should rebuild the
> include file to make sure it is up to date. The include file depends on
> "config.status", which needs to be rebuilt due to configure.ac, which
> entails running "make configure", and so on.

I noticed this while looking at the other autoconf patch yesterday,
but I was otherwise occupied in the evening and did not pursue it
further.  Thanks for looking into it.

This may be an unrelated issue, but I've always thought that it was
strange and extremely unintuitive that running "make configure" once
only creates config.mak.autogen, while running it once again after
that (i.e. while having config.mak.autogen in the tree) seems to run
the resulting "./configure" as well. Maybe it is just me.
