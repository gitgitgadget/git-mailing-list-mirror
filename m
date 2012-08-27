From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] receive-pack: use in_merge_bases() for fast-forward
 check
Date: Mon, 27 Aug 2012 16:12:00 -0700
Message-ID: <1346109123-12357-3-git-send-email-gitster@pobox.com>
References: <1346109123-12357-1-git-send-email-gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68Tr-0007Qr-0P
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab2H0XMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 19:12:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab2H0XMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 19:12:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B0909163;
	Mon, 27 Aug 2012 19:12:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zgbm
	gCpKnAoat9RhkfjJ+HCEO60=; b=XWLmPzUDj8Wlg8Jn2+lDxgGckFgBk2yoxAHo
	8++Z8//OjQD4hfLyQOm3NF+69WbesYZeUu9qoFUgbDdFwnasMGiaDEoICjvEGazJ
	mcYi7F8PFMZcxMO7uFB7rnRd6M6YqPbtTvO3fxOX90yWnM56GStDo2lUkkRDbak/
	arUm3Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	eORlWo1urSws7m2K61UwrHB8xQgDtjhW1H2G9LYOVHhW0xkjmUD8vtRZKR6jtYpt
	SfQWDqk46rtiXz6C889xz+belPZF2rSC1rx0D3128CeeR1l6iVZDyBK0GltMoy4a
	DJkFkTSf5HQUPXsgHmo+CI0HCo6ku5zmAoNEQNvSJRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 289D39162;
	Mon, 27 Aug 2012 19:12:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 851839161; Mon, 27 Aug 2012
 19:12:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.270.g724661d
In-Reply-To: <1346109123-12357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A07692AE-F09C-11E1-984B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204389>

The original computed merge-base between the old commit and the new
commit and checked if the old commit was a merge base between them,
in order to make sure we are fast-forwarding.

Instead, call in_merge_bases(old, new) which does the same.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3f05d97..b1abe7b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -478,7 +478,6 @@ static const char *update(struct command *cmd)
 	    !prefixcmp(name, "refs/heads/")) {
 		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
-		struct commit_list *bases, *ent;
 
 		old_object = parse_object(old_sha1);
 		new_object = parse_object(new_sha1);
@@ -491,12 +490,7 @@ static const char *update(struct command *cmd)
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
-		bases = get_merge_bases(old_commit, new_commit, 1);
-		for (ent = bases; ent; ent = ent->next)
-			if (!hashcmp(old_sha1, ent->item->object.sha1))
-				break;
-		free_commit_list(bases);
-		if (!ent) {
+		if (!in_merge_bases(old_commit, new_commit)) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
 			return "non-fast-forward";
-- 
1.7.12.116.g31e0100
