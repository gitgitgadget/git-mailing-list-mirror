From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make commit, cherry-pick and revert more silent.
Date: Sun, 06 Jan 2008 14:52:33 -0800
Message-ID: <7vir2636tq.fsf@gitster.siamese.dyndns.org>
References: <1199634201-26013-1-git-send-email-g2p.code@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gabriel <g2p.code@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 23:53:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBeMe-0002qR-PS
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 23:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbYAFWwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 17:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbYAFWwl
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 17:52:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbYAFWwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 17:52:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 20CFCA0B5;
	Sun,  6 Jan 2008 17:52:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E93EA0B3;
	Sun,  6 Jan 2008 17:52:35 -0500 (EST)
In-Reply-To: <1199634201-26013-1-git-send-email-g2p.code@gmail.com>
	(g2p.code@gmail.com's message of "Sun, 6 Jan 2008 16:43:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69749>

Gabriel <g2p.code@gmail.com> writes:

> Commit now obeys --quiet more.
> Cherry-pick and revert call commit as --quiet.
> Prevents us from displaying working-tree status once or even twice.

Well, you also need to defend that it is a good thing not to
show the status information during cherry-pick or revert much
better, especially when we are this late into the -rc cycle.

> diff --git a/builtin-commit.c b/builtin-commit.c
> index 73f1e35..96ace77 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -759,7 +759,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  	if (!prepare_log_message(index_file, prefix) && !in_merge &&
>  	    !allow_empty && !(amend && is_a_merge(head_sha1))) {
> -		run_status(stdout, index_file, prefix, 0);
> +		fprintf(stderr, "There are no changes, not committing.\n");
> +		if (!quiet)
> +			run_status(stdout, index_file, prefix, 0);

Especially if you are introducing a change to a command you do
not even mention in the topic line of the patch.

Having said that, I think it is a good change, if the UI change
to cherry-pick and revert only triggers when the operation did
not have any effect.

It is much harder to know for a user if a cherry-pick or revert
will result in such a situation before actually running these
commands, than when making his own commit.  And the status
output from underlying git-commit only distracts him by
obscuring the punch-line "nothing added to commit", which is
currently the only clue.  I'd agree that is a UI bug in the
current implementation of cherry-pick/revert.

So a more convincing presentation would be:

 * A single patch to "git commit".  The commit log message would
   read:

   When there is nothing to commit, "git commit --quiet" still
   shows the status output before saying "nothing added to
   commit...".  This patch makes it less verbose.

 * Another patch on top of it that runs "git commit" with
   the "--quiet" option from cherry-pick and revert.  The commit
   log message would read:

   When cherry-pick or revert results in no change at all
   (e.g. the user cherry-picked an ancestor of the current
   commit), the command correctly refuses to create a new
   commit, but it responds by showing the status output and
   "nothing added to commit" message.

   This is a very roundabout way to tell the user that the
   cherry-pick or revert was unnecessary.  Especially because it
   is much harder to know for a user if a cherry-pick or revert
   will result in such a situation before actually running these
   commands, than when making his own commit.

   This patch makes cherry-pick and revert call "git commit"
   with --quiet option to make the output much less confusing.

After I wrote all that, I realized that the patch is not
acceptable as is.

Why?

This makes a successful cherry-pick way too silent.  With your
patch, we will see:

 * "Auto-merged ..." messages that shows what paths are affected
   by the cherry-pick/revert (which I do not think we would want
   to squelch),

 * "Finished one cherry-pick."

But we will lose the "Created commit ...: <msg>" and "<num>
files changed..."  summary, neither of which we would want to
lose.

Also sign your patch (see Documentation/SubmittingPatches),
please, when you try the second round.

Thanks.
