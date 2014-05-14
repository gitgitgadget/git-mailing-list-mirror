From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 12/42] replace.c: use the ref transaction functions for updates
Date: Wed, 14 May 2014 14:16:46 -0700
Message-ID: <1400102236-30082-13-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgbq-0000qe-0U
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbaENVUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:20:54 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:41490 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbaENVRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:24 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so33808veb.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pbk4hgXosbffB6wqSoRl8jpCH2kHogfC3J4WhAm8qko=;
        b=Ap2HxVEQ1AT8fB9npFSDih1gOXfWH8gApwT1IuIpnExax/iF4lHij++9bqWyc9/aMe
         Y+x7CduyJbiNaj0liBynf323INr5rSIB+BclS+SLdnm2dgqKerHJd+tAPoU+sjKtsn2A
         lXbuiDNoz9yPa9//G5uZ6V2tt5gCYTwVqhMtxQUmog4OlSmdBKpS1nlJGYsoQ9VOJA1t
         RMZ/U7mEQlQVWNj7h+Du0bbunfOfdI4ACaKqXeIGlVVc4Vzs/csA3FScVMsMxr/gdcpG
         AhRE3UY33K2uuYFlMzOz7j7tKBiSrH1qaCNMe267ljQ21HfB8Kk/MlWXuVMyMiHYbQvG
         FNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pbk4hgXosbffB6wqSoRl8jpCH2kHogfC3J4WhAm8qko=;
        b=dhS4qjxDI/Sz5Ud3Zbi6ynCVzE4Qw6CJqm1X1AzNh+0JHqBR7b9lmC1jHlxCJgsDMf
         /Et77vxB3+xZHQlKWldjJqsVfMTnRyAizbSwHGzTZfMf+HmFD9RFOlv+9p2Kx4H4DCvV
         qSUsLZJYWojVIo+XeztDSAzQgAMQ/01oEM8y4Lw6pmt2T3XA7O/E0Xq0Um1wXkyK6zK+
         2YqDH8Nh83HPKdVzTHohWbp3l51NsHs9TYqcYkJCFI0LNiJ2PGJU8KekOfv0tqC5W6Ke
         7qcadaORsNz3XRIjJjqsKCSmP/68N1VFtp6CuXABL17a1Y2QZ5tJdM9t0Ec0kD/6B53Q
         uuLw==
X-Gm-Message-State: ALoCoQlaUnp7cmh8llEk/6L0c9lDPyronGIgwF1NgU1TCp544tNp0QDFluOtPZC0LliiiZoR2B4/
X-Received: by 10.58.178.232 with SMTP id db8mr3111042vec.21.1400102243968;
        Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si144158yhl.7.2014.05.14.14.17.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CDFE55A433E;
	Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9366FE0973; Wed, 14 May 2014 14:17:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248986>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 3da1bae..11dc2e1 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -133,7 +133,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (snprintf(ref, sizeof(ref),
 		     "refs/replace/%s",
@@ -156,11 +157,12 @@ static int replace_object_sha1(const char *object_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev)) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
 	return 0;
 }
-- 
2.0.0.rc3.471.g2055d11.dirty
