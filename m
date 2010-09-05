From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v2] string-list: Document STRING_LIST_INIT_* macros.
Date: Sun,  5 Sep 2010 20:40:55 -0300
Message-ID: <1283730055-14477-1-git-send-email-tfransosi@gmail.com>
Cc: jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 01:41:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsOph-0005Fx-OZ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 01:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab0IEXlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 19:41:04 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64688 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab0IEXlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 19:41:03 -0400
Received: by gyd8 with SMTP id 8so1442502gyd.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fkwMyU4ccpVREoFc0Mad4crVZZD024Hz4WotP98OzuA=;
        b=DMRrnlMUqAD6RGSq6CiBVOoHQl17wzB8NCZT7LNtu5NCTtQvWcul57fXNA45h/Y6PZ
         j8q9u/je08YXOLVvxFpGlHbn7RHZWF4YNiOxSa3qto32tHHHK99DMO4Dja+S9o0ns66Z
         X8n92WlkUCR9AbIgzBWujuOmiPWLSY4G4LN4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qdl6/X95v6bZrsV+U9dGJZsSlVMA/jawTrWtnCrrq2ZSPvbzOop75DftBRPnPFsdgb
         y4Swo8ehmqjsjHqC5uvJ1MVs6iQaOWTMevGSYSpmyTKCur3MV+dmYj4zcqIJda+r4UCN
         j0aOR0YyW5aC/1pm1jb5kcMeazB6LrrDbfkJQ=
Received: by 10.150.11.15 with SMTP id 15mr227991ybk.140.1283730062563;
        Sun, 05 Sep 2010 16:41:02 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id t16sm5208185ybm.10.2010.09.05.16.41.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 16:41:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155498>

Clarify the modern ways to initialize a string_list. Text roughly
based on the analogous passage from api-strbuf.txt.

(Note: Based on the demo patch of Jonathan Nieder).

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Documentation/technical/api-string-list.txt |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 3f575bd..1510ee2 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -11,7 +11,14 @@ The caller:
 
 . Allocates and clears a `struct string_list` variable.
 
-. Initializes the members. You might want to set the flag `strdup_strings`
+. Initializes the members. A string_list has to by `= STRING_LIST_INT_NODUP` or
+  `= STRING_LIST_INIT_DUP` before it can be used.
+  Strings in lists initialized with the _DUP variant will be
+  automatically strdup()ed on insertion and free()ed on removal.
+  For example, this is necessary when you add something like
+  git_path("..."), since that function returns a static buffer
+  that will change with the next call to git_path().
+
   if the strings should be strdup()ed. For example, this is necessary
   when you add something like git_path("..."), since that function returns
   a static buffer that will change with the next call to git_path().
@@ -34,10 +41,9 @@ member (you need this if you add things later) and you should set the
 Example:
 
 ----
-struct string_list list;
+struct string_list list = STRING_LIST_DUP;
 int i;
 
-memset(&list, 0, sizeof(struct string_list));
 string_list_append(&list, "foo");
 string_list_append(&list, "bar");
 for (i = 0; i < list.nr; i++)
@@ -52,6 +58,18 @@ However, if you use the list to check if a certain string was added
 already, you should not do that (using unsorted_string_list_has_string()),
 because the complexity would be quadratic again (but with a worse factor).
 
+Macros
+------
+
+`STRING_LIST_INIT_NODUP`::
+
+	Initialize the members and set the `strdup_strings` member to 0.
+
+`STRING_LIST_INIT_DUP`::
+
+	Initialize the members and set the `strdup_strings` member to 1.
+
+
 Functions
 ---------
 
-- 
1.7.2.3.313.gcd15
