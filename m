From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 11/13] remote.c: don't short-circuit match_refs() when error in match_explicit_refs()
Date: Mon, 23 Feb 2009 01:28:59 -0500
Message-ID: <6cbc71876488bd7e14db40560459c0e1b8ae7b37.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULS-00072Y-4i
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbZBWG3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZBWG3n
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:43 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:65030 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbZBWG3a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:30 -0500
Received: by mail-gx0-f174.google.com with SMTP id 22so4839738gxk.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NDal7flUlJpwwUq2PlcsUkFybRT+rnfiR3rCiD4sekI=;
        b=EOF49ui93YZ0LTFcRPboLhwcUi0LchGp9QTe5g2/p2gduXAEkKP0Dc7pEbB9aX2odl
         6TQQsTEjbvVxn9LCc/Z0XcmQHexWjjJmxKf+9tgAISp9cpEBCk2+IJXYJQ16sFeZ70kQ
         Qo67hE9FPbYSFwqrJjD2SNU1sFyF/71sXBWxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=csc8pY5GzmIwvBqX7vHtMgc/Sk11NUNiTaC38gBIdM8UAnOI4L2mGxfoXgHKnKCjuz
         6xljHnDmnhByHlN9ztUy+9JwGxpwtnkhK1k9jqYrE1sVOXMxhxwbW1YkY997yH3hNI3e
         i7iloRtMV/L/EpxyQqHnoOxueg3IxgC8iWfXg=
Received: by 10.100.171.16 with SMTP id t16mr580804ane.80.1235370569899;
        Sun, 22 Feb 2009 22:29:29 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d35sm12280944and.58.2009.02.22.22.29.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:29 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111101>

match_refs() returns non-zero if there is an error in
match_explicit_refs(), without handling any remaining pattern ref specs.

Its existing callers exit upon receiving non-zero, so a partial result
is of no consequence to them; however it is about to have a new caller
that is interested in the complete result even if there are errors in
match_explicit_refs().

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 remote.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index ab387f2..5c14343 100644
--- a/remote.c
+++ b/remote.c
@@ -1046,6 +1046,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	struct refspec *rs;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
+	int errs;
 	static const char *default_refspec[] = { ":", 0 };
 
 	if (!nr_refspec) {
@@ -1053,8 +1054,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		refspec = default_refspec;
 	}
 	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
-	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
-		return -1;
+	errs = match_explicit_refs(src, dst, dst_tail, rs, nr_refspec);
 
 	/* pick the remainder */
 	for ( ; src; src = src->next) {
@@ -1110,6 +1110,8 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	free_name:
 		free(dst_name);
 	}
+	if (errs)
+		return -1;
 	return 0;
 }
 
-- 
1.6.2.rc1.223.gfed32
