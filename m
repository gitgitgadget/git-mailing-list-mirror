From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] bundle: plug resource leak
Date: Wed, 02 Mar 2016 01:00:38 -0800
Message-ID: <xmqqoaax45l5.fsf@gitster.mtv.corp.google.com>
References: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com>
	<20160302085432.GB30295@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 10:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2eO-0004Bt-2P
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 10:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbcCBJAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 04:00:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753219AbcCBJAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 04:00:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 60A6640EF5;
	Wed,  2 Mar 2016 04:00:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SoZhKKOhrVF6QrswATqyv+7pwUw=; b=XYMR4+
	EJHcqi0OIPqYFeKAq2FHHtdAKjoEKbHyE+5La8pv/hm9Azq3ptBYqRKENd8/boNg
	KGHmacJNIf1n72rvt+kZSMrhgFxt9QpQ0nTHk1NxLUfINVViNAeOjEQZUr+d62Jw
	gzqBIVJe9J+kwF/ae1CzgxECBaEQ3uXLoBVyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ny7iJsiFxtc28uPSsqBhpsHlSalfz+de
	vFqnua6jkcUPNP8OSg310mxIZXUC/72HqvI/p/X6ATVMBfJ4qLCzAZ4XWjoG+UwK
	yaxA6ZEexD3c38ZRyayBEfXLMV98j6Vr4uxtgvOEMe74vouPHRJRsenJ3Dkq8tzL
	GxUVnvLKSRE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5739540EF4;
	Wed,  2 Mar 2016 04:00:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D21D940EF2;
	Wed,  2 Mar 2016 04:00:40 -0500 (EST)
In-Reply-To: <20160302085432.GB30295@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Mar 2016 03:54:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D39D2B2-E055-11E5-94C8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288112>

Jeff King <peff@peff.net> writes:

> I do find it hard to believe that the bundle code had to invent its own
> ref storage data structure, and couldn't just use "struct ref" like all
> of the other code. It doesn't look like we ever sort it or do
> non-sequential access. The linked-list "struct ref" probably would have
> been fine.
>
> Not a problem you are introducing, of course, but if you are touching
> this code a lot, it might be worth seeing how painful it is.

The bundle code being fairly old, I actually wouldn't be surprised
if it predated the wide use of "struct ref" ;-)

It is not performance critical to add entries to the list of
prerequisites or references (i.e. it is OK to have these as linear
lists, not linked lists of "struct ref"), and these lists do not
have to be ultra-efficient in their storage use (i.e. it is OK to
replace these with "struct ref" linked lists), so we could go either
way.  It's not like we would be using a lot of helper functions we
already have for "struct ref" in this code, so I'm inclined to give
a very low priority to the task of rethinking this data structure.
