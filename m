From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] unpack-trees: fix accidentally quadratic behavior
Date: Thu, 21 Jan 2016 16:11:48 -0500
Message-ID: <1453410708-23951-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 22:12:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMMWV-00005C-LA
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 22:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbcAUVMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 16:12:03 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:32987 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbcAUVMC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 16:12:02 -0500
Received: by mail-qg0-f52.google.com with SMTP id b35so42547244qge.0
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=W9qgs/GY9NzUbxGCDwZc5lgfwdbLbkHsk0I19hDWUM0=;
        b=VGZ+wZwuwniSNuCOjblgYAm3DQmgcDLKr2iskzUuS9+eURKnNY+j7/W+dp2whReCwh
         Eo+4NqD1lZcjO55Jp5/F1jemKLIj8Upht773RlcyCSs7NtPapb0TIGtuNZ9tGc5Okc/N
         vltnszC53QU+p5LBEuC2CmILf8N3sp/4S/OYBCzon14vzFb6zk7l9GEXLpx0rrJDC1zh
         H9+TD6vjcjIFgcIyh/M//Ooaqsl6q4LifuKxoPI0/t1NKFfl7Sf8eAsQ/r8Mr1pWBXL9
         NN5brUmjmH0u8F2KVjZMSfTGvHr530mL7LvLzmWgTHCh7muwKU1Buz2QuG32u9WXchnj
         UGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W9qgs/GY9NzUbxGCDwZc5lgfwdbLbkHsk0I19hDWUM0=;
        b=TaEayG0tifftytjY9uIlHKb4VvzVjocSmqXjoEzBq7MjuEW8YizEubYOCLP0JRYrSZ
         P0UKjKEsa+NEB1abHdd4I5viNFBGIdhZkWQeOVFCuns3bpsfuyeEhynwqQ0IeUlHWQPl
         08kJCLqNCXIkFz9JiBv0V5y3LrIpc7h/FhCcyfNKCnTfAJ2awwtftLtqyNLyRAB3eSo2
         PrPQswmSlNYWnJ7E8Ll3ieEB8xE3gm/TqtYvhIxl8gWWCTl6JQmJWhLwQ4Vg9pqSfLIG
         vIS7YdU/to5vtW9cVtyCiy6PW/F9U5PxFhBQBCAUu0uNEuogQWsH8JWNEtOxd3xqCR10
         mLag==
X-Gm-Message-State: ALoCoQn0cZT1T8YAKYHiwCyUeDe04Ky0WMTFhm563IJhf+bzl20PV0bBnKARqrpxFuwZ9JLBy5MfP7cWyS7zJgmR4ivF3ujFxg==
X-Received: by 10.140.39.179 with SMTP id v48mr54869172qgv.98.1453410720643;
        Thu, 21 Jan 2016 13:12:00 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id d64sm1366530qgd.9.2016.01.21.13.11.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jan 2016 13:11:59 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284528>

While unpacking trees (e.g. during git checkout), when we hit a cache
entry that's past and outside our path, we cut off iteration.

This provides about a 45% speedup on git checkout between master and
master^20000 on Twitter's monorepo.  Speedup in general will depend on
repostitory structure, number of changes, and packfile packing
decisions.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 unpack-trees.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5f541c2..d8e9685 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -695,8 +695,19 @@ static int find_cache_pos(struct traverse_info *info,
 				++o->cache_bottom;
 			continue;
 		}
-		if (!ce_in_traverse_path(ce, info))
+		if (!ce_in_traverse_path(ce, info)) {
+			/*
+			 * Check if we can skip future cache checks
+			 * (because we're already past all possible
+			 * entries in the traverse path).
+			 */
+			if (info->prev && info->traverse_path) {
+				if (strncmp(ce->name, info->traverse_path,
+					    info->pathlen) > 0)
+					break;
+			}
 			continue;
+		}
 		ce_name = ce->name + pfxlen;
 		ce_slash = strchr(ce_name, '/');
 		if (ce_slash)
-- 
2.4.2.749.g730654d-twtrsrc
