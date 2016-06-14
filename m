From: kmcguigan@twopensource.com
Subject: [PATCH v2 1/1] Don't free remote->name after fetch
Date: Tue, 14 Jun 2016 14:28:56 -0400
Message-ID: <1465928936-68866-1-git-send-email-kmcguigan@twopensource.com>
Cc: Keith McGuigan <kmcguigan@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 20:29:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCt5O-00054i-4J
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 20:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbcFNS3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 14:29:09 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35117 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbcFNS3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 14:29:08 -0400
Received: by mail-qg0-f42.google.com with SMTP id v48so71589658qgd.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=pRCq/KHgMpGzOPD/c4jfqimc4MS9aHoHZ7uWqOnu060=;
        b=gIkI9nquXutiT0KdmVY/HmuZag+8txAtljYZrLTiZsbYXz1J3bcqaqAEa33CyBJd2r
         TSMc62mGYYThaUEd1gOLAC5zNixE51uuVQ40Dj6wTh32HbFioZ7QruQFjIw6m0WRgrGv
         hywgXAf41CihHRVwXTNWA0hb6k95HLPaeH3IBMpD44lQWelOmDSGbOWv4rvjqHkHQa7B
         ItDpYWEs8A7B/B/eThjdLV21jgG0/Y8AGm+q50GLHg13NHqtZ5S6CYieGFeWyu+oBxxP
         jnIu6yUkZX9Y56qFViEfyFHZDO6nymeBqFfBnpoYhRriDn543RNGRNybxM1u4DZu13OT
         Y/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pRCq/KHgMpGzOPD/c4jfqimc4MS9aHoHZ7uWqOnu060=;
        b=WfcLMfzMq2SG7rPAMNmgWwG2P3Pr2R4GjabSsKVshBtMiGQbVsy913COR0hSNatQIn
         c7n6gdLW6jcrqmZdi15pGgNa64JKWwPcAufXMevvrO50LfqDJukVNpCA6dI35yMSPc7M
         +WZjJhmYovrj+sg//oHI0k5djg9dqJCP64xpWETL0t6DrohC1875NTY6ykc0J+1FEo1G
         6e5UguE0UbrtL34S3gVLkUfeI1OWHKm+fUBcn5WGUUSbr1HepH/gH3z96GAMxNRiegW4
         1FJ2cNBfwnz/Fcu9/IuJSer+IXnHZx5SewcRuphvyxV35VWo2qEfwMBdU9smGs7C+kPH
         N7xw==
X-Gm-Message-State: ALyK8tI+bvGY9ZvtuO6GZxCAheDfvpIGechnJH9E0L76IfNHqmCFez4ugUq/ojzZg7uORg==
X-Received: by 10.140.81.213 with SMTP id f79mr20702126qgd.35.1465928947106;
        Tue, 14 Jun 2016 11:29:07 -0700 (PDT)
Received: from tw-mbp-kmcguigan.twitter.corp (d-216-246-147-91.cpe.metrocast.net. [216.246.147.91])
        by smtp.gmail.com with ESMTPSA id o34sm8541361qte.48.2016.06.14.11.29.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2016 11:29:06 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.94.g2dc3105.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297317>

From: Keith McGuigan <kmcguigan@twopensource.com>

Make fetch's string_list of remote names owns all of its string items
(strdup'ing when necessary) so that it can deallocate them safely when
clearing.

---
 builtin/fetch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 630ae6a1bb78..1b4e924bd222 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1071,7 +1071,7 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 			size_t wordlen = strcspn(value, " \t\n");
 
 			if (wordlen >= 1)
-				string_list_append(g->list,
+				string_list_append_nodup(g->list,
 						   xstrndup(value, wordlen));
 			value += wordlen + (value[wordlen] != '\0');
 		}
@@ -1261,7 +1261,7 @@ done:
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct string_list list = STRING_LIST_INIT_NODUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
 	struct remote *remote;
 	int result = 0;
 	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
@@ -1347,8 +1347,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		argv_array_clear(&options);
 	}
 
-	/* All names were strdup()ed or strndup()ed */
-	list.strdup_strings = 1;
 	string_list_clear(&list, 0);
 
 	close_all_packs();
-- 
2.8.0.rc3.94.g2dc3105.dirty
