From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 4/5] pathspec: move prefix check out of the inner loop
Date: Wed, 18 May 2016 12:02:21 -0700
Message-ID: <20160518190222.28105-5-sbeller@google.com>
References: <20160518190222.28105-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 18 21:02:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b36k0-0002BJ-JP
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbcERTCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:02:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33387 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbcERTCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:02:34 -0400
Received: by mail-pa0-f47.google.com with SMTP id xk12so20559376pac.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dSer7HC9YWYz6QRk4hre5cCDqDpbHx9REl1Egyeken8=;
        b=Uga7y0tFHQAVicOd+BC71QKy9vUIO0tTuOASxB9Hm/xroaoLbQCidKt2gPmWIinp+r
         bOc2/tmS9THsw6jmKct1aq94HuGu7Y3YXf0QsLemyMSfcORLyeWvC9Dh70C1x7Z2OKI2
         e/8/KZArvY8Qq25c+E14NcvmFoDVJ93RVHbzR0KTmRN5efpv4Kty7JXX0RTtqPMsEeQH
         ECgB64V70en/L6AWGMKTS02rni/is0MScrpnbdFJxXoZtRjcxwhL1ij8bfpS7oZMvl+Z
         boBm2yjjnjhkxWwcekX1c0yVV4Ixxa1zdIgB94CarzytwIrXS1IBqBIOjbzn5Q/u6Ix4
         g7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dSer7HC9YWYz6QRk4hre5cCDqDpbHx9REl1Egyeken8=;
        b=K47Dp+V7C9gc7nvGnNTcAiLyIodBFM0P7fSz9K/AHQgAVH2uRRE4UODAljYxnRCuvD
         Lmm3P+93vXy43En/6v5M9EOzudjBl0TNqxnk3pA4PXhpfXEJCKvZUrKd2xi/dmfTJ2lO
         q6zELgXHRErr7JRtqzic3gWOt4X1yd34saT35HkhgNAbLcUxZ+6ZxmJDWhiGI3l+PdX9
         a7vLGCU6DmUCdPEyheGycJ5S4ZZC3zLf6KVWC3f8hzINxoISdVJQfjOHjR/5iuASmCZH
         weU0OOEss1y/TYhc5v+eSIJAPoJt7amG9gMnGJoJN0kS9pyfDsPDkrNU3k3IYaQ7PWyU
         Wa1g==
X-Gm-Message-State: AOPr4FVMj9FCDOiIuur16JkXk/O4IYdQgNYqJ9HFtk6yMSEQhyNOR/mQxi0mWykHi7Wi9MIy
X-Received: by 10.66.22.36 with SMTP id a4mr13344249paf.58.1463598153351;
        Wed, 18 May 2016 12:02:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id s14sm12781453pag.7.2016.05.18.12.02.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 12:02:32 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.121.ga97fb08
In-Reply-To: <20160518190222.28105-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294992>

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
2.8.2.121.ga97fb08
