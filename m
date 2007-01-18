From: Matthias Lederhofer <matled@gmx.net>
Subject: [RFC] prune: --expire=seconds
Date: Thu, 18 Jan 2007 23:29:19 +0100
Message-ID: <20070118222919.GA22060@moooo.ath.cx>
References: <20070118171830.GA13521@moooo.ath.cx> <20070118172408.GG15428@spearce.org> <20070118174244.GA14287@moooo.ath.cx> <20070118175134.GH15428@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 18 23:29:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7fl7-000243-IW
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 23:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbXARW3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 17:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbXARW3Y
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 17:29:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:50155 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932662AbXARW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 17:29:23 -0500
Received: (qmail invoked by alias); 18 Jan 2007 22:29:22 -0000
Received: from pD9EBA48D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.164.141]
  by mail.gmx.net (mp044) with SMTP; 18 Jan 2007 23:29:22 +0100
X-Authenticated: #5358227
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20070118175134.GH15428@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37143>

This option specifies the minimum age of an object before it
may be removed by prune.  The default value is 2 hours and
may be changed using gc.pruneexpire.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Shawn O. Pearce <spearce@spearce.org> wrote:
> If you are going to implement this I would suggest making the default
> age 2 hours and allow the user to configure it from a gc.pruneexpire
> configuration option, much like gc.reflogexpire.

Here it is, I've set the default value to 2 hours as you suggested.
Any other comments if the default should be a value >0 or 0 to keep
the old behaviour?
---
 builtin-prune.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 6f0ba0d..f46892d 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -5,8 +5,10 @@
 #include "builtin.h"
 #include "reachable.h"
 
-static const char prune_usage[] = "git-prune [-n]";
+static const char prune_usage[] = "git-prune [-n] [--expire=seconds]";
 static int show_only;
+static int prune_expire;
+static time_t now;
 
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
@@ -38,6 +40,7 @@ static int prune_dir(int i, char *path)
 		char name[100];
 		unsigned char sha1[20];
 		int len = strlen(de->d_name);
+		struct stat st;
 
 		switch (len) {
 		case 2:
@@ -60,6 +63,11 @@ static int prune_dir(int i, char *path)
 			if (lookup_object(sha1))
 				continue;
 
+			if (prune_expire > 0 &&
+			    !stat(mkpath("%s/%s", path, de->d_name), &st) &&
+			    now-st.st_mtime < prune_expire)
+				continue;
+
 			prune_object(path, de->d_name, sha1);
 			continue;
 		}
@@ -79,10 +87,21 @@ static void prune_object_dir(const char *path)
 	}
 }
 
+static void git_prune_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "gc.pruneexpire")) {
+		prune_expire = git_config_int(var, value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct rev_info revs;
+	prune_expire = 2*60*60;
+	now = time(NULL);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -90,6 +109,10 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			show_only = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--expire=", 9)) {
+			prune_expire = atoi(arg+9);
+			continue;
+		}
 		usage(prune_usage);
 	}
 
-- 
1.4.4.4
