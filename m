From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/5] combine-diff.c: use strbuf_readlink()
Date: Wed, 17 Dec 2008 12:37:58 -0800
Message-ID: <7v63lileqh.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171044110.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:39:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD3B1-0001Yq-5w
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 21:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYLQUiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 15:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYLQUiF
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 15:38:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYLQUiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 15:38:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CABB1A807;
	Wed, 17 Dec 2008 15:38:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7502A1A806; Wed,
 17 Dec 2008 15:38:00 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A2C13BE-CC7A-11DD-AF95-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103388>

When showing combined diff using work tree contents, use strbuf_readlink()
to read symbolic links.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 combine-diff.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git i/combine-diff.c w/combine-diff.c
index ec8df39..bccc018 100644
--- i/combine-diff.c
+++ w/combine-diff.c
@@ -703,15 +703,15 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			goto deleted_file;
 
 		if (S_ISLNK(st.st_mode)) {
-			size_t len = xsize_t(st.st_size);
-			result_size = len;
-			result = xmalloc(len + 1);
-			if (result_size != readlink(elem->path, result, len)) {
+			struct strbuf buf = STRBUF_INIT;
+
+			if (strbuf_readlink(&buf, elem->path, st.st_size) < 0) {
 				error("readlink(%s): %s", elem->path,
 				      strerror(errno));
 				return;
 			}
-			result[len] = 0;
+			result_size = buf.len;
+			result = strbuf_detach(&buf, NULL);
 			elem->mode = canon_mode(st.st_mode);
 		}
 		else if (0 <= (fd = open(elem->path, O_RDONLY)) &&
