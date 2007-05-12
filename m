From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Updated documentation of hooks in git-receive-pack.
Date: Sat, 12 May 2007 12:27:52 -0700
Message-ID: <7vmz09yh8n.fsf@assigned-by-dhcp.cox.net>
References: <20070512171113.GA8100@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat May 12 21:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxGw-0004OC-2o
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758842AbXELT2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759597AbXELT2G
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:28:06 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52875 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758842AbXELT1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:27:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512192754.PSFZ6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 15:27:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yKTs1W0091kojtg0000000; Sat, 12 May 2007 15:27:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47081>

Jan Hudec <bulb@ucw.cz> writes:

> Added documentation of pre-receive and post-receive hooks and updated
> documentation of update and post-update hooks.
>
> Signed-off-by: Jan Hudec <bulb@ucw.cz>

Thanks, much appreciated.  Domain ucw.cz sounds familiar; are
you close by to Pasky?

> +[[pre-receive]]
> +pre-receive
>...
> +This hook executes once for the receive operation. It takes no
> +arguments, but for each ref to be updated it receives on standard
> +input a line of the format:
> +
> +  <old-value> SP <new-value> SP <ref-name> NL
> +
> +where `<old-value>` is the old object name stored in the ref,
> +`<new-value>` is the new object name to be stored in the ref and
> +`<ref-name>` is the full name of the ref.

s/NL/LF/
When creating a new ref, `<old-value>` is 40 `0`.

> +If the hook exits with non-zero status, none of the refs will be
> +updated. If the hook returs zero, updating of individual refs can
> +still be prevented by the <<update,'update'>> hook.

s/returs/exits with/

> +The standard output of this hook is sent to `stderr`, so if you
> +want to report something to the `git-send-pack` on the other end,
> +you can simply `echo` your messages.

I think "sent to stderr" is a implementation detail between
receive-pack and hook scripts.  I would just keep the "if you
want to..." part.

> +[[post-receive]]
> +post-receive
> +------------
> +
> +This hook is invoked by `git-receive-pack` on the remote repository,
> +which happens when a `git push` is done on a local repository.
> +It executes on the remote repository once after all the refs have
> +been updated.
> +
> +This hook executes once for the receive operation.  It takes no
> +arguments, but for each ref that was updated it receives on standard
> +input a line of the format:
> +
> +  <old-value> SP <new-value> SP <ref-name> NL
> +
> +on stdin, where `<old-value>` is the old object name stored in the
> +ref, `<new-value>` is the new object name to be stored in the ref and
> +`<ref-name>` is the full name of the ref.

Maybe

	It takes no arguments, but gets the same information as
	the `pre-receive` hook does on its standard input.

to avoid the duplicated description.

> +This hook cannot affect the outcome of `git-receive-pack`, as it's
> +called after the real work is done.
> +
> +This superceedes the [[post-update]] hook in that it actually get's
> +both old and new values of all the refs.

s/superceedes/supersedes/

> +The standard output of this hook is sent to `stderr`, so if you
> +want to report something to the `git-send-pack` on the other end,
> +you can simply `echo` your messages.

Ditto.

> +[[post-update]]
>  post-update
>  -----------
>  
> @@ -146,7 +214,8 @@ the outcome of `git-receive-pack`.
>  
>  The 'post-update' hook can tell what are the heads that were pushed,
>  but it does not know what their original and updated values are,
> -so it is a poor place to do log old..new.
> +so it is a poor place to do log old..new. See
> +<<post-receive,'post-receive'>> hook above for a better one.

Instead of just passing 'a better one' judgement without
rationale, it is more helpful to explain why the newer ones are
recommended, so that the reader can agree to it.

        In general, `post-receive` hook is preferred when the hook needs
        to decide its acion on the status of the entire set of refs
        being updated, as this hook is called once per ref, with
        information only on a single ref at a time.
