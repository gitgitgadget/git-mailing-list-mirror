From: Andrew Wheeler <agwheeler@gmail.com>
Subject: [PATCH] push --force-with-lease: Fix ref status reporting
Date: Wed, 20 Jan 2016 21:17:28 -0600
Message-ID: <1453346248-4489-1-git-send-email-agwheeler@gmail.com>
Cc: gitster@pobox.com, Andrew Wheeler <awheeler@motorola.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 04:17:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM5kd-00050D-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 04:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbcAUDRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 22:17:32 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33727 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcAUDRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 22:17:30 -0500
Received: by mail-pf0-f178.google.com with SMTP id e65so15516455pfe.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 19:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ao18iNqIwA7nGV91ijDIKLBcA3Lu0wh5Wj9vJ0FkOsg=;
        b=TxLPy1eI1wGBogfy2cDRbj4GvwWDZY0edq4ii2NrhdNlwhO+UpeE5YouphwJ3uB2Sw
         HDQ0a/ZqUn70UQw1bhjpca/Rb4jMta+LC4SLT8r6q6JgGvIhSH99FBTc73UPb73FDUQ9
         D8vzlkLLoldvXvaP1hC0yojAxZuHwBFm5c+Ywf8UAbL488XWutmEGUc4JdvwgLM947KR
         JCp782aVFSDELkrss9eDRRiFiECWRSXMFkhGF0iiuX4qh3iyoL0in64iWg8LEzTAMQxO
         v/51r8UKL2a4sX7dIFIqK5ZGSoIE97dd9ZqqYE9OQ2A44hmQB9i8Y4aDxd3MXZVXz9Vg
         WIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ao18iNqIwA7nGV91ijDIKLBcA3Lu0wh5Wj9vJ0FkOsg=;
        b=THU5qlQ78bL3iGHqwiKTskLpUkkJ3RflXmMrUc9QCaKg0XXWQIK/z+TY13XpWLl3Z5
         YnmJI/3yDPlOnOIq65F/nMJvI1/ju927MKEX1w2cXE51ZWKeU7DffVZSTkPpCYGI4Fwt
         BlUfMf/MDDHQ9MBGBOUGiYVpT1XJPM01Xta16riDKGoBS2H82QWhKHCQ6r0KUMI/OSeb
         PP62HFxrQ/bI46tZ8dqhev+DCg/gLtsOwh9J8Do3GQWY6b4cdz0sfwPT5bjJgZPQWluE
         +8xVFZnrMsNGtIbbg3+Fg0L/tMVWz+ApfhOHfdSmkF/uAh4a9gQesgT4XsBYqztCbJKU
         yT6w==
X-Gm-Message-State: ALoCoQmUmQc5E7igYkaj7km2EmsYJYaNq1aVmAsa+WZmr4RbbWS1iHoKbRBpOInyJBV8uS0ArkjtyYqg/ExNVt3X6XzrWiHJWw==
X-Received: by 10.98.73.207 with SMTP id r76mr57770847pfi.118.1453346250167;
        Wed, 20 Jan 2016 19:17:30 -0800 (PST)
Received: from mba.local.com ([144.189.31.2])
        by smtp.gmail.com with ESMTPSA id s84sm51690258pfa.74.2016.01.20.19.17.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jan 2016 19:17:29 -0800 (PST)
X-Mailer: git-send-email 1.7.11.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284497>

From: Andrew Wheeler <awheeler@motorola.com>

The --force--with-lease push option leads to less
detailed status information than --force. In particular,
the output indicates that a reference was fast-forwarded,
even when it was force-updated.

Modify the --force-with-lease ref status logic to leverage
the --force ref status logic when the "lease" conditions
are met.

Signed-off-by: Andrew Wheeler <awheeler@motorola.com>
---
 remote.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 9d34b5a..bad6213 100644
--- a/remote.c
+++ b/remote.c
@@ -1545,11 +1545,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		}
 
 		/*
-		 * Bypass the usual "must fast-forward" check but
-		 * replace it with a weaker "the old value must be
-		 * this value we observed".  If the remote ref has
-		 * moved and is now different from what we expect,
-		 * reject any push.
+		 * If the remote ref has moved and is now different
+		 * from what we expect, reject any push.
 		 *
 		 * It also is an error if the user told us to check
 		 * with the remote-tracking branch to find the value
@@ -1560,10 +1557,14 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			if (ref->expect_old_no_trackback ||
 			    oidcmp(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
+			else
+				/* If the ref isn't stale then force the update. */
+				force_ref_update = 1;
 		}
 
 		/*
-		 * The usual "must fast-forward" rules.
+		 * If the update isn't already rejected then check
+		 * the usual "must fast-forward" rules.
 		 *
 		 * Decide whether an individual refspec A:B can be
 		 * pushed.  The push will succeed if any of the
@@ -1580,9 +1581,10 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *
 		 * (4) it is forced using the +A:B notation, or by
 		 *     passing the --force argument
+		 *
 		 */
 
-		else if (!ref->deletion && !is_null_oid(&ref->old_oid)) {
+		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
 			else if (!has_object_file(&ref->old_oid))
-- 
1.7.11.2
