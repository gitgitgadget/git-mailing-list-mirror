From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote: fix status with branch...rebase=preserve
Date: Sat,  7 Dec 2013 07:08:37 -0600
Message-ID: <1386421717-27698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Jay Soffian <jaysoffian@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 14:16:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpHjx-0002p5-Kr
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 14:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104Ab3LGNQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 08:16:10 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:37551 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab3LGNQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 08:16:07 -0500
Received: by mail-oa0-f49.google.com with SMTP id i4so2036773oah.22
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4rP4v/KsMfq2Q+2L4yP264EMT8grGuwgFAkdwZIWQ5g=;
        b=DsHIwOLTVvWo95ptSmgXogERuUIupVQUH/bQnugwOtulyYCdD6nIKHSwA8pM/vjlhs
         S9EaEIPmvT+yLtheLS2yfnp5G4sFwuwxzsQB6FUgCuoTXjiaHL6JP2dM2r2j3N3VgiH3
         QkQZV52lGOBnqpQjrG94AhiowhgJnFmX9H1tjOT4eK+9TQKj+BLRFv+geFR0gOV6U8Kr
         NmfC3mvMz4W+sFanwoS4r0XIv/q/4FYPfOn8L1b9qnm5iuXMafb5lRlKuPwg08L1y34Z
         C1C38IVE5yp7keq1LuzY3I3NRZdHutgOH91ZXJs13crl3hUHW1mdKqZ76FXgnyyeneO5
         as0w==
X-Received: by 10.182.44.167 with SMTP id f7mr6387197obm.3.1386422166902;
        Sat, 07 Dec 2013 05:16:06 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm3944244obc.10.2013.12.07.05.16.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 05:16:06 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238978>

Commit 66713ef (pull: allow pull to preserve merges when rebasing)
didn't include an update so 'git remote status' parses branch.<name>.rebase=preserve
correctly, let's do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/remote.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 4e14891..5e4ab66 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -309,8 +309,13 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				space = strchr(value, ' ');
 			}
 			string_list_append(&info->merge, xstrdup(value));
-		} else
-			info->rebase = git_config_bool(orig_key, value);
+		} else {
+			int v = git_config_maybe_bool(orig_key, value);
+			if (v >= 0)
+				info->rebase = v;
+			else if (!strcmp(value, "preserve"))
+				info->rebase = 1;
+		}
 	}
 	return 0;
 }
-- 
1.8.4.2+fc1
