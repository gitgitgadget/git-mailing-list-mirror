From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos
 containing damaged trees.
Date: Sun, 24 Jul 2011 11:35:32 -0700
Message-ID: <7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 20:35:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql3Wf-0006ps-27
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 20:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab1GXSfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 14:35:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab1GXSfe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 14:35:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D2D337F0;
	Sun, 24 Jul 2011 14:35:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PWerVAX2spTfr73RWjyRp3jnSmY=; b=e/bZg4
	SOcE84u6z8ay0869/gFZVyDUwgn2Tg8+gv3OSl4RxzaRHmZAa/jk0YfkTcQ8zfTZ
	SZPSgf6s5s8sPDhhUiK1Y+j8IzRNGb2giglmpUa8HM08LLMOSWgMjQryJboF4Qxe
	aicWrcWzp949RqCy7KT5X1wo4GYxBxbm+o78E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R84k2wgDTAMNJAbf6s6HP6jRp2iBWBGn
	riUC8il962v91VjfYHa6sDZByWDXvs/ZYIv/X54iHpFn3qpxpE3NsP95gkWmrtf9
	gi7U4O53l7ZrlW8GlbadTrDe7WG17cpj6/ei82Nh+Y2hzvcVxMbBl1HCNLLF1DXm
	oUdDe65xGEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 652EC37EF;
	Sun, 24 Jul 2011 14:35:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B51A537EC; Sun, 24 Jul 2011
 14:35:33 -0400 (EDT)
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Sun, 24 Jul 2011 15:57:45 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B75CD6AE-B623-11E0-BD1D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177769>

Jon Seymour <jon.seymour@gmail.com> writes:

> ... In particular, it
> allows git bisect to be used to locate commits containing damaged trees.

I am afraid it wouldn't allow it, and I am not going to take this series
that adds an option to bisect to ignore errors during checkout.

Remember that bisection is to find a single event in the history whose
effect consistently persists in all the commits into the future from that
point.  For example, if you have this history:

    ---A---B---C

and there is a bitflip in a blob contained in the commit B's tree, you may
not be able to check it out. But that does _not_ mean you cannot check C
out due to a corrupt object in B. The change going from B to C may be to
remove that blob, for example. "A tree that refers to a corrupt object was
introduced by this commit" is not a single event whose effect cascades
through the history into the future [*1*].

Besides, if you have a corrupt commit, your history traversal may not even
be correct, as we won't be reading its parent pointers correctly.

Having said that, an option to bisect that does _not_ touch the index nor
the working tree at all may be a useful thing to have. The test you want
to run on the candidate revisions bisect suggests may not need a working
tree (e.g. it may be built around "git grep -e foo $revision -- $path"),
and it may work just as well for the bisection you wanted to do in your
broken repository.

[Footnote]

*1* Theoretically, you could turn it into such by using a test that wants
to traverse and verify all the objects reachable from the candidate
commit, e.g.

    $ git rev-list --objects $rev | git pack-objects --stdout >/dev/null

which would succeed on A, and fail on B and all the commits that reach B,
including C. Was that what you had in mind?
