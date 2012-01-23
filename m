From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] grep: fix -l/-L interaction with decoration lines
Date: Mon, 23 Jan 2012 18:52:44 +0100
Message-ID: <74777e0e8633d980fee9a1a680a63535be042fdc.1327340917.git.trast@student.ethz.ch>
References: <CALEc4zGV6Oo-WR0vPE6=oEmm=fo4dd=nyBWFuK1oU7rmF9K41A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	<git@vger.kernel.org>
To: Albert Yale <surfingalbert@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 18:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpO4d-0005z5-2h
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 18:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab2AWRwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 12:52:50 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:26486 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab2AWRwu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 12:52:50 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 23 Jan
 2012 18:52:45 +0100
Received: from thomas.inf.ethz.ch (195.176.121.47) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 23 Jan
 2012 18:52:47 +0100
X-Mailer: git-send-email 1.7.9.rc2.215.gd9e83
In-Reply-To: <CALEc4zGV6Oo-WR0vPE6=oEmm=fo4dd=nyBWFuK1oU7rmF9K41A@mail.gmail.com>
X-Originating-IP: [195.176.121.47]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189001>

From: Albert Yale <surfingalbert@gmail.com>

In threaded mode, git-grep emits file breaks (enabled with context, -W
and --break) into the accumulation buffers even if they are not
required.  The output collection thread then uses skip_first_line to
skip the first such line in the output, which would otherwise be at
the very top.

This is wrong when the user also specified -l/-L/-c, in which case
every line is relevant.  While arguably giving these options together
doesn't make any sense, git-grep has always quietly accepted it.  So
do not skip anything in these cases.

Signed-off-by: Albert Yale <surfingalbert@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

> Reviewed-by: Thomas Rast <trast@student.ethz.ch>

Please don't.  I didn't actually read the patch or look at the code,
or say so, and you're claiming I did.  I was working purely from the
commit message.

> As for creating a test, I'm unfamiliar with the testing procedure for
> git-core. A "how to" in the "Documentation" folder would be very
> useful in that regard.

Well, there's t/README.


Here's a patch that also does -c and has tests.  Placing them was more
finicky than I hoped; the list of files in the repo varies wildly
across the test set.  It also exploits knowledge that git-ls-files
order is the same as 'git grep -l' order, which might not be
appropriate.


 builtin/grep.c  |    6 ++++--
 t/t7810-grep.sh |   22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..1120b9f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1034,8 +1034,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		if (opt.pre_context || opt.post_context || opt.file_break ||
-		    opt.funcbody)
+		if (!(opt.name_only || opt.unmatch_name_only ||
+		      opt.count)
+		    && (opt.pre_context || opt.post_context ||
+			opt.file_break || opt.funcbody))
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7ba5b16..75f4716 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -246,6 +246,28 @@ do
 done
 
 cat >expected <<EOF
+file
+EOF
+test_expect_success 'grep -l -C' '
+	git grep -l -C1 foo >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+file:5
+EOF
+test_expect_success 'grep -l -C' '
+	git grep -c -C1 foo >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -L -C' '
+	git ls-files >expected &&
+	git grep -L -C1 nonexistent_string >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 file:foo mmap bar_mmap
 EOF
 
-- 
1.7.9.rc2.215.gd9e83
