From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 1/6] submodule-config: keep update strategy around
Date: Tue,  9 Feb 2016 12:54:29 -0800
Message-ID: <1455051274-15256-2-git-send-email-sbeller@google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue Feb 09 21:55:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFJY-00021I-V6
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbcBIUys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 15:54:48 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35095 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbcBIUyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 15:54:46 -0500
Received: by mail-pa0-f44.google.com with SMTP id ho8so96905471pac.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g676k1ZU1SS3EjqerAr3mHik1/u82R50nTizZcZ3Ues=;
        b=TFGAg+ytyWKVPf812gfTG3tA2ORUxsvmwqHCkJueqUmFC29oT4COcOKZH43O45n6Fx
         bPh4Oju/3RSJufCnqmej8n81ABWvKYyXKrMZswVjFNPWhfeXopKzSuy5AfRMTL3XNIiQ
         UtyGYjd5LIFchd5/QsNfN7qDuwpN1gd8ttikir1lKnPZxlE91i0lbMrlabffPsjbgKVg
         hmgpcKpPOb1sn4RUQ8WKxj3BHJyIbjNkETH54poB1kxJ0W6hmyXftfHiDjEllK5guy7V
         tmkEba+dS4av2DrrQ05+oAnLRRcZh7r35vf3J2Jy/6qZ57ELjnAA/qBZc4QB509aKH4A
         0aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g676k1ZU1SS3EjqerAr3mHik1/u82R50nTizZcZ3Ues=;
        b=AxqADQtpZpAX9FT9ZoH7pd/1KuSH7AdIRuP7VhBtuAYFyjXQWs8Foi5jNUy0KMf1bQ
         AppXdPcsthapKRb6QYEXlwNHi0j+sPk2kEWd9mo2offC9m2fWGr+uEedHaWPseX87FgK
         Qgke7dJLAALBzrLGvGpUhmT/2wxHxBmdYK4F0w3BbhfiwaVvcvb3AZcPPzBBURjMCZxy
         24LB5Be/k+NUx1gn0Rq6aR26KLOM8D7EiPh/4e+Vo/W0PtVnl6cDxl8TgvrTHADh8XTW
         GPbMIqi6V/rJrA9ACW+PtANp0wiRHb4lhOoG8EfS5/0B5OlvRDCHpvipELAeD1WOGD8z
         462w==
X-Gm-Message-State: AG10YOTfd1EmFt4QLgmLL0sazhBVgH21LGT74Ivrq2yJDSVXjl9UWkF3nZbya5H+jg8CUBPC
X-Received: by 10.66.187.145 with SMTP id fs17mr53700641pac.81.1455051285730;
        Tue, 09 Feb 2016 12:54:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9085:4567:f3b3:63e9])
        by smtp.gmail.com with ESMTPSA id g10sm52555784pfd.92.2016.02.09.12.54.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 12:54:45 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.35.gb0f7869.dirty
In-Reply-To: <1455051274-15256-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285865>

Currently submodule.<name>.update is only handled by git-submodule.sh.
C code will start to need to make use of that value as more of the
functionality of git-submodule.sh moves into library code in C.

Add the update field to 'struct submodule' and populate it so it can
be read as sm->update or from sm->update_command.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 22 ++++++++++++++++++++++
 submodule-config.h | 11 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..a1af5de 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update = SM_UPDATE_UNSPECIFIED;
+	submodule->update_command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -311,6 +313,26 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
+	} else if (!strcmp(item.buf, "update")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite &&
+		    submodule->update != SM_UPDATE_UNSPECIFIED)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "update");
+		else {
+			submodule->update_command = NULL;
+			if (!strcmp(value, "none"))
+				submodule->update = SM_UPDATE_NONE;
+			else if (!strcmp(value, "checkout"))
+				submodule->update = SM_UPDATE_CHECKOUT;
+			else if (!strcmp(value, "rebase"))
+				submodule->update = SM_UPDATE_REBASE;
+			else if (!strcmp(value, "merge"))
+				submodule->update = SM_UPDATE_MERGE;
+			else if (!skip_prefix(value, "!", &submodule->update_command))
+				die(_("invalid value for %s"), var);
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..e3bd56e 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -4,6 +4,15 @@
 #include "hashmap.h"
 #include "strbuf.h"
 
+enum submodule_update_type {
+	SM_UPDATE_CHECKOUT,
+	SM_UPDATE_REBASE,
+	SM_UPDATE_MERGE,
+	SM_UPDATE_NONE,
+	SM_UPDATE_COMMAND,
+	SM_UPDATE_UNSPECIFIED
+};
+
 /*
  * Submodule entry containing the information about a certain submodule
  * in a certain revision.
@@ -14,6 +23,8 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	enum submodule_update_type update;
+	const char *update_command;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
-- 
2.7.0.rc0.35.gb0f7869.dirty
