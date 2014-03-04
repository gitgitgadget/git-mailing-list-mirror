From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH] RFC: make --set-upstream work for branches not in refs/heads/
Date: Tue,  4 Mar 2014 15:07:26 +0100
Message-ID: <1393942046-11488-2-git-send-email-krzesimir@endocode.com>
References: <1393942046-11488-1-git-send-email-krzesimir@endocode.com>
Cc: Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 15:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKq0x-00037E-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 15:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290AbaCDOID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 09:08:03 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:62003 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaCDOIB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 09:08:01 -0500
Received: by mail-bk0-f47.google.com with SMTP id w10so224854bkz.20
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 06:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6zHJUR6xhXRG68OSBSyNB82SVt4uee2lrU9qAIPHRM=;
        b=Xgq6x9JrE0Dl8Yb/whjYO1yGB+KyCJy37OaYXEQEEH+boYa5plfpLTBbNBYnM0Iv9I
         GJ1XU2KSbr3yP+QH/oTf5J9+EG6srZsS4s6rS6rbcoNqBloq3Zf7X32uVhAo3PyMjoiS
         6chHETRWK8qD9IWELdtLuemmHLbUIJUrXLUGu0oeJM13EU8OzsGWpUtVZ47vrp05H/hg
         dJ4WOfj03O3sMrmUwEDAE0yJzvPOlTAu33tqA+YkoRLL/JnaUKU9AWN2mbqMFEAPJy3L
         +Mz97evN45GckscomHegXYZ4KUq/tGMdAPA0RzsDicqQL9Z7a2gWBZuVWg0f61nzn4Ls
         JLDQ==
X-Gm-Message-State: ALoCoQlc66vnTS6X4RgBdHw2gi3Lz6EIh0W+oI7ArCFrIUHaGhm06CzgclFOooV5WRaMNF6SGkWs
X-Received: by 10.204.108.68 with SMTP id e4mr779909bkp.94.1393942079649;
        Tue, 04 Mar 2014 06:07:59 -0800 (PST)
Received: from localhost.localdomain (p57923D4E.dip0.t-ipconnect.de. [87.146.61.78])
        by mx.google.com with ESMTPSA id r1sm1342213bkk.2.2014.03.04.06.07.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Mar 2014 06:07:58 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1393942046-11488-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243344>

---
 transport.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/transport.c b/transport.c
index ca7bb44..ac933ee 100644
--- a/transport.c
+++ b/transport.c
@@ -143,6 +143,25 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 	}
 }
 
+/* That of course should not be hardcoded. */
+static const char* list_of_local_refs[] = {"refs/heads/", "refs/wip/", NULL};
+static const char** get_local_refs(void)
+{
+	return list_of_local_refs;
+}
+
+static int is_local_ref(const char *ref)
+{
+	const char **local_refs = get_local_refs();
+	const char **iter;
+
+	for (iter = local_refs; iter != NULL; ++iter)
+		if (starts_with(ref, *iter))
+			return strlen(*iter);
+
+	return 0;
+}
+
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
 {
@@ -153,6 +172,8 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		const char *remotename;
 		unsigned char sha[20];
 		int flag = 0;
+		int localadd = 0;
+		int remoteadd = 0;
 		/*
 		 * Check suitability for tracking. Must be successful /
 		 * already up-to-date ref create/modify (not delete).
@@ -169,23 +190,29 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		localname = ref->peer_ref->name;
 		remotename = ref->name;
 		tmp = resolve_ref_unsafe(localname, sha, 1, &flag);
-		if (tmp && flag & REF_ISSYMREF &&
-			starts_with(tmp, "refs/heads/"))
-			localname = tmp;
+
+		if (tmp && flag & REF_ISSYMREF) {
+			localadd = is_local_ref (tmp);
+			if (localadd > 0)
+				localname = tmp;
+		}
+		if (localadd == 0)
+			localadd = is_local_ref(localname);
+		remoteadd = is_local_ref(remotename);
 
 		/* Both source and destination must be local branches. */
-		if (!localname || !starts_with(localname, "refs/heads/"))
+		if (!localname || localadd == 0)
 			continue;
-		if (!remotename || !starts_with(remotename, "refs/heads/"))
+		if (!remotename || remoteadd == 0)
 			continue;
 
 		if (!pretend)
 			install_branch_config(BRANCH_CONFIG_VERBOSE,
-				localname + 11, transport->remote->name,
+				localname + localadd, transport->remote->name,
 				remotename);
 		else
 			printf("Would set upstream of '%s' to '%s' of '%s'\n",
-				localname + 11, remotename + 11,
+				localname + localadd, remotename + remoteadd,
 				transport->remote->name);
 	}
 }
-- 
1.8.3.1
