From: Michael Andreen <harv@ruin.nu>
Subject: [PATCH] Make XDF_NEED_MINIMAL default in blame.
Date: Thu, 20 Mar 2014 21:18:58 +0100
Message-ID: <6555655.XSJ9EnW4BY@mako>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 20 21:19:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQjQs-0001pd-0s
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 21:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759834AbaCTUTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 16:19:12 -0400
Received: from n.ruin.nu ([213.180.83.247]:36381 "EHLO n.ruin.nu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759829AbaCTUTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 16:19:11 -0400
Received: from mako.localnet (h-40-196.a336.priv.bahnhof.se [79.136.40.196])
	by n.ruin.nu (Postfix) with ESMTPSA id 334251DC0BB8;
	Thu, 20 Mar 2014 21:19:09 +0100 (CET)
User-Agent: KMail/4.11.5 (Linux/3.11.0-18-generic; KDE/4.11.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244581>

Currently git blame has a big problem finding copies and moves when you
split up a big file into smaller ones. One example in the git repository
is 2cf565c, which split the documentation into smaller files.

In 582aa00 XDF_NEED_MINIMAL was removed as the default for performance
reasons, mainly for diff and rebase, but blame was also changed.

In 059a500 the problem with blame was noticed and the flag --minimal was
introduced. However this flag is not documented and it is not possible
to set when using "git gui blame".

Setting XDF_NEED_MINIMAL as default has a small performance impact when
you run on a file with few modifications. However, if you run it on a
file with a bigger number of modifications, the performance impact is
small enough to not be noticable.

The previous behavior can still be activated with --no-minimal.

((2cf565c...))$ time PAGER=cat git blame -C -M
    Documentation/git-ls-files.txt > /dev/null

real    0m0.003s
user    0m0.002s
sys 0m0.000s

((2cf565c...))$ time PAGER=cat git blame --minimal -C -M
    Documentation/git-ls-files.txt > /dev/null

real    0m0.010s
user    0m0.009s
sys 0m0.000s

((2cf565c...))$ time PAGER=cat git blame -C -C -C -M
    Documentation/git-ls-files.txt > /dev/null

real    0m0.010s
user    0m0.010s
sys 0m0.000s

((2cf565c...))$ time PAGER=cat git blame --minimal -C -C -C -M
    Documentation/git-ls-files.txt > /dev/null

real    0m0.028s
user    0m0.027s
sys 0m0.000s

(master)$ time PAGER=cat git blame -C -C -C -M
    Documentation/git-ls-files.txt > /dev/null

real    0m2.338s
user    0m2.283s
sys 0m0.056s

(master)$ time PAGER=cat git blame --minimal -C -C -C -M
    Documentation/git-ls-files.txt > /dev/null

real    0m2.355s
user    0m2.285s
sys 0m0.069s

(master)$ time PAGER=cat git blame -C -M cache.h > /dev/null

real    0m1.755s
user    0m1.730s
sys 0m0.024s

(master)$ time PAGER=cat git blame --minimal -C -M cache.h > /dev/null

real    0m1.785s
user    0m1.770s
sys 0m0.014s

(master)$ time PAGER=cat git blame -C -C -C -M cache.h > /dev/null

real    0m31.515s
user    0m30.810s
sys 0m0.684s

(master)$ time PAGER=cat git blame --minimal -C -C -C -M cache.h >
/dev/null

real    0m31.504s
user    0m30.885s
sys 0m0.598s

Signed-off-by: Michael Andreen <harv@ruin.nu>
---
There hasn't been any arguments against this patch. Just updated the message 
with a note about --no-minimal.

Applies cleanly on both master and maint.

 builtin/blame.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e5b5d71..0e7ebd0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -42,7 +42,7 @@ static int show_root;
 static int reverse;
 static int blank_boundary;
 static int incremental;
-static int xdl_opts;
+static int xdl_opts = XDF_NEED_MINIMAL;
 static int abbrev = -1;
 static int no_whole_file_rename;
 
-- 
1.8.3.2
