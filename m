From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/2] git remote: allow adding remotes agreeing with
 url.<...>.insteadOf
Date: Tue, 23 Dec 2014 14:25:05 +0100 (CET)
Message-ID: <cf69aaaae4a93ddf2b592c99887669511aa0bf58.1419340898.git.johannes.schindelin@gmx.de>
References: <20141216021900.50095.24877@random.io> <cover.1419340898.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: anapsix@random.io, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 23 14:25:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3PSf-0002DS-14
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 14:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbaLWNZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 08:25:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:51990 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbaLWNZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 08:25:09 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MAloF-1YAF4s3yt1-00Bq3T;
 Tue, 23 Dec 2014 14:25:05 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1419340898.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:/shRI2gx/GFt1tPK5tM/92QLCHRupHlMqR1e2UXXa1WKk+hjz8l
 5wojZISk9osxVtGtHwXEhP05hClRs2AdUhZPq9sQYdG9p6BJPrC38D9TmLSV/+apFtKeLHm
 1sGPhdpqlrkDRThP6Ezk/gwMJs6QXQBcS0y5WJnK/UBugFz62xAZXmEcR097S1oMLZPHMD1
 A5TbU5BJOlo937VZ+y+lA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261731>

When adding a remote, we make sure that the remote does not exist
already. However, this test was not quite correct: when the
url.<...>.insteadOf config variable was set to the remote name to be
added, the code would assume that the remote exists already.

Let's allow adding remotes when there is a url.<...>.insteadOf setting
when both the name and the URL agree with the remote to be added.

It might seem like a mistake to compare against remote->url[0] without
verifying that remote->url_nr >=1, but at this point a missing URL has
been filled by the name already, therefore url_nr cannot be zero.

Noticed by Anastas Dancha.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 46ecfd9..b4ff468 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -180,7 +180,9 @@ static int add(int argc, const char **argv)
 	url = argv[1];
 
 	remote = remote_get(name);
-	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
+	if (remote && (remote->url_nr > 1 ||
+			(strcmp(name, remote->url[0]) &&
+				strcmp(url, remote->url[0])) ||
 			remote->fetch_refspec_nr))
 		die(_("remote %s already exists."), name);
 
-- 
2.0.0.rc3.9669.g840d1f9
