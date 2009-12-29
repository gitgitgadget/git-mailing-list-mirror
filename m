From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] resolve-undo: allow plumbing to clear the information
Date: Tue, 29 Dec 2009 13:42:33 -0800
Message-ID: <1262122958-9378-5-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:43:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqU-0003SS-86
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbZL2Vmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbZL2Vmx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:42:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbZL2Vmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD4148C7ED
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CcJa
	neQXrINAWGjUizxthSRIMq4=; b=ogSy60NKcfW82DybmeJfQn01kEkaWMkutArI
	0FpbhYkP5dbIyqF6Td/BnBZHzJ3DMHvqbHl3zXK+h5BFXf+r6ccq6TthltbyfBSq
	bJlThYqek3gE3G6UvOoav10AEjDlpd268OXxzSLGSyvR/3aE2O/Ry9lx8XmxPwK6
	Vicbh0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rytOr8
	s/knIrUsrVdd4ar8VKM/Cd+2dV8wm3WF+YgIDUmSJe78PB5uHtVAMIehRm7YEwAu
	sDMqdoeG5oeT4qW8FJZHMdJA+DgsWo2wGwvuQ/SanOO9lN5LZQG5f60nXXAITrPw
	2mU1p3vEF2HpQCIzxshJcBnCG4CdL6JV16sMo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B97C38C7EC
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 367F18C7EB for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:48 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1BA3D0BE-F4C3-11DE-A02A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135828>

At the Porcelain level, operations such as merge that populate an
initially cleanly merged index with conflicted entries clear the
resolve-undo information upfront.  Give scripted Porcelains a way
to do the same, by implementing "update-index --clear-resolve-info".

With this, a scripted Porcelain may "update-index --clear-resolve-info"
first and repeatedly run "update-index --cacheinfo" to stuff unmerged
entries to the index, to be resolved by the user with "git add" and
stuff.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-update-index.c    |    5 +++++
 t/t2030-unresolve-info.sh |   12 ++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index a6b7f2d..a19e786 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -9,6 +9,7 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "refs.h"
+#include "resolve-undo.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -703,6 +704,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				verbose = 1;
 				continue;
 			}
+			if (!strcmp(path, "--clear-resolve-undo")) {
+				resolve_undo_clear();
+				continue;
+			}
 			if (!strcmp(path, "-h") || !strcmp(path, "--help"))
 				usage(update_index_usage);
 			die("unknown option %s", path);
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 785c8b3..9844802 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -85,4 +85,16 @@ test_expect_success 'rm records reset clears' '
 	check_resolve_undo discarded
 '
 
+test_expect_success 'plumbing clears' '
+	prime_resolve_undo &&
+	test_tick &&
+	git commit -m merged &&
+	echo committing keeps &&
+	check_resolve_undo kept file initial:file second:file third:file &&
+
+	echo plumbing clear &&
+	git update-index --clear-resolve-undo &&
+	check_resolve_undo cleared
+'
+
 test_done
-- 
1.6.6
