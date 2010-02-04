From: Junio C Hamano <gitster@pobox.com>
Subject: Re: http getpass function in msysgit
Date: Wed, 03 Feb 2010 17:28:32 -0800
Message-ID: <7vaavp3i2n.fsf@alter.siamese.dyndns.org>
References: <1976ea661002021918m19d9b37fx1872557d3c810e3a@mail.gmail.com>
 <7vpr4mrijt.fsf@alter.siamese.dyndns.org>
 <1976ea661002022148s544be10bie912295e04189864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcqWa-0005fD-S6
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 02:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933047Ab0BDB2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 20:28:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991Ab0BDB2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 20:28:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 068B797E2B;
	Wed,  3 Feb 2010 20:28:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j+wGhXsoxlChoqzEXL3VkusVeLE=; b=sQxNds
	+6k+tafZPGuQ7zi6x3RVMuODrkNGN15jdDpNEfkNsc5BV2/u1IlzOe8YpS9gIc4Z
	vTzdmDXvi4u7IzFDoPCzHi1wyPLfslDUz3a8hhLhDCSq26a50o8qW74Mi78a0Y5B
	Iyt8F7U9p1SZd9eUYmaBwWWm+k/RPXVqjjIUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B7YtkhYY1eFT4ejB10gycZpGTjunWKZC
	uPV/r2hVuXzp92F4Lhz9tM78mmlBO5w9sdFf3fJM6Zb3RQjcVkPh5MgZs8q4FB3G
	FoBtag8phE661IqAxjNGMDb2a8Zj1EVjPnzIyk2NWHwXj/yUxsyMAp9CS8ij5UHK
	lY4fywEhwEA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB3EE97E28;
	Wed,  3 Feb 2010 20:28:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9B2A97E23; Wed,  3 Feb
 2010 20:28:33 -0500 (EST)
In-Reply-To: <1976ea661002022148s544be10bie912295e04189864@mail.gmail.com>
 (Frank Li's message of "Wed\, 3 Feb 2010 13\:48\:26 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9EFD630A-112C-11DF-AA81-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138924>

Frank Li <lznuaa@gmail.com> writes:

> You can choose environment name you like. I choose HTTP_ASKPASS just
> because getpass only used at http.c
> ssl_cert_password = getpass("Certificate Password: ");
>
> OpenSSH is separated application and use own SSH_ASKPASS to ask password ...
>
> May GIT_ASKPASS is optional name.

If that is the case, probably it is easiest for the end users if you
arrange it this way:

 - If GIT_ASKPASS is not set:

   - If SSH_ASKPASS is present, then use that from getpass() for any and
     all places that would want to get "password" like things;

   - Otherwise consult the terminal as before;

 - If GIT_ASKPASS is set:

   - If SSH_ASKPASS is not set, then export the value of GIT_ASKPASS as
     such as well, so that whenever we spawn "ssh", the same GIT_ASKPASS
     program will be used as a fallback.

That way, if the user already has set up SSH_ASKPASS, we will use the same
familiar dialog without forcing the user do anything extra.  If the user
only sets GIT_ASKPASS without doing SSH_ASKPASS, we would also use it to
drive the ssh session.  In either case, the user doesn't need to worry
about multiple configuration or dialog interface.

> It is nice to use one dialog for all cases. git-svn also have the same problem.

People often seem to use "/usr/lib{,exec}/openssh/gnome-ssh-askpass" as
SSH_ASKPASS.  It takes the prompt from its command line argument, reads
the input, and spits it out to its standard output so that calling program
can capture it.  It would be a good interface to conform to to minimize
the work we need to support this.
