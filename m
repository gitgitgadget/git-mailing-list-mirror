From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] (trivial) add helpful "use --soft" for bare reset
Date: Thu, 30 Jun 2011 10:21:01 -0700
Message-ID: <7vk4c3qlqa.fsf@alter.siamese.dyndns.org>
References: <20110626221428.GA26780@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Fries <david@fries.net>
X-From: git-owner@vger.kernel.org Thu Jun 30 19:21:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcKvQ-0002mS-8o
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 19:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab1F3RVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 13:21:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab1F3RVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 13:21:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F19E6196;
	Thu, 30 Jun 2011 13:23:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eylr3+4J9EnXc2KTNuNUkNaRrl8=; b=nwJTfj
	D0K9IzMRCD/k35ZdLx1lZ4snlg+rw+LlGa3uN2XEjrLIJrhCFVZ5CHM/6JS/V7fj
	LISU5RZyKlHJiT4zSIUq0VIJvwhbFdNUCPbrolJTq44Z2Ue3jwm7UaYNlRebqFaX
	utxsNDYlVFWm5QmPFzara97oXLhnhD/L66BaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JeRvej8qfrvB+b4z17KYIuBonpQskHwD
	co1sJADaeSL6lNE+0p7Woz0VnZdAd90qC3heXGTsz+Q16uopIxSrUTzNQny9s0fk
	sUGhqc26bKIogRM2tPluN9005a8RsoihZEbMivHoG4znYWhHGVe4oEHoXl7gPQD0
	1pZUGVznalE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 089D96195;
	Thu, 30 Jun 2011 13:23:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 31C316194; Thu, 30 Jun 2011
 13:23:18 -0400 (EDT)
In-Reply-To: <20110626221428.GA26780@spacedout.fries.net> (David Fries's
 message of "Sun, 26 Jun 2011 17:14:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A543B404-A33D-11E0-A790-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176492>

David Fries <david@fries.net> writes:

> Add a helpful "use --soft" message for git-reset (mixed) in a bare
> repository.  This tells the user what they can do, instead of just what
> they can't.
> ...
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 98bca04..dd0cc1e 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -332,7 +332,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		setup_work_tree();
>  
>  	if (reset_type == MIXED && is_bare_repository())
> -		die(_("%s reset is not allowed in a bare repository"),
> +		die(_("%s reset is not allowed in a bare repository, use --soft"),
>  		    _(reset_type_names[reset_type]));
>  
>  	/* Soft reset does not touch the index file nor the working tree

If we want to give a short and concise advice in this codepath, it should
be that "git reset" of any variant must not be used in a bare repository,
which is what we currently say.

The _intent_ of "reset --soft" is to KEEP the current index and the
contents of the working tree, so that next commit using the index and the
working tree will be done immediately on top of the commit you are
resetting to. The implementation detail of how "reset --soft" keeps the
index and the working tree happens to be by not touching them and updating
the branch pointed by the HEAD pointer.

If we wanted to be strict, we would have at least checked that the index
and the working tree existed (iow, made sure we had something worth
keeping) before proceeding, but we were too lazy to check the sanity of
the end user here. An assumption made in early days of git where everybody
knew what was going on is that nobody sane would use "reset" of any flavor
in a bare repository as the command is about changing the base of the next
commit _made_ in that repository, and _making_ a new commit on top of the
updated HEAD would very much mean it is not a bare repository.

And that assumption was the only reason why the command would run inside a
bare repository as a substitute for "update-ref HEAD $the_right_commit".
IOW, "reset --soft" is allowed not because we thought that it made sense
to use the command in a bare repository, nor because we wanted to
encourage it as a way to flip the branch that happens to be the primary
one pointed at by HEAD pointer, but because we (as the implementors) could
get away with an implementation that does not forbid its use, as (1)
nobody sane would have done so anyway, and (2) the implementation happened
to be harmless.

Take a step back and think a bit _why_ you wanted to flip the branch to
point at a different commit. Did you push an incorrect commit to the
repository? The right way to fix that mistake is by pushing the correct
one, possibly with --force. You can also repoint a ref at a different
commit with "update-ref $the_ref $right_commit". It will let you correct a
branch that is not the primary branch pointed at with the HEAD pointer in
the bare repository, unlike "reset --soft".

Encouraging "reset --soft" as a way to run "update-ref HEAD" in a bare
repository leads new users in a wrong direction. The next person who reads
your updated error message would say "I cannot use reset --soft to update
a branch that is not the primary branch in a bare repository. Let's add an
option to name which branch to update, usable only when the command is
used in a bare repository with --soft option". Only because you did not
teach the right way "update-ref refs/heads/$that_branch $right_commit", we
would end up with yet another option to "reset" command that is applicable
only in a very narrow special case (i.e. "in bare and only with --soft").

I do not think we want to go that route.
