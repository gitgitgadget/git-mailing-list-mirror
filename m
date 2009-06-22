From: Jeff King <peff@peff.net>
Subject: Re: git-mailsplit and TortoiseGit bugs
Date: Mon, 22 Jun 2009 16:29:40 -0400
Message-ID: <20090622202939.GA11912@sigill.intra.peff.net>
References: <5b31733c0906221053k4b2659bev1da861b8e997eb5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	tortoisegit-dev@googlegroups.com
To: Filip Navara <filip.navara@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 22:30:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIq9Z-0006Gh-As
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 22:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597AbZFVU3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963AbZFVU3k
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 16:29:40 -0400
Received: from peff.net ([208.65.91.99]:50595 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756597AbZFVU3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 16:29:39 -0400
Received: (qmail 8885 invoked by uid 107); 22 Jun 2009 20:31:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 22 Jun 2009 16:31:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2009 16:29:40 -0400
Content-Disposition: inline
In-Reply-To: <5b31733c0906221053k4b2659bev1da861b8e997eb5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122058>

On Mon, Jun 22, 2009 at 07:53:51PM +0200, Filip Navara wrote:

> I'd like to report a bug. There's an incompatibility between the way
> TortoiseGit sends patches by e-mail and their handling by
> git-mailsplit. The mail sent by TortoiseGit specifies the Content-Type
> header as "Content-Type: text/plain;
> boundary=WC_MAIL_PaRt_BoUnDaRy_05151998". git-mailsplit then
> misinterprets it and treats it as empty patch. While TortoiseGit
> should not be sending the boundary parameter, it is perfectly valid
> e-mail according to RFC 5322 and MIME RFCs. The "boundary" parameter
> should be ignored for anything but "multipart" Content-Types.

That seems like a bug in TortoiseGit, and I don't know if it is worth
git trying to work around problems in something that is not even close
to a 1.0 version.

Still, it is good to be liberal in what we accept. So maybe the patch
below is worth applying (I assume from your description it will fix the
problem you are having, but I didn't actually test it with TortoiseGit;
please confirm that it helps).

-- >8 --
mailinfo: accept useless non-multipart boundary attributes

There is no reason for a program generating a patch email to
add a "boundary" parameter to a text/plain (or any other
non-multipart) content type. However, at least one version
of TortoiseGit does so, confusing git-mailinfo, which looks
for and fails to find the boundary.

This patch causes mailinfo to respect boundary parameters
only for multipart/* content types, and simply ignore the
parameter otherwise.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-mailinfo.c            |    3 ++-
 t/t5100-mailinfo.sh           |   13 +++++++++++++
 t/t5100/boundary.in           |   20 ++++++++++++++++++++
 t/t5100/boundary.msg.expect   |    2 ++
 t/t5100/boundary.out.expect   |    5 +++++
 t/t5100/boundary.patch.expect |   11 +++++++++++
 6 files changed, 53 insertions(+), 1 deletions(-)
 create mode 100644 t/t5100/boundary.in
 create mode 100644 t/t5100/boundary.msg.expect
 create mode 100644 t/t5100/boundary.out.expect
 create mode 100644 t/t5100/boundary.patch.expect

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 92637ac..3e9dbe0 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -184,7 +184,8 @@ static void handle_content_type(struct strbuf *line)
 
 	if (!strcasestr(line->buf, "text/"))
 		 message_type = TYPE_OTHER;
-	if (slurp_attr(line->buf, "boundary=", boundary)) {
+	if (strcasestr(line->buf, "multipart/") &&
+	    slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
 		if (++content_top > &content[MAX_BOUNDARIES]) {
 			fprintf(stderr, "Too many boundaries to handle\n");
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e70ea94..e67ce55 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -77,4 +77,17 @@ test_expect_success 'mailinfo on from header without name works' '
 
 '
 
+test_expect_success 'mailinfo on text message with useless boundary' '
+
+	mkdir boundary &&
+	git mailsplit -oboundary "$TEST_DIRECTORY"/t5100/boundary.in &&
+	test_cmp "$TEST_DIRECTORY"/t5100/boundary.in boundary/0001 &&
+	git mailinfo boundary/msg boundary/patch \
+	  <boundary/0001 >boundary/out &&
+	test_cmp "$TEST_DIRECTORY"/t5100/boundary.out.expect boundary/out &&
+	test_cmp "$TEST_DIRECTORY"/t5100/boundary.msg.expect boundary/msg &&
+	test_cmp "$TEST_DIRECTORY"/t5100/boundary.patch.expect boundary/patch
+
+'
+
 test_done
diff --git a/t/t5100/boundary.in b/t/t5100/boundary.in
new file mode 100644
index 0000000..367ed7d
--- /dev/null
+++ b/t/t5100/boundary.in
@@ -0,0 +1,20 @@
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+Subject: [PATCH] a commit
+MIME-Version: 1.0
+Content-Type: text/plain; boundary="totally_useless"
+
+Commit message.
+
+---
+ foo |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/foo b/foo
+index 9123cdc..918dcf8 100644
+--- a/foo
++++ b/foo
+@@ -1 +1 @@
+-Fri Jun  9 00:44:04 PDT 2006
++Fri Jun  9 00:44:13 PDT 2006
diff --git a/t/t5100/boundary.msg.expect b/t/t5100/boundary.msg.expect
new file mode 100644
index 0000000..550aef5
--- /dev/null
+++ b/t/t5100/boundary.msg.expect
@@ -0,0 +1,2 @@
+Commit message.
+
diff --git a/t/t5100/boundary.out.expect b/t/t5100/boundary.out.expect
new file mode 100644
index 0000000..f247b6f
--- /dev/null
+++ b/t/t5100/boundary.out.expect
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: a commit
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/boundary.patch.expect b/t/t5100/boundary.patch.expect
new file mode 100644
index 0000000..bd32624
--- /dev/null
+++ b/t/t5100/boundary.patch.expect
@@ -0,0 +1,11 @@
+---
+ foo |    2 +-
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+
+diff --git a/foo b/foo
+index 9123cdc..918dcf8 100644
+--- a/foo
++++ b/foo
+@@ -1 +1 @@
+-Fri Jun  9 00:44:04 PDT 2006
++Fri Jun  9 00:44:13 PDT 2006
-- 
1.6.3.2.406.gd6a466.dirty
