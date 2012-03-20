From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH] Fix missing/buggy diff output prefixes w/ --graph
Date: Tue, 20 Mar 2012 01:05:34 -0700
Message-ID: <1332230734-19734-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"Larry D'Anna" <larry@elder-gods.org>,
	"Bo Yang" <struggleyb.nku@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Timo Hirvonen" <tihirvon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 09:06:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9u5L-0001LF-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 09:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758596Ab2CTIGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 04:06:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43255 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758391Ab2CTIGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 04:06:11 -0400
Received: by dajr28 with SMTP id r28so11102223daj.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 01:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GiJq4IauK/9fEbhlxwurxCzR07Qsom7cUTFXZK41eq0=;
        b=Biox9WZS3D9wTMcurKfhzGwfrQaV9LEVOI1vg/4XBTihje1c22B0+XB/jfy4FA69vC
         1YbaB4ONOPNiENoPDleDwCTvrBpLmDjXsuGcafP+Il2pR/XahW41UW9hR+qEidXz7SSk
         2qC5dMunZ/xOg2+TEiKudi5mG4pBVEXO8PIJ/i+wS9LYAlyrGGN5Repe0cYEu2JRLv3c
         KokIbNzA8xatM45vQA05KPj8/G/cwvLFYAsT5+Gy6ax3g+EyJJQQb/sGYu5UzUdg22+4
         cC1a4C4Jc93NCY1gSUz12K2rNGbGZdpl//NoM9mTNgPFZrkD8CDP79ZcsGib36+N37nw
         YDng==
Received: by 10.68.218.134 with SMTP id pg6mr23659627pbc.111.1332230771195;
        Tue, 20 Mar 2012 01:06:11 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id h6sm758080pbj.44.2012.03.20.01.06.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 01:06:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193490>

Fixed issue with `git log --graph --stat -p` in which the "---" diff output
header appears before the diff output prefix.

Fixed issue where diff output prefix is absent on empty lines separating diff
stats and patch.

Added test to verify the graph decoration prefixes of
`git log --pretty=short --stat -p --graph` are printed correctly.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.c         |    6 +
 log-tree.c     |    7 +-
 t/t4202-log.sh |  277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 377ec1e..29003eb 100644
--- a/diff.c
+++ b/diff.c
@@ -4399,6 +4399,12 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
+			if (options->output_prefix) {
+				struct strbuf *msg = NULL;
+				msg = options->output_prefix(options,
+					options->output_prefix_data);
+				fwrite(msg->buf, msg->len, 1, stdout);
+			}
 			putc(options->line_termination, options->file);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
diff --git a/log-tree.c b/log-tree.c
index cea8756..3198503 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -710,15 +710,16 @@ int log_tree_diff_flush(struct rev_info *opt)
 		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE) {
-			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
-			if ((pch & opt->diffopt.output_format) == pch)
-				printf("---");
 			if (opt->diffopt.output_prefix) {
 				struct strbuf *msg = NULL;
 				msg = opt->diffopt.output_prefix(&opt->diffopt,
 					opt->diffopt.output_prefix_data);
 				fwrite(msg->buf, msg->len, 1, stdout);
 			}
+			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
+			if ((pch & opt->diffopt.output_format) == pch) {
+				printf("---");
+			}
 			putchar('\n');
 		}
 	}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 222f755..0634cc8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -516,4 +516,281 @@ test_expect_success 'show added path under "--follow -M"' '
 	)
 '
 
