From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Thu, 22 Mar 2012 13:45:18 -0700
Message-ID: <7vd384wejl.fsf@alter.siamese.dyndns.org>
References: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com>
 <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Bo Yang" <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:45:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAosy-0006Sd-1f
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759803Ab2CVUpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 16:45:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756426Ab2CVUpW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 16:45:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6DB1605C;
	Thu, 22 Mar 2012 16:45:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bU7DGU8MuIIQEhjpDZg8RxYw5U0=; b=lCUAof
	NJCsA/WyI/s3oyz4jWDizZYGKdGxoAAHSmnYDOBUsVAsVYpDPu4jNGzeo0zS02Td
	AkayMtZUR3Cs3t33a5bxnGFLDdePQZc7LtoIp620mWAm5J3jrJAPT4CbkRxM3eAb
	9HBDll37yDtqQNAouZ/KMbtwxgzptnbFYl/mM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ch8zATVbIZVdYfhTTM2sNvkZXduR8GVv
	paOstTlHX0v0gOx/qygwmQJbwfh7dj7z2iwKJnDxa13fthHbXobFZ7sCSzHz6rf8
	3qaQbTa4DsllVhaZJguEaKunjwaKXgGiGD3ylcZZ8Qy06JYy8+uYPzn695I6hlic
	WDBz8kg/iXc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CB58605B;
	Thu, 22 Mar 2012 16:45:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 191A5605A; Thu, 22 Mar 2012
 16:45:20 -0400 (EDT)
In-Reply-To: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
 (Lucian Poston's message of "Thu, 22 Mar 2012 12:27:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0605AFC-745F-11E1-A0CE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193715>

Lucian Poston <lucian.poston@gmail.com> writes:

Administrivia: You seem to be CC'ing people who haven't touched any of
the surrounding code for quite some time, including the now-defunct
address of mine.  Please don't.

> Adjust stat width calculations to reserve space for required characters before
> scaling the widths for the filename and graph portions of the diff-stat. For
> example, consider:
>
> " diff.c |   66 ++-"
>
> Before calculating the widths allocated to the filename, "diff.c", and the
> graph, "++-", reserve space for the initial " " and the part between the
> filename and graph portions " |   66 ". Then, divide the remaining space so
> that 5/8ths is given to the filename and 3/8ths for the graph.
>
> Update the affected test, t4502.

That explains the regression you are introducing, but does not justify it.

When you start showing that line, do you already know how many columns at
the left edge of the display will be consumed by the ancestry graph part?

When the command is run without "--graph" option, the answer would
obviously be zero, but if it is non-zero, wouldn't it be a more sensible
solution to the problem to subtract that width from the total allowed
display width (e.g. on 200-column terminal, if the ancestry graph part at
the left edge uses 20-columns, you do exactly the same as the current
algorithm but use 180 as the width of the terminal).  When --stat-width is
explicitly given, that specifies the width of whatever comes after the
ancestry graph part, so there is no need to change anything.

Am I missing something, or is there something deeper going on?
