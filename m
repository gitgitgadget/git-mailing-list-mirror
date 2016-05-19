From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 3/4] pathspec: move prefix check out of the inner loop
Date: Thu, 19 May 2016 16:23:22 -0700
Message-ID: <20160519232323.12775-4-sbeller@google.com>
References: <20160519232323.12775-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 20 01:23:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3XI5-0005pv-F8
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbcESXXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 19:23:38 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35897 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966AbcESXXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 19:23:33 -0400
Received: by mail-pf0-f176.google.com with SMTP id c189so35788653pfb.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 16:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SlnEwb2KYZuM6hrNBQPIPiHVT5eQ1TSxX838UI1NWjc=;
        b=c0+qpfZGf5ium8//Kxu8dLyNfe+z6cLw+/ACxgFdYCG3IktGgJA2iIpvmfrHY0qYKu
         3l1Fdd9yxsJOBVdh2z9NXAlVjqBu/xL9wBsvWb4rXSZ1pERadcI7svX9/XE3NVZa1MJk
         DwxSLU0L5NzTyCBNHL7ATStAxVdtK9p09bguPEV9dKnHoYiqIElL1bMQFFsV2cwpoHGv
         OCyymx4740PxgLaB53C97/rvqyQk9eXB6+sUaX30iN329xaAZS4PK+QpwSuZH4jrTz0v
         nycQGtyUePZ1BFEGUFJgumt1adfDGc+A0T8vLfQjuMPb2U7Rri9bwjRiaUU2DGhc/aGS
         wr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SlnEwb2KYZuM6hrNBQPIPiHVT5eQ1TSxX838UI1NWjc=;
        b=Be+SM4aW4OvCzYaKEjbCxeI8Al4FH9miisQ86Ab2LjQT49D0wog1zfVsGaPFvxM2cF
         1whQPVKlZzz6100wErMDTCB1vnEA3FH2a64f8kPyefQFb8yEpwbBNjabCmKDV388JfxF
         sEJCcIswV0xOmmC3UOPLMV7vsM0QP5GxuB7hjGofAl9iz031bcRmVahiJ1vTAufLiS3Q
         TR8XIp/MzmrXTUYmUAvdXmfxFM61s36b09bQTGsW9i9QezxLpmH86CnxHVGIDzYhEpsZ
         M96yD9x2f+oQA+Avhb6K0NjVU6NC17MFTqRPoFLzqezTOvBRJ13OQn0OuIHlEh8gW7UB
         frog==
X-Gm-Message-State: AOPr4FX0PvR3bDGvvjH6ywVXaDOScqNBGvdMklddOhP9dqhZH+SEf5I/7l0hHrTMmDeAxPCN
X-Received: by 10.98.21.131 with SMTP id 125mr23756937pfv.92.1463700212874;
        Thu, 19 May 2016 16:23:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:acf4:8121:b728:8fc4])
        by smtp.gmail.com with ESMTPSA id u63sm22290775pfu.18.2016.05.19.16.23.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 16:23:32 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.gb4ad9b6.dirty
In-Reply-To: <20160519232323.12775-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295129>

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
2.8.2.123.gb4ad9b6.dirty
