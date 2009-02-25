From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 09/21] remote: make match_refs() copy src ref before assigning to peer_ref
Date: Wed, 25 Feb 2009 03:32:16 -0500
Message-ID: <4765629ca76c4268d8ba2625f1adab27be838ca1.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF5-0000Xo-M7
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759781AbZBYIdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759638AbZBYIc7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:59 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:45147 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758793AbZBYIcy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:54 -0500
Received: by an-out-0708.google.com with SMTP id c2so1348082anc.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OfZQrdxLj46vncfFaKzvJsoKDvLsY4TO2Xd43CPKubk=;
        b=WFTS/9HWLd5BbRw+3ajhOvOvsj5IwgOLnA3zWb0xmIGpwxR7xUO6RsfNPj81Z9zem1
         dNRqlhF+o5T/S1p4NdI2NtE0vVaWnTQ7TZAtQOrfC9U6SQvOHZIopdcfdy4Xgsyr/Stu
         NfoL6QkM4h6ly2vCRLNRYkHLOJl9IiGPBNm6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tKcHmqpVYlshPwXcdu4uWKCRpblvYTtpeHnEhgkPXktnvPEZAZJt0di/FtfYT6z+Tb
         T3Q5AWFAiwUpgPHdG8RCJvouNQtnQq7utq7elvr74U9+b2yBZa3BWI+pPcqI+ok4CUxQ
         1zb8cyvL70iB5NLdD6u5jCMZnziNtWHrT2C80=
Received: by 10.100.151.14 with SMTP id y14mr776029and.117.1235550772234;
        Wed, 25 Feb 2009 00:32:52 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d35sm2145095and.38.2009.02.25.00.32.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:51 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111398>

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
the src list before assigning them as a peer_ref. This allows
builtin-remote, a future caller, to free the src and dst lists.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 remote.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 3940a3c..81def8b 100644
--- a/remote.c
+++ b/remote.c
@@ -928,6 +928,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			  struct refspec *rs)
 {
 	struct ref *matched_src, *matched_dst;
+	int copy_src;
 
 	const char *dst_value = rs->dst;
 	char *dst_guess;
@@ -938,6 +939,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	matched_src = matched_dst = NULL;
 	switch (count_refspec_match(rs->src, src, &matched_src)) {
 	case 1:
+		copy_src = 1;
 		break;
 	case 0:
 		/* The source could be in the get_sha1() format
@@ -947,6 +949,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		matched_src = try_explicit_object_name(rs->src);
 		if (!matched_src)
 			return error("src refspec %s does not match any.", rs->src);
+		copy_src = 0;
 		break;
 	default:
 		return error("src refspec %s matches more than one.", rs->src);
@@ -992,7 +995,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return error("dst ref %s receives from more than one src.",
 		      matched_dst->name);
 	else {
-		matched_dst->peer_ref = matched_src;
+		matched_dst->peer_ref = copy_src ? copy_ref(matched_src) : matched_src;
 		matched_dst->force = rs->force;
 	}
 	return 0;
@@ -1100,7 +1103,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
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
