From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/10] commit: show "Author:" hint when the ident is not given explicitly
Date: Wed, 14 Jan 2015 15:40:55 -0800
Message-ID: <1421278855-8126-11-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXZG-0002st-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbbANXlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751904AbbANXlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0F862DBC1;
	Wed, 14 Jan 2015 18:41:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gVLB
	AFCun/IGvbYIyhGDKfcYakU=; b=vtbvGX7UFejbqloI+k5/5jCCTkZgXvpElcZU
	z6FgyjTDuX+1HOJL/lOWU09cjrz19OTtNeGAvPKT/1j8DmX+hTPoUXTlQ4qHE6Dn
	XXjG07A/VtzZ2PEHNYcwpympZzvD1ieHGWsdiG7km8UlgXvTGaNeWM2SHC54MaCk
	gyhj/b8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=V0Fabo
	nHyvEp8eLkY0sz1IbD1j0PcGJFlMF3msGzskHfm3UKzEV8VOY8LXhcJ9R6pA5vEY
	AZvaV4+iXJ3Dfr4RCvly/4SYLPKjhZWZzvDaxg11zUN1Wzi88wLOo45fKPeGy9fE
	5QTgh7GSuWIcqcubx1WC4B3i2Np6ZEVnI8UmU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7D952DBC0;
	Wed, 14 Jan 2015 18:41:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C5CA2DB9F;
	Wed, 14 Jan 2015 18:41:16 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D4ECF368-9C46-11E4-8033-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262449>

This is a knee-jerk response to two facts:

 - the author_ident_sufficiently_given() function is public but
   nobody uses it;

 - a corresponding function committer_ident_sufficiently_given() is
   used to determine when to add "Committer: " reminder in the log
   message editor.

The existing logic decides to show "Author:" reminder when the
author is different from the committer, so there won't be practical
difference other than we would end up showing both reminders when a
committer with iffy name derived from the heuristic is committing
her own patch.

Which means this patch probably should be dropped.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7d90c35..b512504 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -847,7 +847,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		assert_split_ident(&ai, author_ident);
 		assert_split_ident(&ci, &committer_ident);
 
-		if (ident_cmp(&ai, &ci))
+		if (ident_cmp(&ai, &ci) ||
+		    !author_ident_sufficiently_given())
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
 				"Author:    %.*s <%.*s>"),
@@ -1440,7 +1441,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 
 	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
 	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
-	if (strbuf_cmp(&author_ident, &committer_ident)) {
+	if (strbuf_cmp(&author_ident, &committer_ident) ||
+	    !author_ident_sufficiently_given()) {
 		strbuf_addstr(&format, "\n Author: ");
 		strbuf_addbuf_percentquote(&format, &author_ident);
 	}
-- 
2.3.0-rc0-134-g109a908
