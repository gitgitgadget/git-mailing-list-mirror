From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 2/5] refs: add ref_type function
Date: Fri, 31 Jul 2015 02:06:18 -0400
Message-ID: <1438322781-21181-2-git-send-email-dturner@twopensource.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 08:06:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL3Sl-00029o-01
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 08:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbbGaGGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 02:06:31 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33705 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbGaGGa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 02:06:30 -0400
Received: by qged69 with SMTP id d69so39577199qge.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 23:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KCq3dVyz1camglJSDvGada4GbaXX9n++xAFZxxGGVo0=;
        b=W9bpkbEd6iRsHeJaWkNgja99G9tSmLKl0gXDqkwUsqRIM7NibX2tHiXMiNiWlG6yQM
         G+WT2/YmFHjPa6jhwVhRo5WqsTmGUfmIcYUKieDIRQoOJItZoKOaJspvNL/xlQjRpoQ/
         GYCARsEf2dWrbOPcmxN/udFPCEckPSmVyNugyadohXdO1XFODz7lGIQI0G+mfy2ScbfJ
         srBPr39Ea+SdIyLWjpvQTICaQkLYa1qGppnlQh6lrIuSpB5rPcqNV8GYgBYGDl1gzcXA
         oVrqSUc+2Zx3h3kpMVpc8vFejxyOHzWwoYiG87gElHK+QVWsDdWyFS8ns/gAFU86bmeX
         FwYA==
X-Gm-Message-State: ALoCoQm7lpQLIIgeqEsWGgqNbwhiOB0irVQYYmXtlqM+vxUWCbfN0nTsnhqeszJVff3zgunc7c0w
X-Received: by 10.140.108.6 with SMTP id i6mr1511690qgf.73.1438322790108;
        Thu, 30 Jul 2015 23:06:30 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id c35sm1737073qgc.47.2015.07.30.23.06.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 23:06:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275037>

Add a function ref_type, which categorizes refs as per-worktree,
pseudoref, or normal ref.

Later, we will use this in refs.c to treat pseudorefs specially.
Alternate ref backends may use it to treat both pseudorefs and
per-worktree refs differently.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 26 ++++++++++++++++++++++++++
 refs.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/refs.c b/refs.c
index 0b96ece..0f87884 100644
--- a/refs.c
+++ b/refs.c
@@ -2848,6 +2848,32 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
+static int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD");
+}
+
+static int is_pseudoref_syntax(const char *refname)
+{
+	const char *c;
+
+	for (c = refname; *c; c++) {
+		if (!isupper(*c) && *c != '-' && *c != '_')
+			return 0;
+	}
+
+	return 1;
+}
+
+enum ref_type ref_type(const char *refname)
+{
+	if (is_per_worktree_ref(refname))
+		return REF_TYPE_PER_WORKTREE;
+	if (is_pseudoref_syntax(refname))
+		return REF_TYPE_PSEUDOREF;
+       return REF_TYPE_NORMAL;
+}
+
 int delete_ref(const char *refname, const unsigned char *old_sha1,
 	       unsigned int flags)
 {
diff --git a/refs.h b/refs.h
index e4e46c3..dca4fb5 100644
--- a/refs.h
+++ b/refs.h
@@ -445,6 +445,14 @@ extern int parse_hide_refs_config(const char *var, const char *value, const char
 
 extern int ref_is_hidden(const char *);
 
+enum ref_type {
+	REF_TYPE_PER_WORKTREE,
+	REF_TYPE_PSEUDOREF,
+	REF_TYPE_NORMAL,
+};
+
+enum ref_type ref_type(const char *refname);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.0.4.315.gad8727a-twtrsrc
