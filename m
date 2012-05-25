From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Fri, 25 May 2012 16:30:56 -0400
Message-ID: <20120525203056.GC4364@sigill.intra.peff.net>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri May 25 22:31:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY1AM-0000TW-4b
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633Ab2EYUbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 16:31:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56110
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758603Ab2EYUa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 16:30:58 -0400
Received: (qmail 12884 invoked by uid 107); 25 May 2012 20:31:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 16:31:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 16:30:56 -0400
Content-Disposition: inline
In-Reply-To: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198522>

On Fri, May 25, 2012 at 09:47:18PM +0200, NGUYEN Huynh Khoi Nguyen wrote:

> git will store its configuration in ~/.config/git/config file if this file
> exists and ~/.gitconfig file doesn't, otherwise git store its configuration
> in ~/.gitconfig as usual

What about reading? For maximum compatibility, we should always read
from _both_ of them, and choose between them only when writing, no? It
looks like your patch will only read from one or the other.

At first people will have only one or the other, but people using
multiple versions of git, or people following already-written
instructions on the web about modifying ~/.gitconfig could end up with
both.

> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -171,8 +171,20 @@ static int get_value(const char *key_, const char *regex_)
>  	if (!local) {
>  		const char *home = getenv("HOME");
>  		local = repo_config = git_pathdup("config");
> -		if (home)
> -			global = xstrdup(mkpath("%s/.gitconfig", home));
> +		if (home) {
> +			char gitconfig_path[PATH_MAX], config_path[PATH_MAX];
> +			FILE *gitconfig_file, *config_file;
> +
> +			sprintf(gitconfig_path, "%s/.gitconfig", home);
> +			sprintf(config_path, "%s/.config/git/config", home);

These are both exploitable buffer overflows. Why not use mkpath?

> +			gitconfig_file = fopen(gitconfig_path, "r");
> +			config_file = fopen(config_path, "r");

So we open both files. It looks like in an attempt to see if they are
readable. But:

  1. No need to go to that much work. You can just call access(R_OK).

  2. You never close the files, so you are leaking memory and file
     descriptors.

> +			if (gitconfig_file==NULL && config_file!=NULL)

Style. We put whitespace around comparison operators, and we usually
don't refer to NULL specifically, like:

  if (!gitconfig_file && config_file)


So a simpler way to write this section would be something like:

  if (home) {
          const char *path = mkpath("%s/.config/git/config", home);

          if (!access(path, R_OK))
                  global = xstrdup(path);
          else
                  global = xstrdup(mkpath("%s/.gitconfig", home));
  }

But like I said earlier, I think this should really be reading from
_both_, which is a different change altogether.

I won't go through the other two hunks individually, but my comments are
similar.

-Peff
