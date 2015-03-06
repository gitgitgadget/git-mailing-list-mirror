From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] wt-status: refactor detached HEAD analysis
Date: Fri,  6 Mar 2015 16:04:06 +0100
Message-ID: <f431cf3ed2348db4badaac061481ff7d777d4f36.1425653932.git.git@drmicha.warpmail.net>
References: <54EB4579.3000103@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 16:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTtna-0002gy-8E
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 16:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbbCFPEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 10:04:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39772 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754268AbbCFPEK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 10:04:10 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 1B5F82058C
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 10:04:09 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 06 Mar 2015 10:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=xlZ8LsRXH0D4dUk9/412s6x6ls8=; b=QM8BL/daBQVFvj4LqaAt
	Gu/2X6iWiEOvUsguA03z8N/DmCn7ELc9r9DdW+TFLXDTGjD+/1pQRxS471uk5vgB
	41lBqVpOEUQIXi2ENf+3XFYEOe7LTpzy9OfRlOpye4inQWpc+JPJ8thuLSEJbAp0
	As9a6am+b2hXMhi1HRM6Sik=
X-Sasl-enc: rJRqGJIPPjPcQS6YP03daDfn7OE0YvyLaJqDMktfpdQW 1425654250
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EEEACC00295;
	Fri,  6 Mar 2015 10:04:09 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <54EB4579.3000103@xiplink.com>
In-Reply-To: <cover.1425653932.git.git@drmicha.warpmail.net>
References: <cover.1425653932.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264928>

wt_status_print() is the only caller of wt_status_get_detached_from().
The latter performs most of the analysis of a detached HEAD, including
finding state->detached_from; the caller checks whether the detached
HEAD is still at state->detached_from or has moved away.

Move that last bit of analysis to wt_status_get_detached_from(), too,
and store the boolean result in state->detached_at.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 wt-status.c | 6 +++---
 wt-status.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 29666d0..e7c1a4b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1222,6 +1222,8 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 		state->detached_from =
 			xstrdup(find_unique_abbrev(cb.nsha1, DEFAULT_ABBREV));
 	hashcpy(state->detached_sha1, cb.nsha1);
+	state->detached_at = !get_sha1("HEAD", sha1) &&
+			     !hashcmp(sha1, state->detached_sha1);
 
 	free(ref);
 	strbuf_release(&cb.buf);
@@ -1310,10 +1312,8 @@ void wt_status_print(struct wt_status *s)
 				on_what = _("rebase in progress; onto ");
 				branch_name = state.onto;
 			} else if (state.detached_from) {
-				unsigned char sha1[20];
 				branch_name = state.detached_from;
-				if (!get_sha1("HEAD", sha1) &&
-				    !hashcmp(sha1, state.detached_sha1))
+				if (state.detached_at)
 					on_what = _("HEAD detached at ");
 				else
 					on_what = _("HEAD detached from ");
diff --git a/wt-status.h b/wt-status.h
index 283a9fe..e0a99f7 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -84,6 +84,7 @@ struct wt_status_state {
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
 	int revert_in_progress;
+	int detached_at;
 	char *branch;
 	char *onto;
 	char *detached_from;
-- 
2.3.1.303.g5174db1
