From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reduce cost of deletion in levenstein distance (4 -> 3)
Date: Tue, 29 May 2012 11:25:15 -0700
Message-ID: <7v4nqy6e0k.fsf@alter.siamese.dyndns.org>
References: <1338134578-29011-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue May 29 20:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZR6h-0001nR-8w
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 20:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab2E2SZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 14:25:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab2E2SZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 14:25:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B689B8C95;
	Tue, 29 May 2012 14:25:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dMK7Em49ZAO46g6r3ATfyPiwv6k=; b=bHbh3J
	kiB23oqW3rAeSwprnKVF6PDFAY1Y3ozCIp9BtTryE5mX1n0xqp7E8nRsqry1J0qa
	x8TmWAIiZS9PBVxTIQ35KbOqV+aXqKHovv7TrYdmTEDDibfb3EAzN1C3i5J/ELRz
	sARVgizBxxljYP+w4qc8AZ5ngHudpKHwIwqw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c31Zxlx2t3q1ABEF9Ri+sXENPRt1Veav
	1KMPDUnQPLaEjxyEERvyu5w8DZuKDGU8pej7kq5wvOwMZdzfxY0iY3UmNq9BsDkE
	eyPvNkLXiy9+nYE/4h1h49gN7mHk+XVqORqkwapOfL0t6GwoHhPICHcQHujX6Nmw
	uoETKvuQLbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADBCA8C94;
	Tue, 29 May 2012 14:25:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35F658C90; Tue, 29 May 2012
 14:25:17 -0400 (EDT)
In-Reply-To: <1338134578-29011-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun, 27 May 2012 18:02:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3F182B8-A9BB-11E1-BAF7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198746>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Before this patch, a character deletion has the same cost as 2 swaps, or
> 4 additions, so Git prefers suggesting a completely scrambled command
> name to removing a character. For example, "git tags" suggests "stage",
> but not "tag".
>
> By setting the deletion cost to 3, we keep it higher than swaps or
> additions, but prefer 1 deletion to 2 swaps. "git tags" now suggests
> "tag" in addition to staged.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> The RFC sent earlier [1] didn't receive negative comments, so I think this
> is a good change.
>
> http://thread.gmane.org/gmane.comp.version-control.git/196457

Lack of objections is never a good reason to assume it is a good
change.  In this particular case, I think the reason why you saw
no comments, either positive or negative, was because nobody came up
with a more "scientific" way to judge the weighting.  Choosing
between "tag" and "stage" given "tags" is just one datapoint, but
does not convince anybody there are not surprising combinations
where this change affects negatively.

I wonder if we can mechanically find a set of parameters that
optimally separates the built-in commands by computing N^2 distances
(e.g. compute "tag" and all other command names and record
minimum. Do so for all other commands. Now fudge the parameters and
repeat to see if it results in better minimum separation.  Something
like that).

Having said all that, until somebody comes up with a better method
of judging, I'd say that the best thing we could do is to apply this
patch and see if anybody finds a "surprising" case where this leads
to a regression.

Thanks.
