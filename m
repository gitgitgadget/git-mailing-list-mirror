From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/6] Add concept of 'publish' branch
Date: Sun,  1 Sep 2013 03:26:38 -0500
Message-ID: <1378024002-26190-3-git-send-email-felipe.contreras@gmail.com>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 10:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG34t-0001G3-IV
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 10:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454Ab3IAIbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 04:31:45 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:53553 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab3IAIba (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 04:31:30 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so4081301oag.36
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3prqwM/HI79H/hzep5zcnH8J/mBnBSqoJgzJ+xiFjE=;
        b=oaGUPS4vxtJUOIQul+69iAaLzhwV7wgV1swGS9aQ/GeZq8CSbqxRSpAEFpOIIx/Zkw
         eKs9mhFK7/M4gyZdh1MdmP/p+338lNjD+Ha6ZZQow8+tYmMdd/M8WzqK3Uc6rf+TB8F9
         sbcVWJbtPXtG1rBUTV8+WN3KUUqxVuyttnfCV+++6nHt6tjSg2vY9UaeqyCc4VlPHozK
         hPAoMoF18GYnOu95c3LDkftxqAVilgRdKUIFOg9PaqjeEha9H7IMbDf1BY4EO6s+mtWJ
         ZsnX3EvLcgqvSXnFC+R7Hbg6zZoMC/yYXUz2YU7aPJMWUJnZm9E/V6jfT+lFed63VJ6g
         pMqw==
X-Received: by 10.182.45.195 with SMTP id p3mr12999144obm.29.1378024289746;
        Sun, 01 Sep 2013 01:31:29 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm7758079oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 01:31:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233577>

The upstream branch is:

  branch.$name.remote
  branch.$name.merge

The publish branch is:

  branch.$name.pushremote
  branch.$name.push

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 19 +++++++++++++++----
 remote.c       | 34 ++++++++++++++++++++++++++++------
 remote.h       |  4 ++++
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 5dc06a3..f2deddf 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -150,6 +150,20 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 	add_refspec(branch->name);
 }
 
+static void setup_push_simple(struct remote *remote, struct branch *branch,
+				int triangular)
+{
+	if (branch->push_name) {
+		struct strbuf refspec = STRBUF_INIT;
+		strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
+		add_refspec(refspec.buf);
+	} else if (triangular) {
+		setup_push_current(remote, branch);
+	} else {
+		setup_push_upstream(remote, branch, triangular);
+	}
+}
+
 static char warn_unspecified_push_default_msg[] =
 N_("push.default is unset; its implicit value is changing in\n"
    "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
@@ -210,10 +224,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_SIMPLE:
-		if (triangular)
-			setup_push_current(remote, get_current_branch(remote));
-		else
-			setup_push_upstream(remote, get_current_branch(remote), triangular);
+		setup_push_simple(remote, get_current_branch(remote), triangular);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
diff --git a/remote.c b/remote.c
index efcba93..04c7ed9 100644
--- a/remote.c
+++ b/remote.c
@@ -350,13 +350,17 @@ static int handle_config(const char *key, const char *value, void *cb)
 				explicit_default_remote_name = 1;
 			}
 		} else if (!strcmp(subkey, ".pushremote")) {
+			if (git_config_string(&branch->pushremote_name, key, value))
+				return -1;
 			if (branch == current_branch)
-				if (git_config_string(&pushremote_name, key, value))
-					return -1;
+				pushremote_name = xstrdup(branch->pushremote_name);
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
 			add_merge(branch, xstrdup(value));
+		} else if (!strcmp(subkey, ".push")) {
+			if (git_config_string(&branch->push_name, key, value))
+				return -1;
 		}
 		return 0;
 	}
@@ -1492,6 +1496,14 @@ struct branch *branch_get(const char *name)
 			}
 		}
 	}
+	if (ret && ret->pushremote_name) {
+		struct remote *pushremote;
+		pushremote = pushremote_get(ret->pushremote_name);
+		ret->push.src = xstrdup(ret->push_name);
+		if (remote_find_tracking(pushremote, &ret->push)
+		    && !strcmp(ret->pushremote_name, "."))
+			ret->push.dst = xstrdup(ret->push_name);
+	}
 	return ret;
 }
 
@@ -1694,6 +1706,15 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 	return found;
 }
 
+static char *get_base(struct branch *branch)
+{
+	if (branch->push.dst)
+		return branch->push.dst;
+	if (branch->merge && branch->merge[0] && branch->merge[0]->dst)
+		return branch->merge[0]->dst;
+	return NULL;
+}
+
 /*
  * Return true if there is anything to report, otherwise false.
  */
@@ -1710,15 +1731,16 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	 * Nothing to report unless we are marked to build on top of
 	 * somebody else.
 	 */
-	if (!branch ||
-	    !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
+	if (!branch)
+		return 0;
+	base = get_base(branch);
+	if (!base)
 		return 0;
 
 	/*
 	 * If what we used to build on no longer exists, there is
 	 * nothing to report.
 	 */
-	base = branch->merge[0]->dst;
 	if (read_ref(base, sha1))
 		return 0;
 	theirs = lookup_commit_reference(sha1);
@@ -1781,7 +1803,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
 		return 0;
 
-	base = branch->merge[0]->dst;
+	base = get_base(branch);
 	base = shorten_unambiguous_ref(base, 0);
 	if (!num_theirs) {
 		strbuf_addf(sb,
diff --git a/remote.h b/remote.h
index cf56724..79e5adf 100644
--- a/remote.h
+++ b/remote.h
@@ -138,6 +138,10 @@ struct branch {
 	struct refspec **merge;
 	int merge_nr;
 	int merge_alloc;
+
+	const char *pushremote_name;
+	const char *push_name;
+	struct refspec push;
 };
 
 struct branch *branch_get(const char *name);
-- 
1.8.4-337-g7358a66-dirty
