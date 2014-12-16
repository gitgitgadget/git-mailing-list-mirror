From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 16 Dec 2014 12:30:15 -0800
Message-ID: <xmqqk31r9w2w.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 21:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0ylF-0007Yk-1z
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 21:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbaLPUaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 15:30:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750983AbaLPUaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 15:30:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC10C27991;
	Tue, 16 Dec 2014 15:30:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qkoaoprV3sI/Fw7C6CBdoDWTo/s=; b=P3PDqD
	OpD/kQYOse6Sp48bmat6OEJlyXvsNnRoQdPC5+/dKgOi7pFUoQr2zCAxQoRtFicF
	F328RnVyZ61yIrp+HluXx6hkPBXKh4H350blP+gHPC9vCpKohyFaLesPILaDw0UM
	8bsnHXYZDOqT/eZaVg7/jc8X5LdgCuaqQmuWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tQqV6d5H708zWX6fLoTzvzK6rsqxXebx
	6EOKCm6h0jvxaazV5ExDrpHklDg7i6UUzoAk3hp6DqsOpisHLq6e1QVISH6Gjw84
	vogb83+/dRUjgLCoYXT3dbo2fCEsmaiSkO56pKRVrIJN/32oi1gEPEjjcieUla6x
	bwikT4YyKOM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1D7527990;
	Tue, 16 Dec 2014 15:30:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BEC02798E;
	Tue, 16 Dec 2014 15:30:18 -0500 (EST)
In-Reply-To: <1418755747-22506-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 16 Dec 2014 10:49:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 599A5390-8562-11E4-B092-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261465>

Stefan Beller <sbeller@google.com> writes:

>     > What's the value of this test?  Isn't it a non-fast-forward check
>     > you already tested in the previous one?
>     
>     I messed up there. Originally I wanted to test the 2 different
>     stages of rejection. A non-fast-forward check is done locally and
>     we don't even try pushing. But I also want to test if we locally
>     thing all is good, but the server refuses a ref to update.

It is tricky to arrange a test to fail a fast-forward check on the
receiver side, because the local test is done by reading from the
other side, not relying on your remote tracking branches.  The usual
flow is:

    pusher says to the receiver "I want to push"

    receiver says to the pusher "Here are the tips of my refs"

    pusher thinks: "Ah, I was about to update their master branch
		with this commit, but what they have is (1) not
		known to me so by definition I cannot fast-forward,
		or (2) known to me and I can definitely tell I am
		not fast-forwarding it, so I'd locally fail this
		push".

You need to invent a way to successfully race with an ongoing push.
After receiver gives the tips of its refs (all of which are
ancestors of what is going to be pushed) but before the pusher
finishes the "thinking" above, you would somehow update the refs at
the receiver so that the push will not fast-forward.  

Such a raced flow would look like:

    pusher says to the receiver "I want to push"

    receiver says to the pusher "Here are the tips of my refs"

    pusher thinks: "OK, everything I'll send will fast-forward"
    pusher thinks: "Let's start generating a packfile"

    you intervene and update receiver's 'master' at this point.

    pusher send a pack and tells the receiver "I want to update your
		master from OLD to NEW".

    receiver thinks: "Huh, that OLD is not where my 'master' is"

    recevier says to the pusher "No fast-forward".

But I do not think it is practical to run such a test.

Rejecting on the receiver's end using pre-receive or update hook
should be testable and should be tested.

Thanks.
