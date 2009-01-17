From: "Ray Chuan" <rctay89@gmail.com>
Subject: [PATCH 1/3] http-push: append slash if possible for directories
Date: Sat, 17 Jan 2009 02:53:14 +0000
Message-ID: <be6fef0d0901161853y6784310dgf94dadb2218001a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 03:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1Ka-0006lA-8Q
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 03:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759693AbZAQCxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 21:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759362AbZAQCxR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 21:53:17 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:32642 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758932AbZAQCxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 21:53:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1036340wah.21
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 18:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=3sy4nIQvbEz42v4sxR9d8vl0E0L8As+DIUj2y0MI44I=;
        b=Uz8rUByQZ6KhyGPyeTAoCS3HojkwFZfcQD18HkKFGT/0rnFtS7bbyie/yeA89ASOPD
         PpJlNUnQZaqKvL1Pa0jUp17owhpgJkC2kEA7JVEs2nv5GLFXgZu7kXnDlqD/Dt5XZkEq
         82iSU9w1dCCrN2KSmurrMZ8ZIf83ZOKqEFaQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=KUaw6Ja1C8UAh9NcaIc+spcNRpjG3kwvlvsKmryeJXQI/+3HRkTlyr66lpFqdN1tWq
         Gct4kVfv6UN441wC4bU49P3Edzp8DNrYCZhic4WImYQgwGpJqilcf9WPTyGzqRm9NIPX
         IikFuHbtflIeDCD2ooGbbpGQpRucHOQou9vN4=
Received: by 10.114.157.1 with SMTP id f1mr2226669wae.221.1232160794249;
        Fri, 16 Jan 2009 18:53:14 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Fri, 16 Jan 2009 18:53:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106012>

the lock_remote currently sends MKCOL requests to leading directories
to make sure they exist; however, it doesn't put a forward slash '/'
behind the path, so if the path is a directory, the server sends a 301
redirect.

by appending a '/' we can save the server this additional step.

in addition, it seems that curl doesn't re-send the authentication
credentials when it follows a 301 redirect, so skipping (unnecessary)
redirects can also be seen as a workaround for this issue. (i'm using
7.16.3)

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 src/git-1.6.1/http-push.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/src/git-1.6.1/http-push.c b/src/git-1.6.1/http-push.c
index 7c64609..25b655d 100644
--- a/src/git-1.6.1/http-push.c
+++ b/src/git-1.6.1/http-push.c
@@ -1189,6 +1189,7 @@ static struct remote_lock *lock_remote(const
char *path, long timeout)
 	struct strbuf in_buffer = STRBUF_INIT;
 	char *url;
 	char *ep;
+	char ep_old;
 	char timeout_header[25];
 	struct remote_lock *lock = NULL;
 	struct curl_slist *dav_headers = NULL;
@@ -1198,9 +1199,18 @@ static struct remote_lock *lock_remote(const
char *path, long timeout)
 	sprintf(url, "%s%s", remote->url, path);

 	/* Make sure leading directories exist for the remote ref */
-	ep = strchr(url + strlen(remote->url) + 1, '/');
-	while (ep) {
-		*ep = 0;
+	ep = url + strlen(remote->url) + 1;
+	int has_fs = 0;
+	while (1) {
+		ep = strchr(ep + 1, '/');
+		if(ep) {
+			ep++;
+			ep_old=*ep;
+			*ep = 0;
+			has_fs = 1;
+		} else {
+			break;
+		}
 		slot = get_active_slot();
 		slot->results = &results;
 		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
@@ -1222,8 +1232,9 @@ static struct remote_lock *lock_remote(const
char *path, long timeout)
 			free(url);
 			return NULL;
 		}
-		*ep = '/';
-		ep = strchr(ep + 1, '/');
+		if(has_fs) {
+			*ep = ep_old;
+		}
 	}

 	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, git_default_email);
-- 
1.6.0.4
