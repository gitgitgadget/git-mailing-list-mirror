From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Alternative approach to the git config NULL value checking
 patches..
Date: Sun, 10 Feb 2008 15:41:23 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802101538030.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org> <7vir0wfqrz.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org> <7vbq6oe98y.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802101532070.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLp7-0003ZK-Ir
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYBJXm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 18:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbYBJXm2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 18:42:28 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48182 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752074AbYBJXm1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 18:42:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1ANfOOa019140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Feb 2008 15:41:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1ANfNx1019544;
	Sun, 10 Feb 2008 15:41:24 -0800
In-Reply-To: <alpine.LFD.1.00.0802101532070.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73439>



On Sun, 10 Feb 2008, Linus Torvalds wrote:
> 
> Yes, the 10% that actually *cares* will look exactly the same (the 
> difference being comparing against NULL or config_true), but all the stuff 
> that compares against a special string can just ignore the fact that the 
> special truth value will never ever match that string.

And here's an example of this kind of effect. I'm not actually suggesting 
you apply this patch, but tell me it isn't simpler done this way?

So this is where it *does* make a difference whether we use NULL or 
config_bool, and where config_bool is simply better: it allows a config 
routine to simply never care..

		Linus

---
 color.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/color.c b/color.c
index cb70340..e5fbf01 100644
--- a/color.c
+++ b/color.c
@@ -118,15 +118,12 @@ bad:
 
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 {
-	if (value) {
-		if (!strcasecmp(value, "never"))
-			return 0;
-		if (!strcasecmp(value, "always"))
-			return 1;
-		if (!strcasecmp(value, "auto"))
-			goto auto_color;
-	}
-
+	if (!strcasecmp(value, "never"))
+		return 0;
+	if (!strcasecmp(value, "always"))
+		return 1;
+	if (!strcasecmp(value, "auto"))
+		goto auto_color;
 	/* Missing or explicit false to turn off colorization */
 	if (!git_config_bool(var, value))
 		return 0;
