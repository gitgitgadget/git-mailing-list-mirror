From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v5 3/3] push: teach --recurse-submodules the on-demand
	option
Date: Mon, 26 Mar 2012 21:33:34 +0200
Message-ID: <20120326193334.GC41087@book.hvoigt.net>
References: <20120213092541.GA15585@t1405.greatnet.de> <20120213093008.GD15585@t1405.greatnet.de> <7v7gzq9jg2.fsf@alter.siamese.dyndns.org> <4F3C3172.8030505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFfh-0005Z5-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab2CZTdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:33:37 -0400
Received: from darksea.de ([83.133.111.250]:49971 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754494Ab2CZTdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:33:36 -0400
Received: (qmail 23883 invoked from network); 26 Mar 2012 21:33:34 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 26 Mar 2012 21:33:34 +0200
Content-Disposition: inline
In-Reply-To: <4F3C3172.8030505@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193963>

On Wed, Feb 15, 2012 at 11:28:02PM +0100, Jens Lehmann wrote:
> Am 14.02.2012 04:34, schrieb Junio C Hamano:
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> > 
> >> diff --git a/submodule.c b/submodule.c
> >> index 3c714c2..ff0cfd8 100644
> >> --- a/submodule.c
> >> +++ b/submodule.c
> >> @@ -411,6 +411,54 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20],
> >>  	return needs_pushing->nr;
> >>  }
> >>  
> >> +static int push_submodule(const char *path)
> >> +{
> >> +	if (add_submodule_odb(path))
> >> +		return 1;
> >> +
> >> +	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
> >> +		struct child_process cp;
> >> +		const char *argv[] = {"push", NULL};
> >> +
> >> +		memset(&cp, 0, sizeof(cp));
> >> +		cp.argv = argv;
> >> +		cp.env = local_repo_env;
> >> +		cp.git_cmd = 1;
> >> +		cp.no_stdin = 1;
> >> +		cp.dir = path;
> >> +		if (run_command(&cp))
> >> +			return 0;
> >> +		close(cp.out);
> >> +	}
> >> +
> >> +	return 1;
> >> +}
> > 
> > Hmm, this makes me wonder if we fire subprocesses and have them run in
> > parallel (to a reasonably limited parallelism), it might make the overall
> > user experience more pleasant, and if we did the same on the fetching
> > side, it would be even nicer.
> 
> Yeah, I had the same idea and did some experiments when working on
> fetch some time ago.
> 
> > We would need to keep track of children and after firing a handful of them
> > we would need to start waiting for some to finish and collect their exit
> > status before firing more, and at the end we would need to wait for the
> > remaining ones and find how each one of them did before returning from
> > push_unpushed_submodules().  If we were to do so, what are the missing
> > support we would need from the run_command() subsystem?
> 
> We would not only have to collect the exit status but also the output
> lines. You don't want to see the output of multiple fetches or pushes
> mixed together, so it makes sense to just defer that until the command
> exited and then print everything at once. The interesting part I couldn't
> come up with an easy solution for is to preserve the output order between
> the stdout and stdin lines, as they contain different parts of the
> progress which would look strange when shuffled around.
> 
> And I saw that sometimes parallel fetches took way longer than doing them
> sequentially (in my case because of strange DNS behavior of my DSL router),
> so we would definitely want a config option for that (maybe setting the
> maximum number of simultaneous threads to be used).
> 
> But don't get me wrong, I'm all for having that feature! :-)

Me too, but I would suggest that we first implement the basic recursive
push functionality and then start to do optimizations like this. I think
we will definitely be interested in parallel pushing once we start using it.

Cheers Heiko
