From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fix clang -Wconstant-conversion with bit fields
Date: Wed, 16 Jan 2013 15:43:41 -0800
Message-ID: <7vpq14vglu.fsf@alter.siamese.dyndns.org>
References: <20130116182449.GA4881@sigill.intra.peff.net>
 <1358376443-7404-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvceL-0002Yz-A6
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 00:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757664Ab3APXnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 18:43:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755873Ab3APXno (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 18:43:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98660A6A3;
	Wed, 16 Jan 2013 18:43:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=opmTtdXWnoz92UomJfqSXt0RPtI=; b=JCH9hV8AdbZSVElEBJrV
	3P8/focKeLdSVKOFaUn5j06V8FBrOvyYl/PYHksSm4jlDUrCGh83R4stPgCBs03B
	ApMcjsGmeDZzqbTdMopFb08aGlNp8WOKh5Oo8FwtZYkWDUXUu7a+xaruLLneWVYi
	PqhXg5evXIZ18URD/IlqTNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RVtJdDuEYIPEGUKEQ+CW2EM7R1iWIYTVnloZkAklGpsx7Q
	aHOip2fiTeybumVHK4iq4HxMxQA52jSSPYsSK0jqYz/5LKgumWizqd18ZiTyyVCB
	rygYS/ttGCSzAv7O+8uWHs1lm6rk8X/SKfuHTFaJ7p2GDBUL/2EC3c06RYuRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89131A69F;
	Wed, 16 Jan 2013 18:43:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF3B5A694; Wed, 16 Jan 2013
 18:43:42 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FB2A458-6036-11E2-B4B3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213826>

Antoine Pelisse <apelisse@gmail.com> writes:

> clang incorrectly reports a constant conversion warning (implicit
> truncation to bit field) when using the "flag &= ~FLAG" form, because
> ~FLAG needs to be truncated.
>
> Convert this form to "flag = flag & ~FLAG" fixes the issue as
> the right operand now fits into the bit field.

If the "clang incorrectly reports" is already recognised by clang
folks as a bug to be fixed in clang, I'd rather not to take this
patch.

I do not think it is reasonable to expect people to remember that
they have to write "flags &= ~TO_DROP" in a longhand whenever they
are adding new code that needs to do bit-fields, so even if this
patch makes clang silent for the _current_ code, it will not stay
that way.  Something like

#define FLIP_BIT_CLR(fld,bit) do { \
	typeof(fld) *x = &(fld); \
        *x = *x & (~(bit)); \
} while (0)

may be more palapable but not by a large margin.

Yuck.
