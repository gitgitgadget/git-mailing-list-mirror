From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 04 Oct 2012 13:03:26 -0700
Message-ID: <7vhaqaxawh.fsf@alter.siamese.dyndns.org>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:09:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJthJ-00033L-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab2JDUDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 16:03:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab2JDUD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 16:03:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 351C48AB5;
	Thu,  4 Oct 2012 16:03:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JWjc9ZHKYF+xgLkIuny1lGEii6E=; b=juICFT9RDJ5fWRQwjgKv
	k8EpszHvFRJfswtqXlf+5W4j28LwI2NqR2L76HJv2iXBs74lC5FzoxmgsBRLRCfF
	cXGCRTEGKNx2hXmWL7i8aPLAxD4ydfXEVecYcRJWGawmlsJ4i8i22nJ3ZTL+6NaY
	9sRM+JbnBqePBz7eOlenWRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=f98qwrgn2OGPwnrMEbII+CaMvOEWu383fi3VrRoB7hCy7m
	bRloM+TcvpRWWs4e17soYO1my6iJdjJTeAmNKkm7Gwt3tCyagwrYYrSj7rbI825m
	AX0IAKHMrnYC3HYTUqeSvysgArxunsD3FxUWvPMxvXXiRZhv/nBNRwQa0WszU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 218DF8AB4;
	Thu,  4 Oct 2012 16:03:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 722988AAF; Thu,  4 Oct 2012
 16:03:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9046034E-0E5E-11E2-A451-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207047>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 04, 2012 at 04:14:54PM +0200, Markus Trippelsdorf wrote:
>
>> with current trunk I get the following on an up-to-date Linux tree:
>> 
>> markus@x4 linux % time git pull
>> Already up-to-date.
>> git pull  7.84s user 0.26s system 92% cpu 8.743 total
>> 
>> git version 1.7.12 is much quicker:
>> 
>> markus@x4 linux % time git pull
>> Already up-to-date.
>> git pull  0.10s user 0.02s system 16% cpu 0.740 total
>
> Yikes. I can easily reproduce here. Bisecting between master and
> v1.7.12 gives a curious result: the slowdown first occurs with the merge
> commit 34f5130 (Merge branch 'jc/merge-bases', 2012-09-11). But neither
> of its parents is slow. I don't see anything obviously suspect in the
> merge, though.

There is one extra call site of reduce_heads() added by that merge
relative to 34f5130.  It is likely that the updated reduce_heads()
is totally broken from performance point of view, or at least it is
not optimized for the usage pattern at the new call site, in which
case it would be very plausible that both parents of the merge
perform well while the merge result is sucky.

It gets more curious, though.

I am getting ~9 seconds with the tip of master and ~0.4 seconds with
1.7.12.

When 34f5130^2 is reverted at the tip of master, I get ~0.35
seconds.  That matches Markus's observation.

However.

If I revert 5802f81 that updated the implementation of fmt-merge-msg
on top of 'master', *without* reverting 34f5130^2, I get ~4.5 seconds.
As we are doing an "Already up-to-date" pull, I thought there is no
need to call fmt-merge-msg in the first place?

Which may indicate that "git merge" has been broken for a long time
and making unnecessary calls.

Hrmmm...
