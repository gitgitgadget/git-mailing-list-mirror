From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 15/23] builtin-remote: make get_remote_ref_states() always populate states.tracked
Date: Tue, 24 Feb 2009 04:51:03 -0500
Message-ID: <1c2c1a61e4add51c8a7d748c72365af651aac94f.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu0A-0002Ej-68
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbZBXJwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbZBXJwn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:52:43 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:21822 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbZBXJvx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:53 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005599yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=tOTO98OZgD1t6PIH2fIjIdkhUSL3cuQO96XfG2+0dVM=;
        b=wSEVP+wiJxAnwYNwTjsOGFNegl1IUTt9EKdHOgVc8l8Nkc90xS+mclnMbP5MP9XZZN
         v4oLr2UvKQvCK+JIjEUqweHPUgbDZ+fLxt38veoRFLanMCdOaCx1MpzxeZNu7ol8lHa3
         CYCetaDKpi/pcuiESZP4nFZb/4mr9EGO/W2oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eO8rP176f26zyMI2pJfLNiLzYZOAE4zk8S76WfY8Gv7ZgCrKu9sD6QEcbmbvqceNRa
         lKabfwKciljvNKURcjmk5YlNvYbYaWUXW0mHFVLGwZbGKiojA51dLiADhHk58WRe4WJX
         WkEN0R8oq/6oqA+7p80G5tylhPqZA+63J77TI=
Received: by 10.100.207.14 with SMTP id e14mr2976143ang.128.1235469112268;
        Tue, 24 Feb 2009 01:51:52 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c9sm1718507ana.53.2009.02.24.01.51.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:51 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111264>

When not querying the remote, show() was having to populate
states.tracked itself. It makes more sense for get_remote_ref_states()
to do this consistently. Since show() is the only caller of
get_remote_ref_states() with query=0, this change does not affect the
other call sites.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   41 ++++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index cb56565..5ef8163 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -656,6 +656,23 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->heads, 0);
 }
 
+static int append_ref_to_tracked_list(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct ref_states *states = cb_data;
+	struct refspec refspec;
+
+	if (flags & REF_ISSYMREF)
+		return 0;
+
+	memset(&refspec, 0, sizeof(refspec));
+	refspec.dst = (char *)refname;
+	if (!remote_find_tracking(states->remote, &refspec))
+		string_list_append(abbrev_branch(refspec.src), &states->tracked);
+
+	return 0;
+}
+
 static int get_remote_ref_states(const char *name,
 				 struct ref_states *states,
 				 int query)
@@ -677,28 +694,14 @@ static int get_remote_ref_states(const char *name,
 
 		get_head_names(remote_refs, name, states);
 		get_ref_states(remote_refs, states);
+	} else {
+		for_each_ref(append_ref_to_tracked_list, states);
+		sort_string_list(&states->tracked);
 	}
 
 	return 0;
 }
 
-static int append_ref_to_tracked_list(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct ref_states *states = cb_data;
-	struct refspec refspec;
-
-	if (flags & REF_ISSYMREF)
-		return 0;
-
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst = (char *)refname;
-	if (!remote_find_tracking(states->remote, &refspec))
-		string_list_append(abbrev_branch(refspec.src), &states->tracked);
-
-	return 0;
-}
-
 static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0;
@@ -757,10 +760,6 @@ static int show(int argc, const char **argv)
 				"prune')", &states.stale, "");
 		}
 
-		if (no_query) {
-			for_each_ref(append_ref_to_tracked_list, &states);
-			sort_string_list(&states.tracked);
-		}
 		show_list("  Tracked remote branch%s", &states.tracked, "");
 
 		if (states.remote->push_refspec_nr) {
-- 
1.6.2.rc1.291.g83eb
