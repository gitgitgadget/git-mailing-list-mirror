From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] check-ignore: move setup into cmd_check_ignore()
Date: Thu, 11 Apr 2013 01:25:53 -0400
Message-ID: <20130411052553.GA28915@sigill.intra.peff.net>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 07:26:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQA1O-000705-I5
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 07:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab3DKF0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 01:26:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39732 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab3DKF0A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 01:26:00 -0400
Received: (qmail 11981 invoked by uid 107); 11 Apr 2013 05:27:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 01:27:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 01:25:53 -0400
Content-Disposition: inline
In-Reply-To: <1365645575-11428-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220822>

On Thu, Apr 11, 2013 at 02:59:31AM +0100, Adam Spiers wrote:

> Initialisation of the dir_struct and path_exclude_check structs was
> previously done within check_ignore().  This was acceptable since
> check_ignore() was only called once per check-ignore invocation;
> however the next commit will convert it into an inner loop which is
> called once per line of STDIN when --stdin is given.  Therefore moving
> the initialisation code out into cmd_check_ignore() ensures that
> initialisation is still only performed once per check-ignore
> invocation, and consequently that the output is identical whether
> pathspecs are provided as CLI arguments or via STDIN.
> 
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  builtin/check-ignore.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> index 0240f99..0a4eef1 100644
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -53,30 +53,20 @@ static void output_exclude(const char *path, struct exclude *exclude)
>  	}
>  }
>  
> -static int check_ignore(const char *prefix, const char **pathspec)
> +static int check_ignore(struct path_exclude_check check,
> +			const char *prefix, const char **pathspec)

Did you mean to pass the struct by value here? If it is truly a per-path
value, shouldn't it be declared and initialized inside here? Otherwise
you risk one invocation munging things that the struct points to, but
the caller's copy does not know about the change.

In particular, I see that the struct includes a strbuf. What happens
when one invocation of check_ignore grows the strbuf, then returns? The
copy of the struct in the caller will not know that the buffer it is
pointing to is now bogus.

> -static int check_ignore_stdin_paths(const char *prefix)
> +static int check_ignore_stdin_paths(struct path_exclude_check check, const char *prefix)

Ditto here.

-Peff
