From: Michael Andreen <harv@ruin.nu>
Subject: [PATCH] Make XDF_NEED_MINIMAL default in blame.
Date: Sun, 16 Mar 2014 11:43:03 +0100
Message-ID: <154997837.FlSR2gFiUN@river>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3067410.H4kOPeA8MZ"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 11:53:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP8hC-0004TB-S7
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 11:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbaCPKxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 06:53:12 -0400
Received: from n.ruin.nu ([213.180.83.247]:43982 "EHLO n.ruin.nu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbaCPKxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 06:53:12 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Mar 2014 06:53:11 EDT
Received: from river.localnet (h-40-196.a336.priv.bahnhof.se [79.136.40.196])
	by n.ruin.nu (Postfix) with ESMTPSA id CE44C1DC0078
	for <git@vger.kernel.org>; Sun, 16 Mar 2014 11:43:03 +0100 (CET)
User-Agent: KMail/4.11.5 (Linux/3.12.13-gentoo; KDE/4.11.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244186>

This is a multi-part message in MIME format.

--nextPart3067410.H4kOPeA8MZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

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
Additional measurements attached, the variation is fairly small.

The --minimal flag is still there, but didn't want to break scripts
depending on it.

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


--nextPart3067410.H4kOPeA8MZ
Content-Disposition: attachment; filename="blame-time.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="blame-time.txt"

(master)$ time PAGER=cat git blame -C -M cache.h > /dev/null

real	0m1.767s
user	0m1.747s
sys	0m0.018s
(master)$ time PAGER=cat git blame -C -M cache.h > /dev/null

real	0m1.755s
user	0m1.730s
sys	0m0.024s
(master)$ time PAGER=cat git blame -C -M cache.h > /dev/null

real	0m1.784s
user	0m1.757s
sys	0m0.025s
(master)$ time PAGER=cat git blame --minimal -C -M cache.h > /dev/null

real	0m1.813s
user	0m1.797s
sys	0m0.014s
(master)$ time PAGER=cat git blame --minimal -C -M cache.h > /dev/null

real	0m1.790s
user	0m1.770s
sys	0m0.018s
(master)$ time PAGER=cat git blame --minimal -C -M cache.h > /dev/null

real	0m1.785s
user	0m1.770s
sys	0m0.014s
(master)$ time PAGER=cat git blame --minimal -C -M cache.h > /dev/null

real	0m1.794s
user	0m1.770s
sys	0m0.022s
(master)$ time PAGER=cat git blame -C -C -C -M cache.h > /dev/null

real	0m31.515s
user	0m30.810s
sys	0m0.684s
(master)$ time PAGER=cat git blame -C -C -C -M cache.h > /dev/null

real	0m31.594s
user	0m30.879s
sys	0m0.695s
(master)$ time PAGER=cat git blame --minimal -C -C -C -M cache.h > /dev/null

real	0m31.666s
user	0m31.054s
sys	0m0.591s
(master)$ time PAGER=cat git blame --minimal -C -C -C -M cache.h > /dev/null

real	0m31.504s
user	0m30.885s
sys	0m0.598s

(master)$ time PAGER=cat git blame -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m2.355s
user	0m2.319s
sys	0m0.035s
(master)$ time PAGER=cat git blame -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m2.352s
user	0m2.292s
sys	0m0.059s
(master)$ time PAGER=cat git blame -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m2.354s
user	0m2.312s
sys	0m0.040s
(master)$ time PAGER=cat git blame -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m2.338s
user	0m2.283s
sys	0m0.056s
(master)$ time PAGER=cat git blame --minimal -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m2.376s
user	0m2.302s
sys	0m0.071s
(master)$ time PAGER=cat git blame --minimal -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m2.362s
user	0m2.312s
sys	0m0.049s
(master)$ time PAGER=cat git blame --minimal -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m2.360s
user	0m2.301s
sys	0m0.057s
(master)$ time PAGER=cat git blame --minimal -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m2.355s
user	0m2.285s
sys	0m0.069s


---------------------------------------------------

((2cf565c...))$ time PAGER=cat git blame -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.003s
user	0m0.002s
sys	0m0.000s
((2cf565c...))$ time PAGER=cat git blame -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.003s
user	0m0.003s
sys	0m0.000s
((2cf565c...))$ time PAGER=cat git blame -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.004s
user	0m0.003s
sys	0m0.001s
((2cf565c...))$ time PAGER=cat git blame -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.004s
user	0m0.003s
sys	0m0.001s
((2cf565c...))$ time PAGER=cat git blame -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.003s
user	0m0.002s
sys	0m0.001s
((2cf565c...))$ time PAGER=cat git blame --minimal -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.010s
user	0m0.009s
sys	0m0.000s
((2cf565c...))$ time PAGER=cat git blame --minimal -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.011s
user	0m0.010s
sys	0m0.001s
((2cf565c...))$ time PAGER=cat git blame --minimal -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.012s
user	0m0.012s
sys	0m0.000s
((2cf565c...))$ time PAGER=cat git blame --minimal -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.011s
user	0m0.011s
sys	0m0.000s
((2cf565c...))$ time PAGER=cat git blame -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.008s
user	0m0.007s
sys	0m0.002s
((2cf565c...))$ time PAGER=cat git blame -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.011s
user	0m0.011s
sys	0m0.000s
((2cf565c...))$ time PAGER=cat git blame -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.010s
user	0m0.010s
sys	0m0.000s
((2cf565c...))$ time PAGER=cat git blame -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.010s
user	0m0.009s
sys	0m0.000s
((2cf565c...))$ time PAGER=cat git blame --minimal -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.028s
user	0m0.024s
sys	0m0.003s
((2cf565c...))$ time PAGER=cat git blame --minimal -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.032s
user	0m0.029s
sys	0m0.002s
((2cf565c...))$ time PAGER=cat git blame --minimal -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.027s
user	0m0.025s
sys	0m0.001s
((2cf565c...))$ time PAGER=cat git blame --minimal -C -C -C -M Documentation/git-ls-files.txt > /dev/null

real	0m0.028s
user	0m0.027s
sys	0m0.000s


--nextPart3067410.H4kOPeA8MZ--
