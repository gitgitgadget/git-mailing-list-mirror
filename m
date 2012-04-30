From: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>
Subject: [PATCH v2] log-tree: use custom line terminator in line termination mode
Date: Mon, 30 Apr 2012 22:28:25 +0200
Message-ID: <1335817705-24718-1-git-send-email-jk@jk.gs>
References: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 22:28:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOxDF-0003t8-VO
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 22:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576Ab2D3U2r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 16:28:47 -0400
Received: from zoidberg.org ([88.198.6.61]:49660 "EHLO heapsort.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756582Ab2D3U2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 16:28:36 -0400
Received: from perceptron.heapsort.bogus (xdsl-89-0-44-98.netcologne.de [::ffff:89.0.44.98])
  (AUTH: PLAIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu with esmtp; Mon, 30 Apr 2012 22:28:34 +0200
  id 00401053.4F9EF5F2.00000914
X-Mailer: git-send-email 1.7.10.406.g0017
In-Reply-To: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196603>

When using a custom format in line termination mode (as opposed to line
separation mode), the configured line terminator is not used, so things
like "git log --pretty=3Dtformat:%H -z" do not work properly.

Make it use the line terminator the user ordered.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Here are two simple tests, for both format: and tformat: with -z.

 log-tree.c                    |    2 +-
 t/t4205-log-pretty-formats.sh |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 34c49e7..44f0268 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -682,7 +682,7 @@ void show_log(struct rev_info *opt)
 	if (opt->use_terminator) {
 		if (!opt->missing_newline)
 			graph_show_padding(opt->graph);
-		putchar('\n');
+		putchar(opt->diffopt.line_termination);
 	}
=20
 	strbuf_release(&msgbuf);
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 2ae9faa..03a73ba 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -71,4 +71,16 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=3Dtest-foo
 '
=20
+printf "add bar\0initial" > expected
+test_expect_success 'NUL separation' '
+	git log -z --pretty=3D"format:%s" >actual &&
+	test_cmp expected actual
+'
+
+printf "add bar\0initial\0" > expected
+test_expect_success 'NUL termination' '
+	git log -z --pretty=3D"tformat:%s" >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.10.406.g0017
