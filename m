From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make Git accept absolute path names for files within
	the work tree
Date: Thu, 6 Dec 2007 01:12:34 -0500
Message-ID: <20071206061234.GC23309@coredump.intra.peff.net>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <20071204014326.GA21358@coredump.intra.peff.net> <Pine.LNX.4.64.0712040216220.27959@racer.site> <200712040742.24728.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0712041149440.27959@racer.site> <alpine.LFD.0.9999.0712040756370.2981@woody.linux-foundation.org> <20071204220840.GA3340@coredump.intra.peff.net> <alpine.LFD.0.9999.0712041444090.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J09yk-0003n1-K4
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbXLFGMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbXLFGMh
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:12:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3478 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbXLFGMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:12:36 -0500
Received: (qmail 28246 invoked by uid 111); 6 Dec 2007 06:12:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 01:12:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 01:12:34 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712041444090.13796@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67251>

On Tue, Dec 04, 2007 at 02:52:15PM -0800, Linus Torvalds wrote:

> IOW, that whole thing is simply a bug waiting to happen. The fact that it 
> apparently *always* runs whether needed or not just seems to make it worse 
> (ie if we already know our cwd, and the absolute path we have already has 
> that as a prefix, just strip it off, don't try to do anything complex, and 
> leave the complex and fragile cases for the odd-ball when the simple 
> approach doesn't work)

Fair enough. Something like this then? It gets called only as a
last-ditch (though I think the 'return path' should simply be a die
-- what is the point of getting a pathspec that isn't in the repo?).

---
diff --git a/setup.c b/setup.c
index 4ee8024..fbb956e 100644
--- a/setup.c
+++ b/setup.c
@@ -5,13 +5,17 @@ static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
 static
-const char *strip_work_tree_path(const char *prefix, int len, const char *path)
+const char *strip_work_tree_path(const char *prefix, int len, const char *path,
+		int canonicalized)
 {
 	const char *work_tree = get_git_work_tree();
 	int n = strlen(work_tree);
 
 	if (strncmp(path, work_tree, n))
-		return path;
+		return canonicalized ?
+			path :
+			strip_work_tree_path(prefix, len,
+					xstrdup(make_absolute_path(path)), 1);
 
 	if (!prefix && !path[n])
 		return path + n;
@@ -58,7 +62,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
 	if (is_absolute_path(path))
-		path = strip_work_tree_path(prefix, len, path);
+		path = strip_work_tree_path(prefix, len, path, 0);
 
 	for (;;) {
 		char c;
