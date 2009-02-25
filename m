From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 10/21] remote: make match_refs() not short-circuit
Date: Wed, 25 Feb 2009 03:32:17 -0500
Message-ID: <6a24ea1542d8a1ec750005a710f40e0730db1aa4.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF6-0000Xo-D1
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759869AbZBYIdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759648AbZBYIdB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:01 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:56091 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759292AbZBYIcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:55 -0500
Received: by mail-gx0-f174.google.com with SMTP id 22so8310386gxk.13
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IqPokWc0UC0WY6YLT7GukrNbPfHA63UOw7iFtA8bvNA=;
        b=tFIwb/RypAOrJWi13An4EQuX+Cbu0L22q9S073EW5dHyQVj8GztpFZsIW5MbZwfuUI
         pwT4DwGclRMaMUWWrYm5AqqEKu5Ha9aXaDRtn7Z46C2lHtI3Fx7Btk4aEswnDjwBoCfm
         rl4Mwg0oxSSEtokTKI5rLnG0N+yGjzl90MTGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eBnbNic0P+hHQiRI/JAmo/I7TxbKCsQST2yNGZyCqC9seTStWGGsg0RbLG89AoQIwf
         TTiFSt4nZJ899aYyckhZQ5vm8o7YKMLB0WXKUPRkzFkcxccW1gH2MP2+2mBC6mkEl+U9
         UchuCngw9eOO3o9eK6dHG6LCGG5scHrGXXH5o=
Received: by 10.100.41.9 with SMTP id o9mr801594ano.39.1235550774179;
        Wed, 25 Feb 2009 00:32:54 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d21sm8701893and.6.2009.02.25.00.32.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:53 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111399>

match_refs() returns non-zero if there is an error in
match_explicit_refs(), without handling any remaining pattern ref specs.

Its existing callers exit upon receiving non-zero, so a partial result
is of no consequence to them; however a new caller, builtin-remote, is
interested in the complete result even if there are errors in
match_explicit_refs().

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 remote.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 81def8b..926f842 100644
--- a/remote.c
+++ b/remote.c
@@ -1044,6 +1044,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	struct refspec *rs;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
+	int errs;
 	static const char *default_refspec[] = { ":", 0 };
 
 	if (!nr_refspec) {
@@ -1051,8 +1052,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		refspec = default_refspec;
 	}
 	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
-	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
-		return -1;
+	errs = match_explicit_refs(src, dst, dst_tail, rs, nr_refspec);
 
 	/* pick the remainder */
 	for ( ; src; src = src->next) {
@@ -1108,6 +1108,8 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	free_name:
 		free(dst_name);
 	}
+	if (errs)
+		return -1;
 	return 0;
 }
 
-- 
1.6.2.rc1.291.g83eb
