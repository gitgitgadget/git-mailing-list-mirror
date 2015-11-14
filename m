From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 5/9] submodule-config: introduce parse_generic_submodule_config
Date: Fri, 13 Nov 2015 17:06:58 -0800
Message-ID: <1447463222-12589-6-git-send-email-sbeller@google.com>
References: <1447463222-12589-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:07:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPJR-0003PS-3H
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbbKNBHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 20:07:24 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33438 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbbKNBHU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:20 -0500
Received: by pabfh17 with SMTP id fh17so115998445pab.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m2o+Aalbdy8SRIo7Dgdp3I+gt/K4CFfvFgPn5oWkk34=;
        b=ftO82eHoY+OtBapKnaK/bEeCmu+9Pd6Xx4noCialU1kM9SlEZuCB0Y5ZNvLDBiAduE
         3zUWXR+W8nZiZ2SwQ7CRWj8fYjR0ObBPSvpA4cfwazf/acSn87bR+f7ogcwP1WrIZCSw
         zb7OAR0pCDIobYUMzdw2SXIstW1KuXBMWnB4Qlq3cnH3Rhi5e2nlrDIReJk1iZdQOdG9
         nDK7sPcqFq7IVjmpU44aMzn2QIKjkRXdxM7m6nw4Md/mbI6V46y779VgvtOVsptMIwJB
         nNCzLH//bU2JN53oFu+vohAB8AJxz1uk8FGI7wjhxcbFKuO8L1/PFhwfdGnyuHQy8EwN
         6I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m2o+Aalbdy8SRIo7Dgdp3I+gt/K4CFfvFgPn5oWkk34=;
        b=KitsAwj5sAh0K6uQ5D1hf9sWdhPFPXDh/4fJXgWx2gjJhVKyxtqcmYyQ46+h7IU+pi
         FULLRA4YVZWqj2MTR0ZoYFFj5tVWQKX1d1R0s71Q0Ubo98AHfR7tG+w2jUUk/U1IYLha
         JXC0Nuza25SNK6klvEUrFJgbp5//Y5UXDv6MRDPCd5r0zOeYLkeF61t5o+SwZc+1djQh
         Rbw50jvSzuiYoA7LrYnra7lHU+w6Xft7YDh+N/oPDfW0jz2SXdZFGia4d9F668fQnEAW
         HDX5zf0zuA+v36mALaKf6LO6P60wwVqsd6FTlsOBjl1lRLrxuhX24trCv3+jaDJC9xZy
         ENKg==
X-Gm-Message-State: ALoCoQlVIOFdLfMKgyFFEzfd+n2BxuW+1jxvsk6ztZtS2locNgAzEYordbsC/pTEKBdWnB/yVA7r
X-Received: by 10.66.185.6 with SMTP id ey6mr36434385pac.70.1447463239614;
        Fri, 13 Nov 2015 17:07:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f5eb:b7b9:3afa:a95c])
        by smtp.gmail.com with ESMTPSA id it10sm22643631pbc.14.2015.11.13.17.07.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 17:07:19 -0800 (PST)
X-Mailer: git-send-email 2.6.3.369.gea52ac0
In-Reply-To: <1447463222-12589-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281293>

This rewrites parse_config to distinguish between configs specific to
one submodule and configs which apply generically to all submodules.
We do not have generic submodule configs yet, but the next patch will
introduce "submodule.jobs".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index b826841..29e21b2 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,17 +234,22 @@ struct parse_config_parameter {
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
-			     &subsection_len, &key) < 0 || !subsection_len)
-		return 0;
+	return 0;
+}
 
+static int parse_specific_submodule_config(const char *subsection, int subsection_len,
+					   const char *key,
+					   const char *var,
+					   const char *value,
+					   struct parse_config_parameter *me)
+{
+	int ret = 0;
+	struct submodule *submodule;
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
 					     subsection, subsection_len);
@@ -314,6 +319,24 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
+static int parse_config(const char *var, const char *value, void *data)
+{
+	struct parse_config_parameter *me = data;
+	int subsection_len;
+	const char *subsection, *key;
+
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0)
+		return 0;
+
+	if (!subsection_len)
+		return parse_generic_submodule_config(key, var, value, me);
+	else
+		return parse_specific_submodule_config(subsection,
+						       subsection_len, key,
+						       var, value, me);
+}
+
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1)
 {
-- 
2.6.3.369.gea52ac0
