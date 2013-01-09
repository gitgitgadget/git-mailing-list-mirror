From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 04/19] reset: don't allow "git reset -- $pathspec" in bare repo
Date: Wed,  9 Jan 2013 00:16:01 -0800
Message-ID: <1357719376-16406-5-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqqw-000285-Qv
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371Ab3AIIRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:07 -0500
Received: from mail-qc0-f202.google.com ([209.85.216.202]:35286 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842Ab3AIIRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:05 -0500
Received: by mail-qc0-f202.google.com with SMTP id s25so194535qcq.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=0MkvrIULzeoFrGYsCMGEtjNdrKBB8F9wDC1La7Pd75E=;
        b=dbfOYeHO95xdOB8eU66Fd99k0VU2uy67uHdXBCmXbSJpVTby4fo7Z/tQBByzTEVc06
         9VO2yFuX/W+wUoG3xvlMWNhC2QQM9ZLhYlMunBvmg3nLTH4/LHXWYjFrRoiPriFnygWv
         8WBbQgZK9suBaeejonH+CbyHiAGLcZCMJtGraExV5i6zJjnBLRv6vN9mBIi4TTRHpMCV
         UI8NbU5hin1KQZ83dGKD3rtI4JNfw1D4SQHqpZ2vhZrAE1Rpzyq1qGP8e/X8grZheOgY
         Anw766x2N2o1ouvbnVwyCgaiMzK7dhlAA6A72tw7DtHz0qMXzFuhnjxZFMUfNpjQGu+T
         j/LQ==
X-Received: by 10.236.124.238 with SMTP id x74mr32375650yhh.13.1357719424335;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id p19si5739601yhi.1.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 3D70C820050;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id E6F2F102DA9; Wed,  9 Jan 2013 00:17:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmE7LCPwO5NIx5uaYrF0bmUu9zLH91Y9ECEQkqOs24Ou0mgYB0RisgrwQ9hDpPxUAN/fF3fbQmgL3V0lfSigYvo8cDOWQ7Cx5j2axYgjh1x/OanNvqZyrdGX8+oS9Qa23gWyeRtJHrjl1Sgjf68eOFbZsB5SHS+Dd27kkcAckyOkQ0j8V8rhQgas2XjexZIOZunZTWk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213033>

---
 builtin/reset.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 045c960..664fad9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -295,8 +295,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		else if (reset_type != NONE)
 			die(_("Cannot do %s reset with paths."),
 					_(reset_type_names[reset_type]));
-		return read_from_tree(pathspec, sha1,
-				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
@@ -308,6 +306,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
+	if (pathspec)
+		return read_from_tree(pathspec, sha1,
+				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
-- 
1.8.1.rc3.331.g1ef2165
