From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fsck: drop unused parameter from traverse_one_object()
Date: Wed, 26 Jan 2011 12:46:55 -0800
Message-ID: <7vy667jsu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 26 21:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCGo-0000Hg-Dk
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab1AZUrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 15:47:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab1AZUrE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 15:47:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 154FA355F;
	Wed, 26 Jan 2011 15:47:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=vZU7
	YOzWJrbIpVmvK846v8pvdqw=; b=WpUwb7s/6s4LTUORc1k7q+eUldAGSR1MADxw
	xjkfTnVzdFdkEPNESHLL66aK0HIM5FBEFrAJHih821kyrRYbVOOKCMNb2KNovIiY
	BWSKhqBfzF+W1xvyYS9CNn+TWI1FjzHzx0a4SwNhLMx6owUsHi1BVFGhZsPtcuz+
	Bb5Zjxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=T4w
	upvckU8RFn31PMctTIp30Dvj40/d5TYX2nDxW+8CQOw9xnJnuLtyiMO6Iu5lqH6O
	kTrUv0sy2tejLVViR75LZyZX2T4WRrG93P7SGyZns/vnjKFj2HX1JHVy4MEVymI5
	4th3HcAr+vgEERmUOlzJuS5Kl+6jJlc7QWOeoHQE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DCD5A355E;
	Wed, 26 Jan 2011 15:47:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D35D0355B; Wed, 26 Jan 2011
 15:47:48 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A4E809A-298D-11E0-B2F7-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165543>

Also add comments to seemingly unsafe pointer dereferences, that
are all safe.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6d5ebca..91409a0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -74,7 +74,13 @@ static int mark_object(struct object *obj, int type, void *data)
 {
 	struct object *parent = data;
 
+	/*
+	 * The only case data is NULL or type is OBJ_ANY is when
+	 * mark_object_reachable() calls us.  All the callers of
+	 * that function has non-NULL obj hence ...
+	 */
 	if (!obj) {
+		/* ... these references to parent->fld are safe here */
 		printf("broken link from %7s %s\n",
 			   typename(parent->type), sha1_to_hex(parent->sha1));
 		printf("broken link from %7s %s\n",
@@ -84,6 +90,7 @@ static int mark_object(struct object *obj, int type, void *data)
 	}
 
 	if (type != OBJ_ANY && obj->type != type)
+		/* ... and the reference to parent is safe here */
 		objerror(parent, "wrong object type in link");
 
 	if (obj->flags & REACHABLE)
@@ -109,7 +116,7 @@ static void mark_object_reachable(struct object *obj)
 	mark_object(obj, OBJ_ANY, NULL);
 }
 
-static int traverse_one_object(struct object *obj, struct object *parent)
+static int traverse_one_object(struct object *obj)
 {
 	int result;
 	struct tree *tree = NULL;
@@ -138,7 +145,7 @@ static int traverse_reachable(void)
 		entry = pending.objects + --pending.nr;
 		obj = entry->item;
 		parent = (struct object *) entry->name;
-		result |= traverse_one_object(obj, parent);
+		result |= traverse_one_object(obj);
 	}
 	return !!result;
 }
@@ -556,8 +563,8 @@ static int fsck_cache_tree(struct cache_tree *it)
 			      sha1_to_hex(it->sha1));
 			return 1;
 		}
-		mark_object_reachable(obj);
 		obj->used = 1;
+		mark_object_reachable(obj);
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
 	}
-- 
1.7.4.rc3.259.g12451
