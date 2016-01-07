From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Handle more file writes correctly in shared repos
Date: Thu, 07 Jan 2016 13:52:11 -0800
Message-ID: <xmqq1t9t3vn8.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<cover.1452085713.git.johannes.schindelin@gmx.de>
	<c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:52:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHITi-0006sg-L7
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 22:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbcAGVwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 16:52:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751709AbcAGVwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 16:52:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E439382FD;
	Thu,  7 Jan 2016 16:52:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5QQZdVX3cUbLEZ/MTQpz220kP7s=; b=D9saLE
	NesEP7QNVLjy00a/AinTzT0RMpzdViJ9LauZ779IxarLZFQPJVWOo+3zkXHBao9A
	2aNfdsvrdI0yOdlE3gEr5cKH34F29kO7e1bDjpUJt6Y158L9W/nq+o/lDUJ4Vx06
	nbFzZNNbCxt0ZMVX/sTQmtc4MMZ3RJYfiHkMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IFAt7Qtzk7nfVK2MNXCA8P3m2yfywb64
	4+wysqkoAf38XAZQmTC6+h8RX9JL5W6sM95te+Hw0SWU7Y+btO2Gw1IFteEhpFu6
	a6mjhiA7xrYJgWOHDwnji5HCod7SvgQNbRDOjhxG88f3vzeeDhi0r3S+Khgb/wLi
	74qxE+MJD0U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 155BD382FC;
	Thu,  7 Jan 2016 16:52:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7D058382FB;
	Thu,  7 Jan 2016 16:52:12 -0500 (EST)
In-Reply-To: <c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 6 Jan 2016 14:09:49 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E87B81A4-B588-11E5-8279-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283511>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> - git apply, when writing rejected hunks

Today I may try to apply and leave hello.c.rej; tomorrow you may try
to apply a different patch and get rejection for the same file.  And
you would not be able to if my umask is 077.

I do not know "intended to be shared" is a good criteria, unless it
is a synomym to "what is under $GIT_DIR".  core.sharedRepository is
about the shared-ness of $GIT_DIR and never about the working tree,
so I consider it is correct that not adjusting the permission is the
right thing to do when 'git apply' writes .rej files, though.

> - git fsck, when writing lost&found blobs

So this _is_ conceptually a problem, but writing anything indexed
with the object name is an idempotent operation, so this will not
matter in practice, I think.

> - git merge-file, when writing merged files (when Git itself calls
>   merge-file, the file in question was already there, with shared
>   permissions).

Again, this is not a problem (i.e. not touching it in this patch is
the right thing to do) as this is about files in the working tree.

> - git fast-import, when writing a crash report

I am not sure about this one.  Is the crash report designed to get
unique filename every time you run?  Otherwise, the fixed name
inside $GIT_DIR/ is a shared resource, so I suspect it would want to
overwrite.  "Not overwriting the crash report is safer, because the
existence of it is a sign that the earlier crash hasn't been dealt
with" is also a valid position to take, but then it shouldn't even
overwrite my own crash report from an earlier run.

So I am inclined to say that this should be changed (either
consistently overwrite using fopen_harder(), or consistently fail
when my earlier crash report is already there).  I however do not
think that change belongs to this topic.

> - mailinfo() in mailinfo.c, because the output is clearly not intended to
>   be shared between the users of the current repository

This is more because "not intended to be run multiple simultaneously
using the same filename" plus "the callers clean up after they are
done" (similar to what you wrote for "git am"), I think.

> - git rerere, when writing resolved files, because the files in question
>   were already written with the correct permissions

This again is more because the result goes to the working tree, not
$GIT_DIR.
