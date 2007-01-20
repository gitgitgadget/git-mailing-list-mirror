From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not verify filenames in a bare repository
Date: Sat, 20 Jan 2007 01:52:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200149010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eoqc09$454$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:52:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84T0-0002m0-Lm
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbXATAwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbXATAwS
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:52:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:37883 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965048AbXATAwR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:52:17 -0500
Received: (qmail invoked by alias); 20 Jan 2007 00:52:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 20 Jan 2007 01:52:16 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
In-Reply-To: <eoqc09$454$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37233>


For example, it makes no sense to check the presence of a file
named "HEAD" when calling "git log HEAD" in a bare repository.

Noticed by Han-Wen Nienhuys.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Fri, 19 Jan 2007, Han-Wen Nienhuys wrote:

	> of course, when --bare is used, then HEAD is not ambiguous.
	> 
	> 
	> [lilydev@haring .git]$ git --bare log HEAD
	> fatal: ambiguous argument 'HEAD': both revision and filename
	> Use '--' to separate filenames from revisions

	Note that it would still fail in your case, since saying "--bare" 
	does not get picked up if the current directory is named ".git".

	I was close to sending a patch which sets the environment variable
	"GIT_IS_BARE" when calling git with "--bare", and checking that, 
	but decided against it: it is more likely you are about to shoot 
	yourself in the foot, because real bare repositories are not named 
	".git".

 setup.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index cc97f9f..7181560 100644
--- a/setup.c
+++ b/setup.c
@@ -95,6 +95,9 @@ void verify_non_filename(const char *prefix, const char *arg)
 	const char *name;
 	struct stat st;
 
+	if (is_bare_repository())
+		return;
+
 	if (*arg == '-')
 		return; /* flag */
 	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
-- 
1.5.0.rc1.g38843-dirty
