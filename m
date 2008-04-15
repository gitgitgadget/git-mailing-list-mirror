From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make core.sharedRepository more generic (version 3)
Date: Mon, 14 Apr 2008 18:28:44 -0700
Message-ID: <7v7iez7voz.fsf@gitster.siamese.dyndns.org>
References: <20080415004246.GA13178@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 15 03:29:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlZzM-0007HM-Ec
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 03:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940AbYDOB2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 21:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758136AbYDOB2w
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 21:28:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757713AbYDOB2v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 21:28:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 62C5337CE;
	Mon, 14 Apr 2008 21:28:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 90DA837CD; Mon, 14 Apr 2008 21:28:47 -0400 (EDT)
In-Reply-To: <20080415004246.GA13178@zakalwe.fi> (Heikki Orsila's message of
 "Tue, 15 Apr 2008 03:42:46 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79556>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> Version 2 handles the directory x flags better than version 1.
>
> Version 3 removes a warning for the o+w case, fixes a compatibility
> problem with older Git's, and corrects some style issues.

These four lines should come after "---", as you will have only one commit
in the history for this topic, and the original and the version 2 won't be
there.

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 2854868..f49fea0 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -400,9 +400,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		char buf[10];
>  		/* We do not spell "group" and such, so that
>  		 * the configuration can be read by older version
> -		 * of git.
> +		 * of git. Note, we use octal numbers for new share modes.
>  		 */
> -		sprintf(buf, "%d", shared_repository);
> +		if (shared_repository <= 2)
> +			sprintf(buf, "%d", shared_repository);
> +		else
> +			sprintf(buf, "0%o", shared_repository);

Hmmmm.  shared_repostiory variable is assigned the return value of
git_config_perm() and that function does not return OLD_* variants (which
is a good thing to do), so I do not think if it can ever be "<= 2".

When running "git init" without "--shared" or "--shared=<something>" in an
repository already initialized with git 1.5.5 or order as "shared", I
think you rewrite .git/config to use 0660.  You would need something like
this instead:

	if (shared_repository == PERM_GROUP)
        	strcpy(buf, "1");
	else if (shared_repository == PERM_EVERYBODY))
        	strcpy(buf, "2");
	else ...

> +	/*
> +	 * Mask filemode value. Others can not get write permission.
> +	 * x flags for directories are handled separately.
> +	 */
> +	return i & 0664;

You are still dropping o+w even when the user explicitly asks for it, and
you are not telling that you are disobeying the user anymore.
