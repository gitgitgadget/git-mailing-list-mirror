From: "Ray Chuan" <rctay89@gmail.com>
Subject: [PATCH 1/2] http-push: send opaquelocktoken in If: for PUT requests
Date: Sat, 17 Jan 2009 20:10:28 +0000
Message-ID: <be6fef0d0901171210o97a24carf902e82848d48b5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 21:11:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOHWM-0006hM-8R
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 21:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbZAQUKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 15:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbZAQUKa
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 15:10:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:50437 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbZAQUK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 15:10:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1158448wah.21
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 12:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=7w0e/yVvDvnUmtYOFMpcn6g9McY0VqPtfc4kLRTv2sE=;
        b=Qz81wt+EVrnVlNnTzvaSIFqwxHBDvc/qE7nklYho73a9pkA0WbVYMGzVNlqnibw2aF
         7sB7/toeuo06VjVIeDh0zqXBd7dnnE1r+MS08I5eTqnRsAtiCk2G6B4bmVFl1gbQpktF
         NGLVu4S7rficsqFhoG79FwxJq+5Nm8gMucaVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=njrZAS8wgN3OG77ReeBIwj8c0SjXtjFRIwkT0v+YxK8IxxViSG8sIPCij/lsXLHnZi
         nsUSpqAjxLpz3UyYMkXZJbt/JdS2S60JvrPGkQIdW3ng6mz77hV0ZMbtpbGtk1l8sgbh
         QS8+OywdtPBjy7iJUhREjlf6mDjKWMCVusKh4=
Received: by 10.114.74.1 with SMTP id w1mr2798414waa.155.1232223028516;
        Sat, 17 Jan 2009 12:10:28 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 12:10:28 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106101>

Currently, git PUTs to

  /repo.git/objects/1a/1a2b...9z_opaquelocktoken:1234-....

On some platforms, ':' isn't allowed in filenames so the PUT fails.
This seems to be an (faulty) implementation of the opaquelocktoken URI
scheme (http://www.webdav.org/specs/rfc4918.html#RFC2518).

PUT now sends the object to the url

  /repo.git/objects/1a/1a2b...9z

, without the trailing '_opaquelocktoken:1234-....', with an
additional "If: (<opaquelocktoken:1234-....>)" header.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index c9ba07e..4517cf2 100644
--- a/http-push.c
+++ b/http-push.c
@@ -480,7 +480,9 @@ static void start_put(struct transfer_request *request)
 {
 	char *hex = sha1_to_hex(request->obj->sha1);
 	struct active_request_slot *slot;
+	struct curl_slist *dav_headers = NULL;
 	char *posn;
+	char *if_header;
 	enum object_type type;
 	char hdr[50];
 	void *unpacked;
@@ -535,6 +537,10 @@ static void start_put(struct transfer_request *request)
 	*(posn++) = '_';
 	strcpy(posn, request->lock->token);

+	if_header = xmalloc(strlen(request->lock->token) + 25);
+	sprintf(if_header, "If: <%s>", request->lock->token);
+	dav_headers = curl_slist_append(dav_headers, if_header);
+
 	slot = get_active_slot();
 	slot->callback_func = process_response;
 	slot->callback_data = request;
@@ -546,6 +552,7 @@ static void start_put(struct transfer_request *request)
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);

 	if (start_active_slot(slot)) {
-- 
1.5.6.3
