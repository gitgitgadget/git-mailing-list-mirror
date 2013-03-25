From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: make "show --show-signature" use gpg.program setting
Date: Mon, 25 Mar 2013 17:34:53 -0400
Message-ID: <20130325213453.GB19303@sigill.intra.peff.net>
References: <8C726954D36902459248B0627BF2E66F45D7029930@AUSP01VMBX10.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Hans Brigman <hbrigman@openspan.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:35:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKF36-0008A8-E2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758931Ab3CYVe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:34:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39424 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758501Ab3CYVe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:34:56 -0400
Received: (qmail 28636 invoked by uid 107); 25 Mar 2013 21:36:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 17:36:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 17:34:53 -0400
Content-Disposition: inline
In-Reply-To: <8C726954D36902459248B0627BF2E66F45D7029930@AUSP01VMBX10.collaborationhost.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219093>

On Mon, Mar 25, 2013 at 01:03:52PM -0500, Hans Brigman wrote:

> "show --show-signature" doesn't currently use the gpg.program setting.  Commit signing, tag signing, and tag verification currently use this setting properly, so the logic has been added to handle it here as well.

Please wrap your commit messages at something reasonable (70 is probably
as high as you want to go, given that log output is often shown
indented).

> @@ -364,7 +365,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		use_mailmap_config = git_config_bool(var, value);
>  		return 0;
>  	}
> -
> +	if (!prefixcmp(var, "gpg."))
> +		return git_gpg_config(var, value, NULL); 
>  	if (grep_config(var, value, cb) < 0)
>  		return -1;

The gpg config can also be other places than "gpg.*". Right now it is
just user.signingkey, which log would not care about, but it feels like
we are depending an unnecessary detail here. We also don't know whether
it would care about the callback data. Is there a reason not to do:

  if (git_gpg_config(var, value, cb) < 0)
          return -1;

just like the grep_config call below?

-Peff
