From: public_vi@tut.by
Subject: [PATCH] contrib: Add "external blob storage" clean and smudge filters
Date: Wed, 21 Jul 2010 04:07:31 +0300
Message-ID: <1279674451-13143-1-git-send-email-public_vi@tut.by>
Cc: public_vi@tut.by
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 03:11:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObNpr-0004Lt-Oi
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 03:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761880Ab0GUBKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 21:10:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36145 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761701Ab0GUBKy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 21:10:54 -0400
Received: by ewy23 with SMTP id 23so2021193ewy.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 18:10:52 -0700 (PDT)
Received: by 10.213.31.146 with SMTP id y18mr5415002ebc.50.1279674652537;
        Tue, 20 Jul 2010 18:10:52 -0700 (PDT)
Received: from vi-notebook ([93.125.18.114])
        by mx.google.com with ESMTPS id x54sm52442924eeh.23.2010.07.20.18.10.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 18:10:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151384>

From: Vitaly _Vi Shukela <public_vi@tut.by>

Proof-of-concept "external storage" for big blobs using filters.
This is rather high-impact thing, expect a great slowdown or other
inconsistencies

Files are uploaded on a server each time Git attempts to read them
When checking out, files are downloaded from the server, so it should be
mostly transparent for user (except of slowness)
SHA-1 hashes are stored in Git instead of actual file content

Signed-off-by: Vitaly _Vi Shukela <public_vi@tut.by>
---
 contrib/filters/external_blob_storage.config |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 contrib/filters/external_blob_storage.config

diff --git a/contrib/filters/external_blob_storage.config b/contrib/filters/external_blob_storage.config
new file mode 100644
index 0000000..054eb38
--- /dev/null
+++ b/contrib/filters/external_blob_storage.config
@@ -0,0 +1,11 @@
+# Proof-of-concept "external storage" for big blobs using filters.
+# This is rather high-impact thing, expect a great slowdown or other inconsistencies
+
+# Put strings like "*.avi filter=external_blob_storage" to your .gitattributes or .git/info/attributes files,
+# and that files will be uploaded on server (test@127.0.0.1) each time Git attempts to read them (git add, git diff, git status, ...)
+# When checking out, files will be downloaded from server.
+# SHA-1 hashes are stored in Git instead of actual file content
+
+[filter "external_blob_storage"]
+	clean = ssh test@127.0.0.1 'tee qqq | sha1sum | awk \"{print \\$1}\" | (read S && mv qqq \"$S\" && echo \"$S\" )'
+	smudge = ssh test@127.0.0.1 'read S && cat \"$S\"'
-- 
1.7.1
