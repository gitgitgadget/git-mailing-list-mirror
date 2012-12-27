From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "fatal: git-write-tree: error building trees" from `git stash`
Date: Thu, 27 Dec 2012 12:11:37 -0800
Message-ID: <7vhan7l0g6.fsf@alter.siamese.dyndns.org>
References: <1356631626.13818.126.camel@umgah.localdomain>
 <7vsj6rl456.fsf@alter.siamese.dyndns.org>
 <1356634556.13818.136.camel@umgah.localdomain>
 <20121227190542.GB28811@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Vandiver <alex@chmrr.net>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 27 21:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToJo7-0001cN-VU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 21:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2L0ULm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 15:11:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab2L0ULk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 15:11:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE11FAB6F;
	Thu, 27 Dec 2012 15:11:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yBm6AHpIQzTUGjmIdr1mjY6Sv84=; b=rIkQqi
	9uaArV3G04+ANz6yYcg8gPwOWnLGWMzYkh/dCzLYFCLBgQFf8Zks/reSh6zHSi4z
	mGRHkrVhHwO+1545EH6R+mTVT/AY+rPuOZm4u+HXeDfNay9ddj2PkWg7cYX9UHS+
	T1rgkx4vBWGZ/67/+2Pp2MNGEmCpV8Ax3pZjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FNjL/8H9kjrmNR5bOAXTEt1yeJ24nidv
	SWYSXeBvLg+cuXjJRASvikSgx1+9QrXYCdVwHenZ2lAL130uZqFtZZceOBI6ouvk
	t3KQ7euauOSITqCU91cILEbAIC7ZDxAmecXQdyc6niAGn1vgWkNXn5ZVEuXHeOGP
	IY32sipAIGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA7CDAB6E;
	Thu, 27 Dec 2012 15:11:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2478BAB6D; Thu, 27 Dec 2012
 15:11:39 -0500 (EST)
In-Reply-To: <20121227190542.GB28811@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 27 Dec 2012 14:05:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F710D60-5061-11E2-8DA4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212214>

Jeff King <peff@peff.net> writes:

> but I suspect it is not sufficient:
>
>   1. There are other code paths that will end up in write-tree which
>      should probably be protected, too.

Among 6 calls to write-tree, only the first ones in create_stash and
apply_stash are about the index the user originally had.  If the
only expected failure case is unmerged entries, it should be
sufficient to protect these two (and the one in apply_stash is
already covered, I think).

>   2. Unmerged entries are only one reason that write-tree might fail.
>      It's OK not to catch them all (since ultimately write-tree will
>      complain if need be), but we may want to also handle intent-to-add
>      entries with a nicer message.

Hrmph.

We used to fail write-tree when I-T-A entries existed and relied on
that behaviour to implement "no state lost"; as we broke write-tree
recently by allowing to write a tree out by pretending that I-T-A
entries do not exist, I think we broke it.  Stashing with I-T-A and
then unstashing it may lose the file.  Sigh...
