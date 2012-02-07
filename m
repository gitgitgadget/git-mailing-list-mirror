From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Tue, 7 Feb 2012 14:46:35 -0500
Message-ID: <20120207194635.GA4136@sigill.intra.peff.net>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org>
 <20120207180625.GA27189@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 20:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rur01-0000YW-RG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 20:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844Ab2BGTqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 14:46:39 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59388
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756789Ab2BGTqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 14:46:37 -0500
Received: (qmail 10854 invoked by uid 107); 7 Feb 2012 19:53:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 14:53:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 14:46:35 -0500
Content-Disposition: inline
In-Reply-To: <20120207180625.GA27189@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190205>

On Tue, Feb 07, 2012 at 01:06:25PM -0500, Jeff King wrote:

> Though having looked a lot at the config code recently, I wonder if
> git_config_early is really necessary. The only caller (besides
> git_config) is check_repository_format_early, which just wants to see if
> core.repositoryformatversion in a directory is sane.
> 
> But why in the world would it want to do the full config lookup?
> Shouldn't it be checking git_config_from_file directly on the config
> file in the proposed repo?

I prepared the patch below to fix this, but it fails t0001. It turns out
that check_repository_format_gently checks not only stuff that should be
in .git/config, but also checks and remembers core.sharedrepository in
the process, which can come from anywhere.

So I think the "most correct" thing to do would be:

  - check_repository_format_gently reads _only_ from .git/config

  - core.sharedrepository should come from git_config_default

But that just creates more headaches. Callers like init_db would need to
call git_config separately. But of course they don't have the repo set
up properly, so they would want git_config_early. So we don't end up
getting to remove git_config_early, anyway.

And though it is slightly insane that you can do:

  git config --global core.repositoryformatversion 0

or even:

  git -c core.repositoryformatversion=0 ...

and it is respected, in practice nobody does this. So it's probably
better to just leave the code as-is.

-Peff

-- >8 --
Subject: don't look for repositoryformatversion outside of repo

In the check_repository_format_gently function, we use
git_config_early to parse the repository format version from
the .git/config file.

However, git_config_early looks in all of the sources of git
config, including /etc/gitconfig, ~/.gitconfig, and the
command line. But we should really only be interested in getting
the value from the repository's config file, since the point
of this function is to check the repository itself.

Therefore we can just feed our repo-config argument directly
to git_config_from_file. As a bonus, this means the subtle
distinction in using git_config_early versus git_config can
just go away.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/setup.c b/setup.c
index 61c22e6..20509cf 100644
--- a/setup.c
+++ b/setup.c
@@ -319,17 +319,8 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 {
 	char repo_config[PATH_MAX+1];
 
-	/*
-	 * git_config() can't be used here because it calls git_pathdup()
-	 * to get $GIT_CONFIG/config. That call will make setup_git_env()
-	 * set git_dir to ".git".
-	 *
-	 * We are in gitdir setup, no git dir has been found useable yet.
-	 * Use a gentler version of git_config() to check if this repo
-	 * is a good one.
-	 */
 	snprintf(repo_config, PATH_MAX, "%s/config", gitdir);
-	git_config_early(check_repository_format_version, NULL, repo_config);
+	git_config_from_file(check_repository_format_version, repo_config, NULL);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <= %d, found %d",
-- 
1.7.8.4.12.g3a22e3
