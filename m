From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Wed, 05 Feb 2014 12:34:08 -0800
Message-ID: <xmqqob2l2ta7.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<87r47hvrqt.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:34:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9Ap-0005Ub-SF
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbaBEUeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 15:34:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341AbaBEUeN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 15:34:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBD0867DC7;
	Wed,  5 Feb 2014 15:34:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MN+ec1GnvoFR2Hot304+wj//sEw=; b=ZLU1nc
	uRriDb6i7ygxNFWVyNpL6nBLsZPTLYWIRfKzA6u+wg4dp9/Cc8pVrvxV5jqghbQ5
	aiFB7NGFwWjm2yNMY4n8b9uZtyWNP75I/4ydJdw2L5CVLGQ+rgcswAHp/ep3mZmZ
	JU7CXn18gXC2ETwHCyBjy2CxGhBCZlf2wHLmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=he84xSJaSsO5X1noYBQa/dRvXaCBnbA5
	nFls91EYdscNyR53lRebR+n6PHTMuzppQ0OKIxgwOofxMKhLIx0HgzXO+ufdgqM7
	goSgKuePLY/5s9NRgUUJOYvPuicaezbBPDT7DkWcuO2fNLiPnYXEYaDpAdEejS2X
	CZ4iXbozxRQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7728D67DC3;
	Wed,  5 Feb 2014 15:34:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F7AF67DBE;
	Wed,  5 Feb 2014 15:34:10 -0500 (EST)
In-Reply-To: <87r47hvrqt.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 05 Feb 2014 10:22:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE8BB022-8EA4-11E3-87D2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241654>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> which I think is the prevalent style in our codebase.  The same for
>> the other loop we see in the new code below.
>>
>>  - avoid assignments in conditionals when you do not have to.
>
> commit a77a48c259d9adbe7779ca69a3432e493116b3fd
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Tue Jan 28 13:55:59 2014 -0800
>
>     combine-diff: simplify intersect_paths() further
> [...]
>
> +       while ((p = *tail) != NULL) {
>
> Because we can.

Be reasonable.  You cannot sensibly rewrite it to

	p = *tail;
        while (p) {
        	...
		p = *tail;
	}

when you do not know how ... part would evolve in the future.

	if ((p = *tail) != NULL) {
        	...

is a totally different issue.
