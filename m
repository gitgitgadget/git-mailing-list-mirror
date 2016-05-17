From: Stefan Beller <sbeller@google.com>
Subject: [RFC-PATCHv6 3/4] pathspec: move prefix check out of the inner loop
Date: Mon, 16 May 2016 20:13:52 -0700
Message-ID: <20160517031353.23707-4-sbeller@google.com>
References: <20160517031353.23707-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VSq-00077N-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbcEQDOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:14:12 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33006 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbcEQDOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:14:09 -0400
Received: by mail-pa0-f54.google.com with SMTP id xk12so1638290pac.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jid6GpfpzH9yuQWGXZ43eHC7gZHtTYf0L2ZhXCJYjK8=;
        b=DvRKoYVjbkIo2xVdcQoDOqLjwE6GT84lHJAuCRmunUFPbJao3IA1yF3+SQeK3lss+n
         hV7sIXllqVugHYnOM6/XSsLV64dWuxz2Y0dqAuBNUz/fuL19i/07Lf8g6nuRSaNZYNUO
         EQlB7yl2uo/9YTpiskI3mNeTulpV25NaOSq8khG0toPxszmN+EkLMU/MVSDvizil9lyT
         hm+WEv+byBllbW00GUEHN9/qJ6uqa18JmQoip60whb0O6nCDErdrPQmezVXRGJxwySio
         1fN+1lUyJpoLOogYmkWq8i7ZJVYkGAPrt8S1uOhYs19j6R0LRacWjkbygBO+fNzv7BZG
         sRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jid6GpfpzH9yuQWGXZ43eHC7gZHtTYf0L2ZhXCJYjK8=;
        b=krwVp9WCnh0NcSJHa9IUn/NrNLxZet7cmNbNoGLifk+sCccULANJkCPOvpFnYRzy50
         zXz38mkFzR2/NOKacvMPdwDj6B4z1aTPmkjOsYsA+TxUyg0fIkd1f7YxXwDrFsVbhqDi
         6yNTA6hCgsFMFHMfI8pcF/1THIxYhLihpqxpGoQGF7QU3FCYiTKAMGNYbJdwfaZ+VdGT
         U3DF389V3EP5gGKQYWXuDAdki7f/WAr6MyHvSQI9l8bbjExb0rxF+N617EQPKUgvJdey
         eb3zKnImWT72sNWUSEuFkXZR3CJZcZcfC24AaEcCjjtMI/kJTlUpY/306SUSohgxTjPc
         /2Iw==
X-Gm-Message-State: AOPr4FWcvBBuQtPINB8sRcAOQ8JusjyLMULQRgJXRrR9Ud/FjtUHyhEbRFytD2grAtdpVNz6
X-Received: by 10.66.197.200 with SMTP id iw8mr19981600pac.69.1463454842606;
        Mon, 16 May 2016 20:14:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id y128sm515965pfb.13.2016.05.16.20.14.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:14:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
In-Reply-To: <20160517031353.23707-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294834>

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
2.8.2.401.g9c0faef
