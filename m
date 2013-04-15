From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Sun, 14 Apr 2013 19:48:47 -0700
Message-ID: <7v61zo4igg.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 04:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URZTZ-0000lv-Tn
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 04:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934526Ab3DOCsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 22:48:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933374Ab3DOCsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 22:48:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7155FF38D;
	Mon, 15 Apr 2013 02:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5r+7WnILjx4MDYSC7AdTvx6Dfng=; b=hYUF3Q
	5lPjFqk8JFyP0Lj9KK+WYjNi2nTDUB28EhwtKLqvahohp/lhsXFE2Nl7Dalxt3pX
	6v+x6JyXYFwSFRnBq2T9GWgw7DJB33+ECFo37Hw3qVPD9jf8w+Vv/9BqLXldBcyT
	PFHVvnPgrP3oqu+cf4GvedJ3HhpBzWulKcOi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QF+EWHCXkbqR8ZHODrq6Q/+/T5ie0CmB
	F59mD66Fv5nh8cOzCWhXUDgcu1WRdrXEN8lf7lVnAubsNbvzjQ8w7C8gAE18jZma
	jUUs4vTXEIf0txc5akhiM+qId99mKL2Q0aT0bRbUZ9jlnYIN9bjWY9LJxZ92vmDc
	0CG3/QMiBTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67DF1F38C;
	Mon, 15 Apr 2013 02:48:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6BB1F38B; Mon, 15 Apr 2013
 02:48:48 +0000 (UTC)
In-Reply-To: <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 14 Apr 2013 18:28:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFAEE386-A576-11E2-97C0-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221186>

Junio C Hamano <gitster@pobox.com> writes:

> If the envisioned use of this is to use it as a building block of
> something else that is user-facing (e.g. the user says "git add",
> and before the command finishes, somewhere we internally run "git
> clone"), then would it be possible that you are better off running
> that clone with --separate-git-dir and let it make the gitfile for
> you?

As you may have already guessed, in principle I am all for teaching
"git add" not just to add a submodule itself (which we already do)
but also to record information about the submodule, without having
to delegate it to "git submodule".  "git submodule add" was meant as
an interim measure until we figure out what kind of metainformation
is necessary, and doing things in "git add" has always been a longer
term goal.

There are two ways to "add" a submodule to a superproject.  You may
bring an existing project with "git clone" inside the working tree
of a superproject (which I am guessing is the use case that inspired
this patch), but it will leave the git dir of the submodule embedded
in its working tree.  

You could continue "git clone" and then teach "git add" (or "git
submodule add") to relocate the embedded git directory from the
submodule working tree, you could "git clone" with separate-git-dir
from the beginning, or you could extend "git add", perhaps

    git add --url=git://up.stre.am/repository [--name=name] sub/mod/ule

and do that "git clone --separate-git-dir" internally (which will
mean that the end user will not run "git clone").

Another way ti "add" a submodule is to run "git init" to originate a
new project inside the working tree of a superproject. The resulting
submodule working tree will have the embedded git dir, and again
"git add" (or "git submodule add") could notice and relocate it, but
if the extended "git add" wants to help that use case as well, I
think it is the matter of running "git init --separate-git-dir",
just like "add by cloning from elsewhere" can do the same with the
flag to "git clone".
