From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Wed, 07 Dec 2011 00:01:37 +0100
Message-ID: <4EDE9ED1.8010502@lsrfire.ath.cx>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch> <4ED8F9AE.8030605@lsrfire.ath.cx> <4EDE9BBA.2010409@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 07 00:01:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY41D-0003Fl-8J
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 00:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab1LFXBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 18:01:42 -0500
Received: from india601.server4you.de ([85.25.151.105]:39037 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab1LFXBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 18:01:42 -0500
Received: from [192.168.2.105] (p4FFD9BF7.dip.t-dialin.net [79.253.155.247])
	by india601.server4you.de (Postfix) with ESMTPSA id DB46F2F8033;
	Wed,  7 Dec 2011 00:01:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EDE9BBA.2010409@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186403>

Reading of git objects needs to be protected by an exclusive lock
and cannot be parallelized.  Searching the read buffers can be done
in parallel, but for simple expressions threading is a net loss due
to its overhead, as measured by Thomas.  Turn it off unless we're
searching in the worktree.

Once the object store can be read safely by multiple threads in
parallel this patch should be reverted.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Goes on top of my earlier patch.  Could use a better commit message
with your (cleaned up) performance numbers.

 Documentation/git-grep.txt |    5 +++--
 builtin/grep.c             |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 47ac188..e981a9b 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -228,8 +228,9 @@ OPTIONS
 	there is a match and with non-zero status when there isn't.
 
 --threads <n>::
-	Run <n> search threads in parallel.  Default is 8.  This option
-	is ignored if git was built without support for POSIX threads.
+	Run <n> search threads in parallel.  Default is 8 when searching
+	the worktree and 0 otherwise.  This option is ignored if git was
+	built without support for POSIX threads.
 
 <tree>...::
 	Instead of searching tracked files in the working tree, search
diff --git a/builtin/grep.c b/builtin/grep.c
index 0bda900..f698642 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1048,7 +1048,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	nr_threads = 0;
 #else
 	if (nr_threads == -1)
-		nr_threads = (online_cpus() > 1) ? THREADS : 0;
+		nr_threads = (online_cpus() > 1 && !list.nr) ? THREADS : 0;
 
 	if (nr_threads > 0) {
 		opt.use_threads = 1;
-- 
1.7.8
