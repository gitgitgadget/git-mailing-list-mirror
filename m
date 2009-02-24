From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 06/23] remote.c: make match_refs() copy src ref before assigning to peer_ref
Date: Tue, 24 Feb 2009 04:50:54 -0500
Message-ID: <9bcec2dfd965836ae4a34385f4db7e7b42d313a5.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzu-0002Ej-VK
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbZBXJvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbZBXJvg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:36 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:21822 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828AbZBXJvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:31 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005599yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lcD/YjUnuNvkR9dz4YipH+gK9cDF38iW9AyMnJsL9OM=;
        b=Q2GsKjL3MeaQgfhPIr4YfrfshOFJt7YDQM+4kDYvKeQj2OvrGw5nY81QfmMg7VqxYr
         z7FSwMFdP8557VNiQ2wVfVQSe/1dAF4hwE/JeozLWvwL2E/TjjUu2JTfjTzgKIlnx5+z
         4TvHIjNWF1yM5YN7bFSNDVVNegJwVE/5d9k+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VXeC0Ypayssqxe+t3JfSv6zYB60p4gvL1quM6KE6bc5ITbqJyl1MmhKYfwsENg8WwN
         cbp82tEIbMcPAGiPvb8JU74kL133Rbzg3w2ueutB8wcTPnc/FyRDGLpRjG9vR6E2lmt4
         IyNpAd3CKmE4gf+vN0fyd3j0bssEVvo41C07U=
Received: by 10.100.5.16 with SMTP id 16mr5405824ane.146.1235469089436;
        Tue, 24 Feb 2009 01:51:29 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b32sm10090006ana.15.2009.02.24.01.51.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:28 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111260>

In some instances, match_refs() sets the peer_ref field of refs in the
dst list such that it points to a ref in the src list. This prevents
callers from freeing both the src and dst lists, as doing so would cause
a double-free since free_refs() frees the peer_ref.

As well, the following configuration causes two refs in the dst list to
have the same peer_ref, which can also lead to a double-free:

  push = refs/heads/master:refs/heads/backup
  push = refs/heads/master:refs/heads/master

Existing callers of match_heads() call it only once and then terminate,
w/o ever bothering to free the src or dst lists, so this is not
currently a problem.

This patch modifies match_refs() to first copy any refs it plucks from
the src list before assigning them as a peer_ref, thus future-proofing
the function against callers who might wish to free the src and/or dst
lists.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 remote.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 6385a22..64879ce 100644
--- a/remote.c
+++ b/remote.c
@@ -927,6 +927,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			  struct refspec *rs)
 {
 	struct ref *matched_src, *matched_dst;
+	int copy_src;
 
 	const char *dst_value = rs->dst;
 	char *dst_guess;
@@ -937,6 +938,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	matched_src = matched_dst = NULL;
 	switch (count_refspec_match(rs->src, src, &matched_src)) {
 	case 1:
+		copy_src = 1;
 		break;
 	case 0:
 		/* The source could be in the get_sha1() format
@@ -946,6 +948,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		matched_src = try_explicit_object_name(rs->src);
 		if (!matched_src)
 			return error("src refspec %s does not match any.", rs->src);
+		copy_src = 0;
 		break;
 	default:
 		return error("src refspec %s matches more than one.", rs->src);
@@ -991,7 +994,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return error("dst ref %s receives from more than one src.",
 		      matched_dst->name);
 	else {
-		matched_dst->peer_ref = matched_src;
+		matched_dst->peer_ref = copy_src ? copy_ref(matched_src) : matched_src;
 		matched_dst->force = rs->force;
 	}
 	return 0;
@@ -1099,7 +1102,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			dst_peer = make_linked_ref(dst_name, dst_tail);
 			hashcpy(dst_peer->new_sha1, src->new_sha1);
 		}
-		dst_peer->peer_ref = src;
+		dst_peer->peer_ref = copy_ref(src);
 		dst_peer->force = pat->force;
 	free_name:
 		free(dst_name);
-- 
1.6.2.rc1.291.g83eb
