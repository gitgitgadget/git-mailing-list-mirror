From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/14] merge: clarify "pulling into void" special case
Date: Sat, 25 Apr 2015 22:25:57 -0700
Message-ID: <1430025967-24479-5-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5K-0002kU-RU
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbbDZF0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751077AbbDZF0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F89466EB;
	Sun, 26 Apr 2015 01:26:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UMcC
	qNTkOdADLU2KaMQsyBGYdRc=; b=gEE7ULkl1GE0v9EtZNQ8lyHam2b/WfhEMzfT
	M65+jMIRbi/gddsnWUyhZ52j6nrudUzzFr757HzUuaSYb0whCxT4UFHpM1aF221A
	WOOc5M90tPOxhrdB3Lldoyni7rMKQ4PlN/HR5qrLB4aPyUbc58a4tsOoyU8IO8KN
	6eyL/cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Ho/mIm
	9KbbmhUuURpFXd289wdCWkgwCYrXZou/r7JFi7pRnbnkmXjtkQzIR+Vr920Wa/Oe
	z9D46QbhtrLR3EMMzf1Kjb6fsy4DpqC3e4dr0ii3pECKVvxc81B90uX331VE2ZZo
	MC//TC+aMIMufISAgPO4eOlfj1TAprL+kSBy8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52E33466EA;
	Sun, 26 Apr 2015 01:26:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C899F466E9;
	Sun, 26 Apr 2015 01:26:13 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C1674E50-EBD4-11E4-ACBB-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267810>

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
2.4.0-rc3-238-g36f5934
