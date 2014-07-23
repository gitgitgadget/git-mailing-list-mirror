From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Wed, 23 Jul 2014 11:42:56 -0700
Message-ID: <1406140978-9472-6-git-send-email-tanayabh@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 20:44:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1Wa-0006ui-PP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbaGWSoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:44:10 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41643 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbaGWSoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:44:05 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so2263192pab.28
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OVKbRJkRf6cynoE0e/75iJpSBZyjkPFV9FSHKa2y5HQ=;
        b=wxgeMWHrhbJY6xEJFMxNrVrbbvced/ti/130Gecac8jmqGqQXEBmmBQDYDoew7ZR/V
         0LjueN4EQheURob0Rbo0eJV2vGtBD+Ak3gk9YWPU75U8QQKCGOoZ+BaMGPlsGIUjkraE
         YqZ6rd6WAOq/qzGwryJfEOkTGAL8Hwt5GlzPndbCS49T6N71/0QDMyEPg8ZYkdYcUcVL
         mmgl3HIKbA9bwU3R3kvCCzasMeh9dUuO1A8NSH/NrVIos5ncXCjaVc0/TxBma04DCFko
         uJSV1OH0Cd/Blsu+tRkGovkhghfDznVQFP8Z/8XW/7QNagT82/5N7REwZ5hOWLCmsqza
         3LLw==
X-Received: by 10.66.153.80 with SMTP id ve16mr4258081pab.143.1406141044574;
        Wed, 23 Jul 2014 11:44:04 -0700 (PDT)
Received: from localhost.localdomain ([27.56.89.40])
        by mx.google.com with ESMTPSA id z10sm1067820pdo.14.2014.07.23.11.44.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 11:44:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254108>

t4018-diff-funcname.sh fails for the new `git_config()` which uses the
configuration files caching layer internally.
The test introduced in commit d64d6cdc checks that whether `xfuncname` takes
precedence over `funcname` variable which was not guaranteed by config API
previously and worked only because values were parsed and fed in order. The
new  `git_config()` only guarantees precedence order for variables with the
same name.

Also `funcname` variable is deprecated and not documented properly.
`xfuncname` is mentioned in the docs and takes precedence over `funcname`.
Instead of removing `funcname` variable, enforce `xfuncname` precedence over
`funcname` when the variables have the same subsection. Remove dependency
that required values to be fed to userdiff_config() in parsing order for the
test to succeed.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
Note: this the only test that failed for the new git_config() rewrite.

 userdiff.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index fad52d6..a51bc89 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -2,6 +2,7 @@
 #include "userdiff.h"
 #include "cache.h"
 #include "attr.h"
+#include "string-list.h"
 
 static struct userdiff_driver *drivers;
 static int ndrivers;
@@ -211,9 +212,12 @@ int userdiff_config(const char *k, const char *v)
 	struct userdiff_driver *drv;
 	const char *name, *type;
 	int namelen;
+	char *subsection = NULL;
+	static struct string_list xflag = STRING_LIST_INIT_DUP;
 
 	if (parse_config_key(k, "diff", &name, &namelen, &type) || !name)
 		return 0;
+	subsection = xstrndup(name, namelen);
 
 	drv = userdiff_find_by_namelen(name, namelen);
 	if (!drv) {
@@ -224,10 +228,16 @@ int userdiff_config(const char *k, const char *v)
 		drv->binary = -1;
 	}
 
-	if (!strcmp(type, "funcname"))
+	if (!strcmp(type, "funcname") && !unsorted_string_list_has_string(&xflag, subsection)) {
+		free (subsection);
 		return parse_funcname(&drv->funcname, k, v, 0);
-	if (!strcmp(type, "xfuncname"))
+	}
+	if (!strcmp(type, "xfuncname")) {
+		string_list_append(&xflag, subsection);
+		free (subsection);
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
+	}
+	free(subsection);
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
-- 
1.9.0.GIT
