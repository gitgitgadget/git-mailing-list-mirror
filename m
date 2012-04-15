From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v5 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Sun, 15 Apr 2012 12:42:12 +0200
Message-ID: <20120415104212.GC6263@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-3-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 12:43:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJMvf-0005gX-8T
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 12:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab2DOKna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 06:43:30 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:58729 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752366Ab2DOKn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 06:43:29 -0400
Received: (qmail 28037 invoked from network); 15 Apr 2012 10:43:26 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL506.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub80.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <nhorman@tuxdriver.com>; 15 Apr 2012 10:43:25 -0000
Content-Disposition: inline
In-Reply-To: <1334342707-3326-3-git-send-email-nhorman@tuxdriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195556>

On Fri, Apr 13, 2012 at 02:45:05PM -0400, Neil Horman wrote:
>
> +                     OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_if_made_empty, "keep redundant, empty commits"),

For consistency, I'd prefer if the variable name were the same as the
option. Then I wouldn't have to keep the option<->variable translation
in mind.

>
> +     if (!empty && !opts->keep_if_made_empty) {
[...]
> +                     return 0;
[...]
>       if (opts->allow_empty)
> +             argv_array_push(&array, "--allow-empty");
> +
> +     rc = run_command_v_opt(array.argv, RUN_GIT_CMD);

I find it a bit strange, that if we cherry-pick a commit that was
already empty, we _do_ call git commit (and error out), but if we find a
commit that is made empty, we do _not_ call git commit and quietly
succeed (in not doing anything). But I suppose that is the legacy
behavior?

> +
> +		rc = !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
> +
> +		if (rc)

rc is short for run_command, for which it stores the return value, no?
Let's not abuse the variable like this and instead use the result
directly:

 if (!hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1))

If you make the entire paragraph leading up to this a separate function,
say index_is_empty(), then the above would read more naturally like
this:

 if (!opts->keep_if_made_empty && !empty && index_is_empty())

> +			/*
> +			 * The head tree and the parent tree match
> +			 * meaning the commit is empty.  Since it wasn't created

Don't you mean the head tree and the index?

> +			 * empty (based on the previous test), we can conclude
> +			 * the commit has been made redundant.  Since we don't
> +			 * want to keep redundant commits, just skip this one
> +			 */
> +			return 0;
> +	}
> +
> +	argv_array_init(&array);
> +	argv_array_push(&array, "commit");
> +	argv_array_push(&array, "-n");
>  
> -	args[i++] = "commit";
> -	args[i++] = "-n";
>  	if (opts->signoff)
> -		args[i++] = "-s";
> +		argv_array_push(&array, "-s");
>  	if (!opts->edit) {
> -		args[i++] = "-F";
> -		args[i++] = defmsg;
> +		argv_array_push(&array, "-F");
> +		argv_array_push(&array, defmsg);
>  	}
> +
>  	if (opts->allow_empty)
> -		args[i++] = "--allow-empty";
> +		argv_array_push(&array, "--allow-empty");
> +
> +

Why two newlines?

> +	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
> +	argv_array_clear(&array);
> +	return rc;
> +}

Looks good to me otherwise.
