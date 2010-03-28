From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Sun, 28 Mar 2010 05:22:54 -0400
Message-ID: <20100328092253.GA17563@coredump.intra.peff.net>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Lars R. Damerow" <lars@pixar.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 11:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvoiP-0001HM-8C
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 11:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab0C1JXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 05:23:11 -0400
Received: from peff.net ([208.65.91.99]:42782 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab0C1JXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 05:23:10 -0400
Received: (qmail 20766 invoked by uid 107); 28 Mar 2010 09:23:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 05:23:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 05:22:54 -0400
Content-Disposition: inline
In-Reply-To: <1268855753-25840-4-git-send-email-lars@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143382>

On Wed, Mar 17, 2010 at 12:55:53PM -0700, Lars R. Damerow wrote:

> This patch makes git pay attention to the GIT_ONE_FILESYSTEM environment
> variable. When that variable is set, git will stop searching for a
> GIT_DIR when it attempts to cross a filesystem boundary.
> 
> When working in an environment with too many automount points to make
> maintaining a GIT_CEILING_DIRECTORIES list enjoyable, GIT_ONE_FILESYSTEM
> gives the option of turning all such attempts off with one setting.

Thanks, this version (and the whole series) looks good to me, with two
minor nits below.

As far as a command-line option or a config option, I don't see the
point. It seems to me something you would want enabled all the time, not
a one-shot option, so a command-line option doesn't make much sense
(after all, you could just use --git-dir at that point, which would be
even faster). A config option might be useful, but I think it might be
tricky to implement due to the startup sequence.  If anybody disagrees,
they can always build on top of your series very easily.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 35c0c79..dbb590f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -529,6 +529,9 @@ git so take care if using Cogito etc.
>  	a GIT_DIR set on the command line or in the environment.
>  	(Useful for excluding slow-loading network directories.)
>  
> +'GIT_ONE_FILESYSTEM'::
> +	Stop at filesystem boundaries when looking for .git or objects.
> +

We should give the user a little more information than that.
Specifically:

  - what form should the value take?

  - how does it interact with GIT_DIR?

Also, we use the phrase "repository directory" in
GIT_CEILING_DIRECTORIES, so we should probably do the same here.

So how about this squashed into your patch?

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e7ebaaa..bf1b45e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -531,7 +531,10 @@ git so take care if using Cogito etc.
 	(Useful for excluding slow-loading network directories.)
 
 'GIT_ONE_FILESYSTEM'::
-	Stop at filesystem boundaries when looking for .git or objects.
+	If set to a true value ("true" or a non-zero integer), stop at
+	filesystem boundaries when looking for a repository directory.
+	Like 'GIT_CEILING_DIRECTORIES', it will not affect an explicit
+	respository directory set via 'GIT_DIR' or on the command line.
 
 git Commits
 ~~~~~~~~~~~

> --- a/setup.c
> +++ b/setup.c
> @@ -390,6 +392,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	 *   etc.
>  	 */
>  	offset = len = strlen(cwd);
> +	if ((one_filesystem = git_env_bool("GIT_ONE_FILESYSTEM", 0))) {
> +		if (stat(".", &buf))
> +			die_errno("failed to stat '.'");
> +		current_device = buf.st_dev;
> +	}

Style nit. I know you did the proper () to silence the compiler warning,
but we usually avoid assignment-inside-conditional altogether.
Personally I don't really care either way.

With those fixes, I think it should be ready for 'next'.

-Peff
