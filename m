From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] git-bundle: add --stdin
Date: Sat,  5 Jul 2008 17:26:40 -0400
Message-ID: <1215293200-28199-3-git-send-email-adambrewster@gmail.com>
References: <20080705204849.GJ4729@genesis.frugalware.org>
 <1215293200-28199-1-git-send-email-adambrewster@gmail.com>
 <1215293200-28199-2-git-send-email-adambrewster@gmail.com>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, adambrewster@gmail.com, vmiklos@frugalware.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 23:27:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFFIN-00028d-Uw
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 23:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbYGEV0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbYGEV0t
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 17:26:49 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:50272 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbYGEV0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 17:26:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so739850ywe.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Bp7kkKeAceiLft22BpGzF0URThNZkyYRat82xm20BIA=;
        b=R2Szja5qFioZ4NMwu6Lg3oll9iI07lUHjbafuaItZPYSEKAnAI+EKAJ2/eqGak39W3
         VgQKu5Z1biujPWArqdmVTLmQ/LrWJvj/dqOJlqCYJBcoHE1VZKo72VKmXm7YEHI1JbCo
         BrFzYUI/KlcIYH2KOF/HDKwiS5S/wSlDy6H/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CvA3TwR0dfFbIp15Qynn39Vq73HWHmpMbv3WCSkpq8SH7hvFyJH0IVySFdyn39tPb5
         Ga+doO+p4aXOCuNHKtRjGjDzC/9N9+8g0WZX4/2VF17qlLZouwVHHh/HpLsgGWncnyOq
         5scIrHlnZDlbznTzOO3Ze2osYf8z4otvqZP98=
Received: by 10.150.144.9 with SMTP id r9mr3631485ybd.42.1215293205867;
        Sat, 05 Jul 2008 14:26:45 -0700 (PDT)
Received: from MBE.internal ( [65.96.168.20])
        by mx.google.com with ESMTPS id 30sm2794356yxk.4.2008.07.05.14.26.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 14:26:44 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id D4CD510499C; Sat,  5 Jul 2008 17:26:40 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <1215293200-28199-2-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87471>

Teach git-bundle to read revision arguments from stdin like git-rev-list.

This patch allows the caller to feed the revision parameters to git-bundle
from its standard input.  This way, a script do not have to worry about
limitation of the length of command line.

Documentation/git-bundle.txt says that git-bundle takes arguments acceptable
to git-rev-list.  Obviously some arguments that git-rev-list handles don't
make sense for git-bundle (e.g. --bisect) but --stdin is pretty reasonable.

Signed-off-by: Adam Brewster <adambrewster@gmail.com>
---
 bundle.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 0ba5df1..00b2aab 100644
--- a/bundle.c
+++ b/bundle.c
@@ -178,6 +178,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	int i, ref_count = 0;
 	char buffer[1024];
 	struct rev_info revs;
+	int read_from_stdin = 0;
 	struct child_process rls;
 	FILE *rls_fout;
 
@@ -227,8 +228,16 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* write references */
 	argc = setup_revisions(argc, argv, &revs, NULL);
-	if (argc > 1)
-		return error("unrecognized argument: %s'", argv[1]);
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--stdin")) {
+			if (read_from_stdin++)
+				die("--stdin given twice?");
+			read_revisions_from_stdin(&revs);
+			continue;
+		}
+		return error("unrecognized argument: %s'", argv[i]);
+	}
 
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
-- 
1.5.5.1.211.g65ea3.dirty
