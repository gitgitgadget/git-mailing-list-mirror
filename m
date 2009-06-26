From: newren@gmail.com
Subject: [PATCHv3 3/7] fast-export: Make sure we show actual ref names instead of "(null)"
Date: Thu, 25 Jun 2009 22:48:29 -0600
Message-ID: <1245991713-12782-4-git-send-email-newren@gmail.com>
References: <1245991713-12782-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 06:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3PF-0003HF-DW
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbZFZEut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 00:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbZFZEur
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:50:47 -0400
Received: from mail-pz0-f202.google.com ([209.85.222.202]:44971 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZFZEuq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 00:50:46 -0400
Received: by mail-pz0-f202.google.com with SMTP id 40so3787pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5IVguPllnedSMfzu8Fy6hMT/vaHHusNuIw+CIKcc3Ds=;
        b=bSNSCsFApGAMuhXuEnovkVVqZOMS6rQRK58jncViVrMBh4wLsOb9Jb0y0TmJ5sAswS
         dHpjBFM/mNno0HjR+awcsMOXZTJPH0CiQ9wx2Oa9eoyZsLCQzAawR2I0fRyiPg+J9Uks
         l9yfpAHGnO57h+v0jqYl98fj0pKRE+3QfYdGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YFVpEUDT55Q7IwuXbxX3V7RK9VbKfSA02nLOicBrZkW2IjDjGCLUWilYrIs1y/44+E
         qpNZ86xv6Ump4MnZ0TtuGHqhuGXAoZuNJkmBvHM/TEuMVXSLhAUKJSD5B6Qw+B704P2G
         C4ebTykTzP3CK4Dck7ZEQO2ktxPU3HaanFSow=
Received: by 10.143.33.21 with SMTP id l21mr1146742wfj.252.1245991849224;
        Thu, 25 Jun 2009 21:50:49 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 27sm160173wff.6.2009.06.25.21.50.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 21:50:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.341.g1a0a
In-Reply-To: <1245991713-12782-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122270>

From: Elijah Newren <newren@gmail.com>

The code expects a ref name to be provided in commit->util.  While there
was some code to set commit->util, it only worked in cases where there was
an unbroken chain of revisions from a ref to the relevant commit.  In
cases such as running
   git fast-export --parents master -- COPYING
commit->util would fail to be set.  The old method of setting commit->util
has been removed in favor of requesting show_source from the revision
traversal machinery (related to the "--source" option of "git log" family
of commands.)

However, this change does not fix cases like
   git fast export master~1
or
   git fast export :/arguments
since in such cases commit->util will be "master~1" or ":/arguments" while
we need the actual ref (e.g. "refs/heads/master")

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Since the last series, some now-obsolete code has been removed.  Also,
the commit message now points out two cases that continue to fail with
this patch.  For the second of those cases (the :/arguments one), I'm
not sure that I even know what correct behavior would be.

 builtin-fast-export.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 8c90a2d..43a7e17 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -530,6 +530,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&revs, prefix);
 	revs.topo_order = 1;
+	revs.show_source = 1;
 	argc = setup_revisions(argc, argv, &revs, NULL);
 	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
 	if (argc > 1)
@@ -546,11 +547,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
 	while ((commit = get_revision(&revs))) {
 		if (has_unshown_parent(commit)) {
-			struct commit_list *parent = commit->parents;
 			add_object_array(&commit->object, NULL, &commits);
-			for (; parent; parent = parent->next)
-				if (!parent->item->util)
-					parent->item->util = commit->util;
 		}
 		else {
 			handle_commit(commit, &revs);
-- 
1.6.3.2.323.geb889
