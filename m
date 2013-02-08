From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Thu, 07 Feb 2013 22:45:07 -0800
Message-ID: <7vd2wb483w.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <20130208044836.GC4157@sigill.intra.peff.net>
 <7vliaz49sf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:45:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3hiQ-0007Dd-Eo
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab3BHGpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 01:45:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab3BHGpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:45:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67DD78DE3;
	Fri,  8 Feb 2013 01:45:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SdURLOxySbdmujMUe10lbT3NaVs=; b=vQFtCC
	lOAsAccb9l2dwbebowvNqrQitpxt3XsZcQYQUTscklIuE7EC/3QPWnBilCLr8vTo
	mkCPixkkL9GKcWrKQpoiGJU+81KI4oGphLoyNvCnXDGIMly4snqy6UXZNYCIz/bQ
	8veUFw60YoOLuzMSlOWBlNNTkQAPYfSyds6j8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oD0qjFcqaUtnYh3u0fdS/h1sme/gPNsj
	jWO+B7jLXupv0fTn2NkcLmKgG11yKtyzZ+SdpkE8iqke543+n3Vbu2vXI1sqtsGT
	woP4qvZi2j8LLIiHwYwFB+UHMKQ6UHwEWcocA+PmJaPHTBCCPdBN7xAwJmq/cuBB
	yJqmzgcBAuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B90A8DE2;
	Fri,  8 Feb 2013 01:45:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9F368DE1; Fri,  8 Feb 2013
 01:45:08 -0500 (EST)
In-Reply-To: <7vliaz49sf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 07 Feb 2013 22:08:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14531270-71BB-11E2-B522-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215762>

Junio C Hamano <gitster@pobox.com> writes:

> ....  I think the triangle
> arrangement where you want to have "this is where I fetch from and
> integrate with, and that is where I publish" is more common among
> the Git users these days.

Another thing to know about is that the recent move to change the
behaviour of "git push" to work only on one branch per default may
have to be polished and strengthened a bit.

Originally, the encouraged workflow was to perfect _everything_ that
you would push out and then with a single "git push" to publish
everything at the same time.  Both the "matching" behaviour of "git
push" which was the default, and the set of push refspecs that is to
be defined per remote, were ways to discourage "Work on one branch,
think it is OK, hastily push only that branch out, switch to another
branch, rinse, repeat".

To support a triangular arrangement well, there may need some
thinking on what $branch@{upstream} means.  The original intent of
the upstream mode specified for "push.default" is push the result
back to what you based your work on, but in a triangular arrangement
that is no longer true.  You may be keeping up with my 'master' by
constantly rebasing and then pushing out the result to your 'frotz'
topic.  You want to have a lazy "git fetch" to fetch from my
'master' (i.e. upstream), and have remotes/origin/master to keep
track of it.  You want to see "git rebase" to pay attention to the
updates to remotes/origin/master when figuring out where you forked.
But at the same time, you want a lazy "git push" to go to your
push.defaultTo repository (i.e. your publish point) and update your
'frotz' branch there---remotes/origin/master should not come into
the picture at all.  But the upstream and simple modes want to pay
attention to branch.$name.merge, which is all about the "fetch and
integrate" side of the equation.
