From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] pull: pass the --no-ff-only flag through to
 merge, not fetch
Date: Wed, 30 Nov 2011 20:58:18 -0800
Message-ID: <7vborsq45x.fsf@alter.siamese.dyndns.org>
References: <1322703537-3914-1-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 05:58:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVyj5-000731-Sr
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 05:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab1LAE6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 23:58:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041Ab1LAE6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 23:58:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67DFC5D72;
	Wed, 30 Nov 2011 23:58:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8s1SLlVaCOLJoKjmCdHE95vC67Y=; b=oXgQnG
	H//F5YCEHyyC33dSdP9c9KNhMDFXWLl71kjU/RA4nHDYgA8JCFIOnc8IOjM0jWUF
	n6x84J9V1IR1hVQJwSUWN2+1stRQVhzznE43rU00F+w+T5qrDm3HynD/UMps7LfP
	qHM7EChsJRkJMdcbV/wj94vJFfML0tIWNJ9qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NBW3kSJ13ZJZAx0KqoVfivGla5dyIwyi
	jGqcttMPZDTfhzqjzuKFDTD1N+QAB19dmN4NBknWNEukuiXxAFdaj5/QxIa+ygJR
	Gmiq6pJaz1/gksiGApJMjc7VoqlDj9q5eCznc43ISapa89sI0ks0QwW0k4vILEmT
	86cs8W5EK98=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7CA5D70;
	Wed, 30 Nov 2011 23:58:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADFC95D6F; Wed, 30 Nov 2011
 23:58:19 -0500 (EST)
In-Reply-To: <1322703537-3914-1-git-send-email-naesten@gmail.com> (Samuel
 Bronson's message of "Wed, 30 Nov 2011 20:38:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1681098C-1BD9-11E1-BAA6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186162>

Samuel Bronson <naesten@gmail.com> writes:

> Without this, pull becomes unusable for merging branches when the config
> option `merge.ff` is set to `only`.
>
> Signed-off-by: Samuel Bronson <naesten@gmail.com>

I wonder why you need this. We have "git config --unset merge.ff" after
all. From purely mechanstic point of view, being able to temporarily
defeat a configuration variable makes perfect sense, but from the point of
view of workflow, I am not sure if it is a good thing to even allow it in
the first place in this particular case.

Setting merge.ff to 'only' means you are following along other people's
work and making nothing new on your own in this particular repository, no?
Hence you won't be asking the upstream to pull from this repository, which
in turn means that even if you made a merge by temporarily defeating the
configuration setting with this patch, your future pulls will no longer
fast forward, until somehow the upstream gets hold of your merge commit.

By the way (this is a digression), I also have to say --no-ff-only is too
*ugly* as a UI element, even though I know "git merge" already allows it
by accident.

"ff" is a tristate. By default, fast-forward is done when appropriate, and
people can _refuse_ to fast-forward and force Git to create an extra merge
commit. Or if you are strictly following along, you can say you _require_
fast-forward and reject anything else. So it may make the UI saner if we
updated the UI to allow users to say:

	--ff=normal	the default
        --ff=never	same as --no-ff that forces an extra merge commit
        --ff=required	same as --ff-only

while keeping the current --ff-only and --no-ff as backward compatibility
wart.

I dunno.
