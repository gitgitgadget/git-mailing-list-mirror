From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Use fstat instead of fseek
Date: Mon, 28 Aug 2006 01:55:46 +0200
Message-ID: <20060827235546.GA20904@diku.dk>
References: <20060826141709.GC11601@diku.dk> <Pine.LNX.4.64.0608261509290.11811@g5.osdl.org> <7v4pvz11o6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 01:56:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHUTv-0003oZ-RY
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 01:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWH0Xz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 19:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWH0Xz4
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 19:55:56 -0400
Received: from [130.225.96.91] ([130.225.96.91]:55963 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932266AbWH0Xz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 19:55:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 632BD77000B;
	Mon, 28 Aug 2006 01:55:48 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31879-02; Mon, 28 Aug 2006 01:55:47 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2610D770004;
	Mon, 28 Aug 2006 01:55:47 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 4A2736DF84F; Mon, 28 Aug 2006 01:54:25 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 08CB262A02; Mon, 28 Aug 2006 01:55:46 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pvz11o6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26129>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 dir.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

Junio C Hamano <junkio@cox.net> wrote Sat, Aug 26, 2006:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > I really think you'd be better off rewriting that to use "fstat()" 
> > instead. I don't know why it uses two lseek's, but it's wrong, and looks 
> > like some bad habit Junio picked up at some point.
> 
> I think the code was written to avoid getting confused by
> unseekable input (pipes) but was done in early morning before
> the first shot of caffeine.

I take it that you want this change, so here's a little addition to the
"use X instead of Y" series.

diff --git a/dir.c b/dir.c
index d53d48f..5a40d8f 100644
--- a/dir.c
+++ b/dir.c
@@ -112,17 +112,15 @@ static int add_excludes_from_file_1(cons
 				    int baselen,
 				    struct exclude_list *which)
 {
+	struct stat st;
 	int fd, i;
 	long size;
 	char *buf, *entry;
 
 	fd = open(fname, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0 || fstat(fd, &st) < 0)
 		goto err;
-	size = lseek(fd, 0, SEEK_END);
-	if (size < 0)
-		goto err;
-	lseek(fd, 0, SEEK_SET);
+	size = st.st_size;
 	if (size == 0) {
 		close(fd);
 		return 0;
-- 
1.4.2.g2f76-dirty

-- 
Jonas Fonseca
