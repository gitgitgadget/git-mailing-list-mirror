From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 1/5] checkout: don't crash on file checkout before running post-checkout hook
Date: Fri, 16 Jan 2009 20:09:58 +0100
Message-ID: <1232133002-21725-1-git-send-email-s-beyer@gmx.net>
References: <20090116172521.GD28177@leksak.fem-net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 20:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNu74-0005Fh-GR
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 20:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764688AbZAPTKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 14:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764252AbZAPTKL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 14:10:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:46010 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763709AbZAPTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 14:10:08 -0500
Received: (qmail invoked by alias); 16 Jan 2009 19:10:06 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp010) with SMTP; 16 Jan 2009 20:10:06 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hVWxcRathqUmYRDJcaXuP0wKaJyceFAI8DRVr39
	QvrU/A8otNbEpg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNu4w-0005fH-LT; Fri, 16 Jan 2009 20:10:02 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
In-Reply-To: <20090116172521.GD28177@leksak.fem-net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105987>

In the case of

	git init
	echo exit >.git/hooks/post-checkout
	chmod +x .git/hooks/post-checkout
	touch foo
	git add foo
	rm foo
	git checkout -- foo

git-checkout resulted in a Segmentation fault, because there is no new
branch set for the post-checkout hook.

This patch makes use of the null SHA as it is set for the old branch.

While at it, I removed the xstrdup() around the sha1_to_hex(...) calls
in builtin-checkout.c/post_checkout_hook() because sha1_to_hex()
uses four buffers for the hex-dumped SHA and we only need two.
(Duplicating one buffer is only needed if we need more than four.)

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

	I checked if all run_hook()-like functions in the code are
	addressed with my patch and found that the one in builtin-checkout.c
	isn't.  Then I stumbled over this rare-case bug.

 builtin-checkout.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index b5dd9c0..149343e 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -47,8 +47,10 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
 
 	memset(&proc, 0, sizeof(proc));
 	argv[0] = name;
-	argv[1] = xstrdup(sha1_to_hex(old ? old->object.sha1 : null_sha1));
-	argv[2] = xstrdup(sha1_to_hex(new->object.sha1));
+	argv[1] = sha1_to_hex(old ? old->object.sha1 : null_sha1);
+	argv[2] = sha1_to_hex(new ? new->object.sha1 : null_sha1);
+	/* "new" can be NULL when checking out from the index before
+	   a commit exists. */
 	argv[3] = changed ? "1" : "0";
 	argv[4] = NULL;
 	proc.argv = argv;
-- 
1.6.1.160.gecdb
