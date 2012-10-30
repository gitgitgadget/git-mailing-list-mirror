From: karsten.blees@dcon.de
Subject: [PATCH] update-index/diff-index: use core.preloadindex to improve
 performance
Date: Tue, 30 Oct 2012 10:50:42 +0100
Message-ID: <OF831F4AE9.23F46743-ONC1257AA7.00353C1F-C1257AA7.00361535@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: msysgit@googlegroups.com, pro-logic@optusnet.com.au
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 11:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT8jF-0003ZJ-AV
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 11:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189Ab2J3KHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 06:07:10 -0400
Received: from mail.dcon.de ([77.244.111.98]:18915 "EHLO MAIL.DCON.DE"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab2J3KHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 06:07:09 -0400
X-Greylist: delayed 979 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2012 06:07:09 EDT
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 30.10.2012 11:07:09,
	Serialize complete at 30.10.2012 11:07:09
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208689>

'update-index --refresh' and 'diff-index' (without --cached) don't honor
the core.preloadindex setting yet. Porcelain commands using these (such as
git [svn] rebase) suffer from this, especially on Windows.

Use read_cache_preload to improve performance.

Additionally, in builtin/diff.c, don't preload index status if we don't
access the working copy (--cached).

Results with msysgit on WebKit repo (2GB in 200k files):

                | update-index | diff-index | rebase
----------------+--------------+------------+---------
msysgit-v1.8.0  |       9.157s |    10.536s | 42.791s
+ preloadindex  |       9.157s |    10.536s | 28.725s
+ this patch    |       2.329s |     2.752s | 15.152s
+ fscache [1]   |       0.731s |     1.171s |  8.877s

[1] https://github.com/kblees/git/tree/kb/fscache-v3

Thanks-to: Albert Krawczyk <pro-logic@optusnet.com.au>
Signed-off-by: Karsten Blees <blees@dcon.de>
---

Can also be pulled from: 
https://github.com/kblees/git/tree/kb/update-diff-index-preload-upstream

I thought I might send this upstream directly, as its not msysgit related. 
More performance figures (for msysgit) can be found in this discussion: 
https://github.com/pro-logic/git/commit/32c03dd8

Ciao,
Karsten

 builtin/diff-index.c   |  8 ++++++--
 builtin/diff.c         | 12 ++++++++----
 builtin/update-index.c |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 2eb32bd..1c737f7 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -41,9 +41,13 @@ int cmd_diff_index(int argc, const char **argv, const 
char *prefix)
        if (rev.pending.nr != 1 ||
            rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
                usage(diff_cache_usage);
-       if (!cached)
+       if (!cached) {
                setup_work_tree();
-       if (read_cache() < 0) {
+               if (read_cache_preload(rev.diffopt.pathspec.raw) < 0) {
+                       perror("read_cache_preload");
+                       return -1;
+               }
+       } else if (read_cache() < 0) {
                perror("read_cache");
                return -1;
        }
diff --git a/builtin/diff.c b/builtin/diff.c
index 9650be2..198b921 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -130,8 +130,6 @@ static int builtin_diff_index(struct rev_info *revs,
                        usage(builtin_diff_usage);
                argv++; argc--;
        }
-       if (!cached)
-               setup_work_tree();
        /*
         * Make sure there is one revision (i.e. pending object),
         * and there is no revision filtering parameters.
@@ -140,8 +138,14 @@ static int builtin_diff_index(struct rev_info *revs,
            revs->max_count != -1 || revs->min_age != -1 ||
            revs->max_age != -1)
                usage(builtin_diff_usage);
-       if (read_cache_preload(revs->diffopt.pathspec.raw) < 0) {
-               perror("read_cache_preload");
+       if (!cached) {
+               setup_work_tree();
+               if (read_cache_preload(revs->diffopt.pathspec.raw) < 0) {
+                       perror("read_cache_preload");
+                       return -1;
+               }
+       } else if (read_cache() < 0) {
+               perror("read_cache");
                return -1;
        }
        return run_diff_index(revs, cached);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 74986bf..ada1dff 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -593,6 +593,7 @@ struct refresh_params {
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
        setup_work_tree();
+       read_cache_preload(NULL);
        *o->has_errors |= refresh_cache(o->flags | flag);
        return 0;
 }
-- 
1.8.0.msysgit.0.3.g7d9d98c
