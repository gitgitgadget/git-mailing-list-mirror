From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: check sig of all tags to given object
Date: Fri, 03 Feb 2012 21:16:28 -0800
Message-ID: <7vwr83jhzn.fsf@alter.siamese.dyndns.org>
References: <1328318751-4470-1-git-send-email-tom.grennan@ericsson.com>
 <7v8vkjl24d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com
To: Tom Grennan <tom.grennan@ericsson.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:17:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtXzg-0006fX-Ub
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 06:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897Ab2BDFQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 00:16:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855Ab2BDFQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 00:16:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DCD722EC;
	Sat,  4 Feb 2012 00:16:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WmLpSKGgdtTB1Dz1nZMZNjMjvoU=; b=HbOIyS
	A8H4dlSNY7tFGX73jkCOfGgrntTgZpcSbTUEC3LsFaQdOfZerndLPhUIH0HQTVSj
	aWJNErTT11w5z4MqsVi7d8caXvHLp5MShAevDv9lYDhw+u7de4bvMlMFV7Nw5VYX
	2wQ39zQMkHD3M7JqdUiMtPjXn7pHMishJTEEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=thZ4fBpttgTnkuliQS4/3PSOgHXx2WFU
	qcwa3FDnxzxC0P4tEd6rvxGAqaaCfChnE7UySpBocVWYl2W9ocSxcw64NeWUPpUr
	KaPb0CB8GNYTjcD9C0rKFXH8OxdZqmaxv3NQ1jpnmXkZLzojMW7yOr9Yg+3HckJ7
	5awWSHBS74k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 439EA22EB;
	Sat,  4 Feb 2012 00:16:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE9EF22EA; Sat,  4 Feb 2012
 00:16:29 -0500 (EST)
In-Reply-To: <7v8vkjl24d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 03 Feb 2012 19:16:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6516000E-4EEF-11E1-9087-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189843>

Junio C Hamano <gitster@pobox.com> writes:

> You did not describe what problem you are trying to solve, but the above
> tells me that the design of this feature has a lot of room to be improved
> to be useful for even a single trivial use scenario I can think of off the
> top of my head.

Having said all that, the biggest problem I have with the approach of this
patch is that it does not decompose the necessary functionalities in a way
that allows combinations of options people naturally would expect from the
description of the feature.

"git tag" can be used to create (-a), delete (-d), show (-l) and verify
(-v).  Among these modes, creation has to work on a single tag, so it is a
bit special. But the other three modes could also use the filtering
feature of what "show" supports among themselves.

The mode to show tags (-l) starts from _all_ tags, but limits the output
to those that match given patterns, and the output can further be limited
to the ones that contain a given commit. The verify mode and the delete
mode do not offer this behaviour and require the user to specify exact tag
names. If you are adding "I want to do X on all tags that point at this
object" feature, in which X happens to be "verification" in your case,
don't you think other people would naturally want to use the feature with
X=show instead?

The right first step to do this would be to enhance the "filter" logic so
that it not just lets "--contains", but also "--points-at", be specified.
Once that is done, you could just say:

	$ git tag -l --points-at master:README

to list all the tags that point at the blob, and then your original
example becomes:

	$ git tag --points-at master:README | xargs git tag -v

It even allows something like this:

	$ git tag --points-at master:README 'v1.[0-4].?' |
          xargs git tag -v

to work on tags that point at the blob but only those whose names match
the given pattern, i.e. versions from v1.0 series up to v1.4 series but
not later.

After that is done, you could teach the --verify mode to also accept the
patterns, not exact names, so that the above could become:

	$ git tag --verify --points-at master:README
        $ git tag --verify --points-at master:README 'v1.[0-4].?'

Theoretically, the "start from all and then filter" feature could be
shared also with "delete" mode, but I would not recommend doing so for
safety reasons (i.e. "delete" is destructive). Even so, if somebody does
want to do a bulk delete, it is just a simple matter of:

	$ git tag --points-at master:README 'v1.[0-4].?' |
          xargs git tag -d

So it is not a big deal if you did not to teach --delete to share the
filtering logic with "show".

For exactly the same reason, --verify mode does not have to share the
logic, either. Not having to use "| xargs" is merely an icing on the cake.

Hmm?
