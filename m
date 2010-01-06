From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A question about changing remote repo name
Date: Tue, 05 Jan 2010 17:02:58 -0800
Message-ID: <7vd41oqc3h.fsf@alter.siamese.dyndns.org>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
 <c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com>
 <60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
 <c1b8b6671001051607j6b6398d8gf08f7615a38de64e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dongas <dongas86@gmail.com>, git@vger.kernel.org
To: Russell Steicke <russellsteicke@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:03:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKIv-0005dv-1E
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab0AFBDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754318Ab0AFBDM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:03:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab0AFBDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:03:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07CAAAD472;
	Tue,  5 Jan 2010 20:03:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hOIlQJ8+qycqOEOOEC9wCvDA53w=; b=AaWUc5
	/koPJu4HfVN9S/xNf90t2pi8pVemzc6N+Hzkj00zZfomAavVpRcv0ddEBMPE644k
	HwgZJqgjMcf/sNbrEa4o8LWvHjnPFDli9IpIbWeiDDsQ/uYHRbFlVh8KBp+VP6TM
	bGoWWH5qHSQiKODF9Uh523hg5K0Mq1rcTuUaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uryYCo8t290CCXmY+uQd+o+TMroGYVOK
	tPB6Vncg/SKt3lYDh13dwBfW34TJ73yLsfb1qZCSQoCi4gD1A9saggn9t9Cc/iK1
	AMUiKyCRRqtF055xePh0j7OwYbv7QnpPUYfvrI3kj+dpTE03S2GG4iEeDf6uJDgh
	03Fm4R0B+jE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD076AD46B;
	Tue,  5 Jan 2010 20:03:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 643EAAD46A; Tue,  5 Jan 2010
 20:03:00 -0500 (EST)
In-Reply-To: <c1b8b6671001051607j6b6398d8gf08f7615a38de64e@mail.gmail.com>
 (Russell Steicke's message of "Wed\, 6 Jan 2010 08\:07\:48 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3EA9FA42-FA5F-11DE-91CE-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136224>

Russell Steicke <russellsteicke@gmail.com> writes:

> Ah yes, I forgot about those files.  I _think_ (but I'm not certain
> without digging into the code) that it's always safe to rm
> packed-refs, as that file is a cache for quicker access to the refs.

No what you think is incorrect, no it is not safe at all, and no it is not
a cache.

refs are created loose as files under $GIT_DIR/refs/.  When pack-refs is
run (either from the toplevel or as part of gc), these loose ref files are
removed and instead written to $GIT_DIR/packed-refs file.  When a new ref
is created or an existing ref is updated, only $GIT_DIR/refs/ is modified.

When reading or enumerating, a loose ref, if found, is used.  Otherwise
a record in packed-refs is consulted.  The consequences are:

 - If you have $GIT_DIR/refs/heads/master and at the same time, an entry
   for refs/heads/master exists in $GIT_DIR/packed-refs, removing the
   entry in packed-refs happens to be safe, because it was already masked.

 - If you do not have $GIT_DIR/refs/heads/old, but an entry for
   refs/heads/old exists in $GIT_DIR/packed-refs, removing the entry in
   packed-refs means you lose the "old" branch.  You don't want to do
   that.

 - When deleting a ref, we remove it from $GIT_DIR/refs/, but at the same
   time, if packed-refs contains an entry for it, we remove it from
   there.  Otherwise, the removal of the loose one will unmask the stale
   entry in packed-refs file.
