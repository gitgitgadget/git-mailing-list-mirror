From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 4/4] Allow customizable coloring of commit decorations
Date: Sat, 19 Jun 2010 09:37:36 +0800
Message-ID: <1276911456-18466-4-git-send-email-ayiehere@gmail.com>
References: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 03:38:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPn15-00062G-6c
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 03:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab0FSBiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 21:38:06 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab0FSBiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 21:38:04 -0400
Received: by mail-pw0-f46.google.com with SMTP id 1so660303pwi.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NvY6WiM12W3wjAFXTc61IwzzlYNcCh8tj+ZGd6VCviU=;
        b=JxqEzvOBYdgVHY0D/LwQAe2t2JlUlzmIP3omyC15SBxJbpmrLMaUzC8l+iJjktH8M0
         FySBZN+aXyeDZJ/+2qYEf/lR4p1+KxBmkkE8qvOwmdU3ttkRkolW1SlaIsRfSLw7p5zm
         tOCgUJYY083G9DBN6GLVABu4LKjpeZWL4a23I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MRRTRhrVZy6H8giSQJacCaGUnbxazSj93B/aN7XObuVaZMgtMwiQWErvwbz102N2pk
         h8DtJS2OKl0aZgA/c4gXlFcKn63lYEVWt7Ol6+HVAbGJBdKZVdwhCtRUtRKey5LLBkkI
         /4gpWA/QJtB8ceeCEjc+9dhode/nckveAMTEA=
Received: by 10.140.251.5 with SMTP id y5mr1527425rvh.17.1276911483840;
        Fri, 18 Jun 2010 18:38:03 -0700 (PDT)
Received: from localhost.localdomain ([115.132.104.117])
        by mx.google.com with ESMTPS id s9sm3587164rvl.5.2010.06.18.18.37.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 18:38:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.245.g7c42e.dirty
In-Reply-To: <7vtyp11k9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149372>

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 Documentation/config.txt |    6 ++++++
 builtin/log.c            |    3 +++
 log-tree.c               |   24 ++++++++++++++++++++++++
 log-tree.h               |    1 +
 4 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 95cf73c..b3e80c1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -683,6 +683,12 @@ color.diff.<slot>::
 	(highlighting whitespace errors). The values of these variables may be
 	specified as in color.branch.<slot>.
 
+color.decorate.<slot>::
+	Use customized color for 'git log --decorate' output.
+	`<slot>` is one of `reflocal`, `refremote`, `reftag`, `refstash` or
+	`refhead` for local refs, remote refs, tags, stash and HEAD,
+	respectively.
+
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
 	`never`), never.  When set to `true` or `auto`, use color only
diff --git a/builtin/log.c b/builtin/log.c
index 976e16f..0835866 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -296,6 +296,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!prefixcmp(var, "color.decorate."))
+		return parse_decorate_color_config(var, 15, value);
+
 	return git_diff_ui_config(var, value, cb);
 }
 
diff --git a/log-tree.c b/log-tree.c
index 25586cf..0265228 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -36,6 +36,30 @@ static const char *decorate_get_color(int decorate_use_color, enum decoration_ty
 	return "";
 }
 
+static int parse_decorate_color_slot(const char *slot) {
+	if (!strcasecmp(slot, "reflocal"))
+		return DECORATION_REF_LOCAL;
+	if (!strcasecmp(slot, "refremote"))
+		return DECORATION_REF_REMOTE;
+	if (!strcasecmp(slot, "reftag"))
+		return DECORATION_REF_TAG;
+	if (!strcasecmp(slot, "refstash"))
+		return DECORATION_REF_STASH;
+	if (!strcasecmp(slot, "refhead"))
+		return DECORATION_REF_HEAD;
+	return -1;
+}
+
+int parse_decorate_color_config(const char *var, const int ofs, const char *value) {
+	int slot = parse_decorate_color_slot(var + ofs);
+	if (slot < 0)
+		return 0;
+	if (!value)
+		return config_error_nonbool(var);
+	color_parse(value, var, decoration_colors[slot]);
+	return 0;
+}
+
 /*
  * log-tree.c uses DIFF_OPT_TST for determining whether to use color
  * for showing the commit sha1, use the same check for --decorate
diff --git a/log-tree.h b/log-tree.h
index 3f7b400..5c4cf7c 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -7,6 +7,7 @@ struct log_info {
 	struct commit *commit, *parent;
 };
 
+int parse_decorate_color_config(const char *var, const int ofs, const char *value);
 void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
-- 
1.7.1.245.g7c42e.dirty
