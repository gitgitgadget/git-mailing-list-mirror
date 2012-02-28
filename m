From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] am -3: allow nonstandard -p<num> option
Date: Tue, 28 Feb 2012 15:24:54 -0800
Message-ID: <1330471495-12013-2-git-send-email-gitster@pobox.com>
References: <1330471495-12013-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 00:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2WQ3-0002CE-FP
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 00:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320Ab2B1XZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 18:25:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703Ab2B1XY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 18:24:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA1327A1C
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 18:24:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=cfMW
	99B3rfk/QBvWe4cgiOp+V3k=; b=tLneSzWiFKXqRYABpapk+kVaVxE1OfpoS4Z2
	69/TU2EIgApzMyZlmA40oSKb+6v1Vz3U5K1CbLRoDBW0JqXlMSTiHDkN2HJbD6XQ
	byUNuUwuq5D9YI8k6FFysbn7oV41VR53wZhU4s+cGjRGWxIQKLRHHIiyxeWQcp/I
	1J/jZBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cCyzOb
	qXjp3ufiMP26U5DSPleORXMamDYVfn+he/wY/b10E4t56BqmT3YGzKSstoOyn9jD
	QiWsn4r19fP4hIjRFXK+n1ihcm3CNlb81R6JmeMgFOSAClX6U7ON2fF/pGbhK8hu
	vOXod8U8zIhixAUeuGE64rxH1INF9miZVansU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1C0B7A1B
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 18:24:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D88E7A1A for
 <git@vger.kernel.org>; Tue, 28 Feb 2012 18:24:58 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.344.g3e8c86
In-Reply-To: <1330471495-12013-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6DF59BC6-6263-11E1-9E94-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191791>

When falling back to 3-way merge, we run "git apply" to synthesize the
fake ancestor tree by parsing the incoming patch, and another "git apply"
to apply the patch to the fake ancestor tree.  Both invocation need to
be aware of the custom -p<num> setting to parse patches that were prepared
with non-standard src/dst prefix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 1c13b13..d5d168f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -127,15 +127,18 @@ fall_back_3way () {
     mkdir "$dotest/patch-merge-tmp-dir"
 
     # First see if the patch records the index info that we can use.
-    git apply --build-fake-ancestor "$dotest/patch-merge-tmp-index" \
-	"$dotest/patch" &&
+    cmd="git apply $git_apply_opt --build-fake-ancestor" &&
+    cmd="$cmd "'"$dotest/patch-merge-tmp-index" "$dotest/patch"' &&
+    eval "$cmd" &&
     GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
     git write-tree >"$dotest/patch-merge-base+" ||
     cannot_fallback "$(gettext "Repository lacks necessary blobs to fall back on 3-way merge.")"
 
     say Using index info to reconstruct a base tree...
-    if GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-	git apply --cached <"$dotest/patch"
+
+    cmd='GIT_INDEX_FILE="$dotest/patch-merge-tmp-index"'
+    cmd="$cmd git apply --cached $git_apply_opt"' <"$dotest/patch"'
+    if eval "$cmd"
     then
 	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
 	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
-- 
1.7.9.2.344.g3e8c86
