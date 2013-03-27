From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 16:08:46 -0700
Message-ID: <7vfvzgjv9d.fsf@alter.siamese.dyndns.org>
References: <20130327174259.373bafe1@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, josh@joshtriplett.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Thu Mar 28 00:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzT4-000760-9N
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 00:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab3C0XIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 19:08:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754578Ab3C0XIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 19:08:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C29AE7D;
	Wed, 27 Mar 2013 19:08:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4uQKGSA00ZEBXh7ukxE20SC0uww=; b=UO3rzN
	AIWV4V8sWHeJ8BmAWH26yOQf9Ojxz0bT12TnB6p+f3xPjsdze3iQ0464qVoYfJZl
	W6DLlOrklHjeoSDSxhWosVi+5Tu/bKJcX3Jl8yfWOaYgolds/7SrfRKjqn7U3t6s
	e86QrmjfKJbVbUsOGJ9VUQASM+bJhTfCho2Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZbSdUrWPXwlQp2A2hHtgHD+OEV9dO5u
	Hhps2xyHpmc9/llvAZFtRMvABzbe6CM0cXMIzK4ICoP83yIsG+5Dr0uagDpv9Yie
	fOEfwt2IiCAtXjcKB0OQRBL35zEqYgD8reeZ0XMpyl6fpSlNk/XB52+YwTpqs7kK
	hmdl9ZHaiKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 459AAAE7C;
	Wed, 27 Mar 2013 19:08:49 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7109BAE7A; Wed, 27 Mar 2013
 19:08:48 -0400 (EDT)
In-Reply-To: <20130327174259.373bafe1@hoelz.ro> (Rob Hoelz's message of "Wed,
 27 Mar 2013 17:42:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 482F265E-9733-11E2-864E-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219355>

>> Subject: Re: [PATCH] push: Alias pushurl from push rewrites

Please increment [PATCH v$n] for a new round, so that we can tell
which one is the latest.

Rob Hoelz <rob@hoelz.ro> writes:

> git push currently doesn't consider pushInsteadOf when
> using pushurl; this test tests that.

This patch is no longer "this test", and I thought you are changing
the behaviour so that the command takes it into account.

> If you use pushurl with an alias that has a pushInsteadOf configuration
> value, Git does not take advantage of it.  For example:
>
> [url "git://github.com/"]
>     insteadOf = github:
> [url "git://github.com/myuser/"]
>     insteadOf = mygithub:
> [url "git@github.com:myuser/"]
>     pushInsteadOf = mygithub:
> [remote "origin"]
>     url     = github:organization/project
>     pushurl = mygithub:project

Perhaps indent the above a bit to make it more readable?

But more importantly, isn't this a variant of what we discussed in a
separate thread about "triangular workflow", where you pull from one
place (org/project) and push to another (project)?  I thought the
conclusion from the discussion was that using url/pushurl to call
two logically diffent repositories with the same name is wrong. For
one thing, the "pretend as if we immediately fetched" update of
remote tracking branches will go out of sync, so the above is a
broken configuration, with or without pushInsteadOf.

> With the above configuration, the following occurs:
>
> $ git push origin master
> fatal: remote error:
>   You can't push to git://github.com/myuser/project.git
>   Use git@github.com:myuser/project.git

Yup, that is a documented behaviour.

> So you can see that pushurl is being followed (it's not attempting to
> push to git://github.com/organization/project), but insteadOf values are
> being used as opposed to pushInsteadOf values for expanding the pushurl
> alias.
>
> This commit fixes that.

Saying "fixes" before justifying why such a patch that changes a
documented behaviour is a good idea is a bit weak, to say the least.

Care to justify with a non-triangular example, where origin is
associated to logically the same repository?

That is, currently you can do either:

     ; Fetch anonymously
     [url "git://github.com/me/"]
        insteadOf = github:

     ; Pushing needs to go over ssh
     [url "git@github.com:me/"]
        pushInsteadOf = github:

     ; The repository
     [remote "origin"]
        url = github:project

or:

     ; Fetch anonymously
     [url "git://github.com/me/"]
        insteadOf = githubf:

     ; Pushing needs to go over ssh
     [url "git@github.com:me/"]
        insteadOf = githubp:

     ; The repository
     [remote "origin"]
        url = githubf:project
        pushUrl = githubp:project

You would need to make a convincing argument to justify why allowing:

     ; Fetch anonymously
     [url "git://github.com/me/"]
        insteadOf = github:

     ; Pushing needs to go over ssh
     [url "git@github.com:me/"]
        pushInsteadOf = github:

     ; The repository
     [remote "origin"]
        url = github:project
        pushUrl = github:project

is a good idea.  

I also suspect there could be people who rely on the documented
behaviour; they can manually rewrite their pushURL to what insteadOf
setting has been rewriting to work it around, but to them, this
change may be a needless regression.  I do not offhand how severe a
regression it is, though.
