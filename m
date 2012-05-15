From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] drop length limitations on gecos-derived names and
 emails
Date: Mon, 14 May 2012 21:54:37 -0400
Message-ID: <20120515015437.GA13833@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
 <20120514210225.GA9677@sigill.intra.peff.net>
 <20120514211324.GA11578@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 03:54:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU6yL-0002eg-E1
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 03:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771Ab2EOByj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 21:54:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43315
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758320Ab2EOByj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 21:54:39 -0400
Received: (qmail 27331 invoked by uid 107); 15 May 2012 01:55:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 21:55:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 21:54:37 -0400
Content-Disposition: inline
In-Reply-To: <20120514211324.GA11578@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197817>

On Mon, May 14, 2012 at 05:13:24PM -0400, Jeff King wrote:

> where we are not careful. The fix is trivial. However, while examining
> fmt_ident, I notice there is another potential spot there that needs
> further investigation (I think it may actually be unreachable code, but
> I need to look closer).
> 
> I'll re-roll the series with the fixes after investigating fmt_ident.

Hmm. This code from fmt_ident is very odd:

> const char *fmt_ident(const char *name, const char *email,
> 		      const char *date_str, int flag)
> {
> [...]
> 	setup_ident(&name, &email);
> 
> 	if (!*name) {
> 		struct passwd *pw;
> 
> 		if ((warn_on_no_name || error_on_no_name) &&
> 		    name == git_default_name && env_hint) {
> 			fputs(env_hint, stderr);
> 			env_hint = NULL; /* warn only once */
> 		}
> 		if (error_on_no_name)
> 			die("empty ident %s <%s> not allowed", name, email);
> 		pw = getpwuid(getuid());
> 		if (!pw)
> 			die("You don't exist. Go away!");
> 		strlcpy(git_default_name, pw->pw_name,
> 			sizeof(git_default_name));
> 		name = git_default_name;
> 	}

We call setup_ident with our name pointer, which usually comes from
getenv("GIT_*_NAME"), although could also come from something like "git
commit -c $commit". We feed that to setup_ident. If name is NULL, then
setup_ident will use git_default_name (filling it in from gecos or
config). If it's not NULL, then we use it literally. And then we check
_that_ result to see if it's empty. If it is, we either die or warn,
depending on the flags. In the latter case, we fallback to using the
username as the name.

And that's what confuses me. Depending on what was passed in, we may
have checked that GIT_COMMITTER_NAME is an empty string, or we may have
checked that the config or gecos field yielded an empty string. In the
latter case, it makes sense to fall back to the username. But in the
former case, it doesn't; we should fall back to the config name or the
gecos name. And worse, we've polluted git_default_name for the rest of
the program run.

Instead of falling back to getpwuid(), should it fall back to:

   /* If this wasn't our default name already, then fall back to that. */
   if (name != git_default_name) {
           name = NULL;
           setup_ident(&name, &email);
   }

   /* If we _still_ don't have a non-empty name, then fall back to
    * username. */
   if (!*name) {
          pw = getpwuid(getuid());
          if (!pw)
                  die("You don't exist. Go away!");
          strlcpy(git_default_name, pw->pw_name, sizeof(git_default_name));
          nae = git_default_name;
   }

Of course we've still polluted this crappy fake name into
git_default_name, so that later calls with error_on_no_name will see it
and not error. I think so far it hasn't mattered because the only user
of this "warn" code is format-patch, which otherwise does not care about
ident (and doesn't even end up using the name at all!). And I doubt this
code path gets triggered much anyway; do people really run
"GIT_COMMITTER_NAME= git format-patch"?

I can just leave it as it's not really hurting anybody, I think. But I
was refactoring in the area and it just seemed flaky and questionable. I
wonder if we can simply get rid of the IDENT_WARN_ON_NO_NAME code path
entirely. The use here is grabbing the email address to use as part of a
message id. Could we just call setup_ident and then read from
git_default_email directly? There's no need to respect
GIT_COMMITTER_EMAIL here at all.

-Peff
