From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] bisect: add read_bisect_terms() to the public interface
Date: Thu, 30 Jul 2015 15:33:09 +0100
Message-ID: <55BA35A5.2020605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	antoine.delaite@ensimag.grenoble-inp.fr,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 16:40:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKp0Y-0007VF-TP
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 16:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbbG3OkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 10:40:23 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:39694 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753367AbbG3OkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 10:40:20 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2015 10:40:20 EDT
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 23866400E9D
	for <git@vger.kernel.org>; Thu, 30 Jul 2015 15:33:18 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 69E3F128162;
	Thu, 30 Jul 2015 15:33:15 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 128AE128153;
	Thu, 30 Jul 2015 15:33:15 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Thu, 30 Jul 2015 15:33:14 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274988>


Commit 833bd64f ("bisect: simplify the addition of new bisect terms",
29-06-2015) added a public function, read_bisect_terms(), to 'bisect.c'
which was then called by code in 'revision.c', having directly referenced
the symbol with an explicit external declaration. This causes sparse to
complain ('symbol not declared. Should it be static?').

In order to suppress the warning, move the external declaration to the
"bisect.h" header file and '#include' the header in 'revision.c'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

You recently mentioned that you may squash a fix to the 'ref-filter'
series in next whilst re-winding next. How about squashing this patch
into 'ad/bisect-cleanup' at the same time?

As you know, I have been 'up to my eyeballs' lately, so this patch is
(almost) a 'five minute quick fix' to the sparse warning. (You know that
I prefer to catch these while they are still in pu, but I missed this
one ... sorry!) So, if this patch is not appropriate (since I have not
followed any of the discussion which lead to this commit), please ignore!

BTW, a large part of 'bisect.h', namely the declartions of BISECT_SHOW_ALL,
REV_LIST_QUIET and rev_list_info are only referenced by 'builtin/rev-list.c'.
Noticed in passing ...

ATB,
Ramsay Jones

 bisect.h   | 2 ++
 revision.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bisect.h b/bisect.h
index 2a6c831..acd12ef 100644
--- a/bisect.h
+++ b/bisect.h
@@ -26,4 +26,6 @@ extern int bisect_next_all(const char *prefix, int no_checkout);
 
 extern int estimate_bisect_steps(int all);
 
+extern void read_bisect_terms(const char **bad, const char **good);
+
 #endif
diff --git a/revision.c b/revision.c
index b6b2cf7..5350139 100644
--- a/revision.c
+++ b/revision.c
@@ -18,6 +18,7 @@
 #include "commit-slab.h"
 #include "dir.h"
 #include "cache-tree.h"
+#include "bisect.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2079,8 +2080,6 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
-extern void read_bisect_terms(const char **bad, const char **good);
-
 static int for_each_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data, const char *term) {
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
-- 
2.5.0
