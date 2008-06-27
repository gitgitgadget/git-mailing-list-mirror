From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Fri, 27 Jun 2008 13:55:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271353350.9925@racer>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Jun 27 14:58:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDXU-0003sG-5S
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 14:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954AbYF0M51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 08:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757860AbYF0M50
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 08:57:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:48601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755024AbYF0M5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 08:57:24 -0400
Received: (qmail invoked by alias); 27 Jun 2008 12:57:23 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp050) with SMTP; 27 Jun 2008 14:57:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/39318bpn3m7iEiQU9rvQvgzpXhodnzXDHqBHp35
	KrHcQKu8wZbQnR
X-X-Sender: gene099@racer
In-Reply-To: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86548>


After initializing the config in the newly-created repository, we
need to unset GIT_CONFIG so that the global configs are read again.

Noticed by Pieter de Bie.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 27 Jun 2008, Pieter de Bie wrote:

	> I sometimes use url.insteadOf to create a shortcut to a central 
	> repository. For example, having something like[*1*]
	> 
	> [url "git://repo.or.cz/git/"]
	> 	insteadOf = "repo:"
	> 
	> in my global gitconfig allows me to do a 'git fetch 
	> repo:dscho.git'. I'd also like to use that with git clone :).
	> Currently if I try that, I get
	> 
	> Vienna:~ pieter$ git clone repo:dscho.git
	> Initialize dscho/.git
	> Initialized empty Git repository in /Users/pieter/dscho/.git/
	> ssh: Error resolving hostname repo: nodename nor servname provided,
	>	or not known
	> fatal: The remote end hung up unexpectedly
	> 
	> [...]
	>
	> Is there an easy fix for this?

	Yes ;-)

 builtin-clone.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 17baa20..965b5fc 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -424,6 +424,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	fprintf(stderr, "Initialize %s\n", git_dir);
 	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
 
+	/*
+	 * At this point, the config exists, so we do not need the
+	 * environment variable.  We actually need to unset it, too, to
+	 * re-enable parsing of the global configs.
+	 */
+	unsetenv(CONFIG_ENVIRONMENT);
+
 	if (option_reference)
 		setup_reference(git_dir);
 
-- 
1.5.6.173.gde14c
