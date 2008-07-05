From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] git-bundle: add --stdin
Date: Sat,  5 Jul 2008 16:40:33 -0400
Message-ID: <1215290434-27694-3-git-send-email-adambrewster@gmail.com>
References: <7vod5crydx.fsf@gitster.siamese.dyndns.org>
 <1215290434-27694-1-git-send-email-adambrewster@gmail.com>
 <1215290434-27694-2-git-send-email-adambrewster@gmail.com>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, adambrewster@gmail.com,
	Adam Brewster <asb@bu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 22:42:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFEZs-00068Q-94
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 22:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYGEUkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 16:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYGEUkj
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 16:40:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:28428 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbYGEUki (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 16:40:38 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1149366wri.5
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=jAtQbPSm5UesLi83sLaCdKxkKag27153z2wNxzF6xYc=;
        b=lKT4nIn0op14iq8kNUqOLBLvGG3KTIUQN/w5ReSlyMLIZR6iTZAwJHfDRzEtIZlIXc
         b162fHiJKubz4q0UWRASghjfcgHe16b7ZirALd5NjBafiAJnwt34/FRZuyQ5iF83C2yB
         r8zBodCNIUQNAoK3BkunIB8MwUw6e80IWP03M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WkuC3hQfkgFj4zdivk8TA7Yj/YKYS0/zgyvf97EmHKsyFXs/tUCSSUL0uPo4P9KFuO
         RA/I1EoXLYfN5oBhpZ69s9zcEZsEWzWjl43ZtcPtBVcS8bXrpXj0HHY2OtKAYvAk5+Q2
         Rp3Dcth5ey54aaiEAR8XigVT+P9suZzoxZSPA=
Received: by 10.90.63.12 with SMTP id l12mr3123900aga.5.1215290437781;
        Sat, 05 Jul 2008 13:40:37 -0700 (PDT)
Received: from MBE.internal ( [65.96.168.20])
        by mx.google.com with ESMTPS id 4sm2839899yxj.7.2008.07.05.13.40.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 13:40:36 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id D66F6104A20; Sat,  5 Jul 2008 16:40:34 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <1215290434-27694-2-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87462>

Teach git-bundle to read revision arguments from stdin like git-rev-list.

This patch allows the caller to feed the revision parameters to git-bundle
from its standard input.  This way, a script do not have to worry about
limitation of the length of command line.

Documentation/git-bundle.txt says that git-bundle takes arguments acceptable
to git-rev-list.  Obviously some arguments that git-rev-list handles don't
make sense for git-bundle (e.g. --bisect) but --stdin is pretty reasonable.

Signed-off-by: Adam Brewster <asb@bu.edu>
---
 bundle.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 bundle.c

diff --git a/bundle.c b/bundle.c
old mode 100644
new mode 100755
index 0ba5df1..00b2aab
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
