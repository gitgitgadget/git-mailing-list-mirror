From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Tue, 22 Jul 2008 23:03:55 +0200
Message-ID: <20080722210354.GD5113@blimp.local>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:06:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLP3W-0002cu-UI
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbYGVVD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbYGVVD5
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:03:57 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:56651 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbYGVVD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:03:56 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jepV
Received: from tigra.home (Fa955.f.strato-dslnet.de [195.4.169.85])
	by post.webmailer.de (klopstock mo35) (RZmta 16.47)
	with ESMTP id a0297ek6MHlSOK ; Tue, 22 Jul 2008 23:03:55 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 0D462277BD;
	Tue, 22 Jul 2008 23:03:55 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 0C42D36D17; Tue, 22 Jul 2008 23:03:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080722203730.GC5113@blimp.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89528>

It is off by default, to avoid scaring people unless they asked to.

---

Alex Riesen, Tue, Jul 22, 2008 22:37:30 +0200:
> Johannes Schindelin, Tue, Jul 22, 2008 22:01:29 +0200:
> > As a convenience, if there is only one candidate, Git continues under
> > the assumption that the user mistyped it.  Example:
> > 
> > 	$ git reabse
> > 	WARNING: You called a Git program named 'reabse', which does
> > 	not exist.
> > 	Continuing under the assumption that you meant 'rebase'
> > 	[...]
> 
> Oh, that would make me suspicios (and I hit Ctrl-C fast when I get
> suspicios about what happens to my precious data). Could it be
> configurable? For example, BASH's cdspell is configurable and even off
> by default.
> 

Like this, perhaps?

 help.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 480befe..f08eb9d 100644
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
@@ -704,9 +707,10 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (!main_cmds.cnt)
 		die ("Uh oh.  Your system reports no Git commands at all.");
+	git_config(git_help_config, NULL);
 	best_similarity = similarity(main_cmds.names[0]->name);
-	if (main_cmds.cnt < 2 || best_similarity <
-			similarity(main_cmds.names[1]->name)) {
+	if (autocorrect && (main_cmds.cnt < 2 ||
+		best_similarity < similarity(main_cmds.names[1]->name))) {
 		if (!*cwd)
 			exit(1);
 		if (chdir(cwd))
-- 
1.6.0.rc0.48.g6dda.dirty
