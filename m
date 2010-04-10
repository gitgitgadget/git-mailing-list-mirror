From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] wt-status: collect ignored files
Date: Sat, 10 Apr 2010 00:40:54 -0700
Message-ID: <1270885256-31589-4-git-send-email-gitster@pobox.com>
References: <1270885256-31589-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 09:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VJj-0000KR-CW
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab0DJHlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:41:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab0DJHlH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:41:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AC89A9552
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=SACG
	KYbcpoozaKASQR+v5GoDlgw=; b=AAnQ34SpEzjHF0snbhYat2qPSvCaGUHGm3/6
	UhKLYToPpTSAbXVz0FtjS48EZ2YZSJhxCouiKcIGImU5gReu2qSrMwWOhmC0r2wp
	cQN76tglclrQcwNtrUwU6i6/LdeeLf1yyXHOwXGqLDXJiUY+o8t7R7KwSdU409X4
	jcZbDM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NOzt2v
	VKP60E70jGNNArlkg52Jp6Pkz/Ah/CZAfGR31YP+E9wi8BdrBCY1IBSLYgW80Z/e
	K5anljUF+8jyA4TLAItw8xSfV7/NYVVCmex6WCFbIFBUlF/LliGVbBUGJDqr6Pyo
	xCa0tpT9VJKGkATCqc6RT6TPwZ847WM3WHZWA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13F8BA9551
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D170EA9550 for
 <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc0.264.g94f6e
In-Reply-To: <1270885256-31589-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6C39F14C-4474-11DF-9572-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144526>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |   16 ++++++++++++++++
 wt-status.h |    2 ++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c88159a..f13c7da 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -42,6 +42,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->index_file = get_index_file();
 	s->change.strdup_strings = 1;
 	s->untracked.strdup_strings = 1;
+	s->ignored.strdup_strings = 1;
 }
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
@@ -382,6 +383,21 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		free(ent);
 	}
 
+	if (s->show_ignored_files) {
+		dir.nr = 0;
+		dir.flags = DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
+		fill_directory(&dir, s->pathspec);
+		for (i = 0; i < dir.nr; i++) {
+			struct dir_entry *ent = dir.entries[i];
+			if (!cache_name_is_other(ent->name, ent->len))
+				continue;
+			if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+				continue;
+			string_list_insert(ent->name, &s->ignored);
+			free(ent);
+		}
+	}
+
 	free(dir.entries);
 }
 
diff --git a/wt-status.h b/wt-status.h
index 2c49f46..1093e65 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -41,6 +41,7 @@ struct wt_status {
 	int use_color;
 	int relative_paths;
 	int submodule_summary;
+	int show_ignored_files;
 	enum untracked_status_type show_untracked_files;
 	char color_palette[WT_STATUS_UNMERGED+1][COLOR_MAXLEN];
 
@@ -52,6 +53,7 @@ struct wt_status {
 	const char *prefix;
 	struct string_list change;
 	struct string_list untracked;
+	struct string_list ignored;
 };
 
 void wt_status_prepare(struct wt_status *s);
-- 
1.7.1.rc0.264.g94f6e
