From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 11:17:35 +0200
Message-ID: <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net>
References: <4D94322A.8030409@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 11:21:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5E4F-00039P-Fn
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 11:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227Ab1CaJVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 05:21:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37890 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932977Ab1CaJVL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 05:21:11 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0ACC920965;
	Thu, 31 Mar 2011 05:21:11 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 31 Mar 2011 05:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=b80BTg4plfs5HLG+xalqsiNDOig=; b=jc1bIprNGoTD0ymc/6R1XHdRzsipddZKIZ4EHyql7m4js8snVcjzcg6+bp0l4K4c8KObbUyKe+WyyO1VL7QwS1MItYxTwn0YJBYaeuHTeV4/1bQumKAWxGIPEoP9TowCmXs3LuWTuBacpNmiLE6Ze/Px3GSGuQJLhEX9+LENwi4=
X-Sasl-enc: AARIihVTm0+NzwzIlLB3FaagaUhFkRFuztK7gr3wh8QS 1301563270
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 830E7408841;
	Thu, 31 Mar 2011 05:21:10 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <4D94322A.8030409@drmicha.warpmail.net>
In-Reply-To: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net>
References: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170461>

By design, "git show commit -- path" is not "git show commit:path", and
there is no reason to change that. But "git show commit -- path" simply
returns nothing at all "most of the time" because it prunes by pathspec
even though it does not walk commits. This is pretty useless.

So, turn off pruning (but keep diff limiting of course) so that "git
show commit -- path" shows the commit message and the diff that the
commit introduces to path (filtered by path); only the diff will be
empty "most of the time".

As an intended side effect, users mistaking "git show commit -- path"
for "git show commit:path" are automatically reminded that they asked
git to show a commit, not a blob.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9db43ed..ea0ddb4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -411,6 +411,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	opt.def = "HEAD";
 	opt.tweak = show_rev_tweak_rev;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
+	rev.prune = 0;
 
 	count = rev.pending.nr;
 	objects = rev.pending.objects;
-- 
1.7.4.2.668.gba03a4
