From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make Git accept absolute path names for files within
	the work tree
Date: Tue, 4 Dec 2007 17:08:40 -0500
Message-ID: <20071204220840.GA3340@coredump.intra.peff.net>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <20071204014326.GA21358@coredump.intra.peff.net> <Pine.LNX.4.64.0712040216220.27959@racer.site> <200712040742.24728.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0712041149440.27959@racer.site> <alpine.LFD.0.9999.0712040756370.2981@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:09:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izfwt-0004L1-2N
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXLDWIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 17:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbXLDWIn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 17:08:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1528 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbXLDWIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 17:08:42 -0500
Received: (qmail 12269 invoked by uid 111); 4 Dec 2007 22:08:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Dec 2007 17:08:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2007 17:08:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712040756370.2981@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67090>

On Tue, Dec 04, 2007 at 07:59:43AM -0800, Linus Torvalds wrote:

> > I do remember the hassles I went through with get_relative_cwd() until I 
> > broke down and used chdir() two times (ugly).
> 
> It really is a pretty heavy and complex operation in UNIX in general (and 
> open to various races too), which is why I'd generally suggest avoiding it 
> if you at all can.

It is more expensive, though we will be doing it once per user-supplied
pathspec, so I don't know that it will actually have an impact.

I am concerned that not supporting symlinks will make this feature
unusably annoying for some users. I used to have a home directory that
had a symlink in it, and I frequently ran into these sorts of path
comparison issues ($HOME was /home/peff, so typing ~/repo/file pointed
there, but /home was a symlink to /mnt/data/home, so any routines that
normalize the cwd used /mnt/data/home/repo, and the two never matched
up).

Hrm. Looks like somebody has already helpfully implemented
make_absolute_path, so it would just require calling that on each
argument. Something like this on top of Robin's patch:

diff --git a/setup.c b/setup.c
index 4ee8024..e76c83c 100644
--- a/setup.c
+++ b/setup.c
@@ -58,7 +58,8 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
 	if (is_absolute_path(path))
-		path = strip_work_tree_path(prefix, len, path);
+		path = strip_work_tree_path(prefix, len,
+				xstrdup(make_absolute_path(path)));
 
 	for (;;) {
 		char c;

-Peff
