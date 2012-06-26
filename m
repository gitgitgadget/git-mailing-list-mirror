From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] add: listen to --ignore-errors for submodule-errors
Date: Mon, 25 Jun 2012 19:41:54 -0700
Message-ID: <7vfw9ieqvh.fsf@alter.siamese.dyndns.org>
References: <1340666519-41804-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 04:42:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjLjF-0001dA-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 04:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab2FZCl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 22:41:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35394 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659Ab2FZCl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 22:41:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A22E8B15;
	Mon, 25 Jun 2012 22:41:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TRGxL3Rzh7/YEmSF50ICzrDR6Ns=; b=oG16hV
	7ID1ipT6QvfuUNlA2am851o3xTywFl6QmswJ359QcbllKc8QLJ1NHlFuQ3K+hmzA
	tcRZzsxYkex9k7ZqSg9jdwFlxT5LliJC9+IToDE49EiBiEjLGTEvp6QKREsk+BAS
	L/chw+Di3PNfJdij38/sOjBiSoR1gtNGxrfC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A8wsCoT8UJiTzNPoh2PkL34oaYQD1mLb
	a1I+gOKqrBgBISLcA1979aTtBEs+BX7l8KR9HKrrxA9LT8NnipohpkSFf6FtUV0V
	ipQbnmB9HvKSQ/Y7JwEr9TAk//0uMM/BUK3YhSNIcLFnumYg+whzXElp2Vipv87Z
	d/g/P0LHKh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F6948B13;
	Mon, 25 Jun 2012 22:41:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A550A8B12; Mon, 25 Jun 2012
 22:41:57 -0400 (EDT)
In-Reply-To: <1340666519-41804-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Tue, 26 Jun 2012 01:21:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F8D85E2-BF38-11E1-9F87-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200619>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> I recently tried to do the following in the msysGit-repo:
>
>  $ git add --ignore-errors -- */.gitignore
>  fatal: Path 'src/git-cheetah/.gitignore' is in submodule 'src/git-cheetah'
>
> I was a bit puzzled by this; I explicitly specified --ignore-errors
> because I did not want to be stopped due to src/git-cheetah/.gitignore
> being located in a submodule.

If I recall correctly, originally --ignore-errors was added was by
those who (arguably misguidedly) wanted to randomly run "git add"
that can potentially race with ongoing working tree updates
(i.e. think of a poor-man's unreliable snapshotting filesystem), to
which "git add" will notice that the working tree file it was asked
to index changed while it was reading and error out.  Also on some
systems, "git add" on files that are currently open may not be able
to read from them, which would also cause a run-time error.  The
kind of errors the option was meant to ignore were "these paths are
perfectly OK to add, but for some reason, adding them fails at this
moment, and for the purpose of poor-man's unreliable snapshot, it is
OK not to pick the exact current state up, as we will pick it up the
next round", not your kind of request that will lead to an error of
the "adding this path will break the structural integrity of the
repository and git should error out" kind.

> The documentation seems to suggest that this is what is supposed to
> happen, and this seems like the most likely behavior that the user
> wanted. After all, there's no good reason submodules are special
> in this regard, no?

How does "git add .git" or "git add .git/config" behave with your
patch applied?  It is exactly the same kind of error that breaks the
structural integrity of the repository as adding src/cheetah/.gitignore
to the top-level project repository, and there is no good reason to
special case submodules, either.
