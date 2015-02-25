From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/2] sha1_file: Add sha1_object_type_literally and export it.
Date: Wed, 25 Feb 2015 16:37:40 +0530
Message-ID: <1424862460-13514-1-git-send-email-karthik.188@gmail.com>
References: <54EDACC9.5080204@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 12:07:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQZos-0001Us-0q
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 12:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbbBYLHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 06:07:54 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43543 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbBYLHx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 06:07:53 -0500
Received: by pdev10 with SMTP id v10so4143677pde.10
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 03:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lAtF47HYWs9N4GWbzDMf5sU48oIWWQ0zfXDal9GZ7Yw=;
        b=B7xd/mNOwTrlz/deB+fgcUXPvCnxadl/bBbuH8qBHxqQdX8GXx0tdXdDFUWdzhPWOq
         3jh+/EEuz3FtP4gLj2e/H7cg80/xTocxRLNEW+RxXjySn/T4oTfHXvuiKUV6KjTjrI49
         XXPO4k+SGzi+nm8e+2rJBkCb4HjZl0i4Pmx53MknmblGTeWZeZOhIp2wt0q6D7jPwzVQ
         w7aal7AtXPStJ4uHn9gmufsLMObK0w5QGIBaWOTLjkQQWfkQJ/x0D7l04HtarbPvHJ9A
         Zwe2W6XbPRdETOGbpy0T6dyZ/L6xp4tyobrrmEwCx0X7aDKi3viAtsCqg2wA6rHyigdi
         21ig==
X-Received: by 10.66.102.4 with SMTP id fk4mr4282131pab.111.1424862473047;
        Wed, 25 Feb 2015 03:07:53 -0800 (PST)
Received: from nayak.localdomain ([182.48.234.2])
        by mx.google.com with ESMTPSA id f12sm42145446pat.43.2015.02.25.03.07.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Feb 2015 03:07:52 -0800 (PST)
X-Mailer: git-send-email 2.3.1.129.g11acff1.dirty
In-Reply-To: <54EDACC9.5080204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264384>

sha1_object_type_literally takes a sha value and
gives the type of the given loose object, used by
git cat-file -t --literally.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 cache.h     |  1 +
 sha1_file.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/cache.h b/cache.h
index 4d02efc..48086b9 100644
--- a/cache.h
+++ b/cache.h
@@ -872,6 +872,7 @@ extern int git_open_noatime(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
+extern int sha1_object_type_literally(const unsigned char *sha1, char *type);
 
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
diff --git a/sha1_file.c b/sha1_file.c
index 69a60ec..34b4810 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2635,6 +2635,33 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 	return type;
 }
 
+int sha1_object_type_literally(const unsigned char *sha1, char *type)
+{
+	int status = 0;
+	unsigned long mapsize;
+	void *map;
+	git_zstream stream;
+	char hdr[32];
+	int i;
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (!map)
+		return -1;
+	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+		status = error("unable to unpack %s header",
+			       sha1_to_hex(sha1));
+
+	for (i = 0; i < 32; i++) {
+		if (hdr[i] == ' ') {
+			type[i] = '\0';
+			break;
+		}
+		type[i] = hdr[i];
+	}
+
+	return status;
+}
+
 static void *read_packed_sha1(const unsigned char *sha1,
 			      enum object_type *type, unsigned long *size)
 {
-- 
2.3.1.129.g11acff1.dirty
