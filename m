From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patches for git-push --confirm and --show-subjects
Date: Mon, 14 Sep 2009 17:46:38 -0700
Message-ID: <7v7hw19gr5.fsf@alter.siamese.dyndns.org>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
 <7vpr9ugxn5.fsf@alter.siamese.dyndns.org>
 <1252895719.11581.53.camel@localhost.localdomain>
 <alpine.LNX.2.00.0909141745410.14907@iabervon.org>
 <1252970294.11581.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Owen Taylor <otaylor@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 02:46:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnMC5-0007cg-Qy
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 02:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZIOAqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 20:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZIOAqo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 20:46:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZIOAqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 20:46:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ECD932F24;
	Mon, 14 Sep 2009 20:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YhzK4kg9T1MZSCfYtFNj3eLIeaw=; b=BDztUS
	DUK8zvU4W21u3/Lfd8XE5pADl3NKQ6xK7cPwv7cUy9jHwnxsDaZilUZ28+o5FLw/
	1TxDec6bkmrl8Djw2M1ax68SeVPhuq6oogoZmPbTL3fVhzl5gKi5iBCgvifbs4jp
	HlZn5y+MNodcfGIxClEFi0CG305yQRWmM6EyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=knZcCIQMJusNww/+MRaTa3K2TCSu/TgT
	jyHcQTqNo3M0SyOa39fBBjTIAu1JJkJwj6+Z7fFxZeq+aiUj/12JJBoY3vnDCmuz
	VtsUN+WBvU5DEY4LqsZOo5riKvS4D3Ji5pjUzEl3z19Bf7VL6B3qfRM2B69IowOf
	hV9BVWgA66I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05C1332F22;
	Mon, 14 Sep 2009 20:46:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B01032F21; Mon, 14 Sep
 2009 20:46:40 -0400 (EDT)
In-Reply-To: <1252970294.11581.71.camel@localhost.localdomain> (Owen Taylor's
 message of "Mon\, 14 Sep 2009 19\:18\:14 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D63B23A-A191-11DE-A624-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128503>

Owen Taylor <otaylor@redhat.com> writes:

> If I can figure out the rest of it, I'll look at adding a hook on top as
> a sweetener :-)

Please don't.

I seriously suggest you start from, and stick to, nothing but a hook.

The pre-push codepath is conceptually very simple --- something needs to
inspect a list of <ref, old, new> and say yes or no.  But what the users
want needs great customizability (e.g. Daniel's sign-off validation
example).  It's the prime example of codepath that should have a hook and
no built-in policy logic.

You have to enable the necessary hook in all your repositories, and if
that bothers you, then *that* can (and should) be solved as a separate
issue by devising a mechanism that can be extended to the other hooks to
solve the same issue once and for all.

E.g. perhaps in $HOME/.gitconfig, you may want to allow

	[hook]
        	prePush = $HOME/.githooks/my-pre-push-hook
                preCommit = $HOME/.githooks/my-pre-commit-hook

Lack of a general mechanism to allow users to say "I want this hook to
apply to all of my repositories" is not an excuse to add tons of complex
code in the codepath.  Just give users the mechanism and leave the policy
logic to them.
