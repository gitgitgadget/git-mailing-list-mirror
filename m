From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Make sure show_all_errors when using porcelain error messages
Date: Wed,  1 Sep 2010 08:05:53 +0200
Message-ID: <1283321153-24745-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqeide0zkx.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 01 08:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqgSv-0003QJ-2s
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 08:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab0IAGGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 02:06:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47282 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab0IAGGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 02:06:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o815s12E029571
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Sep 2010 07:54:01 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OqgSJ-0007gN-1B; Wed, 01 Sep 2010 08:05:55 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OqgSI-0006Rl-V6; Wed, 01 Sep 2010 08:05:54 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpqeide0zkx.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 01 Sep 2010 07:54:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o815s12E029571
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1283925242.70965@rYeyNYnrZjNDBxwL3u/W9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155016>

opts.show_all_errors controls the number of errors that can be displayed,
and set_porcelain_error_msgs gives the format. But the formatting would
be incorrect if set_porcelain_error_msgs is called without setting
opts.show_all_errors.

There was a missing opts.show_all_errors in merge-recursive.c, and a case
where it was not obvious enough in merge.c.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
If this is the issue, we should probably change
set_porcelain_error_msgs to set show_all_errors itself (but that
requires changing the argument type)

 builtin/checkout.c |    2 +-
 merge-recursive.c  |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7250e5c..8a7f994 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -376,6 +376,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
 
+		topts.show_all_errors = 1;
 		set_porcelain_error_msgs(topts.msgs, "checkout");
 
 		refresh_cache(REFRESH_QUIET);
@@ -395,7 +396,6 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |= DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir = ".gitignore";
-		topts.show_all_errors = 1;
 		tree = parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
diff --git a/merge-recursive.c b/merge-recursive.c
index 638076e..c7fc7a7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -180,6 +180,7 @@ static int git_merge_trees(int index_only,
 	opts.fn = threeway_merge;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.show_all_errors = 1;
 	set_porcelain_error_msgs(opts.msgs, "merge");
 
 	init_tree_desc_from_tree(t+0, common);
-- 
1.7.2.2.175.ga619d.dirty
