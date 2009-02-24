From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 21/23] refactor find_refs_by_name to accept const list
Date: Tue, 24 Feb 2009 04:51:09 -0500
Message-ID: <ca07244190a8ed3eba1ee19198e53dbb6ae09417.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu04-0002Ej-S8
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162AbZBXJwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105AbZBXJwN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:52:13 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:29393 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074AbZBXJwL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:52:11 -0500
Received: by an-out-0708.google.com with SMTP id c2so1048556anc.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gbODCKMUvcixHEbFoTGJoVshXrV97M1uH3strGKZYl4=;
        b=Cj9+Sxy1HGp2TW8XX72l2DbrxXYhxnFomjH0VWSZTbhnU52rmPNcyyPNJmJ8i7mAYZ
         vIZ6O2nEg4WrCrDolN1m6R99Oelf4LIkVQXWZknmGMg96bU8vGTbISBuAE8Z+DDTh+GG
         UCmroNIzG7m0XA9pSofH/4SWfqxvSOcR9jhHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=up66ykawHpAMXDnyXGYfFomJJ4sk1v4nx0G09RdrE61OK7AHoWgm4kSFyYlOJ4X2nS
         r+lpbDNWkL1YtrSqp5rBmP8gJRcjXBZcWLeXdcDMkYvRvw3LhOciHK1llGrjNA0M3uIU
         tiZ0UHZtUe/dE+rxF5Bj1+700U2iwtdLke11Q=
Received: by 10.100.109.13 with SMTP id h13mr5280637anc.21.1235469127651;
        Tue, 24 Feb 2009 01:52:07 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b37sm1464232ana.57.2009.02.24.01.52.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:52:07 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111274>

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
