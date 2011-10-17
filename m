From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] push: teach --recurse-submodules the on-demand
 option
Date: Mon, 17 Oct 2011 15:33:26 -0700
Message-ID: <7vr52bjljd.fsf@alter.siamese.dyndns.org>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-3-git-send-email-iveqy@iveqy.com>
 <7vmxemls8z.fsf@alter.siamese.dyndns.org> <20111017190749.GA3126@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:33:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvkd-0001mt-1R
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab1JQWdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:33:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756533Ab1JQWdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 18:33:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92F8B665C;
	Mon, 17 Oct 2011 18:33:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jKe4P60D3Ykllc5oFS5RMHs5Dd4=; b=r9r6sF
	sGRbn/Pr5DTBSuXuBmTDohBqvgY3kj7ORiIpeHeum/9cxvw5J+4zzvAP4y8V6r+p
	6wgD/0NIuh70m/1cnbBEuI+vsHfS0ecO5+yogroRkC5gkEbK1d8HkCJBdi/A4Ym7
	bcykwJX4EePdbJ4mSG9KIxzEAfI37I1nmwhY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k+FL4XDTrDXVcbM7pshLTSoWJqjtra3U
	XFOI+gmxoQXhHuCFw7aHDehlFKXAd3GKeJK3tHfmQRcl89vtrtVadtUwgKOjX/RF
	6YJ9A8Q2lxPs/0rpjGAbRmDell6utHxbVD6w/A/b+IgqXMwtclr662Vi/e5aagOH
	MGLpSUDkRfU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89BAD665B;
	Mon, 17 Oct 2011 18:33:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD0E4665A; Mon, 17 Oct 2011
 18:33:29 -0400 (EDT)
In-Reply-To: <20111017190749.GA3126@sandbox-rc> (Heiko Voigt's message of
 "Mon, 17 Oct 2011 21:07:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09B14C30-F910-11E0-906A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183837>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> since we have not heard anything from Fredrik I will probably look into
> cleaning this up. Should I do that with follow-up patches since this
> patch is already in next?

I thought we kicked it back to 'pu' after 1.7.7 cycle.

I would personally want to put a freeze on "recursively do anything to
submodule" topic (including but not limited to "checkout") for now, until
we know how we would want to support "floating submodule" model. For
existing code in-flight, I would like to see us at least have a warm and
fuzzy feeling that we know which part of the code such a support would
need to undo and how the update would look like before moving forward.

There are two camps that use submodules in their large-ish projects.

One is mostly happy with the traditional "submodule trees checked out must
match what the superproject says, otherwise you have local changes and the
build product cannot be called to have emerged from that particular
superproject commit" model. Let's call this "exact submodules" model.

The other prefers "submodule trees checked out are whatever submodule
commits that happen to sit at the tips of the designated branches the
superproject wants to use" model. The superproject tree does not exactly
know or care what commit to use from each of its submodules, and I would
imagine that it may be more convenient for developers. They do not have to
care the entire build product while they commit---only the integration
process that could be separate and perhaps automated needs to know.

We haven't given any explicit support to the latter "floating submodules"
model so far. There may be easy workarounds to many of the potential
issues, (e.g. at "git diff/status" level, there may be some configuration
variables to tell the tools to ignore differences between the commit the
superproject records for the submodule path and the HEAD in the
submodule), but with recent work on submodules such as "allow pushing
superproject only after submodule commits are pushed out", I am afraid
that we seem to be piling random new things with the assumption that we
would never support anything but "exact submodules" model. Continuing the
development that way would require retrofitting support for "floating
submodules" model to largely undo the unwarranted assumptions existing
code makes. That is the reason why I would like to see people think about
the need to support the other "floating submodules" model, before making
the existing mess even worse.

The very first step for floating submodules support would be relatively
simple. We could declare that an entry in the .gitmodules file in the
superproject can optionally specify which branch needs to be checked out
with something like:

	[submodule "libfoo"]
		branch = master
                path = include/foo
                url = git://foo.com/git/lib.git
                
and when such an entry is defined, a command at the superproject level
would largely ignore what is at include/foo in the tree object recorded in
the superproject commit and in the index. When we show "git status" in the
superproject, instead of using the commit bound to the superproject, we
would use include/foo/.git/HEAD as the basis for detecting "local" changes
to the submodule. We could even declare that the gitlink for such a
submodule should record 0{40} SHA-1 in the superproject, but I do not
think that is necessary.
