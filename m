From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 02/10] builtin/index-pack.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:16 +0000
Message-ID: <20160603074724.12173-2-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:48:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqe-0000YP-2q
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbcFCHsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33320 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbcFCHsk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id a136so21580194wme.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M1RfqzCc1kQDbQANSTJLXz7086hbgz7iOQVN2+1x1Po=;
        b=SqJTButTJJcZyJoz5XbwhqBu302gTYqPBaOkdnWTD8e2atGKNEB/DMV5dXMWBB3Ttf
         ebmnvr8x/ipjnHPgo3qA9uw0RUpS8yuu/isnDyDFdOKny24nSr2zZ0kz75FlnFRlpjMl
         ZwK2A6SySMT5WCJRtp48PL3RGb22eltxpxipMXJFQCogchySDdma4wTuWYZ5e583JBx4
         GWeHnCvIPiazwaawbNInwH/UgwhiBuwC2DKes2yZjbBOz5AaXgHHj9cpuv2a8JkmvWpB
         6UbScjNmGhP9dwNFlIQG7SOMnBlMktaep491wHviGPSDrjbt6RKqOgNKRlx5Lea4tR+5
         CRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M1RfqzCc1kQDbQANSTJLXz7086hbgz7iOQVN2+1x1Po=;
        b=ZTX4hQ+c98zMJM70FQaLqEFO+dQBjEgzTHXG+bEPRk6DTg5SI2f6dcf1WZnZYo41F7
         7RtZo+TmXk2bOlEbFBPhiSWwEjwIVi0VW0x4j4JoBmn3M0rR4BH11XQFK7DkxSe0PHnH
         /MKKU+Is88Jq2YEqZF7FHjbqqu+wm24/z1hN15A9dgicgZKWfPoZrJY1fi5I8yO8NGBx
         aOD8qYP8krPtPcK+OEmPFMWcA1vfU28x5fOqYKhzG69O3J5VMkSb6qXMDl/rp099kfzq
         SthXDBN9yWGxjAqBfXaidF1VnBXPMuJK0EEoE75IZdIBVUs93GgiFEfvWStTq5hHRHoM
         Thcw==
X-Gm-Message-State: ALyK8tJgpALzCPT9t/fiEYPXD2xDFtOQ5gV5xIakWXfBn5xH+9DIm0CeNmldFq7zfNmr5Q==
X-Received: by 10.194.178.166 with SMTP id cz6mr1606736wjc.102.1464940118943;
        Fri, 03 Jun 2016 00:48:38 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:38 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296282>

With the commits f2f02675 and 5096d490 we have been converted in some files the call
from snprintf/sprintf/strcpy to xsnprintf. This patch converts the remaining calls
to snprintf with xsnprintf under the following conditions:

- The call to snprintf does not control the outcome of the command
  or the presence of truncation errors.
- A call to snprintf can generate a fatal error, directly or indirectly.

The other few remaining cases in which a call to snprintf can generate a soft error
have not been changed.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e8c71fc..c032fe7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1443,7 +1443,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		printf("%s\n", sha1_to_hex(sha1));
 	} else {
 		char buf[48];
-		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
+		int len = xsnprintf(buf, sizeof(buf), "%s\t%s\n",
 				   report, sha1_to_hex(sha1));
 		write_or_die(1, buf, len);
 
-- 
2.9.0.rc1.265.geb5d750
