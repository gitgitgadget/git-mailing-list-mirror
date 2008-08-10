From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH 2/2] builtin-reflog: fix deletion of HEAD entries
Date: Sun, 10 Aug 2008 11:35:01 +0200
Message-ID: <1218360901-36215-1-git-send-email-pdebie@ai.rug.nl>
References: <7vd4kh4r9m.fsf@gitster.siamese.dyndns.org>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 11:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS7Lc-0002zT-7p
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 11:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYHJJfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 05:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYHJJfF
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 05:35:05 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:28116 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbYHJJfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 05:35:04 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6106.online.nl (SMTP Server) with ESMTP id 1BD797000098;
	Sun, 10 Aug 2008 11:35:02 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6106.online.nl (SMTP Server) with ESMTP id BACF37000096;
	Sun, 10 Aug 2008 11:35:01 +0200 (CEST)
X-ME-UUID: 20080810093501765.BACF37000096@mwinf6106.online.nl
X-Mailer: git-send-email 1.6.0.rc1.288.g5b89f
In-Reply-To: <7vd4kh4r9m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91826>

On Aug 10, 2008, at 3:01 AM, Junio C Hamano wrote:
>-		if (!dwim_ref(argv[i], spec - argv[i], sha1, &ref)) {
>+		if (!dwim_log(argv[i], spec - argv[i], sha1, &ref)) {

This is also what add_reflog_for_walk() does, but that function tries to resolve
the argv[i] part first, without doing the dwim_log().

Perhaps we can also do this to allow "git reflog expire master" instead of
"git reflog expire refs/heads/master"? 

--<8--
Subject: [PATCH] builtin-reflog: Allow reflog expire to name partial ref

This allows you to specify 'git reflog expire master' without needing
to give the full refname like 'git reflog expire refs/heads/master'

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 builtin-reflog.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 5af3f28..a8311a6 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -541,14 +541,15 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	}
 
 	while (i < argc) {
-		const char *ref = argv[i++];
+		char *ref;
 		unsigned char sha1[20];
-		if (!resolve_ref(ref, sha1, 1, NULL)) {
-			status |= error("%s points nowhere!", ref);
+		if (!dwim_log(argv[i], strlen(argv[i]), sha1, &ref)) {
+			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb, explicit_expiry, ref);
 		status |= expire_reflog(ref, sha1, 0, &cb);
+		i++;
 	}
 	return status;
 }
-- 
1.6.0.rc0.320.g49281
