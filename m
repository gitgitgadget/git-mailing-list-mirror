From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] name-rev: strip trailing ^0 in when --name-only
Date: Sun,  7 Jul 2013 18:13:15 +0530
Message-ID: <1373200996-9753-3-git-send-email-artagnon@gmail.com>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 14:47:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvoNB-0007dr-Rc
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 14:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab3GGMrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 08:47:21 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:61510 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab3GGMrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 08:47:20 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so3438404pbc.10
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FCruyzHNEona8fpBOUyvR8cXF7LfD4k+TEwPu7aIea4=;
        b=edHpEMU092ir6sFXfqIrBsl/i7LqDfFWcWCEwKBg44LgOCxuN/PyycpR5CbQWfWKl5
         nqSNBwGj+xbZtkZVvkQgkmGM3cXqg1JzjjFPlNhvbdjRBF48XSt/XyuxGvHIJOY0CCfh
         7Kot8zvGF2jPT8Rrw8ldljPYj1t8ketaPB4l7OJAi9ZwN2toV6Ah0cbWxA9RHE+WEuPs
         +5i9o4xA4PKWaDSl5oYxe25rYrOKW37nS4l3SaeDL5Bs9O3bHMQKhjeLJ5uXtXTsJL+j
         PkTMNpLoFfpzOvJHzQjT52dL3mv6OIrDpkPJo7BkgI+i7wIUEmVC82j65+05jKKwhjl8
         npwg==
X-Received: by 10.66.155.102 with SMTP id vv6mr18924257pab.60.1373201239703;
        Sun, 07 Jul 2013 05:47:19 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id eq5sm17024014pbc.15.2013.07.07.05.47.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 05:47:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.737.gcbc076a.dirty
In-Reply-To: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229771>

236157 (Teach git-describe how to run name-rev, 2007-05-21) introduced
`git name-rev --name-only`, with the intent of using it to implement
`git describe --contains`.  According to the message, one of the primary
objectives of --name-only was to make the output of name-rev match that
of describe.

  $ git describe --contains --all master
  master

  $ git describe --contains --all master~1
  master~1

  $ git describe --contains --all v1.8.3~1
  v1.8.3~1

  $ git describe --contains --all v1.8.3
  v1.8.3^0

The last invocation unnecessarily prints a trailing "^0" (--stdin does
not suffer from this defect).  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/name-rev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 37207a9..8ba5d72 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -186,7 +186,14 @@ static void show_name(const struct object *obj,
 	if (!name_only)
 		printf("%s ", caller_name ? caller_name : sha1_to_hex(sha1));
 	name = get_rev_name(obj);
-	if (name)
+
+	if (name && name_only) {
+		/* strip possible trailing ^0 from name */
+		int len = strlen(name);
+		if (len > 2 && !strcmp(name + len - 2, "^0"))
+			len -= 2;
+		printf("%.*s\n", len, name);
+	} else if (name)
 		printf("%s\n", name);
 	else if (allow_undefined)
 		printf("undefined\n");
-- 
1.8.3.2.737.gcbc076a.dirty
