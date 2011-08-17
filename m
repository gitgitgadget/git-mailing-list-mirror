From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Wed, 17 Aug 2011 11:41:41 -0700
Message-ID: <7vhb5fev8a.fsf@alter.siamese.dyndns.org>
References: <1313569298-3879-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 20:41:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtl3o-00034a-1Z
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 20:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1HQSlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 14:41:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab1HQSlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 14:41:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D376C3AE0;
	Wed, 17 Aug 2011 14:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qllBw4jL1MtGSyj45f27a2pfrLk=; b=HD5Szx
	bvdM4e85D/ubN9jCbcLbFBe4tbRqrMibYtLNgGwXh32arKpVLF/mwJxdKY5xKnrn
	MVkDauFPns3aSE00n6IikUGQFRpLY5Vc0ow2l1K6XEw+AKw7cwxSvoYTIJ1PYgR7
	PGIN8Hs2A3MkhwkzFvbWKQNPVKoWKZLe39k8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DHjexiQ3vEzuvGkSxJnkIjaJK7CtddI8
	mRcoq/Y6r8O/JqhnV5OtNZv9gSSKgfBNVh7cAXJClfh52ON8iLnPn0NkjNknZ8lp
	ydUZ/mroYYqGN2Wcs++6B6Mm4C8dHQ4VrMZ4HLQdK1bJ2fj+GcPdE1BtBr1Iw8fR
	P4GvCpsIB/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9E2D3ADF;
	Wed, 17 Aug 2011 14:41:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4051C3ADD; Wed, 17 Aug 2011
 14:41:45 -0400 (EDT)
In-Reply-To: <1313569298-3879-1-git-send-email-conrad.irwin@gmail.com>
 (Conrad Irwin's message of "Wed, 17 Aug 2011 01:21:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8EB85EEA-C900-11E0-801F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179524>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> Before this change, it was comparatively easy to create a confusingly

Drop everything before the ", ".

> named branch (like "origin/master" or "tag.1"). The former case is
> particularly biting to newcomers, who suddenly find themselves needing
> to handle nuances of the refs namespaces.

If you start forbidding certain names, newcomers will need to be exposed
the same nuances to understand why what they wanted to do is not allowed,
so that is not an argument.

My preferences (take them as "the ground rules" if you want) are:

 - We don't disallow what we have long allowed, without a good reason;
 - We make sure new people will get a warning with useful advice.

I would be happy to see the end result that warns when the end user
creates a branch (or a tag) that is ambiguous _when_ it is created (not
"much later, when we noticed there are ambiguous refs"), and offers an
advice message to use "branch -m" to rename it away (control the message
with a new "advice.*" configuration and unless explicitly declined with
it, always give the advice).

> In both cases, git commands would omit a warning about "ambiguous refs"
> if they noticed that this had occurred,

Assuming that you meant s/omit/emit/, I do agree that what we do right now
is suboptimal. I just tried these two:

	$ git branch v1.0.0
        $ git checkout v1.0.0
        warning: refname 'v1.0.0' is ambigous.
	$ git branch -m v1.0.0-branch

        $ git checkout -b v1.0.0
        Switched to a new branch 'v1.0.0'
	$ git checkout v1.0.0
        warning: refname 'v1.0.0' is ambigous.
	Already on 'v1.0.0'
	$ git branch -m v1.0.0-branch-2

We should be giving these warning messages immediately after creating
potentially problematic refs, i.e. just after "git branch v1.0.0" and
"git checkout -b v1.0.0". The user experience should look like this
instead:

	$ git branch v1.0.0
        warning: refname 'v1.0.0' is ambiguous.
        advice: you may want to rename it to an unambigous name with
        advice: git branch -m v1.0.0 v1.0.0-branch
	$ git branch -m v1.0.0 v1.0.0-branch ;# thanks for an advice

        $ git checkout -b v1.0.0
        warning: refname 'v1.0.0' is ambiguous.
        advice: you may want to rename it to an unambigous name with
        advice: git branch -m v1.0.0-branch-2
	$ git branch -m v1.0.0-branch-2 ;# thanks for an advice
