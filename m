From: newren@gmail.com
Subject: [PATCH 1/7] fast-export: Omit tags that tag trees
Date: Fri, 19 Jun 2009 22:36:57 -0600
Message-ID: <1245472623-28103-2-git-send-email-newren@gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusambite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 06:47:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHsTy-00067G-8t
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 06:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbZFTErF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 00:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbZFTErE
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 00:47:04 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:42466 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbZFTErD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 00:47:03 -0400
Received: by pxi40 with SMTP id 40so337490pxi.33
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 21:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zkIdLJUXhqaAF8CiiD/MYP9rdEOQjbTSzmxbme7xCFc=;
        b=NiGmWcVQVpab4a9nm+u3K9p5qRX1TeB4BAyruq3Zsxyn5m9CjQIurWGL4VUPxqx2+A
         1GRajz9aDGe4HoBedjvQVXpCtZ6h02ZCKDsOnjjyCb1U4z9DQ+t6gtIIk78GpXbnFmkY
         EvXSuKzFWQjJz/mwbcnyoIRTCgpReyh+767AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p+WyXkvR3YovU3SQGa+ZqwlBTirbEOyJupPHF33vNhxUObhagJxq7DmgfhlC/gvBNr
         NnxXktIcZ+zgh0uN0S5QzD5kBt35tVDzUlbUecmeiGqy4XBaOtezUqgYBghBqVx51qF/
         Lb0g77CYPBTW7Qnwlvp4cqhQZXDrW9/SXtIII=
Received: by 10.142.154.9 with SMTP id b9mr1627658wfe.154.1245472766727;
        Fri, 19 Jun 2009 21:39:26 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 22sm39467wfi.32.2009.06.19.21.39.25
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 21:39:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245472623-28103-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121930>

From: Elijah Newren <newren@gmail.com>

Commit c0582c53bcf4e83bba70e1ad23abbad31f96ebc8 introduced logic to just
omit tags that point to tree objects.  However, a case was missed
resulting in a tag being output which pointed at "mark :0", which would
cause fast-import to crash.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin-fast-export.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 6cef810..891e2d4 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -407,9 +407,15 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
 		const char *name = extra_refs->items[i].string;
 		struct object *object = extra_refs->items[i].util;
+		struct tag *tag;
 		switch (object->type) {
 		case OBJ_TAG:
-			handle_tag(name, (struct tag *)object);
+			tag = (struct tag *)object;
+			if (tag->tagged->type == OBJ_TREE) {
+				/* Ignore this tag altogether */
+				return;
+			}
+			handle_tag(name, tag);
 			break;
 		case OBJ_COMMIT:
 			/* create refs pointing to already seen commits */
-- 
1.6.3.2.323.gfb84f
