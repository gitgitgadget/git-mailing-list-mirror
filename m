From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add `git diff2`, a GNU diff workalike
Date: Fri, 16 Feb 2007 15:20:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702161506100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702160500280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wkq8r26.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702161447080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 15:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI3x8-0002g8-LF
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 15:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbXBPOUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 09:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbXBPOUm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 09:20:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:43326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932365AbXBPOUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 09:20:42 -0500
Received: (qmail invoked by alias); 16 Feb 2007 14:20:40 -0000
X-Provags-ID: V01U2FsdGVkX19OXQwC92pOocvMK+/c6UvsnAU8ecu9OZZLLwDbDK
	4/qg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702161447080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39915>

Hi,

On Fri, 16 Feb 2007, Johannes Schindelin wrote:

> On Fri, 16 Feb 2007, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > +	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> > > +		return error("file/directory conflict: %s, %s", name1, name2);
> > 
> > If a/frotz is a file and b/frotz/nitfol is there, I do not think we show 
> > an error; we say "a/frotz" was removed (see notes below, though).
> 
> Good point. Will fix.

Thinking about this again, I do not know of any patch implementation which 
removes a directory which just became empty, so dir->file is a real 
problem. Also, if dir is empty, another problem looms.

So at least the dir->non-dir case should be an error.

BTW I just realized that diff2 as-is will output a diff header for _every_ 
file pair, even if they do compare equally. Actually, I like it, so I 
don't want to imitate GNU diff behaviour here.

Ciao,
Dscho

P.S.: Here is a quick-fix patch on top of my original (tested with 
dir->file (error!), file->dir, link->link, link->null, file->link):

 builtin-diff2.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin-diff2.c b/builtin-diff2.c
index 1de82c1..234dabb 100644
--- a/builtin-diff2.c
+++ b/builtin-diff2.c
@@ -15,7 +15,7 @@ static int read_directory(const char *path, struct path_list *list)
 
 	while ((e = readdir(dir)))
 		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
-			path_list_insert(xstrdup(e->d_name), list);
+			path_list_insert(e->d_name, list);
 
 	closedir(dir);
 	return 0;
@@ -28,18 +28,24 @@ static int queue_diff(struct diff_options *o,
 	int mode1 = 0, mode2 = 0;
 
 	if (name1) {
-		if (stat(name1, &st))
+		if (lstat(name1, &st))
 			return error("Could not access '%s'", name1);
 		mode1 = st.st_mode;
 	}
 	if (name2) {
-		if (stat(name2, &st))
+		if (lstat(name2, &st))
 			return error("Could not access '%s'", name1);
 		mode2 = st.st_mode;
 	}
 
-	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
-		return error("file/directory conflict: %s, %s", name1, name2);
+	if (mode1 && mode2) {
+		if (S_ISDIR(mode1) && !S_ISDIR(mode2))
+			return error("Cannot handle dir->file: %s -> %s",
+				name1, name2);
+		if (!S_ISDIR(mode1) && S_ISDIR(mode2))
+			return queue_diff(o, name1, NULL) ||
+				queue_diff(o, NULL, name2);
+	}
 
 	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
 		char buffer1[PATH_MAX], buffer2[PATH_MAX];
