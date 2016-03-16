From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] builtin/apply: exit when parse_binary() fails
Date: Wed, 16 Mar 2016 20:31:15 +0100
Message-ID: <1458156675-26109-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 20:33:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHCK-0004ZI-0C
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbcCPTdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:33:32 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36690 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbcCPTdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:33:31 -0400
Received: by mail-wm0-f48.google.com with SMTP id l124so60884989wmf.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Mj+LMFUcMRafTAtxuNEYobACqYEGFYYSdYgLX4aET0w=;
        b=qw5SQAAbpR6D6ffkB3UBY4wHveuwh1M4ckFFVCZOTqmRoxOjKtyfFi7sQpIyoUxpRE
         ctXgTT/k+RGnEOMM9RSGgNhqvmHunKZxlSYGV21jU93Ie6B1ExIG+D9x9fJUVkZitQkz
         j5OvRbkwLnh4TqbvhN4VscCff9jO2DbPVxSsdbnJaSSSp9wmmaljO523fnuZsE+/m0Ks
         fLmZcMBL08x1H8tCL2PoysDvGqLpay4kJ9JsEL2xN/zFPe9xn1hhA7TzKMGMQK0wMa1b
         kElOGgdHgQ54jLyVC6sh9ZpJCcqADjjManbyMhhXHVOy3FnH27ek/ZD9K8ZR2jgecyMz
         HCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mj+LMFUcMRafTAtxuNEYobACqYEGFYYSdYgLX4aET0w=;
        b=h7ikiYoDbnBt7NrxVC8VBV2VAetfQfm/MDrl1lZnYUuA3N+PndU9Clu7A5ecErisez
         cxFOruxrOIkKi4JOim5QwUVR8zF9frvFFrXXlnDtmEp02IC9NqUp0r1UccW88ZJhukAS
         55IMyRVOEDvItf4/iHvCe50xqso94fRuQSlGHHWRdM+I10g6vODfemmzDHPQ+e9ilXRs
         yMfh/hdWaCMTigq9bBTKA+9QXveVeDDHtLl5kwD4YDjwx1MZO4nRWITcfe7mlIff18I/
         hCXOVjx6NstDs5f952/7w1VQXf4JZYA3D7x261Emu5e/hL+BqbV9bNH0HjAAYsCG44+N
         Tkyg==
X-Gm-Message-State: AD7BkJLMQSlXqrbO1f78AmREc2RJV8qESTKXmW02nhUx260zrWnvOI/ykTQExaSca2C1Dg==
X-Received: by 10.28.46.5 with SMTP id u5mr6525713wmu.75.1458156810087;
        Wed, 16 Mar 2016 12:33:30 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id i2sm4414995wje.22.2016.03.16.12.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 12:33:29 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc2.54.g810e8ee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289021>

In parse_binary() there is:

	forward = parse_binary_hunk(&buffer, &size, &status, &used);
	if (!forward && !status)
		/* there has to be one hunk (forward hunk) */
		return error(_("unrecognized binary patch at line %d"), linenr-1);

so parse_binary() can return -1, because that's what error() returns.

Also parse_binary_hunk() sets "status" to -1 in case of error and
parse_binary() does "if (status) return status;".

In this case parse_chunk() should just exit, rather than add -1 to the
patchsize it computes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 42c610e..18dec0f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1872,6 +1872,11 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	return NULL;
 }
 
+/*
+ * Returns:
+ *   -1 in case of error,
+ *   the length of the parsed binary patch otherwise
+ */
 static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 {
 	/*
@@ -2017,6 +2022,8 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 			linenr++;
 			used = parse_binary(buffer + hd + llen,
 					    size - hd - llen, patch);
+			if (used < 0)
+				exit(1);
 			if (used)
 				patchsize = used + llen;
 			else
-- 
2.8.0.rc2.54.g810e8ee
