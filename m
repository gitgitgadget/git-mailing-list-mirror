From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v5 4/4] git-commit: add a prepare-commit-msg hook
Date: Wed, 06 Feb 2008 02:58:23 -0800
Message-ID: <7v3as6z700.fsf@gitster.siamese.dyndns.org>
References: <E1JMe6e-0004HH-Uq@fencepost.gnu.org>
	<7v1w7q4khm.fsf@gitster.siamese.dyndns.org>
	<E1JMfN3-0006XI-Qs@fencepost.gnu.org>
	<7vy79y1mhb.fsf@gitster.siamese.dyndns.org>
	<E1JMgdC-00019t-HY@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:59:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhzc-000604-Ld
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758829AbYBFK6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758207AbYBFK6b
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:58:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758164AbYBFK6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 05:58:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EDC51C60;
	Wed,  6 Feb 2008 05:58:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C051C5E;
	Wed,  6 Feb 2008 05:58:25 -0500 (EST)
In-Reply-To: <E1JMgdC-00019t-HY@fencepost.gnu.org> (Paolo Bonzini's message of
	"Tue, 5 Feb 2008 08:04:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72797>

Paolo Bonzini <bonzini@gnu.org> writes:

> If the exit status is non-zero, git-commit will abort.  The hook is
> not suppressed by the --no-verify option, so it should not be used
> as a replacement for the pre-commit hook.

I see this matches _exactly_ what I wanted to say.  I however am
suspecting that it may not match what you think the hook should
do, though.

For example,

> The hook is allowed to edit the message file in place.  It can also be
> used for the same purpose as the pre-commit message, if the verification
> should not be skipped for automatic commits (e.g. during interactive
> rebasing).

I, who is claiming that the purpose of this hook is about
preparing the message and not about validating and interfering
with the commit, would never say that.  It's not just "allowed";
editing is the _sole_ reason for its existence.

I'd make it even stronger and clearer:

    The purpose of the hook is to edit the message file in place
    before it gets presented to the user for further editing.
    It is not suppressed by the --no-verify option, because it
    is not about validating what is to be committed.  A non-zero
    exit from the hook means the hook failed, and aborts the
    commit (in other words, non-zero exit from the hook is an
    abnormal condition, perhaps a bug in the hook itself, and
    should never be about the hook not liking the commit being
    created).

But that is apparently quite different from what you wrote.  So
I am sensing some miscommunication here.  I suspect that you are
not convinced by my claim that the hook's sole purpose should be
preparing the commit message to be edited, and that it should
never be used for validation.  Yet an early part of your commit
log message pretends that you are agreeing with me.  The rest of
the patch however still seems to think differently.

And if you think the hook should actively interfere with the
commit, please argue for that case first, without sending an
incoherent patch.  As I often say, unlike Linus, I am not always
right.

> +If the exit status is non-zero, `git-commit` will abort.
> +The hook is not suppressed by the `\--no-verify` option.
> +
> +The hook is allowed to edit the message file in place.  It can also be
> +used for the same purpose as the pre-commit message, if the verification
> +should not be skipped for automatic commits (e.g. during interactive
> +rebasing).

The same comment applies here.

> +++ b/templates/hooks--prepare-commit-msg
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +#
> +# An example hook script to prepare the commit log message.
> +# Called by git-commit with the name of the file that has the
> +# commit message, followed by the description of the commit
> +# message's source.  The hook should exit with non-zero
> +# status after issuing an appropriate message if it wants to stop the
> +# commit.  The hook is allowed to edit the commit message file.

The same comment applies here as well.

There may be cases where an unmaskable validation hook is
desired.  But even if that is the case, I see little reason to
tie it to the act of commit message preparation.
