From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 11:29:17 -0700
Message-ID: <7v62dowpdu.fsf@alter.siamese.dyndns.org>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 20:29:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxcc-0000VW-N5
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674Ab2C1S3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:29:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932618Ab2C1S3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:29:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D788E6A51;
	Wed, 28 Mar 2012 14:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/5T90bVf8WrJyB3l8+gfwNeHuXo=; b=Kp72PF
	GoSlLYFg3lilHJRLDYnLo4VhgjSY1zwQQsZgg9VRY8kyvaE6ZHczEjaQ8UHcpmaW
	iCmM8By69idoCYRvxVD2TU//36LeQAmAnXUd+F0tqi/XjU3jVc/k4FKxzlDZDGOb
	swVAOmYcYx/XcU6Z6ugOxQNaGdb967SkfKuNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bJA6YEgqyVVrfJJkUvrKv/ihBMqHyUNw
	2gDILL1CauFptOjgxi9y0X0NNgiDggSZmb47rQxpGpfaqeVvbUTsyGxiWKw2pT/2
	nNxcg+g//hZXJ+KvDyzhsZaC9EzhqoRf/2ygB2u8I3OfDS82U2Uw9Il6qybVRHi7
	muUn/CeSukU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFE436A50;
	Wed, 28 Mar 2012 14:29:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66A7C6A4F; Wed, 28 Mar 2012
 14:29:19 -0400 (EDT)
In-Reply-To: <20120328174841.GA27876@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Mar 2012 13:48:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEB1BA68-7903-11E1-B300-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194156>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 28, 2012 at 10:42:26AM -0700, Junio C Hamano wrote:
>
>> > Yes, though I held back on writing tests, because I don't think we've
>> > quite decided what the behavior _should_ be. Should we be
>> > differentiating "chmod -x /bin/ls" from "chmod -x /bin"? Should we be
>> > continuing alias lookup on EACCES? Should we print edit-distance
>> > suggestions on EACCES?
>> 
>> I am leaning to think that it would be the least surprising if we treat as
>> if /bin/ls does not even exist if /bin is not searchable.  If /bin/ls is
>> unreadable or unexecutable but /bin is searchable, then we _know_ it
>> exists, and we follow the usual exec*p() rule to ignore it so "git ls"
>> would try to find an alias and when all else fails will give the edit
>> distance suggestions but should exclude /bin/ls from candidates.  If /bin
>> itself is unsearchable, we do not even know what it contains, so it is
>> needless to say that /bin/ls will not be part of suggestion candidates.
>
> That sounds sensible to me. I think it involves writing our own
> execvp, though, right? If we use stock execvp, we can't tell the
> difference between the two cases.

The stock exec*p() will not hit "/bin/ls" in either case, so we will give
"'ls' is not a git command", without having to differenciate it.  That is
what I meant by "we follow the usual rule to ignore it".

We already have the code necessary to enumerate the possible commands from
components of the PATH in order to give suggestion, so we can run it
after seeing exec*p() failure to see if we did not see any "ls", or we saw
"ls" but it was not executable.  No need to penalize the normal case, no?
