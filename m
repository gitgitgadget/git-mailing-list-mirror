From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 5/9] submodule-config: introduce parse_generic_submodule_config
Date: Thu,  4 Feb 2016 14:09:32 -0800
Message-ID: <1454623776-3347-6-git-send-email-sbeller@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 04 23:10:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRS69-0007Fz-VP
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965555AbcBDWJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:09:52 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33474 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965189AbcBDWJv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:09:51 -0500
Received: by mail-pf0-f169.google.com with SMTP id w123so56961400pfb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y3RkoZIuuCy92eRmODlLA3KEkE/AKax8fqJRiwg4yuo=;
        b=FCOkLA2le716jQK0xZ3CnQpdAAh73t/tu5AGqkdOLaqImXax+VxzH6T+5VtEzqMoiV
         KgqaBYjY091RtIe/JSMqHLFVcYX7txQyOsh7ZzPefTkVm9ElpEBbLTrK9epfdJZl4gEA
         JNgTVeHORpoq7kbH31sq8abPZE5Dib7e2MdPGa+4aNIVgXiy88vSpOcliIF49WNcm87n
         YY0ufts8tq+ZegH2kczzyPIQYSkWisWMxX406cX0zVvORCOh60HY/0dqqjIKiUdO0nMq
         MOTc2DemPrE+B357kbvk4W/qobLBBFPLmtyaL8eoQXRhAUdG1rzlKviPpOkCMRWlovSG
         iUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y3RkoZIuuCy92eRmODlLA3KEkE/AKax8fqJRiwg4yuo=;
        b=kTR9yM4KXeu9+AdYvQorDbLd/O3O1cZlIndXa6fZAGguHAIYG4itM+zhXZK9V0CVIS
         p172YnVlaCmqfZIJb5k520jEca9z+c/iR73n2V3zLNk6q01W3dHIT+2ZXaNT0gVegAxG
         ofLlToerjMhoL7Wr2G1Vj7keDjf9zuux9O+F4eZbPT5B10LT+r72nm5eQ/Ifp6bFcf3g
         qtVkveCWRf0Y0ZPa3VZkU37/PY5U8SafmkdVzAtHNIDPLzFy9m37AbpXiT+ciPnG8Cxl
         +AYOeCLLI1kA+6Mi8934dgCFkYPs9/YAsvRASW+WsDqu9HX9dpI26jq+TFXqkN920Ie8
         VxUw==
X-Gm-Message-State: AG10YOT0wBzovdgU6PpH9QALU/JLsx20TNdJp8oSKN3D5k+iphybulrvBphsIryq3Ty+jU+1
X-Received: by 10.98.16.12 with SMTP id y12mr14824548pfi.6.1454623790835;
        Thu, 04 Feb 2016 14:09:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5194:ebf5:4051:c1fd])
        by smtp.gmail.com with ESMTPSA id lt14sm19325133pab.39.2016.02.04.14.09.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 14:09:49 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.gd102984.dirty
In-Reply-To: <1454623776-3347-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285505>

This rewrites parse_config to distinguish between configs specific to
one submodule and configs which apply generically to all submodules.
We do not have generic submodule configs yet, but the next patch will
introduce "submodule.fetchJobs".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index e375730..2841c5e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -228,18 +228,22 @@ struct parse_config_parameter {
 	int overwrite;
 };
 
-static int parse_config(const char *var, const char *value, void *data)
+static int parse_generic_submodule_config(const char *key,
+					  const char *var,
+					  const char *value,
+					  struct parse_config_parameter *me)
 {
-	struct parse_config_parameter *me = data;
-	struct submodule *submodule;
-	int subsection_len, ret = 0;
-	const char *subsection, *key;
-
-	if (parse_config_key(var, "submodule", &subsection,
-			     &subsection_len, &key) < 0 || !subsection)
-		return 0;
+	return 0;
+}
 
-	subsection = xmemdupz(subsection, subsection_len);
+static int parse_specific_submodule_config(const char *subsection,
+					   const char *key,
+					   const char *var,
+					   const char *value,
+					   struct parse_config_parameter *me)
+{
+	int ret = 0;
+	struct submodule *submodule;
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
 					     subsection);
@@ -309,6 +313,27 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
+static int parse_config(const char *var, const char *value, void *data)
+{
+	struct parse_config_parameter *me = data;
+	int subsection_len, ret;
+	const char *subsection, *key;
+	char *sub;
+
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0)
+		return 0;
+
+	if (!subsection)
+		return parse_generic_submodule_config(key, var, value, me);
+
+	sub = xmemdupz(subsection, subsection_len);
+	ret = parse_specific_submodule_config(sub, key,
+					      var, value, me);
+	free(sub);
+	return ret;
+}
+
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1)
 {
-- 
2.7.0.rc0.41.gd102984.dirty
