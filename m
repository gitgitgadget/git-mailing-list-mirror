From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 10/13] remote.c: make match_refs() copy src ref before assigning to peer_ref
Date: Mon, 23 Feb 2009 01:28:58 -0500
Message-ID: <75e083170cea799499bf66792a1c3950b29d6021.1235368324.git.jaysoffian@gmail.com>
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
	id 1LbULS-00072Y-Rx
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbZBWG3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbZBWG3o
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:44 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:12876 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbZBWG32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:28 -0500
Received: by yx-out-2324.google.com with SMTP id 8so746765yxm.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vfpdMGRcUWEk0kNSuMz1+EWuWQ7g9lIssfHQTD09g18=;
        b=Z3QHtLhbktWnqlbYEhKNiSzRKzYs4tzccYCAwdNezMK5vnXkOfKEwaUmO1fnkD2Q+C
         XhkWodVQqmN9sHXwO+rFrkbTcs4V6aZ1e0otaO31Poyzjnd8DQZeN8FclsyUQl4/id6q
         ync19UQ5W+ZiZqok6ysQ+V+VoY5HX3Dt5tTjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qh56kJ1xZPU+5SL7h5GC8zIBkuXayPmhY/xk5cs2SVKGx9cEoMB0y0eGKrKWxrO95Q
         0pJdoc8kM93731li68wJ2BMG7bgd6XMxC4ZkO9jYzUK57xgbldDfkl+d9bj0mFm2NuA0
         aD4+3NEe+oJiQdPgdyqH1/uCTtixDOteXYrbc=
Received: by 10.100.96.10 with SMTP id t10mr3601358anb.32.1235370567917;
        Sun, 22 Feb 2009 22:29:27 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d35sm8325285and.38.2009.02.22.22.29.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:27 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111102>

In some instances, match_refs() was setting the peer_ref field in the
dst ref list such that it pointed to a ref in the src list, instead of
to a copy. This would cause a double-free when both the src and dst ref
lists were freed, as free_refs() frees the peer_ref. A double-free would
also occur if the same branch was pushed to two different destinations
such as:

  push = refs/heads/master:refs/heads/backup
  push = refs/heads/master:refs/heads/master

This patch corrects the problem by copying the ref when it has been
plucked from the src list.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 remote.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 5cb443f..ab387f2 100644
--- a/remote.c
+++ b/remote.c
@@ -930,6 +930,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			  struct refspec *rs)
 {
 	struct ref *matched_src, *matched_dst;
+	int copy_src;
 
 	const char *dst_value = rs->dst;
 	char *dst_guess;
@@ -940,6 +941,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	matched_src = matched_dst = NULL;
 	switch (count_refspec_match(rs->src, src, &matched_src)) {
 	case 1:
+		copy_src = 1;
 		break;
 	case 0:
 		/* The source could be in the get_sha1() format
@@ -949,6 +951,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		matched_src = try_explicit_object_name(rs->src);
 		if (!matched_src)
 			return error("src refspec %s does not match any.", rs->src);
+		copy_src = 0;
 		break;
 	default:
 		return error("src refspec %s matches more than one.", rs->src);
@@ -994,7 +997,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return error("dst ref %s receives from more than one src.",
 		      matched_dst->name);
 	else {
-		matched_dst->peer_ref = matched_src;
+		matched_dst->peer_ref = copy_src ? copy_ref(matched_src) : matched_src;
 		matched_dst->force = rs->force;
 	}
 	return 0;
@@ -1102,7 +1105,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			dst_peer = make_linked_ref(dst_name, dst_tail);
 			hashcpy(dst_peer->new_sha1, src->new_sha1);
 		}
-		dst_peer->peer_ref = src;
+		dst_peer->peer_ref = copy_ref(src);
 		dst_peer->force = pat->force;
 	free_name:
 		free(dst_name);
-- 
1.6.2.rc1.223.gfed32
