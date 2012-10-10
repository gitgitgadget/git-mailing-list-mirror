From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] log: honor grep.* configuration
Date: Wed, 10 Oct 2012 00:55:14 -0700
Message-ID: <1349855714-17008-8-git-send-email-gitster@pobox.com>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 09:56:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLr9C-0000lc-HU
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab2JJHzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:55:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab2JJHzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:55:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B41056FB6
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ls+4
	81kfnNsLxpF1msxth+ecMa4=; b=uG6gkqLKM/uigkWySWOe2tlFwqnKhgkBUtHk
	srk5vtmmWd+EuQUoxE/r15x2MssaTWvZHaCty80F6sGNNxKrvmp+LrQjGi36KhfK
	evckiPvi8vKSyoiLQhBJGC0DRziM02oHAEpJB+JWhXZISbofCgZ2aeU+L+ha8pbn
	r++kRwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fnRhXB
	kB7xl2TxufuW6ac5P7Am6qiXrrOG/rQmYnKHG0lwLO5VRafGGTgSPQ9bf6X1a3yT
	cQ4CfA/4z8+VtaMzJD0bOqu6HoEwSKYmvaAwung2Agl7PhA6xiXYF2OD2kxE02JI
	+27nG7J0L6IexOpHVQV1wi1XSM/u8Boc2o2Io=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B566FB5
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F55F6FB2 for
 <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:48 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc1.76.g5a375e6
In-Reply-To: <1349855714-17008-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E7B7C392-12AF-11E2-9086-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207379>

Now the grep_config() callback is reusable from other configuration
callbacks, call it from git_log_config() so that grep.patterntype
and friends can be used with the commands in the "git log" family.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 09cf43e..e7b7db1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -351,7 +351,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	}
 	if (!prefixcmp(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
-
+	if (grep_config(var, value, cb) < 0)
+		return -1;
 	return git_diff_ui_config(var, value, cb);
 }
 
@@ -360,6 +361,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
+	init_grep_defaults();
 	git_config(git_log_config, NULL);
 
 	init_revisions(&rev, prefix);
@@ -450,6 +452,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	struct pathspec match_all;
 	int i, count, ret = 0;
 
+	init_grep_defaults();
 	git_config(git_log_config, NULL);
 
 	init_pathspec(&match_all, NULL);
@@ -530,6 +533,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
+	init_grep_defaults();
 	git_config(git_log_config, NULL);
 
 	init_revisions(&rev, prefix);
@@ -552,6 +556,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
+	init_grep_defaults();
 	git_config(git_log_config, NULL);
 
 	init_revisions(&rev, prefix);
@@ -1121,6 +1126,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_hdr.strdup_strings = 1;
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
+	init_grep_defaults();
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
-- 
1.8.0.rc1.76.g5a375e6
