From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 7/8] push: clarify rejection of update to non-commit-ish
Date: Thu, 29 Nov 2012 19:41:39 -0600
Message-ID: <1354239700-3325-8-git-send-email-chris@rorvick.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFdt-0007Rx-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab2K3Bn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:26 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43897 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab2K3BnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:24 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so13169118iea.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=R6evnx96GXoTpyAMtT8dLo4vnbg506sqhebXMmnnMJI=;
        b=Xx+VlkYu6vGgVsaUPGC5Wwmtajp+65vdOXVPBezCKUA7phSwsXPSFadKGQZySkAumP
         cYBQtEhoLv68ikd4YNT8RGjIjjAH2sFUIQx4eVNFCKiEQOFpRqEottKd48gpbZMCMqxv
         Wt6M3VK2bu5WMSe6ezdQdNTxAw7+UUnUTeVG93NE8WhO807DjIUQMtx4QomgjCmpJb9x
         lMIuIb6tSMau2OsHEWxROqkbsdNUC9uq5ZAjByndfPRDorXI9MtoRBt/6rrNvKvg2gPv
         Ou9SAxncUJknrLD3NOLlbv0e8T24dRRLtrbtQZ0SGVR60ZQO/GPj3FwpDo3GsOsQnsZt
         POcA==
Received: by 10.50.154.227 with SMTP id vr3mr27464885igb.43.1354239804128;
        Thu, 29 Nov 2012 17:43:24 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210890>

Pushes must already (by default) update to a commit-ish due to the fast-
forward check in set_ref_status_for_push().  But rejecting for not being
a fast-forward suggests the situation can be resolved with a merge.
Flag these updates (i.e., to a blob or a tree) as not forwardable so the
user is presented with more appropriate advice.

While updating *from* a tag object is potentially destructive, updating
*to* a tag is not.  Additionally, a push to the refs/tags/ hierarchy is
already excluded from fast-forwarding, and refs/heads/ is protected from
anything but commit objects by a check in write_ref_sha1().  Thus
someone fast-forwarding to a tag is probably not doing so by accident.
Since updating to a tag is benign and unlikely to cause confusion, allow
it in case someone finds the behavior useful.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 remote.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/remote.c b/remote.c
index f5bc4e7..ee0c1e5 100644
--- a/remote.c
+++ b/remote.c
@@ -1291,6 +1291,11 @@ static inline int is_forwardable(struct ref* ref)
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 
+	/* new object must be commit-ish */
+	o = deref_tag(parse_object(ref->new_sha1), NULL, 0);
+	if (!o || o->type != OBJ_COMMIT)
+		return 0;
+
 	return 1;
 }
 
-- 
1.8.0.158.g0c4328c
