From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 16 May 2013 18:31:39 -0700
Message-ID: <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 03:32:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud9Wl-0008O7-NL
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 03:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab3EQBbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 21:31:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab3EQBbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 21:31:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4008010B06;
	Fri, 17 May 2013 01:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Dzq5QdaTMm/7lUgCbzr/v4q0uE=; b=Vok60G
	+bkekSFRMsdMNqeLnHxRaUqquhn0Sk0WswHdpA1Ku8la1horX/JZLAJXXfoK7P5P
	eJapZRkUSNRczHKAXRghqV1kdoiau5I7LInHaSteD3bH2vvEABAJJl5+IGJLAj3u
	6aRdYxNFjozlbQCYCP8EVLo3LrvbzNIPXQRJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EAVSpFpyhlQKxHgVSTHOze/qykzSjY+W
	NZzdp4U+7mq5uwDav3Ow6PXJkYkk7hgsawYpf3pp257ktWxnRE05ISO9ZepQCkUD
	m75Lmsr1ijijPzE18mzoVfm5Uk+O70kSoMF4AidCCgdidcTzhEn81jwQt11NxXsT
	92SVM4dPzr8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3299A10B05;
	Fri, 17 May 2013 01:31:52 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 950B910B04;
	Fri, 17 May 2013 01:31:51 +0000 (UTC)
In-Reply-To: <7vobca3465.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 16 May 2013 16:17:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CCB911E-BE91-11E2-BFEB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224645>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> What happens if I want to push to 'refs/heads/topics/frotz-for-juno'?
>
> You would weigh pros-and-cons of supporting such a "single branch
> only" special case, and add a branch level override, and if the
> benefit outweighs the cost of complexity, design and implement it.
>
> The push.default setting is to make sure we have a simple mechanism
> to cover more common cases, and my suspicion is what 'current' gives
> us is already there without the need for 'single'.

Actually, I suspect that you shouldn't even need to do that
pros-and-cons analysis, because the 'single' thing should cover as a
natural extension of the existing infrastructure.  You should only
need to have something like this:

	[remote "there"]
        	url = ... were you push ...
		push = refs/heads/frotz:refs/heads/topics/frotz-for-juno
                push = refs/heads/*:refs/heads/topics/*

Without the 'single', your 'frotz' will be pushed to update
heads/topics/frotz-for-juno, not heads/topics/frotz, because the
exact refspec match will prevent it from matched twice by the
wildcarded one.  The imagined 'single' mode would just limit the
push to the current branch, so it would end up pushing to the branch
you want to update, without sending an extra copy to the same name.
