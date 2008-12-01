From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6 (v2)] clone: find the current branch more explicitly
Date: Mon,  1 Dec 2008 06:12:53 -0800
Message-ID: <1228140775-29212-5-git-send-email-gitster@pobox.com>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <1228140775-29212-2-git-send-email-gitster@pobox.com>
 <1228140775-29212-3-git-send-email-gitster@pobox.com>
 <1228140775-29212-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 15:14:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79Y5-0007sQ-6s
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbYLAONe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbYLAONe
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:13:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYLAONd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:13:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 44C3A17E39
	for <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8800717E37 for
 <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:29 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.23.g38649f
In-Reply-To: <1228140775-29212-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3C987280-BFB2-11DD-916C-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102043>

This makes "git clone" use the HEAD information sent by an updated
uploader to point the resulting HEAD at the current branch that is not
'master' but happens to point at the same commit as 'master'.

IOW, immediately after doing:

    $ git checkout -b another master

a clone made out of that repository will check out 'another' branch, not
'master'.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-clone.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 2feac9c..a8b8d56 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -299,13 +299,27 @@ static const struct ref *locate_head(const struct ref *refs,
 	const struct ref *remote_head = NULL;
 	const struct ref *remote_master = NULL;
 	const struct ref *r;
-	for (r = refs; r; r = r->next)
-		if (!strcmp(r->name, "HEAD"))
+
+	for (r = refs; r; r = r->next) {
+		if (!strcmp(r->name, "HEAD")) {
 			remote_head = r;
+			break;
+		}
+	}
 
-	for (r = mapped_refs; r; r = r->next)
-		if (!strcmp(r->name, "refs/heads/master"))
-			remote_master = r;
+	if (remote_head && remote_head->symref) {
+		for (r = mapped_refs; r; r = r->next)
+			if (!strcmp(r->name, remote_head->symref)) {
+				remote_master = r;
+				break;
+			}
+	}
+
+	if (!remote_master) {
+		for (r = mapped_refs; r; r = r->next)
+			if (!strcmp(r->name, "refs/heads/master"))
+				remote_master = r;
+	}
 
 	if (remote_head_p)
 		*remote_head_p = remote_head;
-- 
1.6.0.4.864.g0f47a
