From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP PATCH 3/6] unpack_callback(): use unpack_failed() consistently
Date: Sat, 19 Sep 2009 22:06:12 -0700
Message-ID: <1253423175-6339-4-git-send-email-gitster@pobox.com>
References: <1253423175-6339-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 07:06:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpEdH-00044A-Rn
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 07:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbZITFG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 01:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbZITFGY
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 01:06:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZITFGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 01:06:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D3DB391BB
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ylhL
	MouOMk5NZhsI8pQqQLrA9rI=; b=DZJdSoBjdyvFLqvfwoZZVnluFjIL2FMrD/wD
	Wdk2qxjQnYuC0ikMnzt2bmUJdfnwqrDg6yK/pSsq36RgMouHlux9DAaT/x3k2kCh
	m1fjo033vuPWR/qUOaNXxpTDC6mXj6pcgJwQm1X0kvvLhxg7KkSQtj0jvJArp4A1
	dNBbjuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ln1BuU
	bVd3mF23gj7emW4fdOn+rc0GMZCJ3czZNyswzZFN0VR4Dz8kkpwrfw2JnMYpfhuw
	qZ2QRYxZ1uIJyVy0VBrKQPTMM4RDPc1XfIAqc3D08clN5Ykb8jFm+HA8HU5aSYg9
	O7IC3eE8nIQw3g5G3FY08XoKKLQX+VZYXXWrk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ADFD391BA
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E91FD391B9 for
 <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:24 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.90.ga3b1b
In-Reply-To: <1253423175-6339-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 58A9AFAC-A5A3-11DE-810E-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128837>

When unpack_index_entry() failed, consistently call unpack_failed(),
instead of silently returning -1.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index d174fe0..c424bab 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -277,6 +277,17 @@ static int unpack_nondirectories(int n, unsigned long mask,
 	return 0;
 }
 
+static int unpack_failed(struct unpack_trees_options *o, const char *message)
+{
+	discard_index(&o->result);
+	if (!o->gently) {
+		if (message)
+			return error("%s", message);
+		return -1;
+	}
+	return -1;
+}
+
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
@@ -294,7 +305,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			int cmp = compare_entry(ce, info, p);
 			if (cmp < 0) {
 				if (unpack_index_entry(ce, o) < 0)
-					return -1;
+					return unpack_failed(o, NULL);
 				continue;
 			}
 			if (!cmp) {
@@ -352,17 +363,6 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	return mask;
 }
 
-static int unpack_failed(struct unpack_trees_options *o, const char *message)
-{
-	discard_index(&o->result);
-	if (!o->gently) {
-		if (message)
-			return error("%s", message);
-		return -1;
-	}
-	return -1;
-}
-
 /*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to manipulate the
  * resulting index, -2 on failure to reflect the changes to the work tree.
-- 
1.6.5.rc1.90.ga3b1b
