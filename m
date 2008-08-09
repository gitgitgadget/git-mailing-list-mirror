From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mailinfo: fix MIME multi-part message boundary handling
Date: Sat, 09 Aug 2008 01:33:59 -0700
Message-ID: <7vy7367fk8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 10:35:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRjuu-000302-DK
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 10:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbYHIIeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 04:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYHIIeK
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 04:34:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbYHIIeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 04:34:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3ADD34C8E7;
	Sat,  9 Aug 2008 04:34:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1B19F4C8E3; Sat,  9 Aug 2008 04:34:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE64A732-65ED-11DD-B10A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91755>

After finding a MIME multi-part message boundary line, the handle_body()
function is supposed to first flush any accumulated contents from the
previous part to the output stream.  However, the code mistakenly output
the boundary line it found.

The old code that used one global, fixed-length buffer line[] used an
alternate static buffer newline[] for keeping track of this accumulated
contents and flushed newline[] upon seeing the boundary; when 3b6121f
(git-mailinfo: use strbuf's instead of fixed buffers, 2008-07-13)
converted a fixed-length buffer in this program to use strbuf,these two
buffers were converted to "line" and "prev" (the latter of which now has a
much more sensible name) strbufs, but the code mistakenly flushed "line"
(which contains the boundary we have just found), instead of "prev".

This resulted in the first boundary to be output in front of the first
line of the message.

The rewritten implementation of handle_boundary() lost the terminating
newline; this would then result in the second line of the message to be
stuck with the first line.

The is_multipart_boundary() was designed to catch both the internal
boundary and the terminating one (the one with trailing "--"); this also
was broken with the rewrite, and the code in the handle_boundary() to
handle the terminating boundary was never triggered.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mailinfo.c  |   17 +++++++++++------
 t/t5100-mailinfo.sh |    2 +-
 t/t5100/info0011    |    5 +++++
 t/t5100/msg0011     |    2 ++
 t/t5100/patch0011   |   22 ++++++++++++++++++++++
 t/t5100/sample.mbox |   35 +++++++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100644 t/t5100/info0011
 create mode 100644 t/t5100/msg0011
 create mode 100644 t/t5100/patch0011

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index f974b9d..3577382 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -203,7 +203,8 @@ static void handle_content_transfer_encoding(const struct strbuf *line)
 
 static int is_multipart_boundary(const struct strbuf *line)
 {
-	return !strbuf_cmp(line, *content_top);
+	return (((*content_top)->len <= line->len) &&
+		!memcmp(line->buf, (*content_top)->buf, (*content_top)->len));
 }
 
 static void cleanup_subject(struct strbuf *subject)
@@ -649,8 +650,11 @@ again:
 		check_header(&line, p_hdr_data, 0);
 
 	strbuf_release(&newline);
-	/* eat the blank line after section info */
-	return (strbuf_getline(&line, fin, '\n') == 0);
+	/* replenish line */
+	if (strbuf_getline(&line, fin, '\n'))
+		return 0;
+	strbuf_addch(&line, '\n');
+	return 1;
 }
 
 static inline int patchbreak(const struct strbuf *line)
@@ -757,9 +761,10 @@ static void handle_body(void)
 		/* process any boundary lines */
 		if (*content_top && is_multipart_boundary(&line)) {
 			/* flush any leftover */
-			if (line.len)
-				handle_filter(&line);
-
+			if (prev.len) {
+				handle_filter(&prev);
+				strbuf_reset(&prev);
+			}
 			if (!handle_boundary())
 				goto handle_body_out;
 		}
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e9f3e72..8dfaddd 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. ../t5100/sample.mbox >last &&
 	last=`cat last` &&
 	echo total is $last &&
-	test `cat last` = 10'
+	test `cat last` = 11'
 
 for mail in `echo 00*`
 do
diff --git a/t/t5100/info0011 b/t/t5100/info0011
new file mode 100644
index 0000000..da5a605
--- /dev/null
+++ b/t/t5100/info0011
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: Xyzzy
+Date: Fri, 8 Aug 2008 13:08:37 +0200 (CEST)
+
diff --git a/t/t5100/msg0011 b/t/t5100/msg0011
new file mode 100644
index 0000000..4667f21
--- /dev/null
+++ b/t/t5100/msg0011
@@ -0,0 +1,2 @@
+Here comes a commit log message, and
+its second line is here.
diff --git a/t/t5100/patch0011 b/t/t5100/patch0011
new file mode 100644
index 0000000..8841d3c
--- /dev/null
+++ b/t/t5100/patch0011
@@ -0,0 +1,22 @@
+---
+ builtin-mailinfo.c  |    4 ++--
+
+diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
+index 3e5fe51..aabfe5c 100644
+--- a/builtin-mailinfo.c
++++ b/builtin-mailinfo.c
+@@ -758,8 +758,8 @@ static void handle_body(void)
+ 		/* process any boundary lines */
+ 		if (*content_top && is_multipart_boundary(&line)) {
+ 			/* flush any leftover */
+-			if (line.len)
+-				handle_filter(&line);
++			if (prev.len)
++				handle_filter(&prev);
+ 
+ 			if (!handle_boundary())
+ 				goto handle_body_out;
+-- 
+1.6.0.rc2
+
+
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index aba57f9..d7ca79b 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -465,3 +465,38 @@ index 962aa34..2d1520f 100644
 -- 
 1.5.6.2.455.g1efb2
 
+From nobody Fri Aug  8 22:24:03 2008
+Date: Fri, 8 Aug 2008 13:08:37 +0200 (CEST)
+From: A U Thor <a.u.thor@example.com>
+Subject: [PATCH 3/3 v2] Xyzzy
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="=-=-="
+
+--=-=-=
+Content-Type: text/plain; charset=iso-8859-15
+Content-Transfer-Encoding: quoted-printable
+
+Here comes a commit log message, and
+its second line is here.
+---
+ builtin-mailinfo.c  |    4 ++--
+
+diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
+index 3e5fe51..aabfe5c 100644
+--- a/builtin-mailinfo.c
++++ b/builtin-mailinfo.c
+@@ -758,8 +758,8 @@ static void handle_body(void)
+ 		/* process any boundary lines */
+ 		if (*content_top && is_multipart_boundary(&line)) {
+ 			/* flush any leftover */
+-			if (line.len)
+-				handle_filter(&line);
++			if (prev.len)
++				handle_filter(&prev);
+=20
+ 			if (!handle_boundary())
+ 				goto handle_body_out;
+--=20
+1.6.0.rc2
+
+--=-=-=--
-- 
1.6.0.rc2
