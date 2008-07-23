From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/2] git-checkout: fix command line parsing.
Date: Wed, 23 Jul 2008 12:15:32 +0200
Message-ID: <1216808133-31919-2-git-send-email-madcoder@debian.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org>
 <1216808133-31919-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 12:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbOg-0001Ja-G7
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYGWKPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 06:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYGWKPj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:15:39 -0400
Received: from pan.madism.org ([88.191.52.104]:54297 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbYGWKPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:15:36 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0A8DB3A5A5;
	Wed, 23 Jul 2008 12:15:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6F02D14248F; Wed, 23 Jul 2008 12:15:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.153.ge8bf3
In-Reply-To: <1216808133-31919-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89621>

This fixes an issue when you use:

    $ git checkout -- <path1> [<paths>...]

and that <path1> can also be understood as a reference. git-checkout
mistakenly understands this as the same as:

    $ git checkout <path1> -- [<paths>...]

because parse-options was eating the '--' and the argument parser thought
he was parsing:

    $ git checkout <path1> [<paths>...]

Where there indeed is an ambiguity

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-checkout.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index fbd5105..9cadf9c 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -438,7 +438,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts.track = git_branch_track;
 
-	argc = parse_options(argc, argv, options, checkout_usage, 0);
+	argc = parse_options(argc, argv, options, checkout_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
 	if (argc) {
 		arg = argv[0];
 		if (get_sha1(arg, rev))
-- 
1.6.0.rc0.155.g8e50b
