From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Allow reference values to be checked in a transaction
Date: Mon, 09 Feb 2015 10:41:08 -0800
Message-ID: <xmqqtwyvapx7.fsf@gitster.dls.corp.google.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:41:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtGm-0005C2-15
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933646AbbBISlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:41:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933415AbbBISlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:41:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D578E36BEA;
	Mon,  9 Feb 2015 13:41:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8TQIsl68pSGc5Nxpnoc1jk+gN2Q=; b=tGZY4r
	ydIQbgoJC882YOz5OHK6UJ2Z3enZSOe8spHPSAdP8+GrfxM7kYKJV7HZRAcgwEtL
	PiDFLzXabLU8y+RDzW45EABmNZ6MhEP/VFf5qDw/cFPm0l6H8mwt2vYwxVRfugqt
	77G/TqejfYeiQSQS6h0tMBksDekD6TSzOBav8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f2PsKAc3j39C3Y3L/VV3hkDFg0tWJyIA
	O8AtP6TcsQwNcAtjGCK1pPlNaqNof6UM/RE34w0XnkKr2gpFPlc9qFnp4r5ktjmw
	+Q0nHCInUJF75LCMNgn1+0MPAwWfE6/CV3+0IXBY4aGWBVNyeS4IaQkOcAVM0YrS
	Zy4wQLBSsvI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA01A36BE9;
	Mon,  9 Feb 2015 13:41:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42EFB36BE8;
	Mon,  9 Feb 2015 13:41:10 -0500 (EST)
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sun, 8 Feb 2015 17:13:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3759E58A-B08B-11E4-ADBD-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263578>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The main purpose of this series is to simplify the interface to
> reference transactions as follows:
>
> * Remove the need to supply an explicit have_old parameter to
>   ref_transaction_update() and ref_transaction_delete(). Instead,
>   check the old_sha1 if and only if it is non-NULL.
>
> * Allow NULL to be supplied to ref_transaction_update() as new_sha1,
>   in which case old_sha1 will be verified under lock, but the
>   reference's value will not be altered.
>
> * Add a function ref_transaction_verify(), which verifies the current
>   value of a reference without changing it.
>
> * Make the similarity between ref_transaction_update() and
>   update_ref() more obvious.
>
> Along the way, it fixes a race that could happen if two processes try
> to create an orphan commit at the same time.
>
> This patch series applies on top of master merged together with
> sb/atomic-push, which in turn depends on mh/reflog-expire.

I am a bit puzzled by your intentions, so help me out.

I see that your understanding is that Stefan will be rerolling the
push atomicity thing; wouldn't we then want to have a "fix and
clean" topic like this one first and build the push atomicity thing
on top instead?

In other words, would it make sense to extend mh/reflog-expire (in
'next') topic with commits from "Fix some problems with reflog
expiration (8 patches)" series and this series to fix and clean it?

We may even want to rebase/reroll mh/reflog-expire on top of v2.3
while doing so to adjust to the transaction stuff, if that makes
some of the changes in the two new series unnecessary (if these "fix
and clean up" changes made in mh/reflog-expire in 'next', that is).
