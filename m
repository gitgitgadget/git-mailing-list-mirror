From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce core.initHook
Date: Mon, 24 Mar 2008 13:25:16 -0700
Message-ID: <7vr6dzuaxf.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803230310500.4353@racer.site>
 <alpine.OSX.1.00.0803230943500.7541@cougar>
 <alpine.LSU.1.00.0803231200010.4353@racer.site>
 <alpine.OSX.1.00.0803231326290.11994@cougar>
 <alpine.LSU.1.00.0803231404390.4353@racer.site>
 <alpine.OSX.1.00.0803231428220.13789@cougar>
 <20080323235610.GB25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803240101220.4353@racer.site>
 <20080324002302.GD25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803241155300.4353@racer.site>
 <20080324122153.GF25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803241611200.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>, tormod.hystad@gmail.com,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 21:27:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdtFI-0007A6-HQ
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 21:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbYCXUZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbYCXUZf
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 16:25:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbYCXUZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 16:25:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D8AC2A03;
	Mon, 24 Mar 2008 16:25:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 29FD82A00; Mon, 24 Mar 2008 16:25:22 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803241611200.4353@racer.site> (Johannes
 Schindelin's message of "Mon, 24 Mar 2008 16:12:53 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78094>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 03a4f0e..e082218 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -60,6 +60,9 @@ If you are initializing a non-bare repository, the config variable
>  `receive.guardCurrentBranch` is set to true.  This avoids problems with
>  pushing into the current branch, which does not touch the working tree.
>  
> +If you want to run a specific script everytime git-init was issued, you
> +can set the variable `core.initHook`.

... in your $HOME/.gitconfig, naturally ;-)

I like the general idea, but with a few nits.

The hook might want to differentiate its behaviour based on how git-init
was invoked, don't you think?  E.g. was it because the end user wanted to
create a new repo?  Re-init?  Clone, cvsimport or some other higher level
commands invoked git-init on the user's behalf?).  The higher level ones
could communicate it via environment so we do not have to worry about them
too much (except perhaps in the documentation part to help hook writers),
but at least re-init is something init-db alone would be able to tell the
hook, so either a parameter to the hook or an environment exported to it
would be needed.  The hook can figure out 'shared' and 'bare' by reading
from $GIT_DIR/config itself, but are there other things we may want to
tell the hook?

> +static int config_init_hook(const char *key, const char *value)
> +{
> +	if (!strcmp(key, "core.inithook"))
> +		init_hook = xstrdup(value);
> +	return 0;

The current way to spell this is with git_config_string() to protect
yourself from segfaulting on:

	[core]
        	inithook


> @@ -407,6 +430,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		git_config_set("receive.denyNonFastforwards", "true");
>  	}
>  
> +	if (run_init_hook())
> +		return 1;
> +

Hmm.  Exit without a message even under !quiet?

>  	if (!quiet)
>  		printf("%s%s Git repository in %s/\n",
>  		       reinit ? "Reinitialized existing" : "Initialized empty",
