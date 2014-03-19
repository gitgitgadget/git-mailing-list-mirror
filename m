From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [PATCH] diff-no-index.c: rewrote read_directory() to use is_dot_or_dotdot() function.
Date: Wed, 19 Mar 2014 10:31:50 +0200
Message-ID: <1395217910-7506-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 09:32:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQBuw-0003p2-Ui
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 09:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956AbaCSIcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 04:32:00 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:63646 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbaCSIb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 04:31:57 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so6265420eek.39
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9Uf8unewyFSQ19LLx+OnYLopcR125odG+GEcA54I8WU=;
        b=RTIfZ9YiTmT5XY+KzLsOC/fUb2eKe0ceALac8oN4MTgEo5dpV4FMAU9/F0OUpNsfyO
         qJVsyrkRfvRRcTk/v/wy/2vccoG4yzdrlUQOisQsomnJDH1w9ZEOkbVmlLU5VQvXXbdu
         BvFJ4hJg6gBW7BPB6Vm8H2/Ha5aIpwPXpE6mB8UPZBMgLHmvr/+IA502FtU7ReaJtdXW
         o58+A4tmai2z0nd1kqJ1h9K2p7sSoCNYHXAYEbkNtrI7VaMKuZxWwZdrQmaxR9D11951
         zT6ThCPi3PW5+H1CM5ASlLz6KJNRJfuqqtFwBXNf+k2+OnJG9X17F9BxhiRrj08ZHGO7
         BMUg==
X-Received: by 10.14.219.137 with SMTP id m9mr19575236eep.77.1395217916824;
        Wed, 19 Mar 2014 01:31:56 -0700 (PDT)
Received: from localhost.localdomain ([141.85.0.105])
        by mx.google.com with ESMTPSA id n5sm2649129eex.14.2014.03.19.01.31.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 01:31:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244420>

is_dot_or_dotdot() verifies if the name of the directory sent as parameter to this function is the same with '.' or '..' and returns 0 if that is true.

There is unnecessary to iterate each character of the char* argument and verify it with strcmp because if there is a match that is at the beginning of chars.

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

I plan on applying to GSoc 2014
---
 diff-no-index.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..83cdbf7 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,6 +16,15 @@
 #include "builtin.h"
 #include "string-list.h"
 
+static int is_dot_or_dotdot(const char *path)
+{
+    if (path[0] == '.' && path[1] == '\0')
+        return 0;
+    else if (path[0] == '.' && path[1] == '.' && path[2] == '\0')
+        return 0;
+    return 1;
+}
+
 static int read_directory(const char *path, struct string_list *list)
 {
 	DIR *dir;
@@ -25,7 +34,7 @@ static int read_directory(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.7.9.5
