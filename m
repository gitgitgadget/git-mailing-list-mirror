From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] t7900: Start testing usability of namespaced remote refs
Date: Mon, 06 May 2013 18:29:11 -0700
Message-ID: <7va9o7pogo.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 07 03:29:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZWiW-0008IM-1X
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 03:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727Ab3EGB3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 21:29:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756681Ab3EGB3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 21:29:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3170D12485;
	Tue,  7 May 2013 01:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZI3MXi1QhrtRxy+uJ9zbdsKyLls=; b=VgLpnf
	Y5eH5LO3czPJnDFFkWAdBEWNNyQpN+tx/HjptFcvuJ2wqCWTAitaot5JuzcQ332t
	HfbsMRYRyOWNk6pdZlnV5HcbixzR6k/sprO2jPESENrlR8d9Yj2TYPBXsAwR8CH1
	ZOoTFNYv5hSiC+OjHpz1eALlvf1pd/bube78Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sGig3db80u/LYLMO/pzzBbgQg0eWjw5o
	16CU3iKCuhx9h0glu0RVWzqHxHFOXYIhCdiR3DJwKeTA/iJR8dCm7kbf6eQcdkxx
	vY1CITAbBwMxOMrVW4ZwhNJ5E0T8d8oUTQTZn7NR5Tmg8qRY+vOqp2OjeazvxgQC
	q9d1cOZASDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2998912484;
	Tue,  7 May 2013 01:29:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D9611247B;
	Tue,  7 May 2013 01:29:13 +0000 (UTC)
In-Reply-To: <1367711749-8812-3-git-send-email-johan@herland.net> (Johan
	Herland's message of "Sun, 5 May 2013 01:55:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 866E121C-B6B5-11E2-809A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223516>

Johan Herland <johan@herland.net> writes:

> +test_expect_success 'work-around "clone" with namespaced remote refs' '
> +	rm -rf client &&
> +	git init client &&
> +	(
> +		cd client &&
> +		git remote add origin ../server &&
> +		git config --unset-all remote.origin.fetch &&
> +		git config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/heads/*" &&

If you were to do this, I think you should drop the "remote add
origin" step and illustrate what configuration variables should be
prepared (at least minimally---the final implementation of "git
clone --separate-remote-layout" may add some other configuration
variable as a hint to say "this remote is using the new layout" or
somesuch) in this "client" repository.

That would make the test more self documenting.

I am not convinced that it is a good idea to reuse "remotes/origin"
hierarchy which traditionally has been branches-only like this,
though.  It may be better to use

	refs/$remotes_new_layout/origin/{heads,tags,...}/*

for a value of $remotes_new_layout that is different from "remote",
and teach the dwim_ref() machinery to pay attention to it, to avoid
confusion.  Otherwise, you wouldn't be able to tell between a topic
branch that works on tags named "tags/refactor" under the old layout,
and a tag that marks a good point in a refactoring effort "refactor"
under the new layout.

> +		git config --add remote.origin.fetch "+refs/tags/*:refs/remotes/origin/tags/*" &&
> +		git config --add remote.origin.fetch "+refs/notes/*:refs/remotes/origin/notes/*" &&
> +		git config --add remote.origin.fetch "+refs/replace/*:refs/remotes/origin/replace/*" &&
> +		git config remote.origin.tagopt "--no-tags" &&
> +		git fetch &&
> +		git checkout master
> +	) &&
> +	test_clone client
> +'
> +
> +test_done
