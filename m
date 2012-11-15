From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH] usage.c: detect recursion in die routines and bail out immediately
Date: Wed, 14 Nov 2012 17:45:52 -0800
Message-ID: <1352943952-16964-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 15 02:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoX4-0003vx-VA
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992612Ab2KOBqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:46:03 -0500
Received: from mail-ye0-f174.google.com ([209.85.213.174]:38353 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992617Ab2KOBqA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:46:00 -0500
Received: by mail-ye0-f174.google.com with SMTP id m12so244209yen.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=djkbCg11P1OIYk015ZQ9mpfOThmMgX7uPqk9pFfawnY=;
        b=ZD453BVw/gYEf0TKsD/pMFwsWAn+m5btUPMlEesiy7c/yfyKoNziJcCUU9/hbFrLj0
         RQTDsfklaw9E+b0Bv0UJKDbZURO6HqLtwtnIO2mh2FZKOa+VfDndV7poehU1jRaaGwvP
         vqlxh37SJrM1dXeZ7egweLExpzWNAhNZ1KY1nPTZUkqAUV0+A6EMXir1CVZ0oKmxY4MV
         7Cq6xgCLHzvk58yZ/F7btCLyntPNBit3Nk+MRFUEwBwjQRp527qi3hIbFjk0Og3/fuml
         sVQ1p+204JPNhd85HdHIc4KWSEi86JD5IderJVwdhdgqVz3oAQjJabhXlcpsorOpP5B0
         xvDw==
Received: by 10.101.136.16 with SMTP id o16mr8051561ann.74.1352943960505;
        Wed, 14 Nov 2012 17:46:00 -0800 (PST)
Received: from charliebrown.corp.google.com ([216.239.55.194])
        by mx.google.com with ESMTPS id z28sm14653873yhh.7.2012.11.14.17.45.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 17:45:59 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209787>

It is theoretically possible for a die handler to get into a state of
infinite recursion.  For example, if a die handler called another function
which itself called die().  Let's at least detect this situation, inform the
user, and call exit.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 usage.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/usage.c b/usage.c
index a2a6678..8eab281 100644
--- a/usage.c
+++ b/usage.c
@@ -6,6 +6,8 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
+static int dying;
+
 void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
@@ -82,6 +84,12 @@ void NORETURN die(const char *err, ...)
 {
 	va_list params;
 
+	if (dying) {
+		fputs("fatal: recursion detected in die handler\n", stderr);
+		exit(128);
+	}
+	dying = 1;
+
 	va_start(params, err);
 	die_routine(err, params);
 	va_end(params);
@@ -94,6 +102,13 @@ void NORETURN die_errno(const char *fmt, ...)
 	char str_error[256], *err;
 	int i, j;
 
+	if (dying) {
+		fputs("fatal: recursion detected in die_errno handler\n",
+			stderr);
+		exit(128);
+	}
+	dying = 1;
+
 	err = strerror(errno);
 	for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
 		if ((str_error[j++] = err[i++]) != '%')
-- 
1.8.0
