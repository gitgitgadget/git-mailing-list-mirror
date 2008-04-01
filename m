From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git-gc --auto: add pre-auto-gc hook
Date: Mon, 31 Mar 2008 21:51:12 -0700
Message-ID: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
References: <7637ee64f43964d2e514c1598b2e7783d71b8608.1206929014.git.vmiklos
 @frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 06:52:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgYTj-0004cZ-0K
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 06:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbYDAEv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 00:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYDAEv1
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 00:51:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYDAEv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 00:51:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 678922383;
	Tue,  1 Apr 2008 00:51:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2B85E235F; Tue,  1 Apr 2008 00:51:15 -0400 (EDT)
In-Reply-To: <7637ee64f43964d2e514c1598b2e7783d71b8608.1206929014.git.vmiklos
 @frugalware.org> (Miklos Vajna's message of "Mon, 31 Mar 2008 11:35:46
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78627>

Miklos Vajna <vmiklos@frugalware.org> writes:

> If such a hook is available and exits with a non-zero status, then
> git-gc --auto won't run.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  builtin-gc.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-gc.c b/builtin-gc.c
> index 8cef36f..acd63be 100644
> --- a/builtin-gc.c
> +++ b/builtin-gc.c
> @@ -157,6 +157,25 @@ static int too_many_packs(void)
>  	return gc_auto_pack_limit <= cnt;
>  }
>  
> +static int run_hook()
> +{
> +	const char *argv[2];
> +	struct child_process hook;
> +
> +	argv[0] = git_path("hooks/pre-auto-gc");
> +	argv[1] = NULL;

Hmm.  I wonder if the hook wants any parameters, even though I do not
think of any offhand.

> +	if (access(argv[0], X_OK) < 0)
> +		return 0;
> +
> +	memset(&hook, 0, sizeof(hook));
> +	hook.argv = argv;
> +	hook.no_stdin = 1;
> +	hook.stdout_to_stderr = 1;

I understand no_stdin, but is there a reason to do stdout_to_stderr?

> +	return run_command(&hook);
> +}

Don't we want to distinguish between the case where start_command()
failed, wait_or_whine() failed on waitpid(), the command was killed with
signal, or the command actually ran correctly and decided that you should
not run "git gc --auto" by exiting non-zero?

I think it is prudent to refrain from running "git gc --auto" in any of
the failure cases I listed above, but shouldn't the cases other than the
last one at least issue a warning?
