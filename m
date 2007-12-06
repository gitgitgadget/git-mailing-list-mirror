From: Junio C Hamano <gitster@pobox.com>
Subject: [BUG/PATCH] git grep shows the same hit repeatedly for unmerged paths
Date: Wed, 05 Dec 2007 16:13:08 -0800
Message-ID: <7vsl2gk7e3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 01:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J04NU-0007Y3-HK
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 01:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbXLFANQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 19:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXLFANQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 19:13:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42324 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbXLFANP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 19:13:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A78F42EF;
	Wed,  5 Dec 2007 19:13:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D7699D33E;
	Wed,  5 Dec 2007 19:13:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67214>

When the index is unmerged, e.g.

	$ git ls-files -u
        100644 faf413748eb6ccb15161a212156c5e348302b1b6 1	setup.c
        100644 145eca50f41d811c4c8fcb21ed2604e6b2971aba 2	setup.c
        100644 cb9558c49b6027bf225ba2a6154c4d2a52bcdbe2 3	setup.c

running "git grep" for work tree files repeats hits for each unmerged
stage.

	$ git grep -n -e setup_work_tree -- '*.[ch]'
        setup.c:209:void setup_work_tree(void)
        setup.c:209:void setup_work_tree(void)
        setup.c:209:void setup_work_tree(void)

This should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-grep.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index bbf747f..f1ff8dc 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -343,12 +343,12 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 			memcpy(name + 2, ce->name, len + 1);
 		}
 		argv[argc++] = name;
-		if (argc < MAXARGS)
-			continue;
-		status = flush_grep(opt, argc, nr, argv, &kept);
-		if (0 < status)
-			hit = 1;
-		argc = nr + kept;
+		if (MAXARGS <= argc) {
+			status = flush_grep(opt, argc, nr, argv, &kept);
+			if (0 < status)
+				hit = 1;
+			argc = nr + kept;
+		}
 		if (ce_stage(ce)) {
 			do {
 				i++;
