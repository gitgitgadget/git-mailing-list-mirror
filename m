From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH v2 2/2] git-add: introduce --edit (to edit the diff vs. the index)
Date: Thu, 5 Jun 2008 20:12:10 +0200
Message-ID: <DDEBE262-2D0A-4F2E-8928-C268A845F645@ai.rug.nl>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720300.21190@racer>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Jxc-0005mV-Su
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbYFESMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYFESMY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:12:24 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:64413 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbYFESMX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:12:23 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6312.orange.nl (SMTP Server) with ESMTP id D321F1C000AD;
	Thu,  5 Jun 2008 20:12:17 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6312.orange.nl (SMTP Server) with ESMTP id 691C71C000BD;
	Thu,  5 Jun 2008 20:12:11 +0200 (CEST)
X-ME-UUID: 20080605181217430.691C71C000BD@mwinf6312.orange.nl
In-Reply-To: <alpine.DEB.1.00.0806051720300.21190@racer>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83948>


On 5 jun 2008, at 18:20, Johannes Schindelin wrote:

>
> With "git add -e [<files>]", Git will fire up an editor with the  
> current
> diff relative to the index (i.e. what you would get with "git diff
> [<files>]").
>
> Now you can edit the patch as much as you like, including adding/ 
> removing
> lines, editing the text, whatever.  Make sure, though, that the first
> character of the hunk lines is still a space, a plus or a minus.

Nice feature! However, the lockfile isn't deleted on my system (OS X),
perhaps because the atexit() isn't called after an exec(). How about  
this
patch?

diff --git a/builtin-add.c b/builtin-add.c
index 05ae40d..07fdd2e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -192,6 +192,8 @@ int edit_patch(int argc, const char **argv, const  
char *prefix)
         struct child_process child;
         int ac;
         struct stat st;
+       const char * apply_args[] = { "apply", "--fixup-line-counts",
+                                     "--cached", lock.filename, NULL };

         memset(&child, 0, sizeof(child));
         child.argv = xcalloc(sizeof(const char *), (argc + 5));
@@ -224,10 +226,11 @@ int edit_patch(int argc, const char **argv,  
const char *prefix)
                 return 0;
         }

-       execl_git_cmd("apply", "--fixup-line-counts", "--cached",
-                       lock.filename, NULL);
+       child.argv = apply_args;
+       if (run_command(&child))
+               return 1;

-       return 1;
+       return 0;
  }

  static struct lock_file lock_file;
