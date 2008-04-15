From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make core.sharedRepository more generic (version 2)
Date: Mon, 14 Apr 2008 17:08:03 -0700
Message-ID: <7v3apo7zfg.fsf@gitster.siamese.dyndns.org>
References: <20080412195754.GA15091@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 15 02:09:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlYjW-0003Oo-38
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 02:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760013AbYDOAIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 20:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757212AbYDOAIO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 20:08:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762056AbYDOAIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 20:08:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B825E3FA1;
	Mon, 14 Apr 2008 20:08:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8D7633FA0; Mon, 14 Apr 2008 20:08:06 -0400 (EDT)
In-Reply-To: <20080412195754.GA15091@zakalwe.fi> (Heikki Orsila's message of
 "Sat, 12 Apr 2008 22:57:54 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79544>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 2854868..8c63295 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -400,9 +400,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		char buf[10];
>  		/* We do not spell "group" and such, so that
>  		 * the configuration can be read by older version
> -		 * of git.
> +		 * of git. Note, we use octal numbers.
>  		 */
> -		sprintf(buf, "%d", shared_repository);
> +		sprintf(buf, "0%o", shared_repository);

Unconditionally doing this makes the resulting repository unusable by git
1.5.5 and older, even when the user wanted to use the bog standard "git
init --shared".  You can limit the extent of damage if you continue
writing PERM_GROUP and PERM_EVERYBODY out as 1 and 2, and use the new
octal notation only when the user used the settings allowed only with new
git.

> @@ -438,11 +440,46 @@ int git_config_perm(const char *var, const char *value)
>  		    !strcmp(value, "world") ||
>  		    !strcmp(value, "everybody"))
>  			return PERM_EVERYBODY;
> +
> +		/* Parse octal numbers */
> +		i = strtol(value, &endptr, 8);
> +		if (*endptr != 0) {
> +			/* Not an octal number. Maybe true/false? */
> +			if (git_config_bool(var, value))
> +				return PERM_GROUP;
> +			else
> +				return PERM_UMASK;
> +		}
> +
> +		/* Handle compatibility cases */
> +		switch (i) {
> +		case PERM_UMASK:               /* 0 */
> +			return PERM_UMASK;
> +		case OLD_PERM_GROUP:           /* 1 */
> +			return PERM_GROUP;
> +		case OLD_PERM_EVERYBODY:       /* 2 */
> +			return PERM_EVERYBODY;
> +		}

This is valid only because forcing "chmod 0", "chmod 1", nor "chmod 2"
would not make any sense.  We might want to explain that in comment.

> +		/* A filemode value was given: 0xxx */
> +
> +		if ((i & 0600) != 0600)
> +			die("Problem with core.sharedRepository filemode value"
> +			    " (0%.3o).\nThe owner of files must always have "
> +			    "read and write permissions.", i);
> +
> +		if (i & 0002)
> +			warning("core.sharedRepository filemode (0%.3o) is a "
> +				"security threat.\nMasking off write "
> +				"permission for others\n", i);

I am not sure about this.

If the user explicitly asked for world-writable, I think we should allow
it.  "is a" is too strong a statement to make without knowing how the
access to the repository is arranged.  In a setting where there is nothing
but a restricted access over ssh, and "update-paranoid" hook in place, it
may not be a threat at all, and you are forbidding hosting services to use
such an access control model.

> +		/*
> +                 * Mask filemode value. Others can not get write permission.
> +		 * x flags for directories are handled separately.
> +                 */
Whitespace breakages.

> +		return i & 0664;

>  	}
> -	return git_config_bool(var, value);
> +	return PERM_GROUP;

At this point we know value is NULL so always returning PERM_GROUP
probably makes sense.  But if you did

	if (!value)
	        return PERM_GROUP

upfront, you can lose one level of indentation from the major parts
of this function (this is 70% style and 30% readability comment).
