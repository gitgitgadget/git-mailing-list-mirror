From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: [PATCH] fetch-pack: fix unadvertised requests validation
Date: Sat, 27 Feb 2016 09:43:54 -0300
Message-ID: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
Cc: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 13:45:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZeF3-0003gA-Rs
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 13:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562AbcB0Mo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 07:44:57 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33289 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbcB0Mo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 07:44:56 -0500
Received: by mail-qk0-f170.google.com with SMTP id s5so41497811qkd.0
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 04:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DmUQPXDXi5zRUK5HJD5nZOfyVtyQTc4gVlWE3kKMnUY=;
        b=eN5IZy0i53fMrw4otKlbQUWbyaQXe/C19Ae9WAQI5/jWXsfSMeaRw+K97TfkKIdP2Z
         itGpY3h4SbiQ7A0VUd03F40FdQ3ceK886EfEtwGPaGAfWtRvqX5PmXx7eOGujeUzhD3r
         qs7Lo9yuZA9v5dB5ZPm+xfQWIBsfL/KV//MG27kTY99fKeb3FA885f1lMe8vpOujqbWZ
         /+WxEL9BTTQ0VQM4tfU2yyHXzAyzAbWf/y60RiLHhpRcBaS6QUxqxSHO3qzBhxt4C+Aj
         Tn7zcG0CyNDRH1rM/bEMKd/vM56mZ10u56KFwpaeXZU6bf71lXeIfpWY9z8pLRj8kEZC
         wWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DmUQPXDXi5zRUK5HJD5nZOfyVtyQTc4gVlWE3kKMnUY=;
        b=kIi7vgjPV/gu5J8hAqvoMgQaUSlWRSa5NVzALq0ezNiM9iPO10zaRrMgkJHZmErCZv
         QMc4ym3h7hBv7xf4gaxtgofhVZ/1xLOoTX4N7taQZX1DnCLQzUg5brLg9P6P4bNFgPQB
         IxhOpLRBPHi+TePGIuTdb5jxXgwLnBTlEl3Etf4glcfjRBpx/Yoh2LgPebtV0K7GTODd
         X4M4ZCtmDycKsad8ceUMAnutO1Rd3U+37bIb+dcpn5QSe64WoSH6zPyTp4rajnMmZkJn
         FeO8oYhnS6YYozn2O0/fhdkTfgsvVg5ewPWfGMCER7I13V8B8mjpapZCX03yseJlUj2X
         /I/w==
X-Gm-Message-State: AD7BkJKx3IptR9ulJAIKkRhULZxnyFnUJg3jLZSDKKzTTr03q4FtCjRXXS52Yn+2Cspf2w==
X-Received: by 10.55.79.207 with SMTP id d198mr7893966qkb.49.1456577096029;
        Sat, 27 Feb 2016 04:44:56 -0800 (PST)
Received: from ghost.localdomain ([187.22.88.116])
        by smtp.gmail.com with ESMTPSA id d6sm7257581qkb.13.2016.02.27.04.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Feb 2016 04:44:55 -0800 (PST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287696>

Check was introduced in b791642 (filter_ref: avoid overwriting
ref->old_sha1 with garbage, 2015-03-19), but was always false because
ref->old_oid.hash is empty in this case. Instead copy sha1 from ref->name.

Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
---
 fetch-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 01e34b6..83b937b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -569,11 +569,11 @@ static void filter_refs(struct fetch_pack_args *args,
 			if (ref->matched)
 				continue;
 			if (get_sha1_hex(ref->name, sha1) ||
-			    ref->name[40] != '\0' ||
-			    hashcmp(sha1, ref->old_oid.hash))
+			    ref->name[40] != '\0')
 				continue;
 
 			ref->matched = 1;
+			hashcpy(ref->old_oid.hash, sha1);
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
 		}
-- 
2.7.1
