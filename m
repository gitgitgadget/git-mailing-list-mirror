From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP-PATCH 3/3] pretty_print_commit(): do not append notes message
Date: Wed, 17 Oct 2012 19:20:18 -0700
Message-ID: <1350526818-354-4-git-send-email-gitster@pobox.com>
References: <1350526818-354-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 04:20:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOfj8-0003OE-QE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 04:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640Ab2JRCUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 22:20:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab2JRCU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 22:20:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43C78840C
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ldzt
	yhoGeWt9KFKiyqvoPSKmLAI=; b=ZscydL+GOQ1Ppe6WDMoUBaxhC0kZsGgI0co6
	WotWkrLPP2YiQsNSeSj4ZlklgwBHHZSmUp3mls5XhaOhFh45i9SRR4hLXNpJP8bh
	Kdj4JC8otWO9I7Y4qRVs+9FhEhGLsMbyMIxJUw8tOsrQJuj9cq1qqVZHr6l6/Zo1
	TTSZjDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=pS0EDD
	eHXzY4RYQ56CCk78MTbg0d2vX0BQ+wMu4rJHjNWevR7JcW48xs0SRBHGqzXOYeYe
	RtwPa6LU+l38w/U+0efoVid0MmfF3V78+Gt2s2vX1afJ2a0JE8IeYmHHeMc6bodu
	zNRd/AUeuO38ZxynrqV0MY1ov9rCqgyZnp6yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33551840B
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F76383FE for
 <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:28 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
In-Reply-To: <1350526818-354-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 623EE92C-18CA-11E2-9ADD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207954>

The only case pretty_print_commit() appends notes message to the log
message taken from the commit is when show_log() calls it with the
after_message_body field set and the output format is not the
userformat.  No other users of this function sets this field in the
pretty_print_context, as can be seen in the previous step.

Hoist the code to append the notes message to the caller.

Up to this point, no functionality change is intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c | 2 ++
 pretty.c   | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 95ff405..6e141f0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -673,6 +673,8 @@ void show_log(struct rev_info *opt)
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
 	pretty_print_commit(&ctx, commit, &msgbuf);
+	if ((ctx.fmt != CMIT_FMT_USERFORMAT) && ctx.after_message_body)
+		strbuf_addbuf(&msgbuf, ctx.after_message_body);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
diff --git a/pretty.c b/pretty.c
index bdd991c..ad27325 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1417,9 +1417,6 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 	if (pp->fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (pp->after_message_body)
-		strbuf_addbuf(sb, pp->after_message_body);
-
 	free(reencoded);
 }
 
-- 
1.8.0.rc3.112.gdb88a5e
