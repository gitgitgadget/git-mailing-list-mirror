From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 3/4] git-commit: only append a newline to -m mesg if necessary
Date: Mon, 18 Feb 2013 20:17:06 -0800
Message-ID: <1361247427-438-3-git-send-email-drafnel@gmail.com>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 05:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7eeO-0002Zh-DV
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 05:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344Ab3BSERX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 23:17:23 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:38484 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3BSERW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 23:17:22 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so2015892pbb.27
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 20:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fH26G4nIq+rdlB9HYzRo8pXRNnCr6Bc9YqLC5VJ4r8o=;
        b=wmS/C3xyLARnvIh0fYG6ey5Jp9WN+7CSHQEbW+VsnvLd3Vx/rxpU3g8uFqQiDQaXyZ
         3fuLCuElf9Mvsoit4eZP8C7peeW7OypQLqoHGPHdI8GhJHYIy/2qKyqzo9mE/OrObEUN
         4q2xa4yng5b+IzTyAIy4RGd73Qc9kgICTDZnsmGGDlCJAkbVwipFhFhq5NSHsQTxxNPs
         6yw0mnXlxnfQh5KPI7HW38yEJrSupNVvRomsktb9n0ESr68/CwoBj6CwN2DIxq9yo9cc
         MNFCLjFNE7PzJnWtytwgKARhJEDd7bpmHNeuVPSC56vEMoDodstCrJwlVHaMqzOW0CZl
         ALXw==
X-Received: by 10.68.41.229 with SMTP id i5mr36391280pbl.62.1361247441458;
        Mon, 18 Feb 2013 20:17:21 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id ax3sm16558271pbd.42.2013.02.18.20.17.19
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 20:17:20 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.638.g372f416.dirty
In-Reply-To: <1361247427-438-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216559>

Currently, git will append two newlines to every message supplied via
the -m switch.  The purpose of this is to allow -m to be supplied
multiple times and have each supplied string become a paragraph in the
resulting commit message.

Normally, this does not cause a problem since any trailing newlines will
be removed by the cleanup operation.  If cleanup=verbatim for example,
then the trailing newlines will not be removed and will survive into the
resulting commit message.

Instead, let's ensure that the string supplied to -m is newline terminated,
but only append a second newline when appending additional messages.

Fixes the test in t7502.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin/commit.c  | 4 +++-
 t/t7502-commit.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3348aa1..d21d07a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -124,8 +124,10 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 	if (unset)
 		strbuf_setlen(buf, 0);
 	else {
+		if (buf->len)
+			strbuf_addch(buf, '\n');
 		strbuf_addstr(buf, arg);
-		strbuf_addstr(buf, "\n\n");
+		strbuf_complete_line(buf);
 	}
 	return 0;
 }
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 39e55f8..292bc08 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -204,7 +204,7 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 '
 
-test_expect_failure 'cleanup commit messages (verbatim option,-m)' '
+test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
-- 
1.8.1.3.638.g372f416.dirty
