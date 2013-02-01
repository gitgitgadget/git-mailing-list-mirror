From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] apply: diagnose incomplete submodule object name better
Date: Thu, 31 Jan 2013 20:32:05 -0800
Message-ID: <1359693125-22357-4-git-send-email-gitster@pobox.com>
References: <20130130224904.GB1053@book.hvoigt.net>
 <1359693125-22357-1-git-send-email-gitster@pobox.com>
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 05:32:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U18Iu-0002r0-7t
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 05:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab3BAEcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 23:32:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136Ab3BAEcN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 23:32:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26BB8C810;
	Thu, 31 Jan 2013 23:32:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zFOp
	b0Pb9cYNnPn06GsexkoU9dI=; b=hzH65JbqBjsOCE5jWn4yW+WTIKviVfL4zNVe
	ucGNDjdiMWi6ebtm8lhMkoq2fWWYtosHQTKKpRF2zFZOejYMW7EXPIzFW2eA6Y68
	f4d8LC8e7YQTT3TD712nx9cZGa9aTYLUK69VIs/8KAGIvnDnaOGFdIS/i9gm04cN
	1iVfOs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	k97A5n53q3KO+G5/wyA1j/eFcZFUV0jQsP42eVajp7zPqclcMd5Vk/bPoKifntpO
	d8GGAWXFI3zJbhKB02DMSurMc/pBfqBcG51iQddr+guk16ia+s4evvS/YKBM4URi
	qZCz0gwwOxHtCrHMI3Ndf/JNzy7uk4poQ+owGAYGVOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD71C80D;
	Thu, 31 Jan 2013 23:32:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5D8BC809; Thu, 31 Jan 2013
 23:32:12 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.612.g09f4be5
In-Reply-To: <1359693125-22357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 59471FF4-6C28-11E2-9539-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215201>

"git am -3" uses this function to build a tree that records how the
preimage the patch was created from would have looked like.  An
abbreviated object name on the index line is ordinarily sufficient
for us to figure out the object name the preimage tree would have
contained, but a change to a submodule by definition shows an object
name of a submodule commit which our repository should not have, and
get_sha1_blob() is not an appropriate way to read it (or get_sha1()
for that matter).

Use get_sha1_hex() and complain if we do not find a full object name
there.

We could read from the payload part of the patch to learn the full
object name of the commit, but the primary user "git rebase" has
been fixed to give us a full object name, so this should suffice
for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a1db7b4..1f78e2c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3606,7 +3606,11 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 		if (0 < patch->is_new)
 			continue;
 
-		if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
+		if (S_ISGITLINK(patch->old_mode)) {
+			if (get_sha1_hex(patch->old_sha1_prefix, sha1))
+				die("submoule change for %s without full index name",
+				    name);
+		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
-- 
1.8.1.2.612.g09f4be5
