From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] attr: more matching optimizations from .gitignore
Date: Fri, 05 Oct 2012 11:48:54 -0700
Message-ID: <7vy5jku549.fsf@alter.siamese.dyndns.org>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
 <1349412069-627-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 20:49:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKCxQ-0000eH-GT
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 20:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759Ab2JESs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 14:48:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101Ab2JESs5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 14:48:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CB488E56;
	Fri,  5 Oct 2012 14:48:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NjZyyC+MZ9Jg
	HY8oNl1wIOYsM8A=; b=b3nzuFHSxHt9ReTe0i1T7eIuu22fZ8y7ArTiS5e84wdp
	2bcu6eUFzvQEwuy5wGq1gEI/DV9x4HA5rvoeQlXYhXPwG5iUrRNqHpzhbsS85p7n
	Zq/nrSpflOaXeiQ5QSe0MA8bQe8THLXye/q97OvjrnV3FmWnQgRwwekc402jr5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R4YrJh
	4Y3NH4vx/ppHRUwVwA5CuKJrr1m0BKQHhNtZWZqirkt1GuaDhNWF3vEEXCsSn9Hv
	SB4/Nx1L4yGWv9blXz7Sd/mRLJpdvbtatFYEg0mq5Y0kyf6ORSMubn2C1hvV7e7H
	yMjCn6FEf07KBIhxP9Oyd3OzgjwxECw8sjCrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AE4E8E55;
	Fri,  5 Oct 2012 14:48:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05F358E54; Fri,  5 Oct 2012
 14:48:55 -0400 (EDT)
In-Reply-To: <1349412069-627-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Fri, 5 Oct
 2012 11:41:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50E70FC6-0F1D-11E2-8EAD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207114>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +Unlike `.gitignore`, negative patterns are not supported.
> +Patterns that match directories are also not supported.

Is "are not supported" the right phrasing?

I think it makes perfect sense not to forbid "!path attr1", because
it is unclear what it means (e.g. "path -attr1" vs "path !attr1").
So I would say "Negative patterns are forbidden as they do not make
any sense".

But for the latter, I think it makes a lot more sense to just accept
"path/ attr1" and doing nothing.  The user requests to set an
attribute to "path" that has to be a directory, and there is nothing
wrong in such a request in itself.  But nothing in git asks for
attributes for directories (because we do not track directories),
and such a request happens to be a no-op.
