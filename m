From: "Ray Chuan" <rctay89@gmail.com>
Subject: [PATCH] http-push: update memory allocation for http headers
Date: Sun, 18 Jan 2009 21:16:04 +0800
Message-ID: <be6fef0d0901180516q19327c18oa1d7ccc36ce3a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 14:17:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOXWt-0002s5-By
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 14:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708AbZARNQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 08:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756028AbZARNQI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 08:16:08 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:10148 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756671AbZARNQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 08:16:07 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2238487rvb.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 05:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=APMQfL7uQUZYdwuQ5mZn5fHM1VCjsrOgFLF8q/7Hr6c=;
        b=GWGWl4gvPDMYFhyynUWkem2U7fLkiZ7WKo+ANQIh/0ehIlcCSdHdXCimH9HDSAKhC9
         ONLypK1dmSQnDYkwiBVG6J7+GgpPQDD00vO43M7FEp0kbeXGx48G9pU00m+tftyGZPlW
         T96xH+vrEsVfijriWaVM1pMD8CuOZuBtiqUSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=i+Jaae+eoeNeTPkV1/Lr/J27ydkFWreWzp/JHOWMhT6cYVozXuYOgs9mHP+u1jA6FN
         hLApnZQHrMkvsggF1N42VWujmO6oES6PyaQ/NdPgji1J791EwLyTdjFtrE/FlWrhDtvO
         Ww8rDua0O9xGM2Rg0/5u838Sfpm4wO5OknA0o=
Received: by 10.114.56.4 with SMTP id e4mr3290112waa.48.1232284564718;
        Sun, 18 Jan 2009 05:16:04 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sun, 18 Jan 2009 05:16:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106184>

In 753bc91 (Remove the requirement opaquelocktoken uri scheme), the
header strings were with the removal "opaquelocktoken:" (16
characters).

Unfortunately, this was without the corresponding change in memory
allocation. In this patch we update these allocations.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index a4b7d08..a6522dd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -595,7 +595,7 @@ static int refresh_lock(struct remote_lock *lock)

 	lock->refreshing = 1;

-	if_header = xmalloc(strlen(lock->token) + 25);
+	if_header = xmalloc(strlen(lock->token) + 9);
 	sprintf(if_header, "If: (<%s>)", lock->token);
 	sprintf(timeout_header, "Timeout: Second-%ld", lock->timeout);
 	dav_headers = curl_slist_append(dav_headers, if_header);
@@ -1306,7 +1306,7 @@ static int unlock_remote(struct remote_lock *lock)
 	struct curl_slist *dav_headers = NULL;
 	int rc = 0;

-	lock_token_header = xmalloc(strlen(lock->token) + 31);
+	lock_token_header = xmalloc(strlen(lock->token) + 15);
 	sprintf(lock_token_header, "Lock-Token: <%s>",
 		lock->token);
 	dav_headers = curl_slist_append(dav_headers, lock_token_header);
@@ -1730,7 +1730,7 @@ static int update_remote(unsigned char *sha1,
struct remote_lock *lock)
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
 	struct curl_slist *dav_headers = NULL;

-	if_header = xmalloc(strlen(lock->token) + 25);
+	if_header = xmalloc(strlen(lock->token) + 9);
 	sprintf(if_header, "If: (<%s>)", lock->token);
 	dav_headers = curl_slist_append(dav_headers, if_header);

@@ -1949,7 +1949,7 @@ static void update_remote_info_refs(struct
remote_lock *lock)
 	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
 		  add_remote_info_ref, &buffer.buf);
 	if (!aborted) {
-		if_header = xmalloc(strlen(lock->token) + 25);
+		if_header = xmalloc(strlen(lock->token) + 9);
 		sprintf(if_header, "If: (<%s>)", lock->token);
 		dav_headers = curl_slist_append(dav_headers, if_header);

-- 
1.6.0.4
