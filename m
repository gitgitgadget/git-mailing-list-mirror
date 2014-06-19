From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 11/48] refs.c: make remove_empty_directories always set errno to something sane
Date: Thu, 19 Jun 2014 08:52:53 -0700
Message-ID: <1403193210-6028-12-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxehK-0000qe-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758011AbaFSP4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:56:17 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:61363 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757681AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so693414iec.4
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=darxU/AO2eyZBV3syEpQ9Vzl2gBKIw6xfBNVvT43WpQ=;
        b=WZN2UVTplVCbelvt8/Da3cYoJhhgwvnL12Fg0cbGcNUVZhrpVU6zDL3tN7uDfCrWSV
         sMuyahDh5n/mqbQBd+x62rzyAfmfHkMVKwIt49w0UdKpZ25OTe+E3+Py5y1nuGExZwuv
         4sdTDVkrA2gw3lnd/ypCS+R2C/yKcMrCxw+1VXTX+Leb0LP4CYrXObHsCzK2jqVEyuQX
         nS0NndeZdteAeqm/ebHnuV43G94rHSep/4nAM+/Dihj+g5Isr2d43nSrVJJd4yZNy8/A
         9XXPlHe1Px1Osy2xL+Ooy5BwVcEhA6iVYaKDiRblbfPH5h8AUNKcFPOJa+hwqweqYt7j
         ATvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=darxU/AO2eyZBV3syEpQ9Vzl2gBKIw6xfBNVvT43WpQ=;
        b=W1Tb52bD+rSmPw43MBeEGF688Sfjq3tl6S4d0MkQJvTAJFAj8/HNBzKYJV5w/PGBel
         2qULlRP3MF5SHQEJoZ6LxU48/6/5+sKCVdi8JELAD5tz1rft5rtX3PACeN0FckLC2xVL
         +mdftTG961sku/Na/gYYZ1tLnk8PlqLr4Lq4PB0306tIfo8c5/TtxkIrpyrQzeoIvS2Z
         fSYKO/eAADVx3zc36BY8xGjX0k04FfkTBwIPoOr7Ty1gRMl5VJX03C6KBXdx47oIkyz5
         exGaQEWIMZtP3JTyc+vo9kC35uk1JTAzMke+I2Czu2p8zS3MdkWJjlnssmTNWTFwmtWW
         1Lgg==
X-Gm-Message-State: ALoCoQlwvCcGEuBZDteWkUufMrA6o2K+ByPaqiYscIJOQ44uOPorYpLQN/lyKdEeNwgfA5BiS64y
X-Received: by 10.182.115.133 with SMTP id jo5mr2751989obb.38.1403193213344;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si187563yhh.5.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3382331C487;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CB80BE12AA; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252155>

Making errno when returning from remove_empty_directories() more
obviously meaningful, which should provide some peace of mind for
people auditing lock_ref_sha1_basic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a48f805..cc69581 100644
--- a/refs.c
+++ b/refs.c
@@ -1960,14 +1960,16 @@ static int remove_empty_directories(const char *file)
 	 * only empty directories), remove them.
 	 */
 	struct strbuf path;
-	int result;
+	int result, save_errno;
 
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
 	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
+	save_errno = errno;
 
 	strbuf_release(&path);
+	errno = save_errno;
 
 	return result;
 }
@@ -2056,6 +2058,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+/* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
-- 
2.0.0.438.g337c581
