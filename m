From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/9] Add concept of 'publish' branch
Date: Thu, 10 Apr 2014 14:04:39 -0500
Message-ID: <1397156686-31349-3-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKRL-0006EY-03
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbaDJTPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:15:00 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:50569 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaDJTO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:14:57 -0400
Received: by mail-ob0-f181.google.com with SMTP id wp4so4905510obc.40
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v8+kH1+m5kU7HUNNL+LxXz/t5Q9rGuELxtm1wJVGPpY=;
        b=XdVm0VKVByq+jpIp9HDOmADbgvotmj6SKqVC9F7p4XSHqw/neIRh0VwGeIOLOmJSNP
         KEMAupG2/QIe1J4txqYzebS8MAK0oRAUyCbxvXAHZ2U1u0iWyO6Z15pVHINwqtYCKOqX
         7TK3OhIrfSDdELjubY1T9XL8LPCVKxv5/Kq71qh0NhbJKDDMCXt8WHs4ubNuz5tdn6te
         I63Gi7lkXOeXX0AwZgcWZOaj5Zx627NvxKvkThyjzzBG4LOjIYJIJruqvuA/SCfeSlJA
         Jh8S5LceKxxgabN90/ZvKyrKMLuhZZdfSdTOVv035yZ/nUdcG4GPtR06IrlPjNmsiWsu
         j/Cw==
X-Received: by 10.182.55.103 with SMTP id r7mr1976111obp.78.1397157297368;
        Thu, 10 Apr 2014 12:14:57 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm21305389oec.0.2014.04.10.12.14.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:14:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246040>

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
index d10aefc..a1fdc49 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -192,6 +192,20 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 	add_refspec(branch->name);
 }
 
+static void setup_push_simple(struct remote *remote, struct branch *branch,
+		int triangular)
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
@@ -259,10 +273,7 @@ static void setup_default_push_refspecs(struct remote *remote)
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
index 5f63d55..3437d1f 100644
--- a/remote.c
+++ b/remote.c
@@ -352,13 +352,17 @@ static int handle_config(const char *key, const char *value, void *cb)
 				explicit_default_remote_name = 1;
 			}
 		} else if (!strcmp(subkey, ".pushremote")) {
+			if (git_config_string(&branch->pushremote_name, key, value))
+				return -1;
 			if (branch == current_branch)
-				if (git_config_string(&branch_pushremote_name, key, value))
-					return -1;
+				branch_pushremote_name = xstrdup(branch->pushremote_name);
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
@@ -1562,6 +1566,14 @@ struct branch *branch_get(const char *name)
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
 
@@ -1771,6 +1783,15 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
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
  * Compare a branch with its upstream, and save their differences (number
  * of commits) in *num_ours and *num_theirs.
@@ -1788,12 +1809,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	int rev_argc;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
-	if (!branch ||
-	    !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
+	if (!branch)
+		return 0;
+	base = get_base(branch);
+	if (!base)
 		return 0;
 
 	/* Cannot stat if what we used to build on no longer exists */
-	base = branch->merge[0]->dst;
 	if (read_ref(base, sha1))
 		return -1;
 	theirs = lookup_commit_reference(sha1);
@@ -1869,7 +1891,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		break;
 	}
 
-	base = branch->merge[0]->dst;
+	base = get_base(branch);
 	base = shorten_unambiguous_ref(base, 0);
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
diff --git a/remote.h b/remote.h
index fb7647f..08e93c4 100644
--- a/remote.h
+++ b/remote.h
@@ -204,6 +204,10 @@ struct branch {
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
1.9.1+fc1
