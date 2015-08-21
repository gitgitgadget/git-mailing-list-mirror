From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] submodule: implement `module_clone` as a builtin
 helper
Date: Fri, 21 Aug 2015 10:22:12 -0400
Message-ID: <20150821142212.GA26130@sigill.intra.peff.net>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
 <1439857323-21048-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:22:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSnCz-0003Bm-Rg
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 16:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbbHUOWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 10:22:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:48151 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753640AbbHUOWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 10:22:15 -0400
Received: (qmail 29511 invoked by uid 102); 21 Aug 2015 14:22:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 09:22:14 -0500
Received: (qmail 1579 invoked by uid 107); 21 Aug 2015 14:22:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 10:22:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2015 10:22:12 -0400
Content-Disposition: inline
In-Reply-To: <1439857323-21048-8-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276299>

On Mon, Aug 17, 2015 at 05:22:03PM -0700, Stefan Beller wrote:

> +static int module_clone(int argc, const char **argv, const char *prefix)
> [...]
> +	/* Redirect the worktree of the submodule in the superprojects config */
> +	if (!is_absolute_path(sm_gitdir)) {
> +		char *s = (char*)sm_gitdir;
> +		strbuf_addf(&sb, "%s/%s", xgetcwd(), sm_gitdir);

Coverity noticed that this is a leak; xgetcwd actually returns a newly
allocated buffer. I think you just want:

  if (strbuf_getcwd(&sb))
	die_errno("unable to get current working directory");
  strbuf_addf("/%s", sm_gitdir);

> +		sm_gitdir = strbuf_detach(&sb, NULL);
> +		strbuf_reset(&sb);

This reset is a noop after you've detached. It's not technically
documented, but I do not think it is reasonable for it to work any other
way. Maybe strbuf.h should make that promise.

> +	strbuf_addf(&sb, "%s/%s", xgetcwd(), path);

Ditto on the xgetcwd issue here.

-Peff
