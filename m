From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 11:14:42 -0700
Message-ID: <7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
	<7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
	<87wqs1xi9h.fsf@hexa.v.cablecom.net>
	<7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 17 20:14:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USWsc-0002na-QP
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 20:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966211Ab3DQSOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 14:14:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965858Ab3DQSOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 14:14:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E9FB17801;
	Wed, 17 Apr 2013 18:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CoNpZEWbLEkGvj/5758ZbfGzBKw=; b=J27kwA
	7OJwvfNYNf92DVoBZfTtqme7M/0qCFmRuy01pZgwz1C5PXbD8kOsUbbKfQdRd2Z7
	S/luwj+TNl+RXtCgUG8jUyGL8vfZgv8EI6EXDFlXT+bS4oTZeyqkutl5QV2a8p+j
	fUzVBdEUpjcmvCVRHkSTAwTsvOwvZuzuVSDJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sjl1u3Nh7uS7cjwwEMVKiCd2vlmNI62H
	FhPQLylb22Mshb7aXYIkIIgpG94Ngjn0/6wMn2qCMsvjQUh0npPBnwSS/sez3EU3
	s7l8PwCew6R2yH8DKIELtPLsld1UqE4v7atXMoAfidnmxcEdWJUIIA7aED+A54d1
	nsFl4w+40QQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 125A617800;
	Wed, 17 Apr 2013 18:14:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FEAD177FE;
	Wed, 17 Apr 2013 18:14:44 +0000 (UTC)
In-Reply-To: <7vk3o1f5kb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 17 Apr 2013 10:08:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE2CE3D0-A78A-11E2-98CC-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221559>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> I can see that problem, but along the same lines, why shouldn't I have
>> an expectation that when I say 'git add "*.py"' it removes stuff that I
>> have removed?
>
> You _should_ have that expectation.
>
> If it does not remove with the code that has been prepared for 2.0
> (that is a bit beyond 'next'), then it is a big problem, but I think
> it does remove the removed python source without "-A", as long as
> you give a pathspec "*.py" (with quotes around it) that match it.
>
> I think it is just the warning code avoiding extra complexity and
> overhead, if you are talking about not getting warning in the
> pre-2.0 step that is in 'next'.  Patches are very much welcomed,
> especially the ones that come before I get around to it ;-)

I took a brief look at the code, and as you said "add" needs to know
about submodules, and the best fix looks to me to take the same
approach Jonathan came up with to de-noise the "add -u/-A" topic.

That is, to scan the working tree to actually see if we would record
removals to the index in 2.0, but not remove them in this current
version, and give the warning when the differences in the behaviours
matter.
