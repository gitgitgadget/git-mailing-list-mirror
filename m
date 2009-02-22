From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Make git blame's date output format configurable,
	like git log
Date: Sun, 22 Feb 2009 18:03:58 -0500
Message-ID: <20090222230358.GA19011@coredump.intra.peff.net>
References: <1235170271-10694-1-git-send-email-eletuchy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Eugene Letuchy <eugene@facebook.com>
To: eletuchy@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 23 00:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbNOA-0002LW-UW
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 00:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbZBVXEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 18:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbZBVXED
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 18:04:03 -0500
Received: from peff.net ([208.65.91.99]:56098 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbZBVXEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 18:04:01 -0500
Received: (qmail 18440 invoked by uid 107); 22 Feb 2009 23:04:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Feb 2009 18:04:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Feb 2009 18:03:58 -0500
Content-Disposition: inline
In-Reply-To: <1235170271-10694-1-git-send-email-eletuchy@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111065>

On Fri, Feb 20, 2009 at 02:51:11PM -0800, eletuchy@gmail.com wrote:

> @@ -1975,6 +1975,9 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>  		blank_boundary = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "blame.date") && value[0]) {
> +		blame_date_mode = parse_date_format(value);
> +	}
>  	return git_default_config(var, value, cb);
>  }

When there is a config value we are expecting to have a value rather
than a boolean, we usually print an error rather than silently
discarding. IOW, something like this:

  if (!strcmp(var, "blame.date")) {
          if (!value)
                  return config_error_nonbool(var);
          blame_date_mode = parse_date_format(value);
  }

> +	switch (blame_date_mode) {
> +	case DATE_RFC2822:
> +		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
> +		break;
> +	case DATE_ISO8601:
> +		blame_date_width = sizeof("2006-10-19 16:00:04 -0700");
> +		break;
> +	case DATE_SHORT:
> +		blame_date_width = sizeof("2006-10-19");
> +		break;
> +	case DATE_RELATIVE:
> +		/* unfortunately "normal" is the fallback for "relative" */
> +		/* blame_date_width = sizeof("14 minutes ago"); */
> +		/* break; */
> +	case DATE_LOCAL:
> +	case DATE_NORMAL:
> +		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
> +		break;
> +	}
> +	blame_date_width -= 1; /* strip the null */

Maybe this should be a date_format_width() library function?


Other than that, the patch looks reasonable to me.

-Peff
