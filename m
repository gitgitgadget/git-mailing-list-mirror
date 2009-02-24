From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] remote.c: make match_refs() copy src ref before assigning to peer_ref
Date: Mon, 23 Feb 2009 23:05:34 -0500
Message-ID: <1235448334-36310-1-git-send-email-jaysoffian@gmail.com>
References: <7vzlgcmsan.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 05:07:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LboZY-0002Cj-PS
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 05:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbZBXEFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 23:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbZBXEFk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 23:05:40 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:56199 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbZBXEFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 23:05:39 -0500
Received: by yw-out-2324.google.com with SMTP id 5so966544ywh.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 20:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=x01Ubwewmf0WV5d0djm0xHG9Xj8W0xhpZ0h5N7oNSPg=;
        b=VbfYJ7SW/gsbFxvBPovcuAZ5cVIrjrUyv7VZ1kKxWslpzYiWb/h/Er4IIeAEmyEhby
         Dm6mrAEd+QVORCH7SsBQkFR5LBXavPXQ4vZvHMP+dF9h7KQ5BCCLq31wtZKa2fWxG4Ch
         T6CVWIz3ZBaUYQM+4S3X7GHUoVKmYT7fCj1xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RQAkTVERyj79dxPVF4CjuOy6oS8Fa+waU3/aqOEsV9x3OIVG0cIgjBA/rlj/ijp0X+
         i5+kEYvRUXnyMZsAYIrR16/2WxC1MBpSnlnql9p0V/T+pHtZIEC3MbbtXZ40mM2QxMU5
         REw8TG3C+t6vcsHTuL5unIaJFmcl5mAqVScHA=
Received: by 10.100.14.10 with SMTP id 10mr5033538ann.152.1235448337627;
        Mon, 23 Feb 2009 20:05:37 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b37sm5895372ana.17.2009.02.23.20.05.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 20:05:36 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <7vzlgcmsan.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111204>

In some instances, match_refs() sets the peer_ref field of refs in the
dst list such that it points to a ref in the src list. Were a caller to
free both the src and dst lists, this would cause a double-free as
free_refs() frees the peer_ref.

A double-free would also occur freeing just the dst list under the
following configuration:

  push = refs/heads/master:refs/heads/backup
  push = refs/heads/master:refs/heads/master

Since such a configuration would cause two refs in the dst list to have
the same peer_ref.

This patch corrects the problem by copying the ref when it has been
plucked from the src list.

This issue has gone undetected as the existing callers of match_heads()
call it only once and then terminate, w/o ever bothering to free the src
or dst lists.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 remote.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index d7079c6..98575be 100644
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
