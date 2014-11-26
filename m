From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/1] cat-file: fix a memory leak in cat_one_file
Date: Wed, 26 Nov 2014 20:17:17 +0600
Message-ID: <CANCZXo7CKz2bOM=6ehed-VLUGtyThuBbwtd_QaBMm2KKhEo=Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 15:17:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtdPG-000685-H9
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 15:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbaKZORS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 09:17:18 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:38367 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbaKZORS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 09:17:18 -0500
Received: by mail-oi0-f44.google.com with SMTP id e131so2052667oig.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 06:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ACtf09dyxXFb+5qJ12I8f2qPQjJ/pItF44/F3Pl2wUI=;
        b=ztvAXk6a5zTys/oekQoIXpzbXunFsEh0zDcNDV2gJhbYtZd99MXLteYKCVVKsdgRd1
         cI0n6qGPj3JDAgKN0jadFrghfoTzzds8bKU0YSY+2TROcgTlBysg0B/whPsJUkCHoC7T
         MhNgH9wYjGgXSvZzWqurmVWeTCjsfS332tIEI/plTPwRTCWIkPPp6dxstDlO/ORDaflh
         0vCJx87ijsoJAfKgkSwh0LW6M446XvvajPZh6xkx8RlcgIi0eRyXH/GmTcN2IxGw4aLT
         DmRb7HCTueWQ64G2VBXsZLR9FfaNmsO26L/0dSCeC8TMBVuTqkoQ/rs2ww6FeK2IPwiC
         SSYA==
X-Received: by 10.202.65.85 with SMTP id o82mr18584900oia.95.1417011437404;
 Wed, 26 Nov 2014 06:17:17 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Wed, 26 Nov 2014 06:17:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260282>

Sometimes we should free output buffer in cat_one_file, but not always.
It must to be freed only if it was allocated during git cat-file -t,
commit,tag and tree types handling.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/cat-file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f8d8129..f5dad60 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -18,6 +18,7 @@ static int cat_one_file(int opt, const char
*exp_type, const char *obj_name)
     unsigned char sha1[20];
     enum object_type type;
     char *buf;
+    int buf_must_free = 0;
     unsigned long size;
     struct object_context obj_context;

@@ -68,9 +69,14 @@ static int cat_one_file(int opt, const char
*exp_type, const char *obj_name)

         if (type == OBJ_BLOB)
             return stream_blob_to_fd(1, sha1, NULL, 0);
+
         buf = read_sha1_file(sha1, &type, &size);
-        if (!buf)
+        buf_must_free = 1;
+
+        if (!buf) {
+            free(buf);
             die("Cannot read object %s", obj_name);
+        }

         /* otherwise just spit out the data */
         break;
@@ -100,6 +106,7 @@ static int cat_one_file(int opt, const char
*exp_type, const char *obj_name)
              */
         }
         buf = read_object_with_reference(sha1, exp_type, &size, NULL);
+        buf_must_free = 1;
         break;

     default:
@@ -110,6 +117,10 @@ static int cat_one_file(int opt, const char
*exp_type, const char *obj_name)
         die("git cat-file %s: bad file", obj_name);

     write_or_die(1, buf, size);
+
+    if (buf_must_free)
+        free(buf);
+
     return 0;
 }

-- 
2.2.0.rc3.224.gb2e243b
