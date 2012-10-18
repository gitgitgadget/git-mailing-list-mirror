From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] pretty_print_commit(): do not append notes message
Date: Wed, 17 Oct 2012 22:45:26 -0700
Message-ID: <1350539128-21577-5-git-send-email-gitster@pobox.com>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 07:46:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOivi-0005dI-5A
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab2JRFpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:45:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab2JRFpj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:45:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51D7E6D3B
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=35Mk
	cT0zhNLvSn4XrWpDHSy9e3c=; b=J8BVPiE4HL9yYVyTN0O6iYVGBucr+EGmElVO
	tyNSigO2Of1XnsUkG6q1MDZFnhdxsHTjNE9s8uXmGEeIEBH+wtpbragbjgytstEb
	mFdTJbnLwRqFzy0LDG7y99cqlSTPIIudBpPK3iHGrT1WPgl7YC0RtzRU9ZhKZLrO
	gT8H+9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=OypDm1
	5CudRI6eR0bw/ww/Hi+MalnYa+gDJiluw0ZrW1be43GDaBwvXnqOLy0o5caNdWVg
	AT/S5SXTxEugahviQdQpH4zHUxYbIApwFPmLQ3cCPvTMfOVZnr4IsjekqLbqkm8B
	FZBI9Ea+VOBQtpBlkwBwIFgyQzFEOSDR5lLIo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4024F6D3A
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B493F6D38 for
 <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:38 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
In-Reply-To: <1350539128-21577-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0BB52996-18E7-11E2-8946-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207965>

The only case pretty_print_commit() appends notes message to the log
message taken from the commit is when show_log() calls it with the
notes_message field set, and the output format is not the userformat
(i.e. when substituting "%N").  No other users of this function sets
this field in the pretty_print_context, as can be easily verified in
the previous step.

Hoist the code to append the notes message to the caller.

Up to this point, no functionality change is intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c | 3 +++
 pretty.c   | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 84e9f5b..e7e08f4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -672,6 +672,9 @@ void show_log(struct rev_info *opt)
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
 	pretty_print_commit(&ctx, commit, &msgbuf);
+	if ((ctx.fmt != CMIT_FMT_USERFORMAT) &&
+	    ctx.notes_message && *ctx.notes_message)
+		strbuf_addstr(&msgbuf, ctx.notes_message);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
diff --git a/pretty.c b/pretty.c
index a53eb53..1925e9c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1417,9 +1417,6 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 	if (pp->fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (pp->notes_message && *pp->notes_message)
-		strbuf_addstr(sb, pp->notes_message);
-
 	free(reencoded);
 }
 
-- 
1.8.0.rc3.112.gdb88a5e
