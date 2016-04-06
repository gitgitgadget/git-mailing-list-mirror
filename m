From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Wed, 06 Apr 2016 12:18:33 -0700
Message-ID: <xmqqshyywnp2.fsf@gitster.mtv.corp.google.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
	<CA+55aFz7309BkfHjD5H7tp9WE0yf1VWncxfmB3hgimJ00fbT-Q@mail.gmail.com>
	<xmqqwpoawpmq.fsf@gitster.mtv.corp.google.com>
	<CA+55aFy-mb00=KGWghx5XXfkv5dChnncoLoJA07f_2Y_or0FOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 21:18:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ansyR-0001tE-5K
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 21:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbcDFTSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 15:18:37 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752033AbcDFTSg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 15:18:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE26653110;
	Wed,  6 Apr 2016 15:18:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7mE+R/5oCMzYfWDsiLN8LmCpJMg=; b=W+BMxh
	5JMHWXkaRQ0GAq2xlk5m2nJiu751l64uXLarNk+2Ge0lpRBLGo6ssEsna3ocB5Ur
	t9ic4LmSWkxrfhhGFlvoYblN7kF5qhhc86ihvZkra/nYs/9SGc6Q6TDUTWnUW05g
	pHP+ova5vErrfczNhw8YABW+Hshv90zgaiYuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JH2YfgRwmxuX3SY8Djc4ZJbdF/HujiTJ
	cjazGj9tJ5oIz5ttiUeFxcN0U8iG3Z4hJ/WD9mBJShmQqBZx3cdig/idap5wAm3M
	6K+2tHGQ1atrRXuwPdCt5oZ5ijQo09FFe03rNDcx4GCANIGNYNvk5irTze26aYOh
	n6sDHgfAq3g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E54A85310F;
	Wed,  6 Apr 2016 15:18:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6BD3C5310E;
	Wed,  6 Apr 2016 15:18:34 -0400 (EDT)
In-Reply-To: <CA+55aFy-mb00=KGWghx5XXfkv5dChnncoLoJA07f_2Y_or0FOw@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 6 Apr 2016 11:55:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B4340CA-FC2C-11E5-8CB3-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290863>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... And I guess it might not be too nasty
> to add: it could be done as part of the object checking pass after
> downloading the pack. Was that what you were thinking of?

Not that fancy, actually.  Running an equivalent of

    git rev-list --max-parents=0 ^HEAD FETCH_HEAD

was what I had in mind.  This shouldn't be too costly for a normal
case (O(N) where N is the number of changes on FETCH_HEAD since it
forked from you).

It needs to be done even when FETCH_HEAD is a descendant of HEAD,
(i.e. when we would have fast forwarded without creating a merge) to
be effective, as --no-allow-new-root is about not trusting your
subsystem people not doing silly things on purpose, unlike our
original patches.
