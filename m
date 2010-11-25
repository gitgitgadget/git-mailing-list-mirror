From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 8/9] http-push: add trailing slash at arg-parse time, instead of later on
Date: Thu, 25 Nov 2010 16:21:09 +0800
Message-ID: <1290673270-4284-9-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-2-git-send-email-rctay89@gmail.com>
 <1290673270-4284-3-git-send-email-rctay89@gmail.com>
 <1290673270-4284-4-git-send-email-rctay89@gmail.com>
 <1290673270-4284-5-git-send-email-rctay89@gmail.com>
 <1290673270-4284-6-git-send-email-rctay89@gmail.com>
 <1290673270-4284-7-git-send-email-rctay89@gmail.com>
 <1290673270-4284-8-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLX7M-0000Pl-Pm
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab0KYIXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:23:43 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0KYIXm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:23:42 -0500
Received: by mail-iw0-f174.google.com with SMTP id 5so389iwn.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BzneM0f/R3Mt5Qc3HVc5HR9Q9Gjryedce3jOXe3l5X4=;
        b=tabySkDD8hXcXY9kSfOTGGxI5flAAjncoeqIVq5bK64Ld3CObDtnkpAyO84nuUTl2o
         lLICM1ZwqkzUVZp6G0Kt/cL03mEfj1Hjk1CnbE3Q/IbKAyokn/AwoD2cmK9n0D7N1btn
         jei3FaTk7EW1yN2FFyPtx92ygW3y0Gbh6vCns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wghRcMtGbwcOqYg/8+Q4dLIGF24mdQZTUFx5zMZOs3OkNj2XfFjAYNTIOnFBu5UHd6
         Rqzbau4HkIPr4H39VJb/tCkJqlsVMlgpOqlmVL949D8mLEl0Yj5jGPRCOQ4dHjZXku67
         t6JOHZysccOiEU2BQlKodkK8dme+J1mJh2GGc=
Received: by 10.231.31.1 with SMTP id w1mr356078ibc.7.1290673422458;
        Thu, 25 Nov 2010 00:23:42 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.23.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:23:41 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-8-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162113>

That way, we don't have to update repo->path and repo->path_len again
after adding the trailing slash.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/http-push.c b/http-push.c
index bfa1fe7..ff41a0e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1801,7 +1801,6 @@ int main(int argc, char **argv)
 	int new_refs;
 	struct ref *ref, *local_refs;
 	struct remote *remote;
-	char *rewritten_url = NULL;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -1847,8 +1846,8 @@ int main(int argc, char **argv)
 		}
 		if (!repo->url) {
 			char *path = strstr(arg, "//");
-			repo->url = arg;
-			repo->path_len = strlen(arg);
+			str_end_url_with_slash(arg, &repo->url);
+			repo->path_len = strlen(repo->url);
 			if (path) {
 				repo->path = strchr(path+2, '/');
 				if (repo->path)
@@ -1884,15 +1883,6 @@ int main(int argc, char **argv)
 	remote->url[remote->url_nr++] = repo->url;
 	http_init(remote);
 
-	if (repo->url && repo->url[strlen(repo->url)-1] != '/') {
-		rewritten_url = xmalloc(strlen(repo->url)+2);
-		strcpy(rewritten_url, repo->url);
-		strcat(rewritten_url, "/");
-		repo->path = rewritten_url + (repo->path - repo->url);
-		repo->path_len++;
-		repo->url = rewritten_url;
-	}
-
 #ifdef USE_CURL_MULTI
 	is_running_queue = 0;
 #endif
@@ -2100,7 +2090,6 @@ int main(int argc, char **argv)
 	}
 
  cleanup:
-	free(rewritten_url);
 	if (info_ref_lock)
 		unlock_remote(info_ref_lock);
 	free(repo);
-- 
1.7.3.2.495.gc7b3f
