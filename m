From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/12] git submodule update: Use its own list implementation.
Date: Thu, 15 Oct 2015 18:52:06 -0700
Message-ID: <1444960333-16003-6-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCP-0002W9-Gs
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbbJPBwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:47 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33646 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbbJPBwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:22 -0400
Received: by pabrc13 with SMTP id rc13so104121033pab.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IteYVpRgezbNJTbpb3KqVxL3X63ezH7llK9k+i4NjE0=;
        b=hssovV5AhpIex13yWbw2p+GN3KmsY1VRlcc1sOXigwMF0m+C20CT1OcZgkn/WAIpAA
         OSppQ1cVOSnTXwBWP+vMCTyX+zfB2wfL9gozXdAl/KAUwPktXWb23WEPfmBttHaJj+n/
         Wqp9tZ/WR4svuUnE6X1iVW5TvkEhbBuyHT61p6sjfkP47++r6D4aobH67cpvRizOb3YX
         Cn7nbe1UlnNfjKSPW9KUyuXBpyUptuRSQNg3qOWwGd+HTXEaEl6AjfKpsy0ShBBT3rNP
         QJmoWcm5e9eeQu5UVddaBmT0ugBxzBgJBIOKUGmIJA/NhHWalcCEZbU+9ZY4oBX/eEQL
         TPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IteYVpRgezbNJTbpb3KqVxL3X63ezH7llK9k+i4NjE0=;
        b=DfvMWkMrDqo9d6I6Pi+BHIuxD5XWkLOT07wrkEogtEbJBaJg8aeMkm+VaRRkGp2uaA
         Tq7VXaiQUOqPRMLg/IXeyxg66R4VAXbj8iJ7PUBblX4P1+tIgdjkdzbcUB1gByFq28/Z
         CynnmO39y9HwScVCxJQ+vAOi891b+jimEW7woooORizgivyvKaZiQUsI+QDXjwG0rhVn
         yMAhzsZ7i2rjkJJ8NtokmrlU8RVs/UJj71c4mi03DAae7+Xex2tqBSjxvIvPq77QKCeb
         lTbXmppl/kKSbUXlMBLkKoPX/HdJUwE5zXABsyjX5CdC8C7eXNR/kTsTfJgLw3umhDvm
         QCXQ==
X-Gm-Message-State: ALoCoQmxUiaLCRbKGnIlsFFEMu/dF7NP60bacfbnlgsKZBy0zEzMC+ANFbX/cVr996AfYfOy5MRj
X-Received: by 10.66.122.98 with SMTP id lr2mr13330276pab.146.1444960342085;
        Thu, 15 Oct 2015 18:52:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id fk8sm17920865pab.33.2015.10.15.18.52.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279724>

Discussions turned out that we cannot parallelize the whole loop below
`git submodule--helper list` in `git submodule update`, because some
changes should be done only one at a time, such as messing up a submodule
and leave it up to the user to cleanup the conflicted rebase or merge.

The submodules which are need to be cloned however do not expect to create
problems which require attention by the user one at a time, so we want to
parallelize that first.

To do so we will start with a literal copy of `git submodule--helper list`
and port over features gradually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 40 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..47dc9cb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -255,6 +255,45 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_list_or_clone(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+
+	struct option module_list_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_list_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	for (i = 0; i < list.nr; i++) {
+		const struct cache_entry *ce = list.entries[i];
+
+		if (ce_stage(ce))
+			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
+		else
+			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+
+		utf8_fprintf(stdout, "%s\n", ce->name);
+	}
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -264,6 +303,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"list-or-clone", module_list_or_clone}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index bb8b2c7..d2d80e2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -656,7 +656,7 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	git submodule--helper list --prefix "$wt_prefix" "$@" | {
+	git submodule--helper list-or-clone --prefix "$wt_prefix" "$@" | {
 	err=
 	while read mode sha1 stage sm_path
 	do
-- 
2.5.0.277.gfdc362b.dirty
