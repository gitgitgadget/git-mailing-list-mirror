From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/7] sha1_name: implement finding @{push}
Date: Thu, 23 May 2013 20:42:50 +0530
Message-ID: <1369321970-7759-8-git-send-email-artagnon@gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 23 17:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXB5-0003im-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308Ab3EWPLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:11:25 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49685 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759254Ab3EWPLX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:11:23 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2891412pdj.1
        for <git@vger.kernel.org>; Thu, 23 May 2013 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EYp5GDyWca1B4PfNWuWAUMIEieIfy2eRk3qj1hctcb8=;
        b=cjlduIAmv52BwG8HDyHxrXrpHa7ljUJToHU6SqR7OP0txO2jc6MQ2FKAidR6ys9C4d
         gkN9d/yoWkAwUIAGAMxtQonHdugKX4XZuLp5nAa6Ou+rJ7XcW3uMzsnxRJY6hFGv9Xf+
         ZuZHzwHsIJQUxrZ/Cru3cuXcM1tnpb3Bm+V+f18Cn7TfB6gJoD+wen5PyggpriARctKq
         ii6r9YFHyMoLObIxf8ZMKh1VWzFExAKOXKlmnbQvqXsEADcqLYpS7ExzuA2bF15uUCCm
         OMlnCG1jB0f79BQmhoHKQ6qSPZknMsNys9EfWGeDtauTVdtBXWLVRUim5bdMuDLjC3Jc
         KpXw==
X-Received: by 10.68.13.168 with SMTP id i8mr13449232pbc.86.1369321882631;
        Thu, 23 May 2013 08:11:22 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vb8sm12099173pbc.11.2013.05.23.08.11.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 08:11:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225259>

Try this now: configure your current branch's pushremote to push to
"refs/heads/*:refs/heads/rr/*".  Now, type 'git show @{p}'.  Voila!

It currently only works when:

1. remote.<name>.push is explicitly specified.
2. There is a pattern to match (*).

Proof-of-concept only.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 5f6958b..283d538 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1008,6 +1008,24 @@ static void die_no_upstream(struct branch *upstream, char *name) {
 	}
 }
 
+static void find_push_ref(struct branch *branch) {
+	struct remote *remote = pushremote_get(NULL);
+	const struct refspec *pat = NULL;
+	char raw_ref[PATH_MAX];
+	struct ref *this_ref;
+	char *dst_name;
+	int len;
+
+	sprintf(raw_ref, "refs/heads/%s", branch->name);
+	len = strlen(raw_ref) + 1;
+	this_ref = xcalloc(1, sizeof(*this_ref) + len);
+	memcpy(this_ref->name, raw_ref, len);
+
+	dst_name = get_ref_match(remote->push, remote->push_refspec_nr,
+				this_ref, MATCH_REFS_ALL, 0, &pat);
+	printf("dst_name = %s\n", dst_name);
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -1085,6 +1103,8 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 		cp = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
 		break;
 	case AT_KIND_PUSH:
+		find_push_ref(branch);
+		die("Done!");
 		break;
 	}
 
-- 
1.8.3.rc3.17.gd95ec6c.dirty
