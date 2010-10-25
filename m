From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests to demonstrate update-index bug with
 core.symlinks/core.filemode
Date: Mon, 25 Oct 2010 00:34:12 -0700
Message-ID: <7vtykaiv4b.fsf@alter.siamese.dyndns.org>
References: <1jqvbx3.1icsj8j1jf26lfM%lists@haller-berlin.de>
 <1jqvvxl.1e5c93nipc126M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes.Schindelin@gmx.de (Johannes Schindelin),
	j.sixt@viscovery.net (Johannes Sixt)
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Mon Oct 25 09:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAHZg-0007RK-Nv
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 09:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab0JYHe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 03:34:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab0JYHeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 03:34:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE256E1234;
	Mon, 25 Oct 2010 03:34:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iIIRKCjH9MBKEzMgG8bXXsy2NPM=; b=WCtSRW
	SZQxQhxIjxeLspA2Jd+BWE0Ljtk0vHdrq8RlhQUT0+TN9Lv2FgMlyc78+pjj3sxB
	lAjL41sc5fclsnSKHBJG2qyhlQ0sazeHZ/07BhwmlFSHYPiT8escDRr/JVE2CP/c
	Pl/oYZ9opkkQ/EepCJbyWgasqUoR4JzFCl8Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ADkYwdv1Qzp3FyhzpTgfIIBsRyU0Vnnw
	67VYBKnLiOpbAXMYNtwxR9f2FZiCtoDzh2OqWb73mz/O1NGScJrvnZmUnnQkfZUM
	SUuVf1FM4A8taVmpVlxluhkJXL4Ci4ihI5k0VealIFR3gHRp9WK57kHuzcCxQY3D
	8uEyD0KkFm0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C801E1233;
	Mon, 25 Oct 2010 03:34:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7562E122E; Mon, 25 Oct
 2010 03:34:14 -0400 (EDT)
In-Reply-To: <1jqvvxl.1e5c93nipc126M%lists@haller-berlin.de> (Stefan Haller's
 message of "Sun\, 24 Oct 2010 20\:53\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4754B876-E00A-11DF-8704-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159933>

lists@haller-berlin.de (Stefan Haller) writes:

> OK, so I found commit 2031427 (git add: respect core.filemode with
> unmerged entries), and the corresponding email thread ...

I haven't had a chance to take a look at your issue with update-index, but
the patch you quoted here was the first thing that came to my mind, and my
gut feeling is that the same fix (or at least a fix in the same spirit) is
appropriate for update-index.

Also I agree with you in that we should attempt the three-way merge of
mode bits (not just in update-index but also in add) when the user tries
to add contents from the working tree that does not have trustworthy
executable bit.

 1. If stages 2 and 3 have the same executable bits, we can take that
    result they agree upon, without any warning;

 2. If stages 2 and 3 are different, and if there is stage 1, we should
    take the one that is different from stage 1;  We _might_ want to warn
    in this case, but I am not sure.

 3. If there is no stage 1 present but stages 2 and 3 have different bits,
    we should take the bit from stage 2 (for the sake of backward
    compatibility), but I think we should warn the user that we did so;

 4. If only one of stages 2 or 3 are present, we should take the bit from
    the one that exists (again for the sake of backward compatibility),
    but we should warn in this case as well, I think.
