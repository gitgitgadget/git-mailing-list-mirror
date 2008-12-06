From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] fetch-pack: Avoid memcpy() with src==dst
Date: Sat,  6 Dec 2008 21:50:09 +0100
Message-ID: <1228596609-12720-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 21:51:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L947m-0006O0-Nk
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 21:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbYLFUuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 15:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbYLFUuV
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 15:50:21 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:10208 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbYLFUuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 15:50:20 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Dec 2008 21:50:19 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Dec 2008 21:50:18 +0100
X-Mailer: git-send-email 1.6.1.rc1.75.g7a1a3
X-OriginalArrivalTime: 06 Dec 2008 20:50:18.0753 (UTC) FILETIME=[3F930710:01C957E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102476>

memcpy() may only be used for disjoint memory areas, but when invoked
from cmd_fetch_pack(), we have my_args == &args.  (The argument cannot
be removed entirely because transport.c invokes with its own
variable.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

Found this while valgrinding too much.

 builtin-fetch-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 372bfa2..67fb80e 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -780,7 +780,8 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	struct ref *ref_cpy;
 
 	fetch_pack_setup();
-	memcpy(&args, my_args, sizeof(args));
+	if (&args != my_args)
+		memcpy(&args, my_args, sizeof(args));
 	if (args.depth > 0) {
 		if (stat(git_path("shallow"), &st))
 			st.st_mtime = 0;
-- 
tg: (7f705dc..) t/fp-memcpy-fix (depends on: origin/master)
