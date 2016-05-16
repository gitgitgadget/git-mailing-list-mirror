From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/5] pathspec: move prefix check out of the inner loop
Date: Mon, 16 May 2016 11:05:38 -0700
Message-ID: <20160516180539.4114-5-sbeller@google.com>
References: <20160516180539.4114-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 16 20:06:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MuP-0005lN-GG
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbcEPSGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:06:21 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34038 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbcEPSGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:06:19 -0400
Received: by mail-pf0-f177.google.com with SMTP id y69so69382078pfb.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yVUWNY0B9vGkJqPK6zQMKBt/nHhmmH9Kg5VI4EMweP0=;
        b=gs708ax6aQS/eRN1HuGqUzJW651Oe5jflj9yFP0CLP1GQcCdR1bxmMhoglsBR3d4qY
         awDi9hFZvkv2/Eq2XvUmOqS0wFc8tfAr8sWDxjZO+xxqWSQJ2HyGdNmg0q5ijQ2qLHNB
         vVLLy+6wN7RvKFmcECIwMaqVc+zy8KqWsGwgRkdDG50OJuGzMKBaZURVi6rk2MSeNSR2
         weatj+j7OOBaMnzzsojqbURyw2zSH/cBTBS4KN2nARZ2FB4eSC24siANvC6pEsFl0qak
         dpxS+b9lzA/KSWZaaHFQM+xH0cuR81EnIjE8OAieSBwthlgFzNqV6nneEnQuKpjI8Xa3
         h2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yVUWNY0B9vGkJqPK6zQMKBt/nHhmmH9Kg5VI4EMweP0=;
        b=dWLbG6j+ia4cZj/1o0MEaQzlVRcQxf/PUAUPy7/LqtOWQnDvB9WGRJ3izS0aXGLu7W
         dieOSOA7+4f5ANbofOaXAb4+ZEKebH/3kFR74kBkGkI1bAxxQfQAa6NBEDeyfZbEzp53
         /gOabHmgmUGEBuOPAGA1GN9HYPcmG6TTaqCRryfPBeOr4ql46gJqAxBpQKNYIIQpMGDy
         FnprSuyBM+9wf08z0EPE+JPG2WyXpK53VNmPGhVhgw0V0Smv/SREP3msWV6HqG+0MyxN
         FC3bf+cGJWVz+s8GBl1Yhsq8VJqCugrzdjJ5MaeFjM4H6CjtQ4J7dx6SXihCafK0E8JY
         fLIg==
X-Gm-Message-State: AOPr4FXUP/kucB/HNIKz5AlhLejQMRyMKb4Kb4F6r9wCsAZg/7NLXyu322aV7Ut3p4oWk/HZ
X-Received: by 10.98.51.132 with SMTP id z126mr47027795pfz.23.1463421948933;
        Mon, 16 May 2016 11:05:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id n190sm48834065pfn.23.2016.05.16.11.05.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 11:05:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.gb49ffe6.dirty
In-Reply-To: <20160516180539.4114-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294770>

The prefix check is not related the check of pathspec magic; also there
is no code that is relevant after we'd break the loop on a match for
"prefix:". So move the check before the loop and shortcircuit the outer
loop.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 pathspec.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index eba37c2..4dff252 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -107,21 +107,22 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 			nextat = copyfrom + len;
 		if (!len)
 			continue;
+
+		if (starts_with(copyfrom, "prefix:")) {
+			char *endptr;
+			*pathspec_prefix = strtol(copyfrom + 7,
+						  &endptr, 10);
+			if (endptr - copyfrom != len)
+				die(_("invalid parameter for pathspec magic 'prefix'"));
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
 				*magic |= pathspec_magic[i].bit;
 				break;
 			}
-			if (starts_with(copyfrom, "prefix:")) {
-				char *endptr;
-				*pathspec_prefix = strtol(copyfrom + 7,
-							  &endptr, 10);
-				if (endptr - copyfrom != len)
-					die(_("invalid parameter for pathspec magic 'prefix'"));
-				/* "i" would be wrong, but it does not matter */
-				break;
-			}
 		}
 		if (ARRAY_SIZE(pathspec_magic) <= i)
 			die(_("Invalid pathspec magic '%.*s' in '%s'"),
-- 
2.8.2.401.gb49ffe6.dirty
