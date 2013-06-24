From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/7] rebase: write better reflog messages
Date: Sun, 23 Jun 2013 20:26:29 -0700
Message-ID: <7vfvw8dw9m.fsf@alter.siamese.dyndns.org>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
	<1371629089-27008-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 05:26:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqxQL-0001zB-It
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 05:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab3FXD0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 23:26:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab3FXD0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 23:26:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15ACA209D9;
	Mon, 24 Jun 2013 03:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XNVC1XSbjESM9hSbkGs+z62LFR4=; b=au9rli
	aQhc6+wc9SXgU2SVwEIvmTvoTDcnfcvcbd71faThuxbvDQ1VNxc+OCuJy63p2VBX
	iyEJw6m9d3po5cd58seo41c3+0rSZ8YRvLAkmQisN6trw/odHkpb5Pka5Iyw+t7c
	jS6NNdkta1lwMCnlzjzAlPPS0/MdsNq/MVB0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aozEHYnKS1ozIatjjiHQoN5CcKm7VZP+
	oce0hUmc4zK6Aos/RxO3kK3K9/lAriy9mm7NRZAJRI7XxaTCeC57UNfnLipV84D7
	qLjODs4UrYLZBeF5upTupjT383wh4hzOyrXNwV3xlFGyA6s6xl4b8HAQeanm+kN6
	pFn9xYaYIuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C588209D5;
	Mon, 24 Jun 2013 03:26:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B727209D3;
	Mon, 24 Jun 2013 03:26:31 +0000 (UTC)
In-Reply-To: <1371629089-27008-7-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 13:34:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD443038-DC7D-11E2-B615-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228767>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> @@ -59,6 +63,9 @@ else
>  		return $?
>  	fi
>  
> +	# always reset GIT_REFLOG_ACTION before calling any external
> +	# scripts; they have no idea about our base_reflog_action
> +	GIT_REFLOG_ACTION="$base_reflog_action"
>  	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"

Why does this reroll still use this base_reflog_action convention?

The original orig_reflog_action you borrowed this may have been an
acceptable local solution inside 
git-rebase--interactive that does not call out to amyting, but
the above comment a good demonstration that shows why this cannot be 
a good general solution that scales across scriptlets.

And I already explained that to you at least twice.

cf. http://article.gmane.org/gmane.comp.version-control.git/228399

    But after writing it down this way, I realize that introduction of
    base_reflog_action (or GIT_REFLOG_NAME which is a moral equivalent)
    is not helping us at all.  As long as calls to "git" command in the
    second category exists in these scripts, GIT_REFLOG_ACTION *must* be
    kept pristine after set_reflog_action sets it, so we can get rid of
    this new variable, and rewrite 3.a and 3.b like so:

        3-a)

            GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: custom message" \
                    git cmd

        3-b)

            SAVED=$GIT_REFLOG_ACTION
            GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: custom message"
            output git cmd
            GIT_REFLOG_ACTION=$SAVED

                or

            (
                    GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: custom message"
                    output git cmd
            )

    That essentially boils down to the very original suggestion I made
    before Ram introduced the base_reflog_action.
