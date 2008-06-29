From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 14:31:56 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 20:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD1hn-0005vy-H2
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 20:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbYF2Sb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbYF2Sb6
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 14:31:58 -0400
Received: from iabervon.org ([66.92.72.58]:49034 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860AbYF2Sb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 14:31:58 -0400
Received: (qmail 9081 invoked by uid 1000); 29 Jun 2008 18:31:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jun 2008 18:31:56 -0000
In-Reply-To: <7vvdzuo61b.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86816>

On Fri, 27 Jun 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Fri, 27 Jun 2008, Johannes Schindelin wrote:
> >
> >> After initializing the config in the newly-created repository, we
> >> need to unset GIT_CONFIG so that the global configs are read again.
> >
> > This seems fine to me. OTOH, I'm not sure the environment variable should 
> > be needed in the first place; I think the config stuff should look in 
> > git_path("config") without it, and we set the git dir to the one we're 
> > initializing. So I think the use of the environment variable is just an 
> > artifact of how the shell script did it and how I was originally calling 
> > the init_db stuff.
> >
> > Just removing the "setenv()" line survives all of the tests for me, and I 
> > remember some of them failing before I'd gotten some sort of solution for 
> > the config stuff.
> 
> Ok, I take that you are Ok with 2/2 but you have a better replacement
> patch coming for this 1/2?

I think so. Did we even make a commitment on whether:

GIT_CONFIG=foo git clone bar

must ignore the environment variable, or simply doesn't necessarily obey 
it? IIRC, the test scripts used to set GIT_CONFIG to something 
problematic (and would fail if clone didn't ignore it), but this was 
deemed incorrect usage and fixed. 

If it's okay to obey it (i.e., it gives the location of the config file 
for the clone):

------
Use all of the normal config-file handling in builtin-clone.c

There's no need to use the environment variable to direct the generation 
of the config file in the C version of clone, and having it not defined 
means that global and per-user configuration is available. This is 
necessary for the fetching portion, and could be useful someday for the 
init portion as well. It is unlikely that the user would want the 
repository's configuration in some non-default location, but no less 
likely than with any other git command besides "git config".

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

diff --git a/builtin-clone.c b/builtin-clone.c
index f13845f..6dd58ac 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -415,8 +415,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	atexit(remove_junk);
 	signal(SIGINT, remove_junk_on_signal);
 
-	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
-
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die("could not create leading directories of '%s'", git_dir);
 	set_git_dir(make_absolute_path(git_dir));
