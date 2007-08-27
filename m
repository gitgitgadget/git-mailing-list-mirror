From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFH] Fix initialization of a bare repository
Date: Mon, 27 Aug 2007 11:54:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271154020.28586@racer.site>
References: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0708151821260.19496@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vhcn0pm3h.fsf@gitster.siamese.dyndns.org> <7v7inhmmsx.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 12:52:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPcDA-00059g-EO
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbXH0Kwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbXH0Kwl
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:52:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:54242 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753733AbXH0Kwk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:52:40 -0400
Received: (qmail invoked by alias); 27 Aug 2007 10:52:38 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp055) with SMTP; 27 Aug 2007 12:52:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18b9a9KzRkb5REkgCg3ivTeMlBXEbbMm5sb+G4wJT
	cU+609eT7qwDZQ
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7inhmmsx.fsf_-_@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56810>

Hi,

how about this on top (or squashed):

-- snipsnap --

 builtin-init-db.c |    4 +++-
 t/t0001-init.sh   |   11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ec90b66..af15cb2 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -288,8 +288,10 @@ static void guess_repository_type(const char *git_dir)
 	if (!strcmp(git_dir, cwd))
 		goto force_bare;
 	/*
-	 * "GIT_DIR=something/.git is usually not.
+	 * "GIT_DIR=.git or GIT_DIR=something/.git is usually not.
 	 */
+	if (!strcmp(git_dir, ".git"))
+		return;
 	slash = strrchr(git_dir, '/');
 	if (slash && !strcmp(slash, "/.git"))
 		return;
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 333abb2..b14b3ec 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -79,6 +79,17 @@ test_expect_success 'GIT_DIR bare' '
 	check_config git-dir-bare.git true unset
 '
 
+test_expect_success 'GIT_DIR non-bare' '
+
+	(
+		unset GIT_CONFIG &&
+		mkdir non-bare &&
+		cd non-bare &&
+		GIT_DIR=.git git init
+	) &&
+	check_config non-bare/.git false unset
+'
+
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 
 	(
