From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 05/16] revision: allow setting custom limiter function
Date: Tue, 25 Jun 2013 01:23:02 +0200
Message-ID: <1372116193-32762-6-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7E-0003Il-Mp
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab3FXXXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:23:52 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:41287 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab3FXXXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:49 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq4so185029wib.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3X7sJ5sfgUlri/sZSpOn9OcKqerGoqiXgUmYLtsDkWU=;
        b=qh2vI6+15YPoDgBUFfRMQQHswfwvu9pL3GHICSTcHvrQWR53uwQJWVLvI57HsbPijk
         rDd/ukF7q7Kxane08oK2hOsZ/sYwDX9bifYCuM3ZDhYOIGk5hq1FsZGuZgg8Y2ww7efP
         PF8eJXmr3mb2cfrBvUsTEbZu1apIZf2YraZCQzT0P1ZSEKh+TyAGKqOiX7Wmc/e4QzBo
         YobhF/v4a47memQUNpaXAlkmUO+2mSPxpK6qRkxWKhs2Ey4SBWhztll4j2bRUAZOyoWu
         Hibt8sWQ1KoygozGyCDMtrO2vBgG+P5aAG3qx7e/wqhScHB2HGQQIhgdjGFkzI/kqNzm
         nN9A==
X-Received: by 10.180.76.206 with SMTP id m14mr3728918wiw.38.1372116228318;
        Mon, 24 Jun 2013 16:23:48 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228925>

This commit enables users of `struct rev_info` to peform custom limiting
during a revision walk (i.e. `get_revision`).

If the field `include_check` has been set to a callback, this callback
will be issued once for each commit before it is added to the "pending"
list of the revwalk. If the include check returns 0, the commit will be
marked as added but won't be pushed to the pending list, effectively
limiting the walk.
---
 revision.c |    5 +++++
 revision.h |    2 ++
 2 files changed, 7 insertions(+)

diff --git a/revision.c b/revision.c
index f1bb731..fa78c65 100644
--- a/revision.c
+++ b/revision.c
@@ -777,8 +777,13 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 
 	if (commit->object.flags & ADDED)
 		return 0;
+
 	commit->object.flags |= ADDED;
 
+	if (revs->include_check &&
+		!revs->include_check(commit, revs->include_check_data))
+		return 0;
+
 	/*
 	 * If the commit is uninteresting, don't try to
 	 * prune parents - we want the maximal uninteresting
diff --git a/revision.h b/revision.h
index eeea6fb..997a093 100644
--- a/revision.h
+++ b/revision.h
@@ -162,6 +162,8 @@ struct rev_info {
 	unsigned long min_age;
 	int min_parents;
 	int max_parents;
+	int (*include_check)(struct commit *, void *);
+	void *include_check_data;
 
 	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
-- 
1.7.9.5
