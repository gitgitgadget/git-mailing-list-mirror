From: Junio C Hamano <gitster@pobox.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sat, 26 Nov 2011 14:34:53 -0800
Message-ID: <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 26 23:35:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUQqE-0002wD-Lv
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 23:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab1KZWfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 17:35:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754916Ab1KZWe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 17:34:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 940D251C4;
	Sat, 26 Nov 2011 17:34:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l1Zlcr6K9rOcYtyo9RIjzYDP8q0=; b=WjdH/b
	dUHFJBYe7MuQ22ozsoeDcZTP0lWBkporya2rUdwrDfty4oPj04cQBaHUujv8H/bs
	jU8UOaaGfFpFOIl5heenni63Ye9MtFG6bdS5I4zwA3okYcbrMVFah4z9ZcM2p4SL
	WT2wNGvR23gc8bfzXAbfpxo9V4AF4bPwVdiZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OHCYFpbAYci+ykpjzjOxTwxGdh/ZFiAU
	oiBCGvYsykCshI98IVJGOqPEOrAc8dShTXFZv8xaYd+8GM5xf92aO63HuaKdybzg
	0RGMi34/h2JaYDMlvdd8SUGuWnhttrmVPqXUuE44XgNhomndo/L4la8tDvtx6IDX
	1UyLvQ1Mtzs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C36051C3;
	Sat, 26 Nov 2011 17:34:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB5C151C2; Sat, 26 Nov 2011
 17:34:54 -0500 (EST)
In-Reply-To: <20111125144007.GA4047@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 25 Nov 2011 09:40:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCF3F63C-187E-11E1-BB9B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185955>

Jeff King <peff@peff.net> writes:

> The easiest way would be something like a "trust remote hooks"
> environment variable, off by default. Admins in situation (2) could set
> it for their git-daemon (or webserver, or whatever, or
> gitolite-over-ssh), once they decided it was safe.

Alice and Bob may work on the same project, and they may want to trust
each other as participants of that project, but that does not mean Alice
wants to give Bob a blanket access to places she owns that are not shared
with the project members (e.g. her $HOME directory), so I am afraid "trust
remote hooks" is not a workable solution for the casual sharing on sites
that do not fall into either of your two classes.

The real reason why the upload-hook violates the expectation of the users
is because it would run as the user who fetches, I think. If it ran with
the intersection of capabilities of the owner of the repository and the
user who is fetching, I suspect that we would not have to worry about it.

What would happen if we allowed some hooks to run only when the process is
running under a group-id that can write into the repository?  When Alice
fetches from the repository, it would still run as her and would have an
access to her $HOME, so this won't really work yet, but I am wondering if
there is a workable alternative along this line.
