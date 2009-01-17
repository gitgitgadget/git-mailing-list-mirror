From: "Ray Chuan" <rctay89@gmail.com>
Subject: Re: [PATCH 1/3] http-push: append slash if possible for directories
Date: Sat, 17 Jan 2009 16:28:56 +0800
Message-ID: <be6fef0d0901170028t3b418220wa024880235776037@mail.gmail.com>
References: <be6fef0d0901161853y6784310dgf94dadb2218001a1@mail.gmail.com>
	 <alpine.DEB.1.00.0901170654540.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 09:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO6ZS-0003YF-Uq
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 09:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbZAQI26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 03:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbZAQI26
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 03:28:58 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:58018 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbZAQI24 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 03:28:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1074286wah.21
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 00:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JhabgTaz8wdhqwwWrPEhTXOiQ5WyfbQvq+edX7hO0as=;
        b=lfMUCzCZDa3Ot9Dj8tJDnC41odi2X2gkywTeSksKS5W8o8mS+UmDRvh32QLlLCpUMJ
         7Oqd3xXWo9bfGpjcdGwvv49BKV4Oy3Xr9zuD34I3xBimUH+JwUuQS7ELX4MXHn2gmKu7
         Rsccm6uVjZBkIdBZBQSrxXrutwEc4zVdMKe6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Y9fpaD4RMZFCNbWm6pzemmNeGu5sEJvIoviXs6ilALXplrqqc+i4rg4uYTBbHSWfry
         mKOEEC0C+Bmha3Mj9Tbj8V+eq9JS6QbuUz4k8l1tsh8hYMxvVee7kcerTnpuGMMiM2hl
         H/c4VHbROJAHyXgT86MJiTYx7DMFrqmq4fIYg=
Received: by 10.114.197.10 with SMTP id u10mr2402280waf.96.1232180936279;
        Sat, 17 Jan 2009 00:28:56 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 00:28:56 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901170654540.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106034>

let me rewrite the patch:
----------------------------------------------------
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
 http-push.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7c64609..9218c7a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1187,8 +1187,10 @@ static struct remote_lock *lock_remote(const
char *path, long timeout)
 	struct slot_results results;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
 	struct strbuf in_buffer = STRBUF_INIT;
+	int has_forwardslash = 0;
 	char *url;
 	char *ep;
+	char saved_character;
 	char timeout_header[25];
 	struct remote_lock *lock = NULL;
 	struct curl_slist *dav_headers = NULL;
@@ -1198,9 +1200,16 @@ static struct remote_lock *lock_remote(const
char *path, long timeout)
 	sprintf(url, "%s%s", remote->url, path);

 	/* Make sure leading directories exist for the remote ref */
-	ep = strchr(url + strlen(remote->url) + 1, '/');
-	while (ep) {
-		*ep = 0;
+	ep = url + strlen(remote->url) + 1;
+	while (1) {
+		ep = strchr(ep + 1, '/');
+		if(ep) {
+			saved_character=ep[1];
+			ep[1]=0;
+			has_forwardslash = 1;
+		} else {
+			break;
+		}
 		slot = get_active_slot();
 		slot->results = &results;
 		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
@@ -1222,8 +1231,9 @@ static struct remote_lock *lock_remote(const
char *path, long timeout)
 			free(url);
 			return NULL;
 		}
-		*ep = '/';
-		ep = strchr(ep + 1, '/');
+		if(has_forwardslash) {
+			ep[1] = saved_character;
+		}
 	}

 	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, git_default_email);
-- 
1.6.0.4
