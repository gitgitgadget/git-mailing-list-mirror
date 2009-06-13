From: "Nick Edelen" <sirnot@gmail.com>
Subject: [PATCH] fix show_entry() in tree-diff.c for TREE_IN_RECURSIVE
Date: Sat, 13 Jun 2009 22:32:33 +0200
Message-ID: <op.uvhcoii8tdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:33:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFZuR-00026I-JV
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 22:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759455AbZFMUcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 16:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758679AbZFMUcj
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 16:32:39 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:56750 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640AbZFMUci (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 16:32:38 -0400
Received: by ewy6 with SMTP id 6so3932326ewy.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:to:subject:from:cc
         :content-type:mime-version:content-transfer-encoding:message-id
         :user-agent;
        bh=odNLj9YgK1V6wJTqZ26LUf2rA3Jkz2lfLEIAUVjQ7WA=;
        b=ht6x9xpP+VfyhFxbuGCyzfR/RjjXWZ4RzeHamWsjSqkeUMqtP5zjoyiKpOX0Aw28fV
         aWYgc1vGhY4Cyuh2l7k2HGeKsfpr0In9xTWlRE2HgR3SA/NwDeBhAJbOUPTb3YB80aAo
         qbBHDyfScv+9KQRRcwyQHmN9Cq7ULsWD7/6M8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:from:cc:content-type:mime-version
         :content-transfer-encoding:message-id:user-agent;
        b=xRI0OB/eeX6WUpV9gmzZ++UR6mjErjhKm/dezwRbAYSHc93oxHqYatDQsMNkEUN/zA
         Iyikh1J9gQ/VIq3C6ak8L8TokSSq+FWG398W29fVXuvU5P3geOvHo2CLWzujffm1zLrU
         4HXBWZB1UkeqEUFRo6SD+XplZVoVHWm+FLeN4=
Received: by 10.210.105.3 with SMTP id d3mr2455327ebc.43.1244925159670;
        Sat, 13 Jun 2009 13:32:39 -0700 (PDT)
Received: from sirnot.private (dhcp-077-251-020-197.chello.nl [77.251.20.197])
        by mx.google.com with ESMTPS id 7sm633604eyb.45.2009.06.13.13.32.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 13:32:39 -0700 (PDT)
User-Agent: Opera Mail/9.63 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121523>

fix show_entry() in tree_diff.c to display tree entries on TREE_IN_RECURSIVE

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
this seems like how it should act: trees are shown under this option for changes, so it's logical they should also be shown for adds and removals.  at any rate rev-cache needs it, so I sure hope it's supposed to do this...
 tree-diff.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index edd8394..189a298 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -239,6 +239,12 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 		if (!tree || type != OBJ_TREE)
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
+		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
+			newbase[baselen + pathlen] = 0;
+			opt->add_remove(opt, prefix[0], mode, sha1, newbase);
+			newbase[baselen + pathlen] = '/';
+		}
+
 		init_tree_desc(&inner, tree, size);
 		show_tree(opt, prefix, &inner, newbase, baselen + 1 + pathlen);
 
-- 
