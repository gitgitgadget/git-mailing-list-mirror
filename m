From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/4] builtin/show: do not prune by pathspec
Date: Fri,  1 Apr 2011 11:20:34 +0200
Message-ID: <6509d23c538dfabd4fac8870d29a69b1dd11a516.1301649372.git.git@drmicha.warpmail.net>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 11:24:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5aao-0001Hg-6l
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab1DAJYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 05:24:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53093 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755283Ab1DAJYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:24:16 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E5D4C208B9;
	Fri,  1 Apr 2011 05:24:15 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 01 Apr 2011 05:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=L7A5NyGzse0r9gsHE16DcraUnuc=; b=AsEIO2kjfwehVTs9FY4kS7nx6/y3ByS4CfugOfRoQ1uDBjUR4CQvuMjKyb/bsyfdP8PRgxFAX3riDPEyqK0UFHT1En6ORu24akfPD+C2KNqOuQ6Fv8TN3yCR4Yfp+ptjeRamarUl/+iW6GUvYVqGGAjmIYImDO+T+3S3ko/ODsk=
X-Sasl-enc: P4JJZ1YadNZkJ7OaDul/6fHpgq1be3MONtrh6XMG54p0 1301649855
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 698D24056D6;
	Fri,  1 Apr 2011 05:24:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1301649372.git.git@drmicha.warpmail.net>
References: <cover.1301649372.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170568>

By design, "git show commit -- path" is not "git show commit:path", and
there is no reason to change that. But "git show commit -- path" simply
returns nothing at all "most of the time" because it prunes by pathspec
even though it does not walk commits. This is pretty useless.

So, turn off commit pruning (but keep diff limiting of course) so that
"git show commit -- path" shows the commit message and the diff that the
commit introduces to path (filtered by path); only the diff will be
empty "most of the time".

As an intended side effect, users mistaking "git show commit -- path"
for "git show commit:path" are automatically reminded that they asked
git to show a commit, not a blob.

In case the user has specified "--do-walk", assume they want the old
behaviour (prune by default).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 916019c..474a76d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -420,6 +420,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	opt.def = "HEAD";
 	opt.tweak = show_rev_tweak_rev;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
+	if (rev.no_walk)
+		rev.prune = 0;
 
 	count = rev.pending.nr;
 	objects = rev.pending.objects;
-- 
1.7.4.2.668.gba03a4
