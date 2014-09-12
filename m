From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 1/6] Refactor type_from_string() to avoid die()ing in case
 of errors
Date: Fri, 12 Sep 2014 10:07:49 +0200 (CEST)
Message-ID: <7683fa48644b0958f8e87fbb5db51e362ea40e85.1410509168.git.johannes.schindelin@gmx.de>
References: <cover.1410445430.git.johannes.schindelin@gmx.de> <cover.1410509168.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 12 10:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLth-00054G-VU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 10:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbaILIH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 04:07:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:61291 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbaILIHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 04:07:54 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0M9eHT-1Xe8fw1oIJ-00Czcw;
 Fri, 12 Sep 2014 10:07:51 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410509168.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:qxC+ZJKJVBBlxX4PliXAn8QTZfYOKFWjMURQCQPFONCnurxF0bf
 b9WM4jY00Uef75YuXDEYJGb6260/wNj4B/Nf92YxBJmvQGwi7jn9oHZpOXYEwy2e3E3V1cC
 txF6DQJ0Ix3NtFN+14fB2RpCu3eJpR3h+47WAQS0yVAisBil0ySAOCALMAAQzAZSwYSoGC8
 YAZ44pecnu0gy1HBJBRNA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256907>

In the next commits, we will enhance the fsck_tag() function to check
tag objects more thoroughly. To this end, we need a function to verify
that a given string is a valid object type, but that does not die() in
the negative case.

While at it, prepare type_from_string() for counted strings, i.e. strings
with an explicitly specified length rather than a NUL termination.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 object.c | 11 +++++++++--
 object.h |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/object.c b/object.c
index a16b9f9..aedac24 100644
--- a/object.c
+++ b/object.c
@@ -33,13 +33,20 @@ const char *typename(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string(const char *str)
+int type_from_string_gently(const char *str, ssize_t len, int gentle)
 {
 	int i;
 
+	if (len < 0)
+		len = strlen(str);
+
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
-		if (!strcmp(str, object_type_strings[i]))
+		if (!strncmp(str, object_type_strings[i], len))
 			return i;
+
+	if (gentle)
+		return -1;
+
 	die("invalid object type \"%s\"", str);
 }
 
diff --git a/object.h b/object.h
index 5e8d8ee..e028ced 100644
--- a/object.h
+++ b/object.h
@@ -53,7 +53,8 @@ struct object {
 };
 
 extern const char *typename(unsigned int type);
-extern int type_from_string(const char *str);
+extern int type_from_string_gently(const char *str, ssize_t, int gentle);
+#define type_from_string(str) type_from_string_gently(str, -1, 0)
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.0.0.rc3.9669.g840d1f9
