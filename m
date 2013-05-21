From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Tue, 21 May 2013 13:24:29 -0700
Message-ID: <7vppwkm682.fsf@alter.siamese.dyndns.org>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
	<7v38tgno2k.fsf@alter.siamese.dyndns.org>
	<CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 22:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uet6r-0007os-3z
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 22:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab3EUUYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 16:24:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762Ab3EUUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 16:24:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90DE821414;
	Tue, 21 May 2013 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ZAR9FFf4BwoJ81jri6WqCb3qrc=; b=YHP5DW
	nIc1+VagQ84V1oqJ+C48KHYzEU3sHYC8h/WqIqe8OkJL4lUdnz4nPH4yUGENXmys
	Bxr8noIQLcsN0g2mSHDmK5Nw161XOV9eA2fLcUWaJSooAepLKunodwtpRGcRv/1h
	8odCcv9d+TKVF4DEj+/d/PgHS8ak6SSMygYmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r/cGxVg3NrSMImLXgOfUtXQ0VNd/LXoO
	n2C4hOmpDY+/OAl799AO/40qzcT1wDE74pzjWMvrk2aAsgIZsqAtBEwLQlohuLq6
	iqiakG6w5QxFJdsCidB7h/Er98E+LlIFAhnxOlJIza8hZI54N5x4E6COc9z92+bE
	TWXFWDeA000=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8542B21413;
	Tue, 21 May 2013 20:24:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E607021412;
	Tue, 21 May 2013 20:24:30 +0000 (UTC)
In-Reply-To: <CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 22 May 2013 01:22:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 715CFA82-C254-11E2-A951-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225073>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Is there?  I do not think "volatile" is particularly a good
>> description for this, but showing what is pushed as a concrete
>> branch name feels like a good improvement to me, at least in
>> principle.
>
> Okay.  I used "volatile", because push does not lock HEAD when the
> operation begins, even though it performs a super-late resolution (in
> the transport-layer); HEAD is not guaranteed to remain invariant in
> that time.  Suggest nicer wording?

In general, when a command is working in your repository with a
working tree, we do not make any such promise that it keeps
operationg normally when you pull the rug under its feet from
another terminal ("git checkout maint" running at the same time "git
pull" would not have a chance to work correctly).  Some are safe
(like "git push" racing with "git checkout maint" that would not
have to look at what the current branch is) and some are not (like
"git push github" racing with "git checkout maint && git push
origin HEAD:preview").

I view the value of this topic purely as "showing a real branch name
when that is what we actually pushed is a lot more preferrable than
showing HEAD, especially because the user may see it in the terminal
scrollback buffer hours after it happened".  Explaining this patch
as "we avoid issues from simultaneously flipping HEAD by resolving
early" gives a false sense of security to the reader, as "early" has
to happen early enough for the patch to really avoid the issue, but
you are not in control of when the user does that flipping in the
other terminal.
