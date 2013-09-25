From: Jeff King <peff@peff.net>
Subject: Re: git clone -c core.sharedRepository=group not working as expected
 (git v1.8.4 linux/osx)
Date: Wed, 25 Sep 2013 04:18:44 -0400
Message-ID: <20130925081844.GA23238@sigill.intra.peff.net>
References: <CAFGOX=UiqqeZMxY_TCdA5ns0HpWxVUHHYmUBiEg+Zr1R5ZfHVA@mail.gmail.com>
 <20130924190643.GL9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Amit Bakshi <ambakshi@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 10:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOkJD-0002KT-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 10:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab3IYISu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 04:18:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:35349 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab3IYISr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 04:18:47 -0400
Received: (qmail 22785 invoked by uid 102); 25 Sep 2013 08:18:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Sep 2013 03:18:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Sep 2013 04:18:44 -0400
Content-Disposition: inline
In-Reply-To: <20130924190643.GL9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235335>

On Tue, Sep 24, 2013 at 12:06:43PM -0700, Jonathan Nieder wrote:

> Part of the underlying problem is that unlike 'git init', 'git clone'
> does not accept a --shared=(true|false|group|...) option.  Worse, it
> does accept a --shared option, with a completely different meaning.
> No better option names are coming immediately to mind, but perhaps
> someone on the list will have ideas that could let 'git clone' and
> 'git init' use the same --share-repository=group option?

Perhaps calling it something like --permissions would be good (IMHO,
that is more descriptive than "--shared" for "git init"). Then both can
respect it, and "init" maintains "--shared" for backwards compatibility.

Calling it --shared-repository does match the config name, but I do not
find that name especially descriptive. But perhaps it is good enough,
and consistency with the existing name is certainly a plus.

> Another problem is that once the configuration is written, it is past
> the point that some of the sharedrepository setting's effect would
> have occured.  The repository, including worktree, object dirs, and so
> on has already been created without g+w and setgid bits set.

Yes. This is as-documented for "clone -c", which claims to act after the
repository is initialized. That being said, I think it is less confusing
for the user for them to take effect as early as possible, so the user
doesn't have to worry.

I cannot think off-hand of any case where the user would actually want
the delayed effect.

> Worse, when we write the new configuration and then re-read it, we
> skip reading some repository-specific configuration
> (core.{repositoryformatversion,sharedrepository,bare,worktree})
> on the assumption that we should already know what their values would
> be.  That assumption is now wrong.

Yes, I think this is simply a bug in 84054f7 (clone: accept config
options on the command line), which assumed that any effects it had
would be picked up by the git_config() call.

> I wonder if something like the following (just a sketch, completely
> untested) would make sense.
> 
> diff --git i/builtin/clone.c w/builtin/clone.c
> index 7ac677d..145a974 100644
> --- i/builtin/clone.c
> +++ w/builtin/clone.c
> @@ -856,7 +856,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	init_db(option_template, INIT_DB_QUIET);
>  	write_config(&option_config);
>  
> +	if (option_bare)
> +		git_config_set("core.bare", "true");
> +
>  	git_config(git_default_config, NULL);
> +	check_repository_format();

If we call check_repository_format() again, we will pick up the new
config. But I think we would still have to go back and fix the paths
created by init_db.

It may be cleaner to teach init_db to add the initial config (and
optionally add "init -c" for testing, though I do not think anyone
particularly cares in the real world).

-Peff
