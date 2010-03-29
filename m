From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] refs.c: Write reflogs for notes just like for branch heads
Date: Mon, 29 Mar 2010 15:05:58 +0200
Message-ID: <0f06a30f395c14307066d0e4365fc61a294997db.1269867675.git.git@drmicha.warpmail.net>
References: <d6c334ec855bf04d9edb432b9cdc3590ab96d6e9.1269867675.git.git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 15:09:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwEiF-0007zF-NW
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 15:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab0C2NIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 09:08:55 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37941 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903Ab0C2NIx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 09:08:53 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C0DC3EA518;
	Mon, 29 Mar 2010 09:08:51 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 29 Mar 2010 09:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=MRXh/h1UOj2bbnMJUKMlztCNdIc=; b=Bb2/4tJ+Po1NfgucvP8ot1l2obuPlh+1UqzNorID/2hs9CndQq57MsVPbqyrx1BqRlRCGpLsg+mmQjd8SSfmayiv8E/4cyYWlYbXOXUEdSNO0LlNDGVslj7KQqjYuqeIgH7m0yNWhTHCyrGGSPfRYLZsxiXmqg0TRr7S1vxySyY=
X-Sasl-enc: OUrLqzlhTR2fsPXX5DbappiVtykQT1r9WRJfrANaO4LZ 1269868131
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2B2AB1970E;
	Mon, 29 Mar 2010 09:08:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.448.g82eeb
In-Reply-To: <d6c334ec855bf04d9edb432b9cdc3590ab96d6e9.1269867675.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143469>

The notes code intends to write reflog entries, but currently they are
not written because log_ref_write() checks for the refname path
explicitly.

Add refs/notes to the list of allowed paths so that notes references are
treated just like branch heads, i.e. according to core.logAllRefUpdates
and core.bare.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is actually inspired by Jeff's novel notes use. I think there are
use cases where a notes log makes sense (notes on commits) and those
where it does not (metadata/textconv). In both cases having a reflog is
useful. So, the next step is really to allow notes trees without
history, which also takes care of the pruning issue. I know how to do this,
I just have to decide about the configuration options.

 refs.c           |    1 +
 t/t3301-notes.sh |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 0f24c8d..d3db15a 100644
--- a/refs.c
+++ b/refs.c
@@ -1276,6 +1276,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	if (log_all_ref_updates &&
 	    (!prefixcmp(ref_name, "refs/heads/") ||
 	     !prefixcmp(ref_name, "refs/remotes/") ||
+	     !prefixcmp(ref_name, "refs/notes/") ||
 	     !strcmp(ref_name, "HEAD"))) {
 		if (safe_create_leading_directories(log_file) < 0)
 			return error("unable to create directory for %s",
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 5410a6d..b2e7b07 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -69,7 +69,7 @@ cat >expect <<EOF
 d423f8c refs/notes/commits@{0}: notes: Notes added by 'git notes add'
 EOF
 
-test_expect_failure 'create reflog entry' '
+test_expect_success 'create reflog entry' '
 	git reflog show refs/notes/commits >output &&
 	test_cmp expect output
 '
-- 
1.7.0.3.448.g82eeb
