From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri,  1 May 2015 12:28:27 -0700
Message-ID: <1430508507-14016-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 01 21:28:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoGbz-0000Uc-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 21:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbbEAT2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 15:28:31 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36204 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbEAT2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 15:28:30 -0400
Received: by iebrs15 with SMTP id rs15so95636527ieb.3
        for <git@vger.kernel.org>; Fri, 01 May 2015 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8O6vbI21PyI5a1ox3YDvC3hG8sb7vMEgqHPySy2V6yw=;
        b=TIKyvkjq9rCLjkTt0vQ/zG7SVNgdPmXXJi9tm91fvujgGUqtMItaKhVlYELz0rsJMS
         V0ZSmI9duH/BBFBryjVs9itKOeo5An5plZBHNXpSks/6iY7SeEyqXgRD1ZS9IBAaJxCV
         9ofNwyx1L8zROTXJm21qreAP0jf/FeyyzOiStJmeGNnFYj3tfo77YdL5ygIQgjMe4LNc
         VTbHzrEck4BnjRcIfu0KduR1sIvqgrGFMdsbBCqNKNSQXbHoSw/oaNr8ZedUW4H9nhnx
         Dxf7kSoDqtrA+tGBqnxhJIhrNkpI2Sx57RHO1IG/sw6rK4Pk1w19acHfiPup8tIvRbpT
         lhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8O6vbI21PyI5a1ox3YDvC3hG8sb7vMEgqHPySy2V6yw=;
        b=F5XM3W18s4n+oSuxxHhn0hpsTY/ekoSHgNmhf/Y5Bb5/a/e7UUvgHwHJixwaHKkYXB
         4rHAiTh7sh6XF5De4a1xPJFWO1dpZRWefIK7a9BlNnwtgoFX9jd8DqB6I+SyVsRmajkY
         BIzMxc8sxQi1J7toS7aKatxsDBnSZR8aD569lTTu2y95it4t5nlpoTnMhfIJN7rc3CFN
         oVgK6kK2H8EVcxnxfLpcvbRbLPHTyRth5a9CyTFo1jjgaoDF4bJjSP+A7899fkrDiGwN
         6Uz1H9xtnLuwljcbrqkgpgtJfBaI7CzQPzfOvSjvYnRq/QsvZ1fiAEM8h789lGQ26j+4
         mNCg==
X-Gm-Message-State: ALoCoQmjFYDOVtnTGiVV+1ntc4HmIfpkTWrvaDLwIWEZLLnr7uDnlgOvBiGzr+DWX3oaojG0VR2v
X-Received: by 10.107.27.210 with SMTP id b201mr14283356iob.42.1430508509925;
        Fri, 01 May 2015 12:28:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:b91d:b254:2e9c:5ed9])
        by mx.google.com with ESMTPSA id p74sm4079446ioe.27.2015.05.01.12.28.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 May 2015 12:28:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.16.g0ab00b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268175>

It's safe to free the char pointer `p` unconditionally.

The pointer is assigned just 2 lines earlier as a return from
prefix_path, which allocates new memory for its return value.

Then it is used in checkout_file, which passes the pointer on to
cache_name_pos and write_tempfile_record, both of which do not store
the pointer in any permanent record.

So the condition on when to free the pointer is just "always".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9ca2da1..e28dc35 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -249,8 +249,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
 		checkout_file(p, prefix);
-		if (p < arg || p > arg + strlen(arg))
-			free((char *)p);
+
+		free((char *)p);
 	}
 
 	if (read_from_stdin) {
-- 
2.4.0.rc3.16.g0ab00b9
