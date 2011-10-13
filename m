From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git pull doesn't recognize --work-tree parameter
Date: Thu, 13 Oct 2011 12:06:46 -0700
Message-ID: <7v62js4sop.fsf@alter.siamese.dyndns.org>
References: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
 <20111013155923.GA13134@sigill.intra.peff.net>
 <7vbotk6aae.fsf@alter.siamese.dyndns.org>
 <20111013183709.GB17573@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 21:06:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQcH-0006Ex-Vr
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 21:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab1JMTGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 15:06:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525Ab1JMTGt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 15:06:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 896AB3BBF;
	Thu, 13 Oct 2011 15:06:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c3v1W9DaCtyun8iNThiCvJHUq8E=; b=PrGW4D
	928dckm1DeRUdEnCv9gie3UahCWiTQqpMDAQZyHwUQmwG2WgTla5qEuWkX4ZO8yN
	isBWLN9wuvA6BEsoOh/e5m64GJgnxPus7VOF7GOMGAWJ4eyv/1QwLoOXvxIBc/GB
	7TZo/tHRpyyXA4vA+awIRQ5x86F/JLboYlcog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wCZ9IteaFzSRQPtzx8croIPR1joKYNrg
	4uIfQvBg8heq5nAN6UupXlnnDTjckc+PdxhSVq+vQYezhejYq8gWFEN1LuXtbzYT
	LgtZ9hmMtUAiwebhP3o+0dSb7jeKNAATzsx1CVAwi964R3VqPB1LICaX56TTvpyU
	jeG9fpQo37w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 811E93BBE;
	Thu, 13 Oct 2011 15:06:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05AFD3BBD; Thu, 13 Oct 2011
 15:06:47 -0400 (EDT)
In-Reply-To: <20111013183709.GB17573@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Oct 2011 14:37:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FFB0542-F5CE-11E0-B8F5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183517>

Jeff King <peff@peff.net> writes:

> And then convert the two scripts in my patch to use it (along with the
> change to require_work_tree_exists).  That would make my prior analysis
> hold, then, as the annoying do-nothing behavior of "cd_to_toplevel" only
> kicks in when we are outside the work tree (i.e., it could not have
> happened before in those scripts, because the existing require_work_tree
> call would cause us to die).
> ...
> Right. I suspect the proposed behavior for cd_to_toplevel is what they
> all would want eventually, but some scripts may need minor tweaks. I
> think we should follow the same path as require_work_tree_exists, and
> introduce the new function, use it where we know it's safe, and then
> eventually get rid of the old one.
>
> The real trick is coming up with a good name, because cd_to_toplevel is
> already taken. :)

It is not as simple as that I am afraid. We could introduce cd_to_top with
the new semantics and use it in pull and rebase, but a case that would
break is for a script (let's call that hypothetical operation "git svn
dcommit", even though I do not know if dcommit uses the real working tree
or a temporary one) that prepares a temporary working tree inside .git/svn/
and run "git rebase" there without setting GIT_WORKING_TREE to point at
the temporary directory.

With cd_to_toplevel, such a "rebase" would work and "git svn dcommit" can
take that result and do whatever it wants to the real working tree after
it finishes. When we start using cd_to_top in the updated "rebase", such a
script suddenly breaks, as we would start touching the real working tree.

So I do not think it makes much sense to add cd_to_top with updated
semantics while keeping cd_to_toplevel.

What we could do is to update cd_to_toplevel so that it would notice and
warn when the results between the historical incorrect behaviour and the
updated behaviour would be different. The warning can first read "You are
running 'rebase' somewhere in $GIT_DIR without setting $GIT_WORK_TREE; we
historically used the directory you started 'rebase' as the top level of
the working tree, and this version continues to do so, but it will change
to work on the real working tree associated with your $GIT_DIR in future
versions of git. Update your script to correctly set $GIT_WORK_TREE", and
then we transition to start using the new semantics while rewording the
warning message, and then later remove the warning altogether.
