From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] --walk-reflogs: disallow uninteresting commits
Date: Sat, 20 Jan 2007 03:28:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200325380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6tqbjt8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200218290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pqmbhzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 03:28:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H85xw-0000kJ-Nq
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 03:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871AbXATC2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 21:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932876AbXATC2V
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 21:28:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:50951 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932874AbXATC2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 21:28:21 -0500
Received: (qmail invoked by alias); 20 Jan 2007 02:28:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 20 Jan 2007 03:28:19 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pqmbhzg.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37253>


Do not allow uninteresting commits with --walk-reflogs, since it is
not clear what should be shown in these cases:

	$ git log --walk-reflogs master..next
	$ git log --walk-reflogs ^master

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Fri, 19 Jan 2007, Junio C Hamano wrote:
	
	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > How about failing if there are _uninteresting_ commits? So,
	> >
	> > 	git log --walk-reflogs next master
	> >
	> > still works?
	> 
	> That feels like a good way to deal with it.

	Here you are.

	> I think people may also appreciate timestamps on Reflog headers 
	> you add to the output.

	At the moment, if you ask for @{1} (or leave it out), you will see 
	them enumerated by number. If you ask for @{now}, you will see 
	them identified by date...

 reflog-walk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index d4b49c7..2d97411 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -145,6 +145,9 @@ void add_reflog_for_walk(struct reflog_walk_info *info,
 	char *branch, *at = strchr(name, '@');
 	struct commit_reflog *commit_reflog;
 
+	if (commit->object.flags & UNINTERESTING)
+		die ("Cannot walk reflogs for %s", name);
+
 	branch = xstrdup(name);
 	if (at && at[1] == '{') {
 		char *ep;
-- 
1.5.0.rc1.g5a400-dirty
