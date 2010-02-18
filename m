From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] show help message also for aliased commands
Date: Wed, 17 Feb 2010 21:18:50 -0500
Message-ID: <20100218021850.GB21693@coredump.intra.peff.net>
References: <1266456562-88841-1-git-send-email-patrick.sudowe@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Patrick Sudowe <patrick.sudowe@rwth-aachen.de>
X-From: git-owner@vger.kernel.org Thu Feb 18 03:19:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhvyu-0001pl-VK
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 03:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522Ab0BRCSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 21:18:52 -0500
Received: from peff.net ([208.65.91.99]:55174 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932495Ab0BRCSv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 21:18:51 -0500
Received: (qmail 24122 invoked by uid 107); 18 Feb 2010 02:19:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 17 Feb 2010 21:19:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2010 21:18:50 -0500
Content-Disposition: inline
In-Reply-To: <1266456562-88841-1-git-send-email-patrick.sudowe@rwth-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140289>

On Thu, Feb 18, 2010 at 02:29:22AM +0100, Patrick Sudowe wrote:

> git help 'alias' currently only shows the actual git command
> 'alias' refers to. This patch changes the behavior so that
> the help for the actual git command is shown. The user usually
> knows the aliases defined, and sometimes its just more convenient
> to type something like git help co than git help checkout
> to find out about some rarely used option.
> The original message is still there, so users do not face
> unexpected or surprising behavior.

Won't the original message get eaten when 'man' starts a pager (I know
there are other, non-paged ways of showing the help, but man is the
default).

> @@ -446,19 +447,22 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	alias = alias_lookup(argv[0]);
>  	if (alias && !is_git_command(argv[0])) {
>  		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
> -		return 0;
> +		cmd = alias;
> +	} else {
> +		cmd = argv[0];
>  	}
>  
> +
>  	switch (help_format) {
>  	case HELP_FORMAT_NONE:
>  	case HELP_FORMAT_MAN:
> -		show_man_page(argv[0]);
> +		show_man_page(cmd);

This breaks horribly for all but the simplest of aliases. This works:

  $ git config alias.co checkout
  $ git help co

But this would need to trim it down to just "log":

  $ git config alias.lp 'log -p'
  $ git help lp
  `git lp' is aliased to `log -p'
  No manual entry for gitlog -p

And this is just impossible:

  $ git config alias.jive '!sh -c "git log | jive"'
  $ git help jive
  `git jive' is aliased to `!sh -c "git log | jive"'
  No manual entry for git!sh -c "git log | jive"

-Peff
