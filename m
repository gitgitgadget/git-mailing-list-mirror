From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git --reference bug(?)
Date: Tue, 18 Oct 2011 23:55:50 -0700
Message-ID: <7v4nz5eah5.fsf@alter.siamese.dyndns.org>
References: <CAK-xaQaUxJ5c_kN48g7-J9fosDv6awbAFQSFLpF2fA+hc-i-MA@mail.gmail.com>
 <4E9E59A7.7070307@alum.mit.edu> <7vpqhtec2n.fsf@alter.siamese.dyndns.org>
 <7vipnlebwb.fsf@alter.siamese.dyndns.org>
 <7v8vohebhx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 19 08:55:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGQ4D-0000fv-Uh
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 08:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab1JSGzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 02:55:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047Ab1JSGzx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 02:55:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19BC933EE;
	Wed, 19 Oct 2011 02:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eRaEpYi8NhDKkbopRLQIrG68AJM=; b=cfFG3f
	+hDtuofcis6kk8KbobyTtRdLtxVuLnn5NFYAbYRUiLk9/0JvRObRcpzCuck+Svjr
	XLqfNXY+Lt+eIk/1Eu/rFECEYGASYqfUQig/3XSyAiALbS2gt22cdiwBkPAWhrRP
	gFTvVssfsddpyqXP2u+YFEyif7kVZt8wyQIao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I8niqKutJBw9JbMbO6h81gIfR+9Tn9Dj
	qWqHq67OY2e0mviu6ctSSI8YeJ853COhjiGQ9SH7383yFDtguE1A+k7rauWcwEzj
	v2dss7zPR7maS4SvlHE4qQTW8F/lkdLzSaD0Imo0s/HjEBD992PUeQQSiPb4txDj
	baByZE4cayU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1066733ED;
	Wed, 19 Oct 2011 02:55:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9707B33EC; Wed, 19 Oct 2011
 02:55:51 -0400 (EDT)
In-Reply-To: <7v8vohebhx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Oct 2011 23:33:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 620162C0-FA1F-11E0-B7F5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183923>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> In addition, you must be careful about what is added with add_extra_ref();
> they are often not refs but are placeholders for Git to know that the
> history leading to it is complete, even though they do not exist as
> refs. The values of real refs that exist in your alternate object store
> are treated this way, because you know you do not have to fetch (if you
> are initiating fetch-pack) or receive (if the other side is initiating
> send-pack) histories leading to them from the other side.

I think a quick and simple rule would be that add_extra_ref() is to give
our history in the object database extra anchor points to avoid fetching
or receiving pushes of unnecessary history into our object database, when
we know our object database has certain histories that are not reachable
from our own refs available. The names given to add_extra_ref() would not
follow any normal refname rules (in fact, "refs/tags/v2.6.12-rc3^{}"
peeled notation was designed not to collide with real refs, so was ".have"
sent from receive-pack.c to send-pack.c even though the latter is not kept
track of with the refs mechanism).

They do not have to be shown when resolve_ref() is called. They only need
to appear in for_each_ref() so that revision walking machinery can use
them when we need to compute the set-difference of commits between what we
have and what the other side has.

Hope this clears things up a bit.
