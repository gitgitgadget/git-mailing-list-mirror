From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Wed, 23 Jul 2008 00:25:10 +0200
Message-ID: <20080722222510.GA4474@blimp.local>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local> <alpine.DEB.1.00.0807222207110.8986@racer> <20080722212633.GF5113@blimp.local> <alpine.DEB.1.00.0807222242160.8986@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLh8b-0003HJ-Et
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYGWQX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbYGWQX0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:23:26 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:40079 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYGWQXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:23:25 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5EC7
Received: from tigra.home (Faf34.f.strato-dslnet.de [195.4.175.52])
	by post.webmailer.de (fruni mo42) (RZmta 16.47)
	with ESMTP id J02deak6ND1cGw ; Wed, 23 Jul 2008 18:23:21 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 48717277BD;
	Wed, 23 Jul 2008 18:23:21 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id D929936D18; Wed, 23 Jul 2008 00:25:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807222242160.8986@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89702>

It is off by default, to avoid scaring people unless they asked to.
---

Johannes Schindelin, Tue, Jul 22, 2008 23:44:50 +0200:
> On Tue, 22 Jul 2008, Alex Riesen wrote:
> 
> > @@ -704,9 +707,10 @@ const char *help_unknown_cmd(const char *cmd)
> >  
> >  	if (!main_cmds.cnt)
> >  		die ("Uh oh.  Your system reports no Git commands at all.");
> > +	git_config(git_help_config, NULL);
> >  	best_similarity = similarity(main_cmds.names[0]->name);
> > -	if (main_cmds.cnt < 2 || best_similarity <
> > -			similarity(main_cmds.names[1]->name)) {
> > +	if (autocorrect && (main_cmds.cnt < 2 ||
> > +		best_similarity < similarity(main_cmds.names[1]->name))) {
> >  		if (!*cwd)
> >  			exit(1);
> >  		if (chdir(cwd))
> 
> This "if" already checks if there is only one candidate.  So you should 
> just add an inner "if (autocorrect) ... else single = 1;" or some such.

Oh right, stupid me.

> However, I think that the intention of this patch is too much DWIMery, 
> which might be good for me (just like my "git add remote" patch), but not 
> for the general audience.

Mustn't be good for all (for the "general audience" it is even common
practice to forget to thank. It may be even a sign of bad manners for
it). It is good for me though. And thanks for sharing.

Moved git_config before the calls where current directory is changed:
so that it has the same filesystem context as in normal case. Less
surprises.

 help.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index 480befe..8b25a55 100644
--- a/help.c
+++ b/help.c
@@ -28,6 +28,7 @@ enum help_format {
 	HELP_FORMAT_WEB,
 };
 
+static int autocorrect;
 static int show_all = 0;
 static enum help_format help_format = HELP_FORMAT_MAN;
 static struct option builtin_help_options[] = {
@@ -269,6 +270,8 @@ static int git_help_config(const char *var, const char *value, void *cb)
 	}
 	if (!prefixcmp(var, "man."))
 		return add_man_viewer_info(var, value);
+	if (!strcmp(var, "help.autocorrect"))
+		autocorrect = git_config_bool(var,value);
 
 	return git_default_config(var, value, cb);
 }
@@ -683,7 +686,7 @@ static int levenshtein_compare(const void *p1, const void *p2)
 
 const char *help_unknown_cmd(const char *cmd)
 {
-	int i, best_similarity = 0;
+	int i, best_similarity = 0, n;
 	char cwd[PATH_MAX];
 
 	if (!getcwd(cwd, sizeof(cwd))) {
@@ -691,6 +694,7 @@ const char *help_unknown_cmd(const char *cmd)
 		cwd[0] = '\0';
 	}
 
+	git_config(git_help_config, NULL);
 	load_command_list();
 	ALLOC_GROW(main_cmds.names, main_cmds.cnt + other_cmds.cnt,
 			main_cmds.alloc);
@@ -705,8 +709,11 @@ const char *help_unknown_cmd(const char *cmd)
 	if (!main_cmds.cnt)
 		die ("Uh oh.  Your system reports no Git commands at all.");
 	best_similarity = similarity(main_cmds.names[0]->name);
-	if (main_cmds.cnt < 2 || best_similarity <
-			similarity(main_cmds.names[1]->name)) {
+	n = 1;
+	while (n < main_cmds.cnt &&
+		best_similarity == similarity(main_cmds.names[n]->name))
+		++n;
+	if (autocorrect && n == 1) {
 		if (!*cwd)
 			exit(1);
 		if (chdir(cwd))
@@ -721,10 +728,10 @@ const char *help_unknown_cmd(const char *cmd)
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
 
 	if (best_similarity < 6) {
-		fprintf(stderr, "\nDid you mean one of these?\n");
+		fprintf(stderr, "\nDid you mean %s?\n",
+			n < 2 ? "this": "one of these");
 
-		for (i = 0; i < main_cmds.cnt && best_similarity ==
-				similarity(main_cmds.names[i]->name); i++)
+		for (i = 0; i < n; i++)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 
-- 
1.6.0.rc0.48.ga184
