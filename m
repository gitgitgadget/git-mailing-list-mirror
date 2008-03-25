From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 5/5] builtin-prune: protect objects listed on the command line
Date: Mon, 24 Mar 2008 23:59:55 -0700
Message-ID: <7vtzivmgpg.fsf@gitster.siamese.dyndns.org>
References: <200803232150.29971.barra_cuda@katamail.com>
 <200803241502.21465.barra_cuda@katamail.com>
 <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
 <200803242218.44026.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 08:00:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je39U-0002zZ-4P
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 08:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbYCYHAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 03:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752795AbYCYHAN
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 03:00:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYCYHAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 03:00:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 091142F95;
	Tue, 25 Mar 2008 03:00:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E61EF2F8F; Tue, 25 Mar 2008 03:00:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78158>

From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 24 Mar 2008 23:20:51 -0700

Finally, this resurrects the documented behaviour to protect other
objects listed on the command line from getting pruned.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is done deliberately differently from what you did.  Because we do
   not want to accept "we allow losing what's reachable from master" with
   "git prune master..next", setup_revisions() is not the right thing to
   use for this command.

 builtin-prune.c  |   12 ++++++++++--
 t/t5304-prune.sh |    2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 71caac5..ca50cca 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -140,8 +140,16 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 
 	argc = parse_options(argc, argv, options, prune_usage, 0);
-	if (argc)
-		die ("unrecognized argument: %s", name);
+	while (argc--) {
+		struct object *object;
+		unsigned char sha1[20];
+		const char *name = *argv++;
+
+		if (!get_sha1(name, sha1) && (object = parse_object(sha1)))
+			add_pending_object(&revs, object, "");
+		else
+			die ("unrecognized argument: %s", name);
+	}
 	mark_reachable_objects(&revs, 1);
 	prune_object_dir(get_object_directory());
 
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 3d81e1f..9fd9d07 100644
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -100,7 +100,7 @@ test_expect_success 'prune: prune unreachable heads' '
 
 '
 
-test_expect_failure 'prune: do not prune heads listed as an argument' '
+test_expect_success 'prune: do not prune heads listed as an argument' '
 
 	: > file2 &&
 	git add file2 &&
-- 
1.5.5.rc1.121.g1594
