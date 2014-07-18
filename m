From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v10 2/4] replace memset with string-list initializers
Date: Fri, 18 Jul 2014 02:19:00 -0700
Message-ID: <1405675142-20300-3-git-send-email-tanayabh@gmail.com>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 11:20:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X84Kl-0006DI-2r
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 11:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761115AbaGRJUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 05:20:01 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63263 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761099AbaGRJT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 05:19:58 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so4993127pab.20
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=akbG6CVjNmTkbNwB5ud5BXLSv+3HLvb9tC48+rcZZ4k=;
        b=H3c5O+740HRLjY/ffgsW44y3kk3tW77CwafmeT60nfVojVAfQVFKsaTTTEjm9wDwuk
         0YoLFPJGF6TABRBGtztgEAe098LfAeH0QIsFwkbNobEd0oaWbn9CTsg7grIYRssKfDxU
         uoXz2zw013YvJDl0MB+cAGK6sNMBGPAZcGjJSMqlVRxVwDOh1xvvjAH6PCSnFYPFzc6R
         q/dWA4vwd4gTJ1KespSzkJtv8z0OHduVZy6iw9QidvYRQWVUdzQzpqntXyj9sRm0KoS4
         1DWZcEw92wWnibO2vSFgUCaxqqndW1gKUa5832OzwtAGU577ueYxNztu4YAiurjB6qyh
         8zSg==
X-Received: by 10.69.25.35 with SMTP id in3mr3274876pbd.63.1405675192974;
        Fri, 18 Jul 2014 02:19:52 -0700 (PDT)
Received: from localhost.localdomain ([106.203.84.80])
        by mx.google.com with ESMTPSA id wn7sm20813928pab.18.2014.07.18.02.19.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 02:19:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253801>

Using memset and then manually setting values of the string-list
members is not future proof as the internal representation of
string-list may change any time.
Use `string_list_init()` or STRING_LIST_INIT_* macros instead of
memset.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 builtin/commit.c  | 3 +--
 merge-recursive.c | 9 +++------
 submodule.c       | 5 +----
 transport.c       | 4 +---
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 72eb3be..5b196ca 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -420,8 +420,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 			die(_("cannot do a partial commit during a cherry-pick."));
 	}
 
-	memset(&partial, 0, sizeof(partial));
-	partial.strdup_strings = 1;
+	string_list_init(&partial, 1);
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, &pathspec))
 		exit(1);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 5814d05..1d332b8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2059,12 +2059,9 @@ void init_merge_options(struct merge_options *o)
 	if (o->verbosity >= 5)
 		o->buffer_output = 0;
 	strbuf_init(&o->obuf, 0);
-	memset(&o->current_file_set, 0, sizeof(struct string_list));
-	o->current_file_set.strdup_strings = 1;
-	memset(&o->current_directory_set, 0, sizeof(struct string_list));
-	o->current_directory_set.strdup_strings = 1;
-	memset(&o->df_conflict_file_set, 0, sizeof(struct string_list));
-	o->df_conflict_file_set.strdup_strings = 1;
+	string_list_init(&o->current_file_set, 1);
+	string_list_init(&o->current_directory_set, 1);
+	string_list_init(&o->df_conflict_file_set, 1);
 }
 
 int parse_merge_opt(struct merge_options *o, const char *s)
diff --git a/submodule.c b/submodule.c
index 48e3b44..c3a61e7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -544,10 +544,7 @@ static int push_submodule(const char *path)
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name)
 {
 	int i, ret = 1;
-	struct string_list needs_pushing;
-
-	memset(&needs_pushing, 0, sizeof(struct string_list));
-	needs_pushing.strdup_strings = 1;
+	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
 	if (!find_unpushed_submodules(new_sha1, remotes_name, &needs_pushing))
 		return 1;
diff --git a/transport.c b/transport.c
index 59c9727..d32aaf2 100644
--- a/transport.c
+++ b/transport.c
@@ -1188,10 +1188,8 @@ int transport_push(struct transport *transport,
 		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
-			struct string_list needs_pushing;
+			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-			memset(&needs_pushing, 0, sizeof(struct string_list));
-			needs_pushing.strdup_strings = 1;
 			for (; ref; ref = ref->next)
 				if (!is_null_sha1(ref->new_sha1) &&
 				    find_unpushed_submodules(ref->new_sha1,
-- 
1.9.0.GIT
