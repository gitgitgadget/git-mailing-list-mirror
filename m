From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 03/21] refactor find_ref_by_name() to accept const list
Date: Wed, 25 Feb 2009 03:32:10 -0500
Message-ID: <6e9d6d590b6f7f7c2457a474f161573d56ea4ae5.1235546707.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:34:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFDT-0008Sh-MM
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759134AbZBYIco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758940AbZBYIcm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:42 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:33864 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZBYIci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:38 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1288214ywh.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gbODCKMUvcixHEbFoTGJoVshXrV97M1uH3strGKZYl4=;
        b=UW1kQEl7WJI5VHlW9Ka3i5+fU4vTSRyQZBiLYNyhA2CVg5eVHl9TLLiYcOECYil4T4
         pEKuKL9JBbWlO+sLvIxLEaHkbEH9B5AAu0gyWF0qv/aBXmrQ11/KufAXgrz9VwxLsbhP
         +b/9gR1S2lEZmDu2y1WYYl0sTYCw6Z6guhEdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JO7YyWXm5FEvknAGvzsd+hvWS3PELyEJBFHEJ8aSxXBiaTwe+QgW+o27YBDYiTNuvl
         OIjp4O6tcTTZe/52R+5qF3tMKinM5oO2e6HKcFvw1s43lkegtafXfIHzjT8xk7QyJs/d
         T48ktDC19yBwj2zlrhD6hUxqVSIgct6bO/VZU=
Received: by 10.100.43.14 with SMTP id q14mr832402anq.60.1235550756880;
        Wed, 25 Feb 2009 00:32:36 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c1sm13852543ana.20.2009.02.25.00.32.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:36 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111392>

From: Jeff King <peff@peff.net>

Since it doesn't actually touch its argument, this makes
sense.

However, we still want to return a non-const version (which
requires a cast) so that this:

  struct ref *a, *b;
  a = find_ref_by_name(b);

works. Unfortunately, you can also silently strip the const
from a variable:

  struct ref *a;
  const struct ref *b;
  a = find_ref_by_name(b);

This is a classic C const problem because there is no way to
say "return the type with the same constness that was passed
to us"; we provide the same semantics as standard library
functions like strchr.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 cache.h |    2 +-
 refs.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 189151d..609380d 100644
--- a/cache.h
+++ b/cache.h
@@ -801,7 +801,7 @@ struct ref {
 #define REF_HEADS	(1u << 1)
 #define REF_TAGS	(1u << 2)
 
-extern struct ref *find_ref_by_name(struct ref *list, const char *name);
+extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 
 #define CONNECT_VERBOSE       (1u << 0)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
diff --git a/refs.c b/refs.c
index 6eb5f53..b2a37e1 100644
--- a/refs.c
+++ b/refs.c
@@ -1628,10 +1628,10 @@ int update_ref(const char *action, const char *refname,
 	return 0;
 }
 
-struct ref *find_ref_by_name(struct ref *list, const char *name)
+struct ref *find_ref_by_name(const struct ref *list, const char *name)
 {
 	for ( ; list; list = list->next)
 		if (!strcmp(list->name, name))
-			return list;
+			return (struct ref *)list;
 	return NULL;
 }
-- 
1.6.2.rc1.291.g83eb
