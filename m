From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 13:15:53 -0700
Message-ID: <7v3bpuenpi.fsf@assigned-by-dhcp.cox.net>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 22:16:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzKE9-0000l6-A7
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 22:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVGaUP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 16:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVGaUP4
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 16:15:56 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53894 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261987AbVGaUPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 16:15:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731201552.DIDV8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 16:15:52 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> +It is assured that sha1-old is an ancestor of sha1-new (otherwise,
> +the update would have not been allowed). refname is relative to
> +$GIT_DIR; e.g. for the master head this is "refs/heads/master".

I think this description is inaccurate; the send-pack can be run
with the --force flag and it is my understanding that receiver
would happily rewind the branch.  One possibility, if we wanted
to enforce it on the receiver end, would be to add another hook
that is called before the rename happens and tell the
receive-pack to refuse that update, but that should be done with
a separate patch, I suppose.

> +Using this hook, it is easy to generate mails on updates to
> +the local repository. This example script sends a mail with
> +the commits pushed to the repository:
> +
> +       #!/bin/sh
> +       git-rev-list --pretty "$3" "^$2" |
> +        mail -r $USER -s "New commits on $1" commit-list@mydomain

What is the environment the hook runs in?  For example, who
defines $USER used here?

We might want to describe the environment a bit more tightly
than the current patch does.  This includes not just the
environment variables, but $cwd and the set of open file
descriptors among other things.

I am not saying this from the security standpoint (the fact that
you can invoke receive-pack and that you can write into the
update hooks means you already have control over that
repository), but to help hook writers to avoid making mistakes.
For example, I offhand cannot tell what happens if the hook
tries to read from its standard input.  Also what happens if the
hook does not return but sleeps forever in a loop?  Do we want
to somehow time it out?  I think "It is hooks' responsibility to
time itself out" is an acceptable answer here, but if that is
the case it had better be documented.

> +static void updatehook(const char *name, unsigned char *old_sha1, unsigned char *new_sha1)
> +{
> +        if (access(update_hook, X_OK) < 0) return;
> +       fprintf(stderr, "executing update hook for %s\n", name);
> +...
> +}

I think I've seen this "fork -- exec -- for loop with waitpid"
pattern repeated number of times in the code.  Would it be
feasible to make them into a single library-ish function and
call it from here and other existing places?

Another thing you may want to consider is to do this hook
processing before and/or after processing all the refs.  A hook
might want to know what the entire set of refs are that are
being updated, and may not have enough information if it is
invoked once per ref.

Thanks for the patch; I agree with what the patch tries to
achieve in general.

-jc
