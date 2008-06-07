From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an
	unknown command
Date: Sat, 7 Jun 2008 09:27:21 +0200
Message-ID: <20080607072721.GA3347@steel.home>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 09:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4sr4-0001z8-HR
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 09:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbYFGH1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 03:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbYFGH1Y
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 03:27:24 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:33033 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbYFGH1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 03:27:24 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarHHwhMGIA==
Received: from tigra.home (Fadd9.f.strato-dslnet.de [195.4.173.217])
	by post.webmailer.de (mrclete mo37) (RZmta 16.42)
	with ESMTP id 4045e2k574TVBx ; Sat, 7 Jun 2008 09:27:21 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7D922277BD;
	Sat,  7 Jun 2008 09:27:21 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4F25E56D28; Sat,  7 Jun 2008 09:27:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806050747000.21190@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84182>

Johannes Schindelin, Thu, Jun 05, 2008 08:48:40 +0200:
> A typical output would now look like this:
> 
> 	$ git reabse
> 	git: 'reabse' is not a git-command. See 'git --help'.
> 
> 	Did you mean one of these?
> 		rebase
> 		merge-base
> 		rev-parse
> 		remote
> 		rerere
> 

That's really cool :) And I find it useful (and already applied it to
my tree). For me, it works like a simple reminder about what I was
about to do. Helps when working on many things at the same time
(typical typo: mrge. And your patch shows it as the first hit).

BTW, you probably want to restrict the number of lines output.
For instance, "git ma" (am, printed correctly in the first line)
lists around 30 commands, which scrolls clear a 25 line terminal
and is a lot of output anyway. I tried it with at most 5 hints:

diff --git a/help.c b/help.c
index ac29225..765eed8 100644
--- a/help.c
+++ b/help.c
@@ -640,7 +640,7 @@ static int levenshtein_compare(const void *p1, const void *p2)
 
 void help_unknown_cmd(const char *cmd)
 {
-	int i, header_shown = 0;
+	int i, header_shown = 0, listed = 0;
 
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
 
@@ -667,6 +667,8 @@ void help_unknown_cmd(const char *cmd)
 			header_shown = 1;
 		}
 		fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+		if (++listed >= 5)
+			break;
 	}
 
 	exit(1);
