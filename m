From: Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH] ls-remote: add --get-push-url option
Date: Fri, 31 Jul 2015 13:38:41 -0400
Message-ID: <1438364321-14646-2-git-send-email-mathstuf@gmail.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Cc: Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 31 19:39:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLEH7-0000dp-7G
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 19:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbbGaRjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 13:39:11 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33645 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbGaRjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 13:39:09 -0400
Received: by igbpg9 with SMTP id pg9so36696953igb.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7kJhPbSiEola8AqMO/bpmsSDHGkp/AKhADhdXbnSmbw=;
        b=oFpuzqZRYA+B1edEvvvwUMS1Um4d9e8M9RfeljHz0ItEZ8muUbV+I2zQ6Nfo6luE9c
         j8mhI7w8RUHb3B5nSIYA13LPtgasHDTjK5C1GRKzuCE6+E0FmHXLsMCdFLWVAan2i386
         TlR6nNMUReVbxptmiHq/VCOAYMFRnqeL4NVT9VAXDauVB3gj2bBTjacdFtzJwhS0fHGx
         CrAhZSdaGwINQZzPpR2EZYRcAtR6NQTn13l60Zqq1ayDvKSxgJ68thMKD63sJrHMzaSf
         y/C9717CSIsKL/ydTWKp6S2miBzRo+PEjxtHOfxl6CUo7hdta3UWuQRxra9gx4PVy706
         rYow==
X-Received: by 10.50.45.34 with SMTP id j2mr7929338igm.53.1438364348875;
        Fri, 31 Jul 2015 10:39:08 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id i123sm3734183ioi.13.2015.07.31.10.39.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 10:39:07 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275058>

With pushInsteadOf and triangle workflows, a flag to have git fully
expand the push URL is also useful since it can be very different from
the --get-url output.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/git-ls-remote.txt |  7 ++++++-
 builtin/ls-remote.c             | 15 +++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 2e22915..66cda0e 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]
-	      [--exit-code] <repository> [<refs>...]
+	      [--exit-code] [--get-url | --get-push-url] <repository> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -47,6 +47,11 @@ OPTIONS
 	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]) and
 	exit without talking to the remote.
 
+--get-push-url::
+	Expand the URL of the given remote repository taking into account any
+	"url.<base>.pushInsteadOf" config setting (See linkgit:git-config[1])
+	and exit without talking to the remote.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 4554dbc..25c6f79 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,7 @@
 
 static const char ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
-"                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]";
+"                     [-q | --quiet] [--exit-code] [--get-url | --get-push-url] [<repository> [<refs>...]]";
 
 /*
  * Is there one among the list of patterns that match the tail part
@@ -40,6 +40,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	const char **pattern = NULL;
 
 	struct remote *remote;
+	struct remote *pushremote;
 	struct transport *transport;
 	const struct ref *ref;
 
@@ -78,6 +79,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 				get_url = 1;
 				continue;
 			}
+			if (!strcmp("--get-push-url", arg)) {
+				get_url = 2;
+				continue;
+			}
 			if (!strcmp("--exit-code", arg)) {
 				/* return this code if no refs are reported */
 				status = 2;
@@ -109,9 +114,15 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (!remote->url_nr)
 		die("remote %s has no configured URL", dest);
 
-	if (get_url) {
+	if (get_url == 1) {
 		printf("%s\n", *remote->url);
 		return 0;
+	} else if (get_url == 2) {
+		pushremote = pushremote_get(dest);
+		if (!pushremote->url_nr)
+			die("remote %s has no configured push URL", dest);
+		printf("%s\n", *pushremote->url);
+		return 0;
 	}
 
 	transport = transport_get(remote, NULL);
-- 
2.1.0
