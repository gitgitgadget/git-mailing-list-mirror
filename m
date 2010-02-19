From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unexpected git-merge result
Date: Fri, 19 Feb 2010 14:27:44 -0800
Message-ID: <7vaav4amjj.fsf@alter.siamese.dyndns.org>
References: <loom.20100219T202452-35@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dale Rowley <ddrowley3@juno.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:28:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NibKN-0007QS-FG
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 23:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab0BSW1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 17:27:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab0BSW1w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 17:27:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DCE09B756;
	Fri, 19 Feb 2010 17:27:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+qc5QoHj+L7xusg09Svn/56Mdzs=; b=Xfkido
	EgEqmdjmGX91X+LFI7B0KkdGndjCNHxukOMrfCOfNOWMw/sTvg6wDZtGrz0r9/lP
	MfRfZ1utAqT+FMnt2fzZOSnygNSCyg84Iiv+bYgGBp4T5XsrXzmi5iqA2ZwQ2fRt
	psK7nHUfrJxXgEwqNLr4HilH4xMCSZa0LQNg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RR0cr31l7CJdISgzjOCSjsaWAQAodVbP
	NVSaICf4FvwqFxPpu5OQIkpnSz0NHUgHiFvhWWJ8tZ9pjtIto+21aaTE3bOBJKG5
	xThb5xAAZjR0Vk6F1jYwmZdenmOzFKEMv3NY/454cQV71hSfT53pIyn4u33Ccn6i
	qnqXMrMsaO0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46CF29B752;
	Fri, 19 Feb 2010 17:27:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9831E9B750; Fri, 19 Feb
 2010 17:27:45 -0500 (EST)
In-Reply-To: <loom.20100219T202452-35@post.gmane.org> (Dale Rowley's message
 of "Fri\, 19 Feb 2010 21\:35\:54 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 022AFCAA-1DA6-11DF-A0B3-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140491>

Dale Rowley <ddrowley3@juno.com> writes:

> Our branch history looked something like the following:
>
>   B---C
>  /     \
> A---D---E---H
>      \     /
>       F---G
>
> In commit D a few lines were added to a file, and then in commit G the same
> lines were removed. When branches E and G were merged, those lines unexpectedly
> re-appeared in the merge commit (H), even though no other commits had touched
> that file.
>
> I think I understand why this happened: git-merge-base reports that the
> common ancestor for E and G is A.

Do you?  I don't.

D is the merge base between E and G.  A and D are both common ancestor
between E and G, but because D is a descendant of A, A is not a merge
base (the definition of merge-base is "common ancestors none of whose
children is common ancestor").  A is not.

Are you sure you really have ancestry relationship between D and G?  If
the history were like this:

   B---C
  /     \
 A---D---E---H
  \         /
   F-------G

and both D and F add the same set of "few lines", and G removes it, then I
can understand how you would get these "removed by G" lines appear in H,
as the side branch F--G didn't have no net effect on these lines and D is
the only one that added them.

It can happen if F is a cherry-pick of D and G is a revert of F, for
example.
