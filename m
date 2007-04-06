From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] rename_ref(): only print a warning when config-file update fails
Date: Fri,  6 Apr 2007 10:33:06 +0200
Message-ID: <11758483861506-git-send-email-hjemli@gmail.com>
Cc: Geert Bosch <bosch@gnat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 11:19:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZkYh-0003zO-IT
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 11:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbXDFJQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 05:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbXDFJQg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 05:16:36 -0400
Received: from mail45.e.nsc.no ([193.213.115.45]:54009 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbXDFJQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 05:16:35 -0400
X-Greylist: delayed 2677 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Apr 2007 05:16:35 EDT
Received: from localhost.localdomain (ti231210a080-10075.bb.online.no [80.212.183.97])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id l368Vj25023693;
	Fri, 6 Apr 2007 10:31:45 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.53.g77e6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43906>

If git_config_rename_section() fails, rename_ref() used to return 1, which
left HEAD pointing to an absent refs/heads file (since the actual renaming
had already occurred).

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On 4/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Thu, 5 Apr 2007, Geert Bosch wrote:
> 
> > Make git_config_rename_section return success if no config file
> > exists.
> 
> I don't think this is correct. git_config_rename_section() _should_ return
> an error.
> 
> > Otherwise, renaming a branch would abort, leaving the repository in an
> > inconsistent state.
> 
> This should take the hint from --rename-section, and print a warning (or
> not).

I think both arguments makes sense. There really is no reason to abort the
rename operation if the config file update fails (for any reason).


 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index f471152..2ac6384 100644
--- a/refs.c
+++ b/refs.c
@@ -835,7 +835,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		snprintf(oldsection, 1024, "branch.%s", oldref + 11);
 		snprintf(newsection, 1024, "branch.%s", newref + 11);
 		if (git_config_rename_section(oldsection, newsection) < 0)
-			return 1;
+			error("unable to update config-file");
 	}
 
 	return 0;
-- 
1.5.1.53.g77e6f
