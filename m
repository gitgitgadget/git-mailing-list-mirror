From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: avoid O(n^2) behavior in match_push_refs by using string_list
Date: Wed, 03 Jul 2013 13:22:14 -0700
Message-ID: <7v7gh7e6mh.fsf@alter.siamese.dyndns.org>
References: <1372809228-2963-1-git-send-email-bcasey@nvidia.com>
	<20130703062332.GA16090@sigill.intra.peff.net>
	<CA+sFfMeDC=hc7QZhfSuQYsdBPzig5WANeTBhMxFZk=Pusq0QpA@mail.gmail.com>
	<7vhagbfpwz.fsf@alter.siamese.dyndns.org>
	<51D479BA.1070207@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTZz-0003F4-8o
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965665Ab3GCUWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:22:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965518Ab3GCUWT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:22:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04EAA2DF22;
	Wed,  3 Jul 2013 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mBod36oEclwBMUpMtEzfijz1Zjw=; b=iffLk9
	iiw0qCxHTdfOKCeM7weOUM+8hTr+GYS0PXvNylieGhG1taTJ8HJM0HhPhA9hd6yl
	5Nb3XI6Ai9/tI8ptC1ScESWWUcPXiNwJnRoevyGFUo+fn1J+vmQECMEBaBBGGnXL
	mqjRtV0/2rTfeFhHfI88uRBO67stLp9V5lPhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fAY3ouV+nsPf1KEfxTRJlsI7Poik1mOR
	TBvFEGvNUtaQIRl8cic0dTE+YVogvBpQfRJwD5fdJnmheofEtfjhlfCufSvwqi5+
	r66WFIy+Hw6pqg20gLbC6GvjwKnL4oNCPQwfx1RJNhwpeYtue5o1t9FwxGmJaxQJ
	voXBOegmmEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE542DF21;
	Wed,  3 Jul 2013 20:22:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E99C2DF20;
	Wed,  3 Jul 2013 20:22:16 +0000 (UTC)
In-Reply-To: <51D479BA.1070207@nvidia.com> (Brandon Casey's message of "Wed, 3
	Jul 2013 12:21:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 410B2E76-E41E-11E2-9063-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229524>

Brandon Casey <bcasey@nvidia.com> writes:

>> ... by penalizing the common case by how much?  If it is not too
>> much, then this obviously would be a good change.
>
> For something the size of the git repo, 5 branches, and pushing with
> matching refspecs, I can't measure any difference.  The fastest time I
> record with or without this patch is the same:
>
>    $ time git push -n
>    real    0m0.178s
>    user    0m0.020s
>    sys     0m0.008s
>
> Ditto, when only pushing a single branch.  Preparing the string list for
> a repo with a "normal" number of refs has very little overhead.

My repository git.git and Linus's kernel are not "normal".  It did
not matter so far to have O(n*m) when pushing to our histories.

The case that matters is for somebody to be pushing one (or a few)
refs against a repository with many many refs, like pushing a review
request to Gerrit instance, which I think Martin has in mind.
