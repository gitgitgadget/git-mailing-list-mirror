From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 3/5] submodule.c: add .gitmodules staging helper functions
Date: Tue, 30 Jul 2013 21:50:34 +0200
Message-ID: <51F8190A.3030002@web.de>
References: <51F8187F.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:50:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4FwO-0007nD-FX
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639Ab3G3Tug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:50:36 -0400
Received: from mout.web.de ([212.227.17.12]:51061 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135Ab3G3Tug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:50:36 -0400
Received: from [192.168.178.41] ([79.193.94.161]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MJCAc-1V2bFA1pLm-002kbN for <git@vger.kernel.org>;
 Tue, 30 Jul 2013 21:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F8187F.7040603@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:bfDDc5xOnlNGyrvMj1kbK5BvL4RARGcHIS7J5nVuc4bmBCiTQFl
 6S48b3tNdYo7BAg/zi5aFCEjynyQs1MtSm0xx09072fEBWgPyL121dMUJLSa2qiixO0bsiA
 ZWrHl3SfBQGH4TUiMlRExiSuE2KDnxZx+9J83mMI5dtnnXFyWCU5JGnQ7T4ygMV3VM1R8s6
 N2QM+HcTuqvNKv7AP/DBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231385>

Add the new is_staging_gitmodules_ok() and stage_updated_gitmodules()
functions to submodule.c. The first makes it possible for call sites to
see if the .gitmodules file did contain any unstaged modifications they
would accidentally stage in addition to those they intend to stage
themselves. The second function stages all modifications to the
.gitmodules file, both will be used by subsequent patches for the mv
and rm commands.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/submodule.c b/submodule.c
index d96d187..584f7de 100644
--- a/submodule.c
+++ b/submodule.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "argv-array.h"
+#include "blob.h"

 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
@@ -30,6 +31,51 @@ static struct sha1_array ref_tips_after_fetch;
  */
 static int gitmodules_is_unmerged;

+/*
+ * This flag is set if the .gitmodules file had unstaged modifications on
+ * startup. This must be checked before allowing modifications to the
+ * .gitmodules file with the intention to stage them later, because when
+ * continuing we would stage the modifications the user didn't stage herself
+ * too. That might change in a future version when we learn to stage the
+ * changes we do ourselves without staging any previous modifications.
+ */
+static int gitmodules_is_modified;
+
+
+int is_staging_gitmodules_ok()
+{
+	return !gitmodules_is_modified;
+}
+
+void stage_updated_gitmodules(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct stat st;
+	int pos;
+	struct cache_entry *ce;
+	int namelen = strlen(".gitmodules");
+
+	pos = cache_name_pos(".gitmodules", namelen);
+	if (pos < 0) {
+		warning(_("could not find .gitmodules in index"));
+		return;
+	}
+	ce = active_cache[pos];
+	ce->ce_flags = namelen;
+	if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
+		die(_("reading updated .gitmodules failed"));
+	if (lstat(".gitmodules", &st) < 0)
+		die_errno(_("unable to stat updated .gitmodules"));
+	fill_stat_cache_info(ce, &st);
+	ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);
+	if (remove_cache_entry_at(pos) < 0)
+		die(_("unable to remove .gitmodules from index"));
+	if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
+		die(_("adding updated .gitmodules failed"));
+	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
+		die(_("staging updated .gitmodules failed"));
+}
+
 static int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory = STRBUF_INIT;
@@ -116,6 +162,11 @@ void gitmodules_config(void)
 				    !memcmp(ce->name, ".gitmodules", 11))
 					gitmodules_is_unmerged = 1;
 			}
+		} else if (pos < active_nr) {
+			struct stat st;
+			if (lstat(".gitmodules", &st) == 0 &&
+			    ce_match_stat(active_cache[pos], &st, 0) & DATA_CHANGED)
+				gitmodules_is_modified = 1;
 		}

 		if (!gitmodules_is_unmerged)
diff --git a/submodule.h b/submodule.h
index 29e9658..244d5f5 100644
--- a/submodule.h
+++ b/submodule.h
@@ -11,6 +11,8 @@ enum {
 	RECURSE_SUBMODULES_ON = 2
 };

+int is_staging_gitmodules_ok();
+void stage_updated_gitmodules(void);
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
-- 
1.8.4.rc0.199.g7079aac
