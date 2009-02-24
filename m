From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 07/23] remote.c: don't short-circuit match_refs() when error in match_explicit_refs()
Date: Tue, 24 Feb 2009 04:50:55 -0500
Message-ID: <502989f7aa7d2066089d9e31ee2d71578998175e.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzx-0002Ej-46
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbZBXJvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbZBXJvp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:45 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:17431 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbZBXJve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:34 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1006856ywh.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yw2ZxhteL2RCfUjGoHc76LiyRoKBiLnUjn15JZDIYOc=;
        b=SgoGNL3ZDjDe2eoyGWe85YVLNBzEIPK3X+Y9kzzIEjd+hAB2aqAXnYjPWfKrDeGi+H
         +jMHIM7HZug/t9JcCJXPOQgc6GmixsPYFGrwzbgcfQEr+elyJco+BtyZ/9DrZY3hkF/O
         ImgxKhzLzXORLAaNyDnVM2RAh1rxjH1L7hfoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fLLpAxCp3eyUw0pG9UwKTh3Zg0jDHtKF+MH+CZ93ZZCSoM+/KeeSbOVn72EZZ+R2o/
         7Xs5TqRyrxdH20GIqQFhPAt+8FmDI+Q4vZqGKRG0P7Nj/3MkS59LFGEJn6jSpTaw3xcx
         RCweH14YvmsYxMXPgdYYcfu7LEOPowKwxXHOg=
Received: by 10.100.14.10 with SMTP id 10mr5220745ann.152.1235469092160;
        Tue, 24 Feb 2009 01:51:32 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b7sm9543291ana.59.2009.02.24.01.51.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:31 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111265>

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
index 64879ce..9f22aaf 100644
--- a/remote.c
+++ b/remote.c
@@ -1043,6 +1043,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	struct refspec *rs;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
+	int errs;
 	static const char *default_refspec[] = { ":", 0 };
 
 	if (!nr_refspec) {
@@ -1050,8 +1051,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		refspec = default_refspec;
 	}
 	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
-	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
-		return -1;
+	errs = match_explicit_refs(src, dst, dst_tail, rs, nr_refspec);
 
 	/* pick the remainder */
 	for ( ; src; src = src->next) {
@@ -1107,6 +1107,8 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	free_name:
 		free(dst_name);
 	}
+	if (errs)
+		return -1;
 	return 0;
 }
 
-- 
1.6.2.rc1.291.g83eb
