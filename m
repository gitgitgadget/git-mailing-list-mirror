From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git describe --contains doesn't work properly for a commit
Date: Wed, 04 Mar 2015 22:00:08 -0800
Message-ID: <xmqq385k56hj.fsf@gitster.dls.corp.google.com>
References: <20150226133534.GB14878@dhcp22.suse.cz>
	<20150226142314.GC14878@dhcp22.suse.cz>
	<20150304105408.GA19693@peff.net>
	<54F71F69.3080500@drmicha.warpmail.net>
	<20150304180529.GA28074@peff.net>
	<xmqq7fuw8pgq.fsf@gitster.dls.corp.google.com>
	<20150305051211.GA3344@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Michal Hocko <mhocko@suse.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 07:00:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTOpa-0005uZ-7d
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 07:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbbCEGAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 01:00:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753757AbbCEGAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 01:00:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 058E332B91;
	Thu,  5 Mar 2015 01:00:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U7HL2/yUvpwPydmXgjgBHmRmvek=; b=vwjoLY
	zdt9VljYm8aLacXWIvHE1MU0QqhjUC3isshQlqMXMvI+2SK7UsByZO86GVvQFIix
	RJ44q5sjCy2dvueVwxDX7xpZP0vyTj+IckXihR3Og9qjj7Hn8PyAWZQqwryAlfIB
	M3bbXMU2YQIg5rIi2//NZgdCiTBiExVBEjUHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mxgTG1yWmH/YUBFnMbHzS6eMSEiqq2Sv
	jULtBQLzXKdATglCN9J6p+pCxZIAy0ynUFvZnHUsodQXQ9z/wR4gbp3+qzsgOk1m
	vrHtS//iRqQR3AFmMFPjjGWhXR4QSjLEqxHHeKLiUN9aTS10BYGqZy3rdZQsDZ8X
	5J6C8fjoj4Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F05F432B8F;
	Thu,  5 Mar 2015 01:00:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75CEA32B89;
	Thu,  5 Mar 2015 01:00:09 -0500 (EST)
In-Reply-To: <20150305051211.GA3344@peff.net> (Jeff King's message of "Thu, 5
	Mar 2015 00:12:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1460168-C2FC-11E4-AF6F-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264815>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 04, 2015 at 12:41:57PM -0800, Junio C Hamano wrote:
>
>
>> This one, and $gmane/264101, are a few instances of this known issue
>> raised here recently.
>
> If $gmane/264101 is caused by clock skew, I'd find that disturbing.
> Those algorithms are supposed to be "correct, but slower" in the face of
> skew, not ever incorrect.

My understanding is that the commit painting done by merge-base is
designed to be always correct, but the A..B revision traversal
depends on SLOP being big enough.  When the traversal queue is
filled with all UNINTERESTING commits, some of which needs to be dug
to reveal newer commits that are not yet painted as UNINTERESTING in
order to get the complete picture, the still_interesting() logic
will end up stopping prematurely, leaving commits that are actually
UNINTERESTING in the topological sense unpainted in the resulting
newlist that is assigned to revs->commits in limit_list(), yielding
an incorrect result.

>> > Calculating them is simple. Caching and storage is the bigger question.
>> 
>> Yes, also having to handle the ones whose generation numbers haven't
>> been computed yet adds to the complexity.
>
> I'm not sure it's that bad. If you cache generation numbers for all
> known commits when you repack, then worst case you have to traverse all
> commits not in the pack.
> ...
> IMHO, if you are going to go to the trouble to detect and store skew,
> you should just go to the trouble to calculate and store reliable
> generation numbers.

I would actually prefer a solution with generation numbers, of
course, because that would give us provably correct result.  If it
can be done without too much hassle, I am all for it.  Scrap the
half-baked "I've been wondering" compromise ;-)

Thanks.
