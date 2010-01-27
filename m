From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git rev-list --reverse --max-count=N
Date: Wed, 27 Jan 2010 14:28:03 -0800
Message-ID: <7vsk9rnpxo.fsf@alter.siamese.dyndns.org>
References: <1264622600-20981-1-git-send-email-spang@google.com>
 <201001272309.26054.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Spang <spang@google.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:28:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaGNA-0001YW-9B
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 23:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab0A0W2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756275Ab0A0W2O
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 17:28:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab0A0W2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 17:28:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EFC6A9448E;
	Wed, 27 Jan 2010 17:28:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bUt/8/1k87j54JjgtLYXx/QTB7I=; b=OtIa5/
	Q3EbJMKQEOA3uTdur20j0lviUiUKeNd/7BYyYQCP0kYq5vHIR0ugvnQE8d5jROLb
	bZNklJed8YJQ6NAmNRLz3EGGaS4SMIBCmVpH9QxC3KIzEsOOQLqPpo2xFgDtokTU
	y5MhPPYKNK31CW6Fp1M28GoyF5JtkcDyjoF5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GVpAsb8NnTQNxyb2UQtDIhdcu3A2a9FQ
	XLkI5GXU2MWeNoPoAeZFeVf5iw2k9ykUaChE69gY/Vf6cYdMrEeN0rvslhy2ZsQj
	enhxm+sqoWkvZVgsjubCLVlrG1nKwhmKkrLy+DCMz/rXpYcX8G7iQQu3wX/271yt
	Hlgk9t9yfmw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2CEC9448C;
	Wed, 27 Jan 2010 17:28:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E03A09448A; Wed, 27 Jan
 2010 17:28:04 -0500 (EST)
In-Reply-To: <201001272309.26054.j6t@kdbg.org> (Johannes Sixt's message of
 "Wed\, 27 Jan 2010 23\:09\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3ED99C08-0B93-11DF-A78B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138203>

Johannes Sixt <j6t@kdbg.org> writes:

> On Mittwoch, 27. Januar 2010, Michael Spang wrote:
>> Using --max-count with --reverse currently outputs the last N commits
>> in the final output rather than the first N commits. We want to
>> truncate the reversed list after the first few commits, rather than
>> truncating the initial list and reversing that.
>
> So when you have this history (A is oldest, D is newest):
>
>    A--B--C--D
>
> and you say
>
>    git log --max-count=2 --reverse D
>
> then you want
>
>    A
>    B
>
> but I want
>
>    C
>    D
>
> Why is your interpretation correct, an mine wrong?

The interaction between --max-count and --reverse was designed a long time
ago to support "I want to review the recent N commits in order to make
sure that they are natural and logical progression".  So an unconditional
change of semantics to break that expectation this late in the game will
never be acceptable, and giving title to such a patch with a word "Fix"
won't fly well (it simply _breaks_ behaviour users have long learned to
expect).

It is a different matter to add an explicit command line option (and no
configuration to change it to default) to apply reversal before count
limiting.
