From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 4/8] Add concept of 'publish' branch
Date: Sat, 12 Oct 2013 02:05:56 -0500
Message-ID: <1381561561-20459-4-git-send-email-felipe.contreras@gmail.com>
References: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtN9-0004mg-Pr
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab3JLHMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:13 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:41275 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3JLHMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:10 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so3121901oag.10
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bbJdBB3tqbhEVUH8M3yhYuik2/fKTAUbzcvX1DhENkw=;
        b=hzXs5RdfSe1wV2s3dE5R7/RSavpskzvSlpf4jgEiMHT6yqpqcvTJdqP0fC3VU9Uf91
         Mrc9dd1ztBLfPWOgO/sfDH2iHduwyyqp05pAg8uGaqfolhnKOp7XONCAabIz4BeOvrXx
         73Nyim/qW3N3TZr6AG+WmtSGxOahhBUUHvzRD7lpViFIBkYjMBvcIKE4hwS4zjtQfLeJ
         vj1wNn1ti7rUr5doEeQsnqXKQzUFH8WMDm/f17NoFo+K1cQ2Q6Dt6XUetSdGv7VA0C4Z
         E1+3B+tczgJFPPgovHcV9ZZIhafVZ/1cPKy+sQznAEcEDUw5hgebKhtJfuoJ7RiprJup
         bPrw==
X-Received: by 10.182.246.74 with SMTP id xu10mr17770129obc.23.1381561929988;
        Sat, 12 Oct 2013 00:12:09 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm101388324oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235989>

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
1.8.4-fc
