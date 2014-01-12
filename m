From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] remote: introduce and fill branch->pushremote
Date: Sun, 12 Jan 2014 22:41:06 +0530
Message-ID: <1389546666-17438-4-git-send-email-artagnon@gmail.com>
References: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 12 18:11:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2OZ4-0007wh-F0
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 18:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbaALRK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jan 2014 12:10:57 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35750 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbaALRKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 12:10:53 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so6488797pdj.25
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 09:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kb05EjExLxM7Askw8NgSY2x1WOjgu0bG1OTothzGVuw=;
        b=mXpGPTdRxpNQ2HrF9fgOdjh2Wgnn+2ivgHguVLmmgYqpG2cHzc692UycB58NXdrIix
         AM8V+XgInGa3ynqanl720yTs04mZwSKSSrV6nd6FIGW0lzaPYaytdHWzUWi5caJ15of+
         xMEQhYpX0Fr6EI9xhKok2yYgQIQIgyz5JED5yk6MAHN7xbskvwZcnohSEHYldEeAV0Ib
         NBZxmgIxw/MNq4HuwJVDYeTO2xQ118e2kLzX5N5zXTwVDHlmzAQF66QytzDQJbaqs0Dv
         K/Zzs1EpuSQeAeM3S4a2Y6dEkqjlvuz/PhbVtL5Cu/vgGBuPQXTP4Cfj9BGbIREJvr+o
         p27Q==
X-Received: by 10.68.98.3 with SMTP id ee3mr24957054pbb.31.1389546652194;
        Sun, 12 Jan 2014 09:10:52 -0800 (PST)
Received: from localhost.localdomain ([122.164.134.24])
        by mx.google.com with ESMTPSA id gn5sm14690070pbc.29.2014.01.12.09.10.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Jan 2014 09:10:51 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.313.g5abf4c0.dirty
In-Reply-To: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240352>

When a caller uses branch_get() to retrieve a "struct branch", they get
the per-branch remote name and a pointer to the remote struct. However,
they have no way of knowing about the per-branch pushremote from this
interface. So, let's expose that information via fields similar to
"remote" and "remote_name"; "pushremote" and "pushremote_name".

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 15 ++++++++++++---
 remote.h |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index a89efab..286cdce 100644
--- a/remote.c
+++ b/remote.c
@@ -351,9 +351,10 @@ static int handle_config(const char *key, const char *value, void *cb)
 				explicit_default_remote_name = 1;
 			}
 		} else if (!strcmp(subkey, ".pushremote")) {
+			if (git_config_string(&branch->pushremote_name, key, value))
+				return -1;
 			if (branch == current_branch)
-				if (git_config_string(&pushremote_name, key, value))
-					return -1;
+				pushremote_name = branch->pushremote_name;
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
@@ -1543,7 +1544,9 @@ struct branch *branch_get(const char *name)
 		ret = current_branch;
 	else
 		ret = make_branch(name, 0);
-	if (ret && ret->remote_name) {
+	if (!ret)
+		return ret;
+	if (ret->remote_name) {
 		ret->remote = remote_get(ret->remote_name);
 		if (ret->merge_nr) {
 			int i;
@@ -1557,6 +1560,12 @@ struct branch *branch_get(const char *name)
 			}
 		}
 	}
+	if (ret->pushremote_name)
+		ret->pushremote = remote_get(ret->pushremote_name);
+	else if (pushremote_name)
+		ret->pushremote = remote_get(pushremote_name);
+	else
+		ret->pushremote = ret->remote;
 	return ret;
 }
 
diff --git a/remote.h b/remote.h
index 00c6a76..ac5aadc 100644
--- a/remote.h
+++ b/remote.h
@@ -201,6 +201,9 @@ struct branch {
 	const char *remote_name;
 	struct remote *remote;
 
+	const char *pushremote_name;
+	struct remote *pushremote;
+
 	const char **merge_name;
 	struct refspec **merge;
 	int merge_nr;
-- 
1.8.5.2.313.g5abf4c0.dirty
