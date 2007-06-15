From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: [RFC][PATCH] Fix assumption that git is installed in a standard place on the remote end ssh
Date: Fri, 15 Jun 2007 11:03:51 -0400
Message-ID: <20070615150351.GH14677@menevado.ms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 17:03:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzDL8-0002Nl-NA
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 17:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbXFOPDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 11:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbXFOPDx
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 11:03:53 -0400
Received: from hqmtabh1.ms.com ([205.228.12.101]:47193 "EHLO hqmtabh1.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbXFOPDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 11:03:52 -0400
Received: from hqmtabh1 (localhost.ms.com [127.0.0.1])
	by hqmtabh1.ms.com (output Postfix) with ESMTP id B164548184
	for <git@vger.kernel.org>; Fri, 15 Jun 2007 11:03:51 -0400 (EDT)
Received: from ny37im01.ms.com (unknown [144.14.31.40])
	by hqvsbh2.ms.com (internal Postfix) with ESMTP id 9519FF76
	for <git@vger.kernel.org>; Fri, 15 Jun 2007 11:03:51 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny37im01.ms.com (Sendmail MTA Hub) with ESMTP id l5FF3p912211;
	Fri, 15 Jun 2007 11:03:51 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l5FF3pDg019897; Fri, 15 Jun 2007 11:03:51 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 15062007 #325705, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50265>


Hi,

I've run into a problem pushing/pulling where we don't (READ: can't) have git installed in the
standard location.  This leads to a failure on trying to find the git binaries
on the remote end.  I've looked through the archives and didn't come across
any similar discussions.  Please point me there if I've missed something...

I wanted to introduce a commandline arg, similar to what rsync does, call it
--git-path=PATH, where a user can specify the location of git on the remote
end. 

After tracking through what really is happening with a git pull, I realized
that a change like that is pretty intrusive and is not just a simple addition
to the ssh handling code, i.e. we'll need to push that arg through all the sh
scripts, etc...

I settled on allowing an env var to be exported, GIT_REMOTE_PATH which a user
can set to the path of git on the remote end.

I want to open up the discussion on whether this is the best way forward or if
there's another way I've missed.


Here's the patch that introduces this new feature:

--- cut here ---
Author: Kevin Green <Kevin.Green@morganstanley.com>
Date: Fri, 15 Jun 2007 10:51:21 -0400

Fix assumption that git is installed in a standard place on the remote end ssh

Introduce env var GIT_REMOTE_PATH which a user can set to the known remote path of
git during a push or pull through PROTO_SSH.

Signed-off-by: Kevin Green <Kevin.Green@morganstanley.com>
---
 connect.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 7fab9c0..ee15a8a 100644
--- a/connect.c
+++ b/connect.c
@@ -560,7 +560,13 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
                char *posn = command;
                int size = MAX_CMD_LEN;
                int of = 0;
+               const char *git_remote_path;

+               git_remote_path = getenv("GIT_REMOTE_PATH");
+               if (git_remote_path) {
+                       of |= add_to_string(&posn, &size, git_remote_path, 0);
+                       of |= add_to_string(&posn, &size, "/", 0);
+               }
                of |= add_to_string(&posn, &size, prog, 0);
                of |= add_to_string(&posn, &size, " ", 0);
                of |= add_to_string(&posn, &size, path, 1);
--
1.5.2.1
