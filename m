From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 5/9] submodule-config: introduce parse_generic_submodule_config
Date: Tue, 24 Nov 2015 17:14:52 -0800
Message-ID: <1448414096-22021-6-git-send-email-sbeller@google.com>
References: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Ofy-0000xG-PN
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbbKYBPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:13 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35289 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbbKYBPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:09 -0500
Received: by pacej9 with SMTP id ej9so39161429pac.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9CoI3PGdk2pkyvHOXq36T0WJCna+EMziFdOiBcTHhTM=;
        b=c7JGiQaREbifkCbiVdZ3EJuSrFwodfORNUtqffa/ZjCq0mJhtmq9uig+ncMzKyJKsS
         /ihVCtgQMDyHSMDDnXnH6WozxkLS9SBOz1IxW67Jz8KdT8kvDI9YeUkokbjCvlusRoL/
         lGxsvxfEYrjugrw4UXvr5IjAdUnkeilcfHPeWAlQsThT4xwIdf4c5AHGxTJhdR5NozWl
         9gVq8jXUIkfpFWFNBhviwLDMq21Gor1MXVFgF3agVbuMoTyH3lm2RtacRfJuZFrwdV5q
         lOqbGNkBW3XKkGH1zE7Q73IQ+C/1VaR2zwpTYv3B/R/a47RfLOwnY9jgn0VFMHqGZGtH
         Tk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9CoI3PGdk2pkyvHOXq36T0WJCna+EMziFdOiBcTHhTM=;
        b=buAHek3dCrXBYosOd5tbixy7Jk7hWf7L1uQCdrpElsJ+NFrsEeYdviaRdeeqK06/Sh
         IorScnz/oS41UoxMDtn4Ay1s7+sk/7K4q9s7kQQdvCe6MYeH/zU5TzEt2dPqPPIJeaAw
         MWzHT2vRxi7E+cg9HH6a7uQGZpAwolxE5dbbnQL43oGp0xAvikbI6WawT7pMEF1eNYx7
         4lWV5gFBX1TK0ERG6OLyaV/4blNcw0NFfsR1bCDjTIYinKwJ7GjPOUw10LRV8PGRLoj7
         hmFE59QJ/R8mK2Z1FidHMDZEGO6kXzLmjI4HUmaO7ZNg/peTsSe84TiAog1ATkBzsgNd
         Svpg==
X-Gm-Message-State: ALoCoQkZxBTYLTZzDZvtKEMEksKbKAGgei6oeOp1Lzd6Q0UCocR0/1e86ONby1HVBXZi4ceaWVF3
X-Received: by 10.98.0.73 with SMTP id 70mr27362861pfa.4.1448414108244;
        Tue, 24 Nov 2015 17:15:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id e25sm16775046pfb.64.2015.11.24.17.15.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:07 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448414096-22021-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281661>

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
2.6.1.261.g0d9c4c1
