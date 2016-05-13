From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] pathspec: move prefix check out of the inner loop
Date: Fri, 13 May 2016 16:13:25 -0700
Message-ID: <20160513231326.8994-5-sbeller@google.com>
References: <20160513231326.8994-1-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 14 01:13:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1MHF-0008KZ-5f
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbcEMXNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:13:46 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34283 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbcEMXNp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:13:45 -0400
Received: by mail-pf0-f169.google.com with SMTP id y69so46513603pfb.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P2Ven66vlBikADpX9WUR7pd3VteenoEvB6KVOOlaick=;
        b=DDTgm0Dfp3vZJ0nAd/fjZJ1jXcrF/eT2kOXpiHhnVUli3FepKyo6d6Mt+3k9dlp/p7
         JafV4JSlsG5h6HQ4dgIQ8t8hl2TopySViOwnWvhhd+bMCENsEocJ8Bonh9/Bi5WJIJFU
         cthn8FKS9qR08IfvM0RNLNnZXcLQ7WS3bTA/Jxid6g+fH4J4oNxe+Pb9EjsJeu6AH6sy
         9a71xqijfWcRK/9PutrmWFdRPsPeuTI/bbOEOI11NgJbw/3VWTq52WihuGYTLWUF4Drd
         kD+2pWhuJGyxnYGLauELw8lhih0ETTa35+Q9bcd3KdeAHrbMgGXJDeW3z6IO/MWLVy3V
         OTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P2Ven66vlBikADpX9WUR7pd3VteenoEvB6KVOOlaick=;
        b=FiSwXW38AjhVEDBtQcSsGCWezSghQi4j1XmLZfgYpydQZfMvjz3igoNhSLP+W6HzR4
         DXPCGU8iA60t0vd48u15MVJxu21rQK5C6MSMEqIPkWLhYSntFRW++VMNZoJv3n24B2O9
         7NRAfLAtQeR8gVz4iSxDNP13TIQpWpU2s30tZDNYujRx21OxcXBan2iGzk1Ng6ISdKpZ
         eraNxuqsvpDom2Nj0uUAQiTLDxv757PjVJMbIRPQ7jYQ9HLZm1HcLKM5sLDrecF9jAn5
         zdts+Au7t523HLBR0IwanBipdCLrvSwhe+h/LKDQhFx/ovrnLCpo3iP8tGn9quezZaMP
         hAwQ==
X-Gm-Message-State: AOPr4FVfQHXpMQQDlL4d5hOukuh77+n4wfQuVhJM0ByAmAEB4Xj3haK85ebanv9gUt1FRoVp
X-Received: by 10.98.95.71 with SMTP id t68mr26502691pfb.158.1463181218996;
        Fri, 13 May 2016 16:13:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e84e:cb12:277e:4f09])
        by smtp.gmail.com with ESMTPSA id ba9sm29890183pab.24.2016.05.13.16.13.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 16:13:38 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g6647087.dirty
In-Reply-To: <20160513231326.8994-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294596>

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
2.8.2.401.g6647087.dirty
