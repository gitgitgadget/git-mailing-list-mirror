From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/15] merge: clarify "pulling into void" special case
Date: Wed, 29 Apr 2015 14:29:23 -0700
Message-ID: <1430342973-30344-6-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYD-0006PM-C6
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbbD2V3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbbD2V3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 088E34DAAA;
	Wed, 29 Apr 2015 17:29:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NAx1
	BKxyZy/eg8UTl9DMaHskmMg=; b=EI/fsoWhKsQO1fTEoz0sCdUs7y4zopv8EalE
	RpHcV+8fuKtwNMUL7QADefKR/wejppV8Nyc3KLQ6JTjfpRa34q+iGgPq3ftXtlKJ
	eA2eMiSUoA6pFosB4vgr2gx0M2zaQVbbIfU2ubTv96rqAFi7oAnLDvMQYUX/ul6S
	krdPnCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=GZy0o2
	DEhAlqEgAdTXKGwjmSZ4ExyeOiKZv6dEjL1kEdSG+t8Rg4o66cO3AoQGCW1m8yFQ
	bTQRqfl26ZxAtd4Ih2GLkAx+eA5uQkH7eohAMwu4OvwMJHorIiGwBdUbisA74Hz4
	BNiwRyTLUiIXb9sp8ZX50me2fS/orwdot5JlA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 004534DAA8;
	Wed, 29 Apr 2015 17:29:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 797634DAA5;
	Wed, 29 Apr 2015 17:29:42 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D94C8F5A-EEB6-11E4-9DF3-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268012>

Instead of having it as one of the three if/elseif/.. case arms,
test the condition and handle this special case upfront.  This makes
it easier to follow the flow of logic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 8477878..878f82a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1178,23 +1178,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
 
-	/*
-	 * This could be traditional "merge <msg> HEAD <commit>..."  and
-	 * the way we can tell it is to see if the second token is HEAD,
-	 * but some people might have misused the interface and used a
-	 * commit-ish that is the same as HEAD there instead.
-	 * Traditional format never would have "-m" so it is an
-	 * additional safety measure to check for it.
-	 */
-
-	if (!have_message && head_commit &&
-	    is_old_style_invocation(argc, argv, head_commit->object.sha1)) {
-		strbuf_addstr(&merge_msg, argv[0]);
-		head_arg = argv[1];
-		argv += 2;
-		argc -= 2;
-		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
-	} else if (!head_commit) {
+	if (!head_commit) {
 		struct commit *remote_head;
 		/*
 		 * If the merged head is a valid one there is no reason
@@ -1217,6 +1201,23 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		update_ref("initial pull", "HEAD", remote_head->object.sha1,
 			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 		goto done;
+	}
+
+	/*
+	 * This could be traditional "merge <msg> HEAD <commit>..."  and
+	 * the way we can tell it is to see if the second token is HEAD,
+	 * but some people might have misused the interface and used a
+	 * commit-ish that is the same as HEAD there instead.
+	 * Traditional format never would have "-m" so it is an
+	 * additional safety measure to check for it.
+	 */
+	if (!have_message &&
+	    is_old_style_invocation(argc, argv, head_commit->object.sha1)) {
+		strbuf_addstr(&merge_msg, argv[0]);
+		head_arg = argv[1];
+		argv += 2;
+		argc -= 2;
+		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
 	} else {
 		struct strbuf merge_names = STRBUF_INIT;
 
-- 
2.4.0-rc3-300-g052d062