+cat > expect <<\EOF
+*   commit 8ef4f4679ada28dd41cf33904171230699b3e18d
+|\  Merge: f20367c 973a5f9
+| | Author: A U Thor <author@example.com>
+| |
+| |     Merge tag 'reach'
+| |
+| * commit 973a5f9e9bb0abe4ec31be32be491c47a7e6398e
+| | Author: A U Thor <author@example.com>
+| |
+| |     reach
+| | ---
+| |  reach.t |    1 +
+| |  1 file changed, 1 insertion(+)
+| |
+| | diff --git a/reach.t b/reach.t
+| | new file mode 100644
+| | index 0000000..10c9591
+| | --- /dev/null
+| | +++ b/reach.t
+| | @@ -0,0 +1 @@
+| | +reach
+| |
+|  \
+*-. \   commit f20367cac9f8cd439c0c87ac759efb4f4796ec29
+|\ \ \  Merge: c379a04 5c3c15c ef3da6e
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     Merge tags 'octopus-a' and 'octopus-b'
+| | | |
+| | * | commit ef3da6e2a2f079bc200e78965a39a116fc2d4878
+| | |/  Author: A U Thor <author@example.com>
+| | |
+| | |       octopus-b
+| | |   ---
+| | |    octopus-b.t |    1 +
+| | |    1 file changed, 1 insertion(+)
+| | |
+| | |   diff --git a/octopus-b.t b/octopus-b.t
+| | |   new file mode 100644
+| | |   index 0000000..d5fcad0
+| | |   --- /dev/null
+| | |   +++ b/octopus-b.t
+| | |   @@ -0,0 +1 @@
+| | |   +octopus-b
+| | |
+| * | commit 5c3c15ce5ec6cf5d260c61be95a731795930447f
+| |/  Author: A U Thor <author@example.com>
+| |
+| |       octopus-a
+| |   ---
+| |    octopus-a.t |    1 +
+| |    1 file changed, 1 insertion(+)
+| |
+| |   diff --git a/octopus-a.t b/octopus-a.t
+| |   new file mode 100644
+| |   index 0000000..11ee015
+| |   --- /dev/null
+| |   +++ b/octopus-a.t
+| |   @@ -0,0 +1 @@
+| |   +octopus-a
+| |
+* | commit c379a04c23f2789edf07246848e31f10176144a9
+|/  Author: A U Thor <author@example.com>
+|
+|       seventh
+|   ---
+|    seventh.t |    1 +
+|    1 file changed, 1 insertion(+)
+|
+|   diff --git a/seventh.t b/seventh.t
+|   new file mode 100644
+|   index 0000000..9744ffc
+|   --- /dev/null
+|   +++ b/seventh.t
+|   @@ -0,0 +1 @@
+|   +seventh
+|
+*   commit 5e75a131827b3266a24d843cf5dae8f8aebff01a
+|\  Merge: e8dcb3b 55d8853
+| | Author: A U Thor <author@example.com>
+| |
+| |     Merge branch 'tangle'
+| |
+| *   commit 55d8853048021e21dfb14765cc40515d4cb9ea59
+| |\  Merge: 2dc6a29 4447a16
+| | | Author: A U Thor <author@example.com>
+| | |
+| | |     Merge branch 'side' (early part) into tangle
+| | |
+| * |   commit 2dc6a29839f63e9972b0704b46b395144872f9b3
+| |\ \  Merge: f6c510e 394ef78
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     Merge branch 'master' (early part) into tangle
+| | | |
+| * | | commit f6c510e7021d2df08f4dde66a6a57da71de8d18a
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     tangle-a
+| | | | ---
+| | | |  tangle-a |    1 +
+| | | |  1 file changed, 1 insertion(+)
+| | | |
+| | | | diff --git a/tangle-a b/tangle-a
+| | | | new file mode 100644
+| | | | index 0000000..7898192
+| | | | --- /dev/null
+| | | | +++ b/tangle-a
+| | | | @@ -0,0 +1 @@
+| | | | +a
+| | | |
+* | | |   commit e8dcb3b68978a445f568542e635e8b320fd71704
+|\ \ \ \  Merge: e9e4904 1666e54
+| | | | | Author: A U Thor <author@example.com>
+| | | | |
+| | | | |     Merge branch 'side'
+| | | | |
+| * | | | commit 1666e5485f5fcc08598407e59213007dbbf4b940
+| | |_|/  Author: A U Thor <author@example.com>
+| |/| |
+| | | |       side-2
+| | | |   ---
+| | | |    2 |    1 +
+| | | |    1 file changed, 1 insertion(+)
+| | | |
+| | | |   diff --git a/2 b/2
+| | | |   new file mode 100644
+| | | |   index 0000000..0cfbf08
+| | | |   --- /dev/null
+| | | |   +++ b/2
+| | | |   @@ -0,0 +1 @@
+| | | |   +2
+| | | |
+| * | | commit 4447a165acfb48b2c9c14aaaf0eca1fbb0f937c7
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     side-1
+| | | | ---
+| | | |  1 |    1 +
+| | | |  1 file changed, 1 insertion(+)
+| | | |
+| | | | diff --git a/1 b/1
+| | | | new file mode 100644
+| | | | index 0000000..d00491f
+| | | | --- /dev/null
+| | | | +++ b/1
+| | | | @@ -0,0 +1 @@
+| | | | +1
+| | | |
+* | | | commit e9e4904485f3a3a62ed85919a94be796512e3b71
+| | | | Author: A U Thor <author@example.com>
+| | | |
+| | | |     Second
+| | | | ---
+| | | |  one |    1 +
+| | | |  1 file changed, 1 insertion(+)
+| | | |
+| | | | diff --git a/one b/one
+| | | | new file mode 100644
+| | | | index 0000000..9a33383
+| | | | --- /dev/null
+| | | | +++ b/one
+| | | | @@ -0,0 +1 @@
+| | | | +case
+| | | |
+* | | | commit 804a7879c6cac637c9d34d1608e3e54867d90b7e
+| |_|/  Author: A U Thor <author@example.com>
+|/| |
+| | |       sixth
+| | |   ---
+| | |    a/two |    1 -
+| | |    1 file changed, 1 deletion(-)
+| | |
+| | |   diff --git a/a/two b/a/two
+| | |   deleted file mode 100644
+| | |   index 9245af5..0000000
+| | |   --- a/a/two
+| | |   +++ /dev/null
+| | |   @@ -1 +0,0 @@
+| | |   -ni
+| | |
+* | | commit 394ef780a000df496e0a8fdd648963c3f9d96f56
+| | | Author: A U Thor <author@example.com>
+| | |
+| | |     fifth
+| | | ---
+| | |  a/two |    1 +
+| | |  1 file changed, 1 insertion(+)
+| | |
+| | | diff --git a/a/two b/a/two
+| | | new file mode 100644
+| | | index 0000000..9245af5
+| | | --- /dev/null
+| | | +++ b/a/two
+| | | @@ -0,0 +1 @@
+| | | +ni
+| | |
+* | | commit 5d311594784eefe7b43496741766fe058f1c91a1
+|/ /  Author: A U Thor <author@example.com>
+| |
+| |       fourth
+| |   ---
+| |    ein |    1 +
+| |    1 file changed, 1 insertion(+)
+| |
+| |   diff --git a/ein b/ein
+| |   new file mode 100644
+| |   index 0000000..9d7e69f
+| |   --- /dev/null
+| |   +++ b/ein
+| |   @@ -0,0 +1 @@
+| |   +ichi
+| |
+* | commit 2fbe8c09c8e84c2346ba2ac744cb09a926773855
+|/  Author: A U Thor <author@example.com>
+|
+|       third
+|   ---
+|    ichi |    1 +
+|    one  |    1 -
+|    2 files changed, 1 insertion(+), 1 deletion(-)
+|
+|   diff --git a/ichi b/ichi
+|   new file mode 100644
+|   index 0000000..9d7e69f
+|   --- /dev/null
+|   +++ b/ichi
+|   @@ -0,0 +1 @@
+|   +ichi
+|   diff --git a/one b/one
+|   deleted file mode 100644
+|   index 9d7e69f..0000000
+|   --- a/one
+|   +++ /dev/null
+|   @@ -1 +0,0 @@
+|   -ichi
+|
+* commit f7dab8eda217fc1e06315e7c91b6bd7c2a56363a
+| Author: A U Thor <author@example.com>
+|
+|     second
+| ---
+|  one |    2 +-
+|  1 file changed, 1 insertion(+), 1 deletion(-)
+|
+| diff --git a/one b/one
+| index 5626abf..9d7e69f 100644
+| --- a/one
+| +++ b/one
+| @@ -1 +1 @@
+| -one
+| +ichi
+|
+* commit 3a2fdcbc365f1f169c2d433dbb277d88b412d8c9
+  Author: A U Thor <author@example.com>
+
+      initial
+  ---
+   one |    1 +
+   1 file changed, 1 insertion(+)
+
+  diff --git a/one b/one
+  new file mode 100644
+  index 0000000..5626abf
+  --- /dev/null
+  +++ b/one
+  @@ -0,0 +1 @@
+  +one
+EOF
+
+test_expect_success 'log --graph with diff and stats' '
+	git log --graph --pretty=short --stat -p |
+		sed "s/ *\$//" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.3.4
