From: Santhosh Kumar Mani <santhoshmani@gmail.com>
Subject: [RFC/PATCH] show tracking branches with their associated branch
 names
Date: Sat, 10 Dec 2011 13:10:29 +0530
Message-ID: <1323502829.1698.6.camel@sdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 08:41:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZHYT-0004hu-JL
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 08:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab1LJHkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 02:40:37 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34188 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab1LJHkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 02:40:36 -0500
Received: by ggnr5 with SMTP id r5so4081546ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 23:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=uU4E9QON+JUOFg4mSD9u68goS4fRp/fdkzm4tYoxumc=;
        b=mWHs6NU9to5IvTsB8pdUf1vmNXe8mfHOt/VE/7kex4DR8LYXr0GD8+tzMFF37uJYHx
         WXntj2LYe2KpsVuHVxsO3GbdCZ/pE5lGCXBMTed/zqHdRNu7VP/MqM1QdQatcyHREj5R
         ZcJtHQJXicexrRxIlsnMuTvrLwoiOTPg/eztY=
Received: by 10.182.7.42 with SMTP id g10mr1205510oba.45.1323502835760;
        Fri, 09 Dec 2011 23:40:35 -0800 (PST)
Received: from [10.0.0.2] ([122.181.155.85])
        by mx.google.com with ESMTPS id xa6sm9076577obb.4.2011.12.09.23.40.33
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 23:40:35 -0800 (PST)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186727>

The "git branch" command, by default, displays the local branches. There
is no visual distinction made between the tracking branches and normal
local branches. This patch enables the "git branch" to display
tracking info for tracking branches:

Before this patch:
  $ git branch
  * master
    local

After this patch:
  $ git branch
  * master [origin/master]
    local

Signed-off-by: Santhosh Kumar Mani <santhoshmani@gmail.com>
---
 builtin/branch.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e1e486e..4841416 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -373,6 +373,19 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
+static int get_tracking_branch_name(struct strbuf *name, const char
*branch_name)
+{
+	struct branch *branch = branch_get(branch_name);
+
+	if (branch && branch->merge && branch->merge[0]->dst) {
+		strbuf_addf(name, " [%s]",
+				shorten_unambiguous_ref(branch->merge[0]->dst, 0));
+		return 1;
+	}
+
+	return 0;
+}
+
 static void fill_tracking_info(struct strbuf *stat, const char
*branch_name,
 		int show_upstream_ref)
 {
@@ -475,6 +488,9 @@ static void print_ref_item(struct ref_item *item,
int maxwidth, int verbose,
 	else if (verbose)
 		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
 		add_verbose_info(&out, item, verbose, abbrev);
+	else if (get_tracking_branch_name(&out, item->name))
+		;
+
 	printf("%s\n", out.buf);
 	strbuf_release(&name);
 	strbuf_release(&out);
-- 
1.7.0.4
