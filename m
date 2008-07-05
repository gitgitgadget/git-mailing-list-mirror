From: "Adam Brewster" <adambrewster@gmail.com>
Subject: [PATCH/v3] bundle.c: added --stdin option to git-bundle
Date: Sat, 5 Jul 2008 12:30:53 -0400
Message-ID: <c376da900807050930i6d1da898s624be58adc6f1751@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mark Levedahl" <mdl123@verizon.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 18:32:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFAgB-00029q-1u
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 18:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYGEQbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 12:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYGEQbG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 12:31:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:15213 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbYGEQbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 12:31:05 -0400
Received: by yw-out-2324.google.com with SMTP id 9so707807ywe.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Z+ZyNk51Zur0fUHpmPL1gOjddmoeeYhRHPBQN71lxb8=;
        b=KcCzWEtnOW+idsYJ/20ZIdS8HG7LsQn48ChNiGpMAlfm8veKNRAHLxDq+j8y/3tYXW
         LcSosef27cadxvfs1i2neAIR+MFusN4Mm6kEqTEhQgq5n7bXsv1f+HgcJz4+2vTiJ1Un
         aRMy+0gkdo/I1fZOebxG5rs40FrrMj7kLSXgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=AvGAaqpMWPF7Ul0+qwOut4botVFNv+J1CpPOOqiCkXhu2ASYaLMPB6J0fxxxb89NQw
         j/szs+/0706H9scti86UqjujEuLvMZ2QpitOAkq04QEkPOmM1z8Qb+/PvFeJ+rPlPxpP
         qBur1U/hitYYZn/jKP94FFVXUEmotWxHPL/Hs=
Received: by 10.151.110.9 with SMTP id n9mr4303767ybm.161.1215275453230;
        Sat, 05 Jul 2008 09:30:53 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Sat, 5 Jul 2008 09:30:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87449>

Signed-off-by: Adam Brewster <asb@bu.edu>
---
It seems that the consensus is that the other half of my original
patch is no good.  You have some pretty good ideas about how to
correctly address the problem I was trying to solve, and I look
forward to seeing them actually implemented.

For now, I offer separately the modification I made to bundle.c to
allow git-bundle to handle the --stdin option.  There is no
accompanying change to the documentation because it already implies
that this option is available.

 bundle.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 0ba5df1..b44a4af 100644
--- a/bundle.c
+++ b/bundle.c
@@ -227,8 +227,26 @@ int create_bundle(struct bundle_header *header,
const char *path,

        /* write references */
        argc = setup_revisions(argc, argv, &revs, NULL);
-       if (argc > 1)
-               return error("unrecognized argument: %s'", argv[1]);
+
+       for (i = 1; i < argc; i++) {
+               if ( !strcmp(argv[i], "--stdin") ) {
+                       char line[1000];
+                               while (fgets(line, sizeof(line),
stdin) != NULL) {
+                               int len = strlen(line);
+                               if (len && line[len - 1] == '\n')
+                                       line[--len] = '\0';
+                               if (!len)
+                                       break;
+                               if (line[0] == '-')
+                                       die("options not supported in
--stdin mode");
+                               if (handle_revision_arg(line, &revs, 0, 1))
+                                       die("bad revision '%s'", line);
+                       }
+                       continue;
+               }
+
+               return error("unrecognized argument: %s'", argv[i]);
+       }

        for (i = 0; i < revs.pending.nr; i++) {
                struct object_array_entry *e = revs.pending.objects + i;
--
1.5.5.1.211.g65ea3.dirty
