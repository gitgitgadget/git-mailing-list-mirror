From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] wt-status: turn advice_status_hints into a field of
 wt_status
Date: Wed, 11 Sep 2013 14:35:20 -0400
Message-ID: <20130911183519.GA24251@sigill.intra.peff.net>
References: <1378890539-1966-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, javierdo1@gmail.com,
	jrnieder@gmail.com, judge.packham@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:35:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJpGS-0002q2-OG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab3IKSff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:35:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:47546 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756727Ab3IKSfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:35:31 -0400
Received: (qmail 31329 invoked by uid 102); 11 Sep 2013 18:35:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Sep 2013 13:35:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Sep 2013 14:35:20 -0400
Content-Disposition: inline
In-Reply-To: <1378890539-1966-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234595>

On Wed, Sep 11, 2013 at 11:08:58AM +0200, Matthieu Moy wrote:

> No behavior change in this patch, but this makes the display of status
> hints more flexible as they can be enabled or disabled for individual
> calls to commit.c:run_status().
> [...]
> +static void status_finalize(struct wt_status *s)
> +{
> +	determine_whence(s);
> +	s->hints = advice_status_hints;
> +}

Is a "finalize" the right place to put the status hint tweak? I would
expect the order for callers to be:

  wt_status_prepare(&s);
  /* manual tweaks of fields in "s" */
  wt_status_finalize(&s);

but the finalize would overwrite any tweak of the hints field. So it
would make more sense to me for it to go in prepare().

But the current callsites look like this:

> @@ -1249,7 +1255,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	wt_status_prepare(&s);
>  	gitmodules_config();
>  	git_config(git_status_config, &s);
> -	determine_whence(&s);
> +	status_finalize(&s);
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_status_options,
>  			     builtin_status_usage, 0);

We do not actually read the config until after _prepare, because the
config is what is doing the tweaking of "s" in this case. But we cannot
trust advice_* until we have read the config.

The problem is that we are doing two things in that git_config call:

  1. Loading basic git-wide core config.

  2. Priming the wt_status struct with options specific to "git status"

So the "cleanest" thing would be something like:

  /* load basic config */
  git_config(git_diff_ui_config, NULL);

  /* initialize the status-run struct; this would probably be better named as
   * _init to match the rest of the code */
  wt_status_prepare(&s);

  /* now tweak the defaults using status-specific config, which does
   * not need to chain to other config callbacks anymore */
  git_config(git_status_config, &s);

  /* and then tweak further with command line options */
  argc = parse_options(...);

  /* and now finally ask wt-status to finalize any setup we've put into
     the struct (e.g., calling determine_whence, though I do not
     actually see it depending on any of the fields we set. Should it
     be part of _prepare? */
  wt_status_finalize(&s);


That would follow our more usual object init-tweak-finalize-use
patterns. Hrm. To make matters more complicated, we have
finalize_deferred_config, too. I think that could be rolled into
wt_status_finalize.

Perhaps that is getting a bit complicated as a refactor. If you don't
want to do it, I understand, but I think you should probably avoid the
name "_finalize" here, as it is a bit mis-leading.

-Peff
