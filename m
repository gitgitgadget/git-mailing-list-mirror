From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [PATCH v2 3/3][GSOC] fsck: replace if-statements to logical expressions
Date: Wed, 19 Mar 2014 20:23:50 +0900
Message-ID: <1395228230-10189-3-git-send-email-sh19910711@gmail.com>
References: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 12:24:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQEbp-0004mb-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 12:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793AbaCSLY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 07:24:29 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:53318 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbaCSLY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 07:24:28 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so8754617pbc.4
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sgu8CpZkg5SXd/FSfsWoCe6SFPMprxK9X6UDz0fTHNk=;
        b=wSNfZVpUItwRyk3+H3mmcwn9xUI8kpCyz0KG0NEaUhFRPc23F6/btlu6sxSZMGZ87F
         QtCzBWbh1LZEjpOVb4EigEtLsjO6WCvIMFFAXcfGjXV6mlroG92QVuM/Wh3UiCnW053k
         ySR1Nv+jMD9hoYAMbgMdXMFGO+OOMkvdqiaEk7Y3QinUtM8MeBSqaD07fzHKZAiIBYbm
         x03EEG2yp/+Y2I0AOHdMT8MsONK5tVt4QrHVo1+vvnvNWdI5HWSLjEVbiYZVe3HmJhHP
         U/kcPIvNlGljcdhokNcNLbQ1YwZPHI9nIzPhLY0XsvuTNzhmrSY5mbs/jPlm9/3H0H+W
         SSLg==
X-Received: by 10.68.184.66 with SMTP id es2mr39362046pbc.19.1395228268014;
        Wed, 19 Mar 2014 04:24:28 -0700 (PDT)
Received: from localhost (ntfkok023001.fkok.nt.adsl.ppp.infoweb.ne.jp. [218.217.179.1])
        by mx.google.com with ESMTPSA id kt8sm55652137pab.7.2014.03.19.04.24.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Mar 2014 04:24:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244437>

There were two different ways to check flag values,
one way is using if-statement, and the other way is
using logical expression.

To make sensible, replace if-statements to logical expressions
in fsck_tree().

When checking "has_dot" and "has_dotdot", use is_dot_or_dotdot()
instead of strcmp() to avoid hard coding.

The is_dot_or_dotdot() is used to check if the string is
either "." or "..".
Include the "dir.h" header file to use is_dot_or_dotdot().

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 fsck.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index b3022ad..08f613d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "dir.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -165,18 +166,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 
 		sha1 = tree_entry_extract(&desc, &name, &mode);
 
-		if (is_null_sha1(sha1))
-			has_null_sha1 = 1;
-		if (strchr(name, '/'))
-			has_full_path = 1;
-		if (!*name)
-			has_empty_name = 1;
-		if (!strcmp(name, "."))
-			has_dot = 1;
-		if (!strcmp(name, ".."))
-			has_dotdot = 1;
-		if (!strcmp(name, ".git"))
-			has_dotgit = 1;
+		has_null_sha1 |= is_null_sha1(sha1);
+		has_full_path |= !!strchr(name, '/');
+		has_empty_name |= !*name;
+		has_dot |= is_dot_or_dotdot(name) && !name[1];
+		has_dotdot |= is_dot_or_dotdot(name) && name[1];
+		has_dotgit |= !strcmp(name, ".git");
 		has_zero_pad |= *(char *)desc.buffer == '0';
 		update_tree_entry(&desc);
 
-- 
1.9.0
