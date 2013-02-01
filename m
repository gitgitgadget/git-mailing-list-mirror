From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] apply: simplify build_fake_ancestor()
Date: Thu, 31 Jan 2013 20:32:04 -0800
Message-ID: <1359693125-22357-3-git-send-email-gitster@pobox.com>
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
	id 1U18It-0002r0-Al
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 05:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300Ab3BAEcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 23:32:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab3BAEcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 23:32:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E22CC803;
	Thu, 31 Jan 2013 23:32:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uKMI
	8jjfTjpc50wb5Cr+nYilinM=; b=ARSY/PfwheTL66IEigmJMk3mZDE0SB4q6Yqk
	/Wv1rZZ5brASAzZ/ONmekJ2PfM9oN1a/VjkWq0uY5VMXEioyX3ZD/r1J8u8SEmdo
	MXvGzI7wHUZTaqMVSHcsKYWtVtXSCIQOU8IgDZ1XBwP43/QyEM5t+g2KvLa19gdu
	GvWsgpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ElbWL/VCwGP+fAOE2/Dv4AUVZC2qI7OvOSueq6Z2cD+oL/ir7CUR9+jSimq8PT23
	+YhdXBDO9JidcB02sdOPVEiZ1jVkfVbFtCkzjQxvUsT8FKCz12KeIxMy05aXbAoQ
	rcidG8eaML6t7KN8hxFqKkEsrdppTZifTGk4tYUhQW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42CC4C802;
	Thu, 31 Jan 2013 23:32:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1ABDC801; Thu, 31 Jan 2013
 23:32:10 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.612.g09f4be5
In-Reply-To: <1359693125-22357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 581D5C88-6C28-11E2-8A4C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215200>

The local variable sha1_ptr in the build_fake_ancestor() function
used to either point at the null_sha1[] (if the ancestor did not
have the path) or at sha1[] (if we read the object name into the
local array), but 7a98869 (apply: get rid of --index-info in favor
of --build-fake-ancestor, 2007-09-17) made the "missing in the
ancestor" case unnecessary, hence sha1_ptr, when used, always points
at the local array.

Get rid of the unneeded variable, and restructure the if/else
cascade a bit to make it easier to read.  There should be no
behaviour change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 156b3ce..a1db7b4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3598,7 +3598,6 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 	 * worth showing the new sha1 prefix, but until then...
 	 */
 	for (patch = list; patch; patch = patch->next) {
-		const unsigned char *sha1_ptr;
 		unsigned char sha1[20];
 		struct cache_entry *ce;
 		const char *name;
@@ -3606,20 +3605,19 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 		name = patch->old_name ? patch->old_name : patch->new_name;
 		if (0 < patch->is_new)
 			continue;
-		else if (get_sha1_blob(patch->old_sha1_prefix, sha1))
-			/* git diff has no index line for mode/type changes */
-			if (!patch->lines_added && !patch->lines_deleted) {
-				if (get_current_sha1(patch->old_name, sha1))
-					die("mode change for %s, which is not "
-						"in current HEAD", name);
-				sha1_ptr = sha1;
-			} else
-				die("sha1 information is lacking or useless "
-					"(%s).", name);
-		else
-			sha1_ptr = sha1;
 
-		ce = make_cache_entry(patch->old_mode, sha1_ptr, name, 0, 0);
+		if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
+			; /* ok */
+		} else if (!patch->lines_added && !patch->lines_deleted) {
+			/* mode-only change: update the current */
+			if (get_current_sha1(patch->old_name, sha1))
+				die("mode change for %s, which is not "
+				    "in current HEAD", name);
+		} else
+			die("sha1 information is lacking or useless "
+			    "(%s).", name);
+
+		ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"), name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
-- 
1.8.1.2.612.g09f4be5
