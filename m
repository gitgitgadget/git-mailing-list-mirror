From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/22] checkout: check_linked_checkout: simplify symref parsing
Date: Fri, 17 Jul 2015 19:00:02 -0400
Message-ID: <1437174017-81687-8-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEe1-0002lq-TK
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbbGQXCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:02:11 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38727 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbbGQXBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:19 -0400
Received: by iggf3 with SMTP id f3so47294226igg.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5aQmUVnnSIT85i7EBU1fWz1sP4XY3jG1ETvb/oUWxro=;
        b=B2MBd/RDfMZ2dGQkhFUrUHh0M8hlbiOi0QV6GWjwIJFfhg7josGmyJGXlwgdui4iGQ
         4t4uYQM9p+WQjoNlF7P71LBEXqZVmyOIaUzKfTz9YSHxsVYkeZq4lf4+z9Hulx1tZ+iJ
         x1q+gJnJxuOBxC1yatQP3RuTqBpyRTxDTXCYTasDHJj/tM8tDre7m+Xn2V3hxmnSFqhA
         sxXc8dTXMTHxYk1vMCicGCtxIWi8AHSaH0ouDIvDKqN9yWqifS9JTQdEx6ClfHjTQeYN
         1xS/zw5j+1uIcSGBhi40kUg854rGafwHmk3s8Fx6AJqOJ1uKuFbr8hStb7EefDOnVfFe
         E14g==
X-Received: by 10.107.135.200 with SMTP id r69mr21784276ioi.54.1437174078738;
        Fri, 17 Jul 2015 16:01:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.18
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274150>

check_linked_checkout() only understands symref-style HEAD (i.e. "ref:
refs/heads/master"), however, HEAD may also be a an actual symbolic link
(on platforms which support it), thus it will need to check that style
HEAD, as well (via readlink()). As a preparatory step, simplify parsing
of symref-style HEAD so the actual branch check can be re-used easily
for symbolic links (in an upcoming patch).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

 builtin/checkout.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index de6619f..6f4e492 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -878,7 +878,6 @@ static void check_linked_checkout(const char *branch, const char *id)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
-	const char *start, *end;
 
 	/*
 	 * $GIT_COMMON_DIR/HEAD is practically outside
@@ -890,15 +889,13 @@ static void check_linked_checkout(const char *branch, const char *id)
 	else
 		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
-	if (strbuf_read_file(&sb, path.buf, 0) < 0 ||
-	    !skip_prefix(sb.buf, "ref:", &start))
+	if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
+	    starts_with(sb.buf, "ref:")) {
+		strbuf_remove(&sb, 0, strlen("ref:"));
+		strbuf_trim(&sb);
+	} else
 		goto done;
-	while (isspace(*start))
-		start++;
-	end = start;
-	while (*end && !isspace(*end))
-		end++;
-	if (strncmp(start, branch, end - start) || branch[end - start] != '\0')
+	if (strcmp(sb.buf, branch))
 		goto done;
 	if (id) {
 		strbuf_reset(&path);
-- 
2.5.0.rc2.378.g0af52e8
