From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Restore umasks influence on the permissions of work tree
 created by clone
Date: Sat, 7 Jul 2012 23:50:30 +0200
Message-ID: <20120707215029.GA26819@blimp.dmz>
References: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 23:57:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Snczv-0002b4-6z
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 23:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab2GGV46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 17:56:58 -0400
Received: from h877881.serverkompetenz.net ([85.214.60.77]:60470 "EHLO
	h877881.serverkompetenz.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751818Ab2GGV45 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jul 2012 17:56:57 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jul 2012 17:56:57 EDT
Received: from tigra.home (krlh-5f720995.pool.mediaWays.net [95.114.9.149])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h877881.serverkompetenz.net (Postfix) with ESMTPSA id 872058C068D;
	Sat,  7 Jul 2012 23:50:31 +0200 (CEST)
Received: from blimp.localdomain (unknown [192.168.0.155])
	by tigra.home (Postfix) with ESMTP id 84F239FC02;
	Sat,  7 Jul 2012 23:50:30 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 26E143FBAC; Sat,  7 Jul 2012 23:50:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201168>

The original (shell coded) version of the git-clone just used mkdir(1)
to create the working directories. The builtin changed the mode argument
to mkdir(2) to 0755, which was a bit unfortunate, as there are use
cases where umask-controlled creation is preferred and in any case
it is a well-known behaviour for new directory/file creation.
---

On Fri, 6 Jul 2012, Daniel Barkalow wrote:
> On Fri, 6 Jul 2012, Alex Riesen wrote:
>> when git-clone was built in, its treatment of umask has changed: the shell
>> version respected umask for newly created directories by using plain mkdir(1),
>> and the builtin version just uses mkdir(work_tree, 0755).
>>
>> Is it intentional?
> 
> I have the vague feeling that it was intentional, but it's entirely 
> plausible that I just overlooked that mkdir(2) applies umask and went for 
> the mode that you normally want. I don't think there's any particular need 
> for this operation to be more restrictive than umask.

I didn't look hard enough, but still, I found not much of complaining either
way (frankly - none, but as I said, I didn'l look hard): none before - for
being too permissive, the only one in original post after building the thing
in - for being too restrictive.

Maybe we should reconsider and go back to the old permission handling?

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d3b7fdc..e314b0b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -708,7 +708,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (safe_create_leading_directories_const(work_tree) < 0)
 			die_errno(_("could not create leading directories of '%s'"),
 				  work_tree);
-		if (!dest_exists && mkdir(work_tree, 0755))
+		if (!dest_exists && mkdir(work_tree, 0777))
 			die_errno(_("could not create work tree dir '%s'."),
 				  work_tree);
 		set_git_work_tree(work_tree);
-- 
1.7.11.1.185.g5abe2c9
