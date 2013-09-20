From: Jeff King <peff@peff.net>
Subject: [PATCH] format-patch: print in-body "From" only when needed
Date: Fri, 20 Sep 2013 06:16:28 -0400
Message-ID: <20130920101626.GA21684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 20 12:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMxlZ-0007ji-FQ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 12:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab3ITKQm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Sep 2013 06:16:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:44760 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238Ab3ITKQl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 06:16:41 -0400
Received: (qmail 9611 invoked by uid 102); 20 Sep 2013 10:16:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Sep 2013 05:16:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Sep 2013 06:16:28 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235063>

Commit a908047 taught format-patch the "--from" option,
which places the author ident into an in-body from header,
and uses the committer ident in the rfc822 from header.  The
documentation claims that it will omit the in-body header
when it is the same as the rfc822 header, but the code never
implemented that behavior.

This patch completes the feature by comparing the two idents
and doing nothing when they are the same (this is the same
as simply omitting the in-body header, as the two are by
definition indistinguishable in this case). This makes it
reasonable to turn on "--from" all the time (if it matches
your particular workflow), rather than only using it when
exporting other people's patches.

Signed-off-by: Jeff King <peff@peff.net>
---
I had meant for this to be the behavior all along (as shown in the
documentation), and I can't imagine why I didn't implement it along wit=
h
the original topic. I never noticed because I didn't turn on "--from"
all the time in my workflow scripts until recently, but instead just
used it manually when sending other people's patches (which I do only
rarely).

 cache.h                 |  9 +++++++++
 ident.c                 | 29 +++++++++++++++++++++++++++++
 pretty.c                |  2 +-
 t/t4014-format-patch.sh | 10 ++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index a47b9c0..bfea954 100644
--- a/cache.h
+++ b/cache.h
@@ -953,6 +953,15 @@ struct ident_split {
  */
 extern int split_ident_line(struct ident_split *, const char *, int);
=20
+/*
+ * Compare split idents for equality or strict ordering. Note that we
+ * compare only the ident part of the line, ignoring any timestamp.
+ *
+ * Because there are two fields, we must choose one as the primary key=
; we
+ * currently arbitrarily pick the email.
+ */
+extern int ident_cmp(const struct ident_split *, const struct ident_sp=
lit *);
+
 struct checkout {
 	const char *base_dir;
 	int base_dir_len;
diff --git a/ident.c b/ident.c
index 1c123e6..b29f81f 100644
--- a/ident.c
+++ b/ident.c
@@ -402,3 +402,32 @@ int git_ident_config(const char *var, const char *=
value, void *data)
=20
 	return 0;
 }
+
+static int buf_cmp(const char *a_begin, const char *a_end,
+		   const char *b_begin, const char *b_end)
+{
+	int a_len =3D a_end - a_begin;
+	int b_len =3D b_end - b_begin;
+	int min =3D a_len < b_len ? a_len : b_len;
+	int cmp;
+
+	cmp =3D memcmp(a_begin, b_begin, min);
+	if (cmp)
+		return cmp;
+
+	return a_len - b_len;
+}
+
+int ident_cmp(const struct ident_split *a,
+	      const struct ident_split *b)
+{
+	int cmp;
+
+	cmp =3D buf_cmp(a->mail_begin, a->mail_end,
+		      b->mail_begin, b->mail_end);
+	if (cmp)
+		return cmp;
+
+	return buf_cmp(a->name_begin, a->name_end,
+		       b->name_begin, b->name_end);
+}
diff --git a/pretty.c b/pretty.c
index 74563c9..b4e32b7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -432,7 +432,7 @@ void pp_user_info(struct pretty_print_context *pp,
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
=20
 	if (pp->fmt =3D=3D CMIT_FMT_EMAIL) {
-		if (pp->from_ident) {
+		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
 			struct strbuf buf =3D STRBUF_INIT;
=20
 			strbuf_addstr(&buf, "From: ");
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 668933b..8f272bc 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1000,6 +1000,16 @@ test_expect_success '--from uses committer ident=
' '
 	test_cmp expect patch.head
 '
=20
+test_expect_success '--from omits redundant in-body header' '
+	git format-patch -1 --stdout --from=3D"A U Thor <author@example.com>"=
 >patch &&
+	cat >expect <<-\EOF &&
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" <patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success 'in-body headers trigger content encoding' '
 	GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic &&
 	test_when_finished "git reset --hard HEAD^" &&
--=20
1.8.3.4.20.geeaee04.dirty
