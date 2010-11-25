From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 9/9] http-fetch: rework url handling
Date: Thu, 25 Nov 2010 16:21:10 +0800
Message-ID: <1290673270-4284-10-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-2-git-send-email-rctay89@gmail.com>
 <1290673270-4284-3-git-send-email-rctay89@gmail.com>
 <1290673270-4284-4-git-send-email-rctay89@gmail.com>
 <1290673270-4284-5-git-send-email-rctay89@gmail.com>
 <1290673270-4284-6-git-send-email-rctay89@gmail.com>
 <1290673270-4284-7-git-send-email-rctay89@gmail.com>
 <1290673270-4284-8-git-send-email-rctay89@gmail.com>
 <1290673270-4284-9-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:24:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLX7X-0000Ue-MF
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776Ab0KYIXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:23:55 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58311 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0KYIXy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:23:54 -0500
Received: by ywl5 with SMTP id 5so333857ywl.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=f9r8RA2uHbtfM/r5fVpFHZh3DD0C4IRD2shBcwzZ8Nk=;
        b=IyKNrpWfRtpT21NhC2xe7azzGiqiJGrCti5rydagcjsV2kXgLZZzMIeaLgbQoQIBeN
         BAjF5zpsnfVhVkwYYymcsjwK5ge83H5FXazKNg/L5wRf/aEGaPIz4alSw74K0Ar22cJv
         0/us998xldw+0V/zbDPQD8/bupJrom520wV7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pX0Wo2d1NK84WRmbTL5p6LkPUUj7XVvIQ1p1zzvdEb2XV69npafJq7xNNBz8QtkDHl
         2Cetu+XgpXveczpQiNaNJud8n5d5xMrZnFKmEreSaTY/B86HP1vFbByihLBt/2srh5op
         s/2B5NkDBH8/lEjrtx/g+9y20GgIl8ZL3ZGfA=
Received: by 10.42.218.7 with SMTP id ho7mr169051icb.169.1290673433510;
        Thu, 25 Nov 2010 00:23:53 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.23.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:23:52 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-9-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162114>

Do away with a second url variable, rewritten_url, and make url
non-const. This is safe because the functions called with url (ie.
get_http_walker() and walker_fetch()) do not modify it (ie. marked with
const char *).

Also, replace code that adds a trailing slash with a call to
str_end_url_with_slash().

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

New in v3.

 http-fetch.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 762c750..923904f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -14,8 +14,7 @@ int main(int argc, const char **argv)
 	int commits;
 	const char **write_ref = NULL;
 	char **commit_id;
-	const char *url;
-	char *rewritten_url = NULL;
+	char *url = NULL;
 	int arg = 1;
 	int rc = 0;
 	int get_tree = 0;
@@ -57,19 +56,14 @@ int main(int argc, const char **argv)
 		commit_id = (char **) &argv[arg++];
 		commits = 1;
 	}
-	url = argv[arg];
+
+	if (argv[arg])
+		str_end_url_with_slash(argv[arg], &url);
 
 	prefix = setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
-	if (url && url[strlen(url)-1] != '/') {
-		rewritten_url = xmalloc(strlen(url)+2);
-		strcpy(rewritten_url, url);
-		strcat(rewritten_url, "/");
-		url = rewritten_url;
-	}
-
 	http_init(NULL);
 	walker = get_http_walker(url);
 	walker->get_tree = get_tree;
@@ -93,7 +87,7 @@ int main(int argc, const char **argv)
 	walker_free(walker);
 	http_cleanup();
 
-	free(rewritten_url);
+	free(url);
 
 	return rc;
 }
-- 
1.7.3.2.495.gc7b3f
