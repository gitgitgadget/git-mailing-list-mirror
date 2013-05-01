From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] remote.c: teach branch_get() to treat symrefs other than HEAD
Date: Wed,  1 May 2013 21:50:34 +0530
Message-ID: <1367425235-14998-5-git-send-email-artagnon@gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 18:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXZlu-0006cT-BM
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 18:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761500Ab3EAQUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 12:20:38 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:57606 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761433Ab3EAQUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 12:20:35 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so721713dan.10
        for <git@vger.kernel.org>; Wed, 01 May 2013 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UDU+rG2eAnuLJMjqVhXMdR6hYFIbG/QmKaaTuD+4q4Q=;
        b=zrMzFlZxMDedWeax1qUSPn8yHU3pbU0oHrROZ6LAgc7fLECfcCJCcxfupuLFVtzKBZ
         ++FUbAH0wejIkfTdGbsDzARFuLMlwZNuVPNb3+4JtZz+kWjjqTPHySjWbcK8n8hepSUH
         XMEaELHHvkOgDRW1DjPETTk/xEU+CVg5Pul74gvIDHTirpFEBjUpGZph5t7GG20QRgbu
         ps4LN5zLWYbOkNZOiraa6BJnHt143xkU0yEQLP0ERwKKCZYsJRqtwoAc09MnsX7f5hPE
         0lNO2ONpiXyq5PU7dM6/xTrWdfJZ7hfj5gPpMbfZkHHFKWKwaZs33ttXTUKXOHlUYH3m
         Ralg==
X-Received: by 10.66.248.105 with SMTP id yl9mr5604746pac.159.1367425234592;
        Wed, 01 May 2013 09:20:34 -0700 (PDT)
Received: from localhost.localdomain ([122.164.132.210])
        by mx.google.com with ESMTPSA id sg4sm3549741pbc.7.2013.05.01.09.20.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 09:20:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.24.g6456091
In-Reply-To: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223098>

Currently, branch_get() either accepts either a branch name, empty
string, or the magic four-letter word "HEAD".  Make it additionally
handle symbolic refs that point to a branch.

Update sha1_name.c:interpret_branch_name() to look for "@{", not '@'
(since '@' is a valid symbolic ref).

These two changes together make the failing test in t1508
(at-combinations) pass.  In other words, you can now do:

    $ git symbolic-ref @ HEAD

And expect the following to work:

    $ git rev-parse @@{u}

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c                   | 14 ++++++++++++++
 sha1_name.c                |  2 +-
 t/t1508-at-combinations.sh |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 68eb99b..0f44e2e 100644
--- a/remote.c
+++ b/remote.c
@@ -1470,6 +1470,20 @@ struct branch *branch_get(const char *name)
 		ret = current_branch;
 	else
 		ret = make_branch(name, 0);
+
+	if (name && *name && (!ret || !ret->remote_name)) {
+		/* Is this a symref pointing to a valid branch, other
+		 * than HEAD?
+		 */
+		const char *this_ref;
+		unsigned char sha1[20];
+		int flag;
+
+		this_ref = resolve_ref_unsafe(name, sha1, 0, &flag);
+		if (this_ref && (flag & REF_ISSYMREF) &&
+			!prefixcmp(this_ref, "refs/heads/"))
+			ret = make_branch(this_ref + strlen("refs/heads/"), 0);
+	}
 	if (ret && ret->remote_name) {
 		ret->remote = remote_get(ret->remote_name);
 		if (ret->merge_nr) {
diff --git a/sha1_name.c b/sha1_name.c
index f30e344..c4a3a54 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1060,7 +1060,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 		return ret - used + len;
 	}
 
-	cp = strchr(name, '@');
+	cp = strstr(name, "@{");
 	if (!cp)
 		return -1;
 	tmp_len = upstream_mark(cp, namelen - (cp - name));
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index efa2a2a..73c457d 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -59,7 +59,7 @@ nonsense "HEAD@{-1}"
 git symbolic-ref @ HEAD
 check "@@{1}" new-one
 check "@@{now}" new-two
-check "@@{u}" upstream-two failure
+check "@@{u}" upstream-two
 nonsense "@@{-1}"
 
 test_done
-- 
1.8.3.rc0.24.g6456091
