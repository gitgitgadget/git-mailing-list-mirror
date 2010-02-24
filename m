From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/11] rebase -i: invoke post-rewrite hook
Date: Tue, 23 Feb 2010 22:15:10 -0800
Message-ID: <7vaauzcg7l.fsf@alter.siamese.dyndns.org>
References: <cover.1266885599.git.trast@student.ethz.ch>
 <87f20b987fa7a389e89f8931d553de7095d2bc86.1266885599.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 24 07:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkAWv-0006sn-1I
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 07:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab0BXGPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 01:15:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab0BXGPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 01:15:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E91129CB7B;
	Wed, 24 Feb 2010 01:15:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fL2VjNHK0Sv79Zty/KMawJDGAV8=; b=odeYha
	DBShO0tcqnCxl8aCE8Bg0TOanHX7Mpta/QSXQyAe8Q5MtMG1w0HFS8UrOhW+oyT3
	q7VcDTyQs8wyy/8RncP/7ID9uFSq6OyAJTcCEHFZppX31eWGoJBTdCaF9MCtlB7j
	NuY1zNjDrWi6W2Llk8dKm05rPlqEkZqyhjL9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVFljEZBHJaXDChsiOqslokc1MRij7Rw
	Z0FHc60hf5J7lmf2iRG2iFz5obqXn38/yxmyaKTfPpALX56L1Npe/bPn3ZE/Yt2J
	QYQgaX5Ppyqlw2Dt4JJowWRHyRfBzSa9jFrRrCxxYYZB/kmmWrkZSpdwzz7aIG0E
	N5tYG3gghGo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F0A9CB79;
	Wed, 24 Feb 2010 01:15:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8927A9CB78; Wed, 24 Feb
 2010 01:15:12 -0500 (EST)
In-Reply-To: <87f20b987fa7a389e89f8931d553de7095d2bc86.1266885599.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue\, 23 Feb 2010 01\:42\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA91C60E-210B-11DF-AB3F-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140901>

Thomas Rast <trast@student.ethz.ch> writes:

> +test_expect_success 'git rebase -i (unchanged)' '
> +	git reset --hard D &&
> +	clear_hook_input &&
> +	FAKE_LINES="1 2" test_must_fail git rebase -i --onto A B &&

This

> ...
> +test_expect_success 'git rebase -i (skip)' '
> +	git reset --hard D &&
> +	clear_hook_input &&
> +	FAKE_LINES="2" test_must_fail git rebase -i --onto A B &&

and this

> ...
> +test_expect_success 'git rebase -i (squash)' '
> +	git reset --hard D &&
> +	clear_hook_input &&
> +	FAKE_LINES="1 squash 2" test_must_fail git rebase -i --onto A B &&

and this need to be fixed to something like

	( FAKE_LINES=... &&
          export FAKE_LINES &&
          test_must_fail git ... ) &&

for Bourne-shell portability.  test_must_fail is a shell function and the
usual one-shot-assignment-to-export rule does not apply.
