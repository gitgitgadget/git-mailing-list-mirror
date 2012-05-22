From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: avoid buffer overflow in format_person_part
Date: Tue, 22 May 2012 13:53:57 -0700
Message-ID: <7vy5ok2aze.fsf@alter.siamese.dyndns.org>
References: <20120522054508.GA10576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 22:54:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWw5v-0000z8-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665Ab2EVUyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 16:54:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932326Ab2EVUyA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 16:54:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0132A8E9F;
	Tue, 22 May 2012 16:54:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hfs7crHAeSZw
	NJ2jAix63ElCW98=; b=XVXw5CIjNEeEMuX275YcluUgpH3uFOFB1VDzH9DXWbGN
	GFf7iRyWiSeGs2OqwFy8PvNOujOAkwRFhg2f9OpmtjF4A2GEmALToRp4597ffVnQ
	9o6R6GHTaT/Vu0h8nuvOBCWCfOae56HFkaipdOUkgh1rTJzvAmiPfCew2ZSCEt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ov1+b9
	Xnh1JhnaEhEF17C3NcNTRcS5QUxT7H/0tr4U7is16qNVYmnXgxB36KvArK1/VHV4
	aa16l8+by1fpoORi6QvVG+QXNN9r8+EF5J7I5/l9QaAbW+C8IjxMEvJFxz9RyOAL
	dnW/DXk3/88oj571pK9pFKRfI+L8NiKLLK/FM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC61F8E9E;
	Tue, 22 May 2012 16:53:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6690A8E9B; Tue, 22 May 2012
 16:53:59 -0400 (EDT)
In-Reply-To: <20120522054508.GA10576@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 22 May 2012 01:45:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4118AFA6-A450-11E1-A6EE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198252>

Jeff King <peff@peff.net> writes:

> A more ideal solution would be for mailmap to grow an
> interface that:
>
>   1. Takes a pointer and length combination, instead of
>      assuming a NUL-terminated string.
>
>   2. Returns a pointer to the mailmap's allocated string,
>      rather than copying it into the buffer.

I was looking at Ren=C3=A9's patch to refs codepath that converted some=
 "we
allocate because callee wants to have NUL-terminated strings" functions=
 to
take counted strings (or whatever we want to call it---perhaps "string
slices"?), and it appears that we may benefit if more callers that do n=
ot
have to own strings that comes to them used them instead of NUL-termina=
ted
strings as their interface.  At some deep point near the leaf of the
callchain, they may need to be converted in order to call external API
(read: POSIX) that takes NUL-terminated strings, but internal callchain
like the mailmap one, if done carefully, should let us avoid extra
allocations.
