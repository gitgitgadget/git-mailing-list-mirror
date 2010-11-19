From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 6/6] http-push: add trailing slash at arg-parse time, instead of later on
Date: Fri, 19 Nov 2010 20:46:30 +0800
Message-ID: <1290170790-2200-7-git-send-email-rctay89@gmail.com>
References: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
 <1290170790-2200-2-git-send-email-rctay89@gmail.com>
 <1290170790-2200-3-git-send-email-rctay89@gmail.com>
 <1290170790-2200-4-git-send-email-rctay89@gmail.com>
 <1290170790-2200-5-git-send-email-rctay89@gmail.com>
 <1290170790-2200-6-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:47:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJQN5-0001C8-WF
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab0KSMrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:47:12 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:54600 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0KSMrK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:47:10 -0500
Received: by mail-px0-f174.google.com with SMTP id 15so1003656pxi.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=16JyMVtuyyJd495rEONJpwuUmDoU7Tf7YUjTC1lmyZ4=;
        b=gNAnO2gT2ZfkYk4gaeu8dMDlAynlXIegP4nAdUicBIaCj46NiyMbEUSOPN/i6LpalA
         p3P8qQNcYDfPHWaOe+1bYwFxRvJylIijtaKUHIrOgXPYFTdOc/2ohiPaarBGoKHC3L2D
         LV1lv7RUar2YgGfqiSpkFlhNxVkc5M2E4KglM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a36lM690903D/9m4fls8AfyA8sgcbb+TS0INbbjuVwANI5VpnMsdoFBxZGVdWxQ+hz
         aQZS5hP0cnwkrDEhsrm/JiO4QVPtRKRdPS5HIZ2GEcxAjOtz89Dqc4KKFaJksiDkRLlh
         u/w0ROy6YHs0BICr0qwmg8sb20H2860kRw70E=
Received: by 10.142.43.12 with SMTP id q12mr1672744wfq.238.1290170830287;
        Fri, 19 Nov 2010 04:47:10 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id q13sm1852420wfc.5.2010.11.19.04.47.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 04:47:09 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290170790-2200-6-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161751>

That way, we don't have to update repo->path and repo->path_len again
after adding the trailing slash.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/http-push.c b/http-push.c
index 1c34b00..a10891e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1799,7 +1799,6 @@ int main(int argc, char **argv)
 	int new_refs;
 	struct ref *ref, *local_refs;
 	struct remote *remote;
-	char *rewritten_url = NULL;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -1845,8 +1844,8 @@ int main(int argc, char **argv)
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
@@ -1882,15 +1881,6 @@ int main(int argc, char **argv)
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
@@ -2098,7 +2088,6 @@ int main(int argc, char **argv)
 	}
 
  cleanup:
-	free(rewritten_url);
 	if (info_ref_lock)
 		unlock_remote(info_ref_lock);
 	free(repo);
-- 
1.7.3.67.g2a10b
