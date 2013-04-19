From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Teach git to change to a given directory using -C option
Date: Fri, 19 Apr 2013 12:12:50 -0400
Message-ID: <20130419161250.GC14263@sigill.intra.peff.net>
References: <1366374108-23725-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 18:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTDvl-00062E-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967565Ab3DSQMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:12:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:44117 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967459Ab3DSQMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 12:12:52 -0400
Received: (qmail 4616 invoked by uid 102); 19 Apr 2013 16:12:57 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 11:12:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2013 12:12:50 -0400
Content-Disposition: inline
In-Reply-To: <1366374108-23725-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221766>

On Fri, Apr 19, 2013 at 08:21:48PM +0800, Nazri Ramliy wrote:

> This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".
> 
> Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
> ---
> Often I find myself needing to find out quickly the status of a repository that
> is not in my currenct working directory, like this:
> 
>          $ (cd ~/foo; git log -1)
> 
> With this patch now i can simply do:
> 
>          $ git -C ~/.zsh log -1 
> 
> That's just one example. I think those who are familiar with the -C arguments
> to "make" and "tar" commands would get the "handiness" of having this option in
> git.

This motivation should probably go into the commit message.

I think it's worth pausing for a moment and considering if we can do
this already with existing features.

You can _almost_ do this with "git --git-dir". But it expects the actual
git directory, not a starting point for finding the git directory. And
it remains in your same working dir. So with a bare repository, these
two are equivalent:

  $ git --git-dir=/path/to/foo.git ...
  $ git -C /path/to/foo.git ...

But with a non-bare repo, this does not work:

  $ git --git-dir=/path/to/non-bare ...

You must instead say:

  $ git --git-dir=/path/to/non-bare/.git ...

and even then, I think it will treat your current directory as the
working tree, not /path/to/non-bare.

So I think "-C" is a worthwhile addition compared to just "--git-dir".

It is redundant with "(cd foo && git ...)" in the shell, as you note,
but sometimes it is more convenient to use "-C" (especially if you are
exec-ing git from another program and want to avoid the shell entirely
for quoting reasons).

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 6a875f2..20bba86 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -379,6 +379,9 @@ displayed. See linkgit:git-help[1] for more information,
>  because `git --help ...` is converted internally into `git
>  help ...`.
>  
> +-C <directory>::
> +	Change to given directory before doing anything else.
> +

It might make sense to clarify this as "...anything else, including
determining the location of the git repository directory". If you think
hard about it, doing anything else would not really make much sense, but
spelling it out makes it clear what the option can be used for.

> +		if (!prefixcmp(cmd, "-C")) {

Should this be strcmp? You do not seem to handle "-Cfoo" below.

> +			if (*argc < 2) {
> +				fprintf(stderr, "No directory given for -C.\n" );
> +				usage(git_usage_string);
> +			}

I know you are copying this from the other options in the same function,
but I wonder if they should all be calling "error()" (and dropping the
terminating ".") to better match our usual error messages.

> +			if (chdir((*argv)[1]))
> +				die_errno("Cannot change to '%s'", (*argv)[1]);
> +			(*argv)++;
> +			(*argc)--;

You would want to set "*envchanged = 1" here. The intent of that flag is
that git would need to throw away things it has looked up already (like
the git dir) in order to correctly utilize the options (and since we
haven't implemented that "throw away" step, it just complains and dies).

I didn't try it, but I suspect your patch would be broken with:

  $ git config alias.logfoo '-C /path/to/foo log'
  $ cd /some/other/repo
  $ git logfoo

It would still use /some/other/repo as a $GIT_DIR, having looked it up
before processing the "-C".

-Peff
