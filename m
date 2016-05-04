From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unary minus operator applied to unsigned type, result still unsigned?
Date: Wed, 04 May 2016 16:19:56 -0700
Message-ID: <xmqqoa8lcswz.fsf@gitster.mtv.corp.google.com>
References: <74B59A4DF45C45AF9CDCF6662DDAEF1E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 05 01:20:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay65j-00050X-NI
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 01:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbcEDXUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 19:20:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751132AbcEDXUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 19:20:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E634D19293;
	Wed,  4 May 2016 19:19:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BIKlB5Uf6FZZlUOSKN+S4gXqtJU=; b=AshLmF
	As0KUNVMdhXXCYrUlvUDllwK//+AabTJCY454/IDd5q99dlXWn4BgkO1qcBMDtmC
	m3k1MdTnAcOs/JE8WLEzFi4WlL9/EmNx/MBfG58e04CGWW+kDrB8Ke5oJME8zwft
	PrReYMIcwA7lu2A34rskuTxTblUeyrBqEdNIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iq8skipbY/UK+pKecRjmd4lW2s4vahfl
	idiKXzqmIAXprvXZ7iKBijSdKBh4Zj8sDzbroH0LT8CoU9Gac0N7B/oOpoCbmhcB
	r0Q2y60yVrTvDTufFK5s17I1F3sktCHQPEpyqFfPzi7BuWO1WR7BEuXwZOaCj9Ox
	LsUElVuS+Yo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD9FF19292;
	Wed,  4 May 2016 19:19:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59FE719291;
	Wed,  4 May 2016 19:19:58 -0400 (EDT)
In-Reply-To: <74B59A4DF45C45AF9CDCF6662DDAEF1E@PhilipOakley> (Philip Oakley's
	message of "Wed, 4 May 2016 23:59:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7EC708E-124E-11E6-983B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293622>

"Philip Oakley" <philipoakley@iee.org> writes:

> I'm working on building Git on Visual Studio as part of the Git for Windows
> capability.
>
> The MSVC compiler is reporting:
>
> 1>..\sha1-lookup.c(100) : warning C4146: unary minus operator applied to
> unsigned type, result still unsigned

> 1>..\sha1-lookup.c(316) : warning C4146: unary minus operator applied to
> unsigned type, result still unsigned
>
> the two lines of code are the same, and the message suggests a bad
> return value:
>
> #100: return -lo-1;
>
> #316: return -lo-1;
>
>
> Should these be protected by an appropriate brackets/calculation
> (-1-lo) ? Or does
> gcc use an alternate assumption about unary minus conversion for functions
> returning int?

I think -lo-1 (which is carried out as unsigned) is further casted
back to signed int as part of the return from the function whose
type is signed int.  This may be portable in practice, but changing
type of lo to signed int may be prudent.

sha1_pos() uses size_t, but returns "int", which is inconsistent
(size_t could be much larger).  Either using int for hi/lo/mi, or
using ssize_t and returning ssize_t would make sense.
