From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 8/9] sha1_name.c: fix @-parsing bug in interpret_branch_name()
Date: Thu,  2 May 2013 19:09:33 +0530
Message-ID: <1367501974-6879-9-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtio-0002b0-Hl
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759652Ab3EBNij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:39 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41960 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759379Ab3EBNiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so360556pde.18
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UCtxwjslmUHf8rHf3jJbtEXHs89KkDmMAp4l24JQaMA=;
        b=EG+AedqpLdHvax/OsOUzsN/1+baJFZzZgMNNTwKqg5U3Qx/PLkJoFdD/s9UEVhFY+c
         OKuHJnG8tRKGJA/HeDtORW2EKccVy0tX9adbao2+DoCJXZ5FNuscTZ/tGCFcN0Ou5qu0
         2BJT/XDbQHM3vFv3jO7u0Fb/2jY2b6SV0XZkm6n3nF2bluXsYpjQELR12D5KUmvGWM4L
         7PmuO3TrURv/Q87qs/964qsdSjQl/6KofPDWbJMs0k8XG5TkpHHxcWtYSavdB1wddAxY
         +qAMYSKNMWMXC0O1AsP1HPFcBTn106kNCm0y4kr+h1ExeLq3BCU9vo5PiQNeNSIH7ajd
         BaIA==
X-Received: by 10.68.59.167 with SMTP id a7mr8910424pbr.94.1367501901352;
        Thu, 02 May 2013 06:38:21 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223206>

Symbolic refs work in the general case, but making @ a symbolic-ref
doesn't work due to a parsing bug in interpret_branch_name().  Update
the function to parse "@{", not '@' (since '@' is a valid symbolic
ref).

This makes a failing test in t1508 (at-combinations) pass.  In other
words, you can now do:

    $ git symbolic-ref @ HEAD

And expect the following to work:

    $ git rev-parse @@{u}

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c                | 2 +-
 t/t1508-at-combinations.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..850e6d7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1019,7 +1019,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 		return ret - used + len;
 	}
 
-	cp = strchr(name, '@');
+	cp = strstr(name, "@{");
 	if (!cp)
 		return -1;
 	tmp_len = upstream_mark(cp, namelen - (cp - name));
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 424caf5..6a69f9e 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -70,7 +70,7 @@ check "H@{u}" refs/heads/upstream-branch
 git symbolic-ref @ HEAD
 check "@@{1}" commit new-one
 check "@@{now}" commit new-two
-check "@@{u}" ref refs/heads/upstream-branch failure
+check "@@{u}" refs/heads/upstream-branch
 
 # Document differences between @{N} and HEAD@{N}.  The former resolves
 # HEAD to a branch and looks up the logs for that branch, while the
-- 
1.8.3.rc0.40.g09a0447
