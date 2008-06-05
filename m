From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Fri, 6 Jun 2008 00:15:36 +0300
Message-ID: <20080605211536.GA4328@mithlond.arda.local>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080605081911.GA5946@mithlond.arda.local> <7viqwn3g3r.fsf@gitster.siamese.dyndns.org> <408F1687-FC42-4E96-B641-088F200CE8D1@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Mpe-0008Tz-J2
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYFEVQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 17:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbYFEVQY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 17:16:24 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:48469 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424AbYFEVQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 17:16:22 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F00639193; Fri, 6 Jun 2008 00:15:39 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K4Mo4-0003s4-Ru; Fri, 06 Jun 2008 00:15:36 +0300
Content-Disposition: inline
In-Reply-To: <408F1687-FC42-4E96-B641-088F200CE8D1@ai.rug.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83984>

Pieter de Bie wrote (2008-06-05 20:38 +0200):

> On 5 jun 2008, at 20:13, Junio C Hamano wrote:
> 
> >See 'man git' and 'git help' for more information.
> 
> I'd like to see something more like
> 
> See 'git help COMMAND' for more information on a specific command

Sounds good. Here comes my first _ever_ attempt on C "programming". It
implements (i.e. tries to) what pretty much seems like an agreement on
the list: a separate info line after the command list. If the patch
sucks, well, at least I've had fun trying. And there's no need to ask me
to defend my code; I'm not able to answer. :-)

---snip---
Print info about "git help COMMAND" on git's main usage pages

Git's main usage pages did not show "git help" as a way to get more
information on a specific subcommand. This patch adds an info line after
the list of git commands currently printed by "git", "git help", "git
--help" and "git help --all".

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 builtin.h |    1 +
 git.c     |    4 ++++
 help.c    |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin.h b/builtin.h
index 8bda111..b460b2d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -5,6 +5,7 @@
 
 extern const char git_version_string[];
 extern const char git_usage_string[];
+extern const char git_more_info_string[];
 
 extern void list_common_cmds_help(void);
 extern void help_unknown_cmd(const char *cmd);
diff --git a/git.c b/git.c
index 272bf03..15a0e71 100644
--- a/git.c
+++ b/git.c
@@ -6,6 +6,9 @@
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
+const char git_more_info_string[] =
+	"See 'git help COMMAND' for more information on a specific command.";
+
 static int handle_options(const char*** argv, int* argc, int* envchanged)
 {
 	int handled = 0;
@@ -427,6 +430,7 @@ int main(int argc, const char **argv)
 		/* The user didn't specify a command; give them help */
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
+		printf("\n%s\n", git_more_info_string);
 		exit(1);
 	}
 	cmd = argv[0];
diff --git a/help.c b/help.c
index d89d437..8aff94c 100644
--- a/help.c
+++ b/help.c
@@ -649,12 +649,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_commands();
+		printf("%s\n", git_more_info_string);
 		return 0;
 	}
 
 	if (!argv[0]) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
+		printf("\n%s\n", git_more_info_string);
 		return 0;
 	}
 
-- 
1.5.6.rc1.16.gc6796
