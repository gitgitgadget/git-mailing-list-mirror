From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] notes: don't leak memory in
 git_config_get_notes_strategy
Date: Tue, 29 Mar 2016 21:13:34 -0400
Message-ID: <20160330011334.GC2237@sigill.intra.peff.net>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
 <1459298333-21899-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:13:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4hZ-0008Mk-DR
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758316AbcC3BNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:13:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:40472 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753483AbcC3BNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:13:37 -0400
Received: (qmail 22907 invoked by uid 102); 30 Mar 2016 01:13:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:13:36 -0400
Received: (qmail 30220 invoked by uid 107); 30 Mar 2016 01:13:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:13:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 21:13:34 -0400
Content-Disposition: inline
In-Reply-To: <1459298333-21899-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290248>

On Tue, Mar 29, 2016 at 05:38:50PM -0700, Stefan Beller wrote:

> `value` is just a temporary scratchpad, so we need to make sure it doesn't
> leak. It is xstrdup'd in `git_config_get_string_const` and
> `parse_notes_merge_strategy` just compares the string against predefined
> values, so no need to keep it around longer.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/notes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/notes.c b/builtin/notes.c
> index ed6f222..d6bab17 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -751,6 +751,7 @@ static int git_config_get_notes_strategy(const char *key,
>  	if (parse_notes_merge_strategy(value, strategy))
>  		git_die_config(key, "unknown notes merge strategy %s", value);
>  
> +	free((void*)value);
>  	return 0;
>  }

I don't think this is wrong, but would it perhaps be simpler to call
git_config_get_value() in the first place, which does not make a copy of
the string?

-Peff
