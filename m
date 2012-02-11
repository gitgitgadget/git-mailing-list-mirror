From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Fri, 10 Feb 2012 18:16:55 -0800
Message-ID: <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com,
	jasampler@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 11 03:18:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw2Xf-0003Cj-Ec
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 03:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758294Ab2BKCRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 21:17:40 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35436 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2BKCRP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 21:17:15 -0500
Received: by mail-qy0-f174.google.com with SMTP id w6so2034153qcq.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 18:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=52UpIDr8EeSWHKG22wyi3OGxvin+qK+ACLQDQC3Hw/0=;
        b=YexjcOztGHrhv4fBghpsNhc85Gv7dfvsygR5bows53abmkL5BQFigu4X7I4T8d5XhJ
         KpKxRwy8Y4RoupAa797uVGJ6AJjMXSysDNMsODzJT778DMG/RU8X92TcQdaNmPHihvH/
         XedqwzDSKDPkdxPRp7xEXC/xlyNqK+TolEmTA=
Received: by 10.224.95.196 with SMTP id e4mr1523178qan.63.1328926635159;
        Fri, 10 Feb 2012 18:17:15 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id fd1sm16844239qab.1.2012.02.10.18.17.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 18:17:14 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120210185516.GA4903@tgrennan-laptop>
References: <20120210185516.GA4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190479>

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 refs.c |   14 ++++++++++++++
 refs.h |    8 ++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index b8843bb..b42eb4a 100644
--- a/refs.c
+++ b/refs.c
@@ -1057,6 +1057,20 @@ int refname_match(const char *abbrev_name, const char *full_name, const char **r
 	return 0;
 }
 
+int refname_match_patterns(const char **patterns, const char *refname)
+{
+	int given_match_pattern = 0, had_match = 0;
+
+	for (; *patterns; patterns++)
+		if (**patterns != '!') {
+			given_match_pattern = 1;
+			if (!fnmatch(*patterns, refname, 0))
+				had_match = 1;
+		} else if (!fnmatch(*patterns+1, refname, 0))
+			return 0;
+	return given_match_pattern ? had_match : 1;
+}
+
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
diff --git a/refs.h b/refs.h
index 00ba1e2..13015ba 100644
--- a/refs.h
+++ b/refs.h
@@ -152,4 +152,12 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
+/**
+ * Returns:
+ *   1 with NULL patterns
+ *   0 if refname fnmatch()es any ! prefaced pattern
+ *   1 if refname fnmatch()es any pattern
+ */
+extern int refname_match_patterns(const char **patterns, const char *refname);
+
 #endif /* REFS_H */
-- 
1.7.8
