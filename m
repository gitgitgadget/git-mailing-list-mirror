From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 1/4] reset: improve mixed reset error message when in a
	bare repo
Date: Wed, 30 Dec 2009 06:54:44 +0100
Message-ID: <20091230055448.4475.94394.chriscool@tuxfamily.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 06:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPrUM-0005vC-VA
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 06:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbZL3Fwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 00:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZL3Fwp
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 00:52:45 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55874 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbZL3Fwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 00:52:45 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3FD6881807C;
	Wed, 30 Dec 2009 06:52:34 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 27A8D818078;
	Wed, 30 Dec 2009 06:52:32 +0100 (CET)
X-git-sha1: ef74e1f63f81820980b8c7a20a124ad77d6c8cf4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091230055008.4475.95755.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135861>

When running a "git reset --mixed" in a bare repository, the
message displayed is something like:

fatal: This operation must be run in a work tree
fatal: Could not reset index file to revision 'HEAD^'.

This message is a little bit misleading because a mixed reset is
ok in a git directory, so it is not absolutely needed to run it in
a work tree.

So this patch improves upon the above by changing the message to:

fatal: mixed reset is not allowed in a bare repository

And if "git reset" is ever sped up by using unpack_tree() directly
(instead of execing "git read-tree"), this patch will also make
sure that a mixed reset is still disallowed in a bare repository.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 11d1c6e..3180c2b 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -291,6 +291,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die("%s reset requires a work tree",
 		    reset_type_names[reset_type]);
 
+	if (reset_type == MIXED && is_bare_repository())
+		die("%s reset is not allowed in a bare repository",
+		    reset_type_names[reset_type]);
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
-- 
1.6.6.rc2.5.g49666
