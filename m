From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/6] Refactor type_from_string() to avoid die()ing in case
 of errors
Date: Thu, 28 Aug 2014 16:46:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1408281646350.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 28 16:47:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN0yg-0007Gp-F5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbaH1Oqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:46:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:50394 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaH1Oqu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 10:46:50 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MI5rO-1XJBDO3JaY-003ykA;
 Thu, 28 Aug 2014 16:46:36 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7q6L7eroRjXgFGucle3xy/1ik0Zq2vXiG/W3hY9f7OHncQIKSCU
 Tj5wMD3pVgN/ED5o2EmOrzjfDjNJWM8DqO2ku/UcPE142OmJBdH7J/wI3gtb04ndi/ibPzp
 OWE9JubN4vQz5Tkn56ZJtx5Ed15CqEQ4TQUDbleqwwGIs2mE/3IMq0L9nIC+cpiIXaWjSKB
 BShY5p+9rdsp2UEa72HRQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256086>

In the next commits, we will enhance the fsck_tag() function to check
tag objects more thoroughly. To this end, we need a function to verify
that a given string is a valid object type, but that does not die() in
the negative case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 object.c | 13 ++++++++++++-
 object.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/object.c b/object.c
index a16b9f9..5eee592 100644
--- a/object.c
+++ b/object.c
@@ -33,13 +33,24 @@ const char *typename(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string(const char *str)
+int type_from_string_gently(const char *str)
 {
 	int i;
 
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strcmp(str, object_type_strings[i]))
 			return i;
+
+	return -1;
+}
+
+int type_from_string(const char *str)
+{
+	int i = type_from_string_gently(str);
+
+	if (i >= 0)
+		return i;
+
 	die("invalid object type \"%s\"", str);
 }
 
diff --git a/object.h b/object.h
index 5e8d8ee..5c5d22f 100644
--- a/object.h
+++ b/object.h
@@ -54,6 +54,7 @@ struct object {
 
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
+extern int type_from_string_gently(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.0.0.rc3.9669.g840d1f9
