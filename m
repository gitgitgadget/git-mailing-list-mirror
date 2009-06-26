From: newren@gmail.com
Subject: [PATCHv3 1/7] fast-export: Set revs.topo_order before calling setup_revisions
Date: Thu, 25 Jun 2009 22:48:27 -0600
Message-ID: <1245991713-12782-2-git-send-email-newren@gmail.com>
References: <1245991713-12782-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 06:50:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3Ol-0003A8-Hr
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbZFZEuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 00:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbZFZEuo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:50:44 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:35002 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbZFZEum (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 00:50:42 -0400
Received: by pxi28 with SMTP id 28so1456198pxi.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=X2R/FdFORQAt+7S9RsMpDjtp9+thmNwYoRJYqBKNZ4s=;
        b=Er67Ka/cVmOLsiEWZ+0blEjA9ID7sP+MtTyvGFGTJpOfq1vqQQb2Cw32IPpNRT/MAw
         tpPvUCrmFrZ1D1HM8QrkaIL5uV+qIpSsWKas/4MT5Fip753wMjhxQnZEnnlT7/Os/hfz
         4zvnvwhqsPB1kpqkpyOeC6kP8WkbrL3drd6LI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Og1Gf+M8qSulTGy+LGL+uFUuIiJXPhrJRaEpAnzlmf2vtKmAqjm2SxKSMZ3FOoycSy
         1ijF9rf47i+Cia2ASlYmVxBVcAfhykeCEOxbbP7jU1zU9NDXkDfuwR7MAMShxIBpgrO+
         Y5KB0EfwnE5rzpylJNnr3etfUI3Js9C4sXAKY=
Received: by 10.142.135.13 with SMTP id i13mr1128808wfd.133.1245991844895;
        Thu, 25 Jun 2009 21:50:44 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 27sm160173wff.6.2009.06.25.21.50.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 21:50:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.341.g1a0a
In-Reply-To: <1245991713-12782-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122269>

From: Elijah Newren <newren@gmail.com>

setup_revisions sets a variety of flags based on the setting of other
flags, such as setting the limited flag when topo_order is set.  To avoid
circumventing any invariants created by setup_revisions, we set
revs.topo_order before calling it rather than after.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
This patch is new since the last series.

 builtin-fast-export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 6cef810..e0cfa60 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -514,6 +514,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	init_revisions(&revs, prefix);
+	revs.topo_order = 1;
 	argc = setup_revisions(argc, argv, &revs, NULL);
 	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
 	if (argc > 1)
@@ -524,7 +525,6 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
-	revs.topo_order = 1;
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
-- 
1.6.3.2.323.geb889
