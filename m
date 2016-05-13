From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] pathspec: move prefix check out of the inner loop
Date: Thu, 12 May 2016 17:19:35 -0700
Message-ID: <20160513001936.7623-4-sbeller@google.com>
References: <20160513001936.7623-1-sbeller@google.com>
Cc: pclouds@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
	Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 13 02:19:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b10pe-0006f2-IL
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 02:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbcEMATt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 20:19:49 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36063 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbcEMATp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 20:19:45 -0400
Received: by mail-pf0-f177.google.com with SMTP id c189so37177102pfb.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V5KIA0kQQtGwUfHA3p8vrCdecpoQCvdF1K9MiJpAeI4=;
        b=hITKYHOUnGSvU1fcqTv8QsvYOB3KSVq1YfgcYwENJePJA793Gym4Pt1rGNHv2f1Izg
         r9mItGJvc0YtT2hNFQf7dlk8ycxMKGGmhN9r0Q3/keYO7vf6+vWMFaOqqKd+DIujbFOB
         pv1Iwy57DmEk4TtJWzcyhKo0/BEhMi2U3I5Sl22YlZex1SwX8FHg60N2i4fwsaF5mYo0
         kKvAFHWFduihA5JRk8yxcRjFr0YS8jRgQ7Oav5xs62d6UUKj5IumwS0Wnn/GJZ8AIiOd
         BTTUEzIZpyqBHaKcjzL/zIiH5qNWzw8q5dtPG0AgW9/Nwygt48atj7ohTsW/rUBKbgRE
         PEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V5KIA0kQQtGwUfHA3p8vrCdecpoQCvdF1K9MiJpAeI4=;
        b=gy1R/5QYvaW92MBZGarz1bzHFxknEKIyKIWNvvnBW3w4OsR9+2kektHlndylHCVShh
         y40zycldk7xl48XxpiDXlNuq/BfKSzlMEhJvNWt1b+CYSp67VVCKon228sqczUe0sbcd
         0jOi3P9kNlff+MGjsOiRRjMI5jjq6yKTbAJ//WREm/6vdmnFnNXrDOKc8OlzdKM5AeY1
         mcAwOZsaCFWhwLxnGiNy3LLbJQbBQ54A7WNTnH8xpQ1N72HFk/aFiggul36O70Chta3S
         hYx2VHIqPatFjAZk7Pz+J4yFbbRS/SAHIMmW8oxp7rj8MG8LZPS6VXZRL2/0O3I5CYms
         chKA==
X-Gm-Message-State: AOPr4FV5y5lPEHFIYtc3O2V9iWF6T1xi4h5Vd9LzRHMm2VxqgL9Ykw/ZjSkaYSMaQzpXKd+D
X-Received: by 10.98.47.66 with SMTP id v63mr18084824pfv.67.1463098784792;
        Thu, 12 May 2016 17:19:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c9fc:8b37:8cb7:4400])
        by smtp.gmail.com with ESMTPSA id bf4sm22545075pac.4.2016.05.12.17.19.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 May 2016 17:19:44 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.400.g8bfb85c.dirty
In-Reply-To: <20160513001936.7623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294495>

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
2.8.2.400.g66c4903.dirty
