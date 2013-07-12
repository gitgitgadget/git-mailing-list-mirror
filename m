From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in .mailmap handling?
Date: Fri, 12 Jul 2013 13:38:13 -0700
Message-ID: <7v8v1bjyyy.fsf@alter.siamese.dyndns.org>
References: <51E029B9.20108@googlemail.com>
	<7vfvvjjzee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:38:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxk6r-0004V8-IB
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965415Ab3GLUiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:38:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965377Ab3GLUiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:38:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42FEE3072F;
	Fri, 12 Jul 2013 20:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dZ6gjdBgWzWzVNKK5WfuST6tAFA=; b=eSewDH
	ZdIvd0IRsBlfwTHHaqD5QMFzzIwD7rKJHLWL5f0+5olMHFEm+Exjbw/+ZGeP+5Pr
	CThcFR0VjzaUE5lP3ljqvP0Yozwd6rnBbjkntZIKO01Z8yP6VCr6pAmOCR6UWPmK
	1WrjmAej8M55vy93LQQdBtFdwijRhtbSR4fHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eMtCe2QzxogcqZPDiFpVcOxqBhE4svJs
	+8eNQ2gWv06tYpJDPcFLyuGhlp63KzcpPB0IUhGuMnyRjr0AfKDwR1LD5U5svPB/
	xQySXrj69/tONNmJqQZ/iFO7ySQ8Hqdi85r91793kZnEAkEg6mqguCg8cucktzxy
	TZbQKBizGaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36A1F3072E;
	Fri, 12 Jul 2013 20:38:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64B7A3072B;
	Fri, 12 Jul 2013 20:38:15 +0000 (UTC)
In-Reply-To: <7vfvvjjzee.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 12 Jul 2013 13:28:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA444272-EB32-11E2-BBF7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230251>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> 	git shortlog -sne
>> 		 1  A <A@example.org>
>> 		 1  A <a@example.org>
>
> This is coming from mailmap.c::add_mapping() that downcases the
> e-mail address.
>
> changed_email@example.org is mapped to a@example.org because of this
> downcasing, while "A <A@example.org>" does not have any entry for it
> in the .mailmap file, so it is given back as-is.  Hence we see two
> distinct entries.

I think it is wrong for the parser to lose information by
downcasing.

It is perfectly fine to do the comparison case insensitively, to
allow <changed_Email@example.org> in the input is mangled using the
entry for <changed_email@example.org> in the .mailmap file; it is
not fine to downcase the parsed result, especially the side that is
used as the "rewritten result" (i.e. the tokens earlier on the line),
as that would mean mangling the output.

Let me see if I can quickly whip up a fix.
