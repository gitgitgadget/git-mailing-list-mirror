From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating
 submodules"
Date: Fri, 09 Dec 2011 22:30:23 -0800
Message-ID: <7vborhaqgw.fsf@alter.siamese.dyndns.org>
References: <20111109174027.GA28825@book.fritz.box>
 <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box>
 <loom.20111210T062013-538@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leif Gruenwoldt <leifer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 07:33:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZGV8-0008KK-NE
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 07:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab1LJGa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 01:30:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026Ab1LJGa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 01:30:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DCD92535;
	Sat, 10 Dec 2011 01:30:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pu+7ak0kRO3CItOawLvHMzkIADc=; b=bG5kC9
	pP1ISCTckLlv/Sh8Al21hNJ92rdVkAmvMC9feUzhSRRLC/VulCWCwSn3UCCtQXhg
	cyVyRIeHtF8SEK0g1MnA+7bZnAnTTBpvudx7eGa0g8oz4txHd4MN6PIzG5kFKTky
	jhGhHNE4YiWHpZr/ucFI5eIUZvW7xhFT7IXzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nwHOZhxvScsktJL9rRLgl+9sQbj742Qr
	gq1aZCIoAw1xwHH8h5UgPytUeIfYcm1TLJqgMHU0R7trP5FlWO/eJ7AU7lFvJXOQ
	tc3ZyNNLupOOK2i8+DLOP3M2mMm4lCPYGuA3L4ziqikbA27wlV1KVbmJQ+FUPQcc
	qrbsObtXHwo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C4B92534;
	Sat, 10 Dec 2011 01:30:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4F6F2533; Sat, 10 Dec 2011
 01:30:24 -0500 (EST)
In-Reply-To: <loom.20111210T062013-538@post.gmane.org> (Leif Gruenwoldt's
 message of "Sat, 10 Dec 2011 05:50:59 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7183315E-22F8-11E1-BB86-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186726>

Leif Gruenwoldt <leifer@gmail.com> writes:

> Our use case is as follows. We have several repositories for our common code 
> (commonA.git, commonB.git, etc) and a few different products that leverage these 
> common repos (productA.git, productB.git, etc). When one of the products is in 
> heavy development we often need to do a lot of work in the common repos. Having 
> to increment the sha1 of the submodules to track the latest tip would be overly 
> arduous. (Obviously when development of the product stabilizes we would want to 
> change to anchoring to a specific sha1 in the common repos).

Nobody forces you to update the commit in the submodule bound to the
superproject tree every time you update areas that are unrelated to or
independent from that frequently updated submodule.

During the period the submodule is so often updated that you feel "having
to increment ... would be overly arduous", it does not matter which exact
commit in that submodule is used in the tree for your other modules and
the superproject. Otherwise you _would_ want to say something like "for
this entire tree state from the top-level superproject to correctly work,
we absolutely need to have this commit, not any commit that is older and
is known to be broken, from this submodule", and cannot afford to use
floating.

Which means by definition anybody who wants floating can instead let such
an often updated submodule stay somewhat stale by not running "submodule
update" for it unnecessarily.  In a well-modularized set of projects, the
interface to the busy submodule may be stable and I can imagine that kind
of arrangement would well be not just possible but practical, and probably
yours may be such a project.

So that use case does not sound like a good rationale to require addition
of floating submodules.
