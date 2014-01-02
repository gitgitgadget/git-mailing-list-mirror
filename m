From: Junio C Hamano <gitster@pobox.com>
Subject: Re: aborted 'git fetch' leaves workspace unusable
Date: Thu, 02 Jan 2014 10:09:45 -0800
Message-ID: <xmqqbnzuqmqe.fsf@gitster.dls.corp.google.com>
References: <32eeea08963ec4438f97ff9ef6553a75@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: stephen_leake@stephe-leake.org
X-From: git-owner@vger.kernel.org Thu Jan 02 19:10:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VymiZ-0007PS-FT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 19:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbaABSJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 13:09:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbaABSJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 13:09:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 196635F8DD;
	Thu,  2 Jan 2014 13:09:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E2cRwlpRllRlRK2Bk8bV7VhaSoo=; b=hTs04p
	5xd67NCodEV18bI7EFywfm2p+xsOIw+J4zfEV/q4Z889FB99SlvRLh65FYhZuVs4
	k3oU1Zb0FOeJbXAtpT+PKtJ2nlkusjtlR0Ubt00p0ObS6H/vgjh8TSHWPH6cgewq
	lZIuwcA4n1iYviULoc26HYSBkj/RK6OZ1H7co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofVkmsGV/i+OME+HCcAsr8D+y7xEhCm2
	l9sFKc7kV6aE5Lyg3+VNBwpci0/7fmOzasz2EVMjDUNYEEWFrtzqaWnwQ3ECVsAX
	UYZMyqI1qrxLaLeuc3zFkwV464WZ4Hs0tb0Pm5LJnJtkhvg4r+taOOtct3jezePO
	CCekK4XR1/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26C535F8DA;
	Thu,  2 Jan 2014 13:09:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 206875F8D9;
	Thu,  2 Jan 2014 13:09:50 -0500 (EST)
In-Reply-To: <32eeea08963ec4438f97ff9ef6553a75@stephe-leake.org> (stephen
	leake's message of "Tue, 31 Dec 2013 01:19:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 122F0F32-73D9-11E3-8669-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239862>

stephen_leake@stephe-leake.org writes:

> However, in this case, even running the fetch was a mistake; I would
> have prefered that it leave FETCH_HEAD in its previous state.

I think the clearing of leftover FETCH_HEAD is one of the early
things "git fetch" does, unless "--append" is in effect.  I haven't
looked at the code for a long time, but it may be possible to move
the logic of doing so around so that this clearing is done as lazily
as possible.

I however suspect that such a change may have fallouts on other
people who are writing tools like yours; they may be depending on
seeing FETCH_HEAD cleared after a failed fetch, and be surprised to
see a stale contents after they (attempt to) run "git fetch" in it.

So it is not so clear if it is a good thing to change the behaviour
of "git fetch" not to touch FETCH_HEAD upon a failure.
