From: Jeff King <peff@peff.net>
Subject: [PATCH] rev-list: handle %x00 NUL in user format
Date: Thu, 7 Oct 2010 14:25:43 -0400
Message-ID: <20101007182542.GA20165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 20:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3v9t-0001mW-Nx
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab0JGSZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 14:25:32 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35426 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab0JGSZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 14:25:31 -0400
Received: (qmail 20220 invoked by uid 111); 7 Oct 2010 18:25:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 07 Oct 2010 18:25:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Oct 2010 14:25:43 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158426>

The code paths for showing commits in "git log" and "git
rev-list --graph" correctly handle embedded NULs by looking
only at the resulting strbuf's length, and never treating it
as a C string. The code path for regular rev-list, however,
used printf("%s"), which resulted in truncated output. This
patch uses fwrite instead, like the --graph code path.

Signed-off-by: Jeff King <peff@peff.net>
---
I built this on master, though it is perhaps maint-worthy. The buggy
line seems to blame back to at least v1.5.3-era.

Erik mentioned a potential problem with fwrite() and the way we handle
ANSI emulation for Windows. I think if there is a problem, then the same
problem exists in the --graph code, and we should do this, and then fix
both on top.

 builtin/rev-list.c         |    6 ++++--
 t/t6006-rev-list-format.sh |    8 ++++++++
 t/test-lib.sh              |    4 ++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index efe9360..3b2dca0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -147,8 +147,10 @@ static void show_commit(struct commit *commit, void *data)
 			}
 		} else {
 			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
-			    buf.len)
-				printf("%s%c", buf.buf, info->hdr_termination);
+			    buf.len) {
+				fwrite(buf.buf, 1, buf.len, stdout);
+				putchar(info->hdr_termination);
+			}
 		}
 		strbuf_release(&buf);
 	} else {
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index cccacd4..d918cc0 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -162,6 +162,14 @@ commit 131a310eb913d107dd3c09a65d1651175898735d
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 EOF
 
+test_expect_success '%x00 shows NUL' '
+	echo  >expect commit f58db70b055c5718631e5c61528b28b12090cdea &&
+	echo >>expect fooQbar &&
+	git rev-list -1 --format=foo%x00bar HEAD >actual.nul &&
+	nul_to_q <actual.nul >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '%ad respects --date=' '
 	echo 2005-04-07 >expect.ad-short &&
 	git log -1 --date=short --pretty=tformat:%ad >output.ad-short master &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2af8f10..bbe79e0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -248,6 +248,10 @@ test_decode_color () {
 		-e 's/.\[m/<RESET>/g'
 }
 
+nul_to_q () {
+	perl -pe 'y/\000/Q/'
+}
+
 q_to_nul () {
 	perl -pe 'y/Q/\000/'
 }
-- 
1.7.3.1.203.g81d8.dirty
