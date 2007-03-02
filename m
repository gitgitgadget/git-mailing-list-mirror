From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 22:45:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703022237000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703011206.47213.andyparkins@gmail.com> <es9aal$5gf$1@sea.gmane.org>
 <Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
 <200703021937.33648.andyparkins@gmail.com> <Pine.LNX.4.64.0703021249010.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 22:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNFZA-00027H-E5
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 22:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965674AbXCBVpO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 16:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965638AbXCBVpO
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 16:45:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:53163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965666AbXCBVpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 16:45:12 -0500
Received: (qmail invoked by alias); 02 Mar 2007 21:45:10 -0000
X-Provags-ID: V01U2FsdGVkX1+I9AtyfZSIiKssKUqM97JP7sWWnKhOwesKmsBGed
	jivpTpVhQED+vf
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703021249010.3953@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41250>

Hi,

On Fri, 2 Mar 2007, Linus Torvalds wrote:

> Doing the pager internally would obviously solve that issue,

Ooooooh! A builtin! (Seriously, I thought about that already, but 
dismissed it for the reasons you said, and more...)

> So we're in the situation where:
> 
>  - the pager process *will* wait until actual data is starting to appear,
>    so we *can* have some side-band channel to tell it "oh, btw, if there 
>    is a pager, this is going to be image data, so start up an external 
>    image viewer instead". 
> 
>  - but I don't have a good clue what side-band to use. We could use 
>    a special "FILE *pagerdata", of course (which would just be fd#3 in 
>    the pager). Then, "git show" could just do something like
> 
> 	if (pager_in_use)
> 		fprintf(pagerdata, "'%s'\n", type);
> 
>    and we could change pager.c to do something like the appended patch.
> 
> but I have to say, it looks a bit strange.

The obvious thing, of course, is a git-show specific solution (this is no 
patch, it only illustrates my idea):

 builtin-log.c |   11 +++++++++++
 git.c         |    2 +-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1c9f7d0..83e6cea 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -123,6 +123,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct object_array_entry *objects;
 	int i, count, ret = 0;
+	enum { NO_PAGER, TEXT_PAGER, OTHER_PAGER } pager_mode = NO_PAGER;
 
 	git_config(git_log_config);
 	init_revisions(&rev, prefix);
@@ -140,6 +141,16 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < count && !ret; i++) {
 		struct object *o = objects[i].item;
 		const char *name = objects[i].name;
+		if (o->type == OBJ_BLOB) {
+			/* determine if name falls into some special class */
+			if (pager_mode == NO_PAGER &&
+					setup_special_pager(name))
+				pager_mode = OTHER_PAGER;
+		}
+		if (pager_mode == NO_PAGER) {
+			setup_pager();
+			pager_mode = TEXT_PAGER;
+		}
 		switch (o->type) {
 		case OBJ_BLOB:
 			ret = show_object(o->sha1, 0);
diff --git a/git.c b/git.c
index 909adf2..a3811e6 100644
--- a/git.c
+++ b/git.c
@@ -291,7 +291,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "runstatus", cmd_runstatus, RUN_SETUP | DISALLOW_IN_GIT_DIR },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
-		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "show", cmd_show, RUN_SETUP },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
