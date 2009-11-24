From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] shortlog: respect commit encoding
Date: Tue, 24 Nov 2009 16:12:35 +0100
Message-ID: <1259075555-7831-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091111141342.GA1849@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiri Kosina <jkosina@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 16:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCx4W-0003vD-5c
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 16:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933407AbZKXPMl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 10:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933280AbZKXPMj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 10:12:39 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59392 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbZKXPMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 10:12:37 -0500
Received: from ukl by metis.ext.pengutronix.de with local (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1NCx4I-0000qQ-AI; Tue, 24 Nov 2009 16:12:41 +0100
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <20091111141342.GA1849@pengutronix.de>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.5 tests=BAYES_00,NO_RELAYS
	shortcircuit=no autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133578>

Before this change the author was taken from the raw commit without
reencoding.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 builtin-shortlog.c  |   25 +++++++++++++++----------
 t/t4201-shortlog.sh |   24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 8aa63c7..050bda8 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -139,14 +139,19 @@ static void read_from_stdin(struct shortlog *log)
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	const char *author =3D NULL, *buffer;
+	struct strbuf buf =3D STRBUF_INIT;
+	struct strbuf ufbuf =3D STRBUF_INIT;
+	struct pretty_print_context ctx =3D {0};
=20
-	buffer =3D commit->buffer;
+	pretty_print_commit(CMIT_FMT_RAW, commit, &buf, &ctx);
+
+	buffer =3D buf.buf;
 	while (*buffer && *buffer !=3D '\n') {
 		const char *eol =3D strchr(buffer, '\n');
=20
-		if (eol =3D=3D NULL)
+		if (eol =3D=3D NULL) {
 			eol =3D buffer + strlen(buffer);
-		else
+		} else
 			eol++;
=20
 		if (!prefixcmp(buffer, "author "))
@@ -157,20 +162,20 @@ void shortlog_add_commit(struct shortlog *log, st=
ruct commit *commit)
 		die("Missing author: %s",
 		    sha1_to_hex(commit->object.sha1));
 	if (log->user_format) {
-		struct strbuf buf =3D STRBUF_INIT;
 		struct pretty_print_context ctx =3D {0};
 		ctx.abbrev =3D DEFAULT_ABBREV;
 		ctx.subject =3D "";
 		ctx.after_subject =3D "";
 		ctx.date_mode =3D DATE_NORMAL;
-		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &buf, &ctx);
-		insert_one_record(log, author, buf.buf);
-		strbuf_release(&buf);
-		return;
-	}
-	if (*buffer)
+		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
+		buffer =3D ufbuf.buf;
+
+	} else if (*buffer)
 		buffer++;
+
 	insert_one_record(log, author, !*buffer ? "<none>" : buffer);
+	strbuf_release(&ufbuf);
+	strbuf_release(&buf);
 }
=20
 static void get_from_rev(struct rev_info *rev, struct shortlog *log)
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 405b971..118204b 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -51,5 +51,29 @@ git log HEAD > log
 GIT_DIR=3Dnon-existing git shortlog -w < log > out
=20
 test_expect_success 'shortlog from non-git directory' 'test_cmp expect=
 out'
+iconvfromutf8toiso885915() {
+	printf "%s" "$@" | iconv -f UTF-8 -t ISO-8859-15
+}
+
+git reset --hard "$commit"
+git config --unset i18n.commitencoding
+echo 2 > a1
+git commit --quiet -m "set a1 to 2 and some non-ASCII chars: =C3=84=C3=
=9F=C3=B8" --author=3D"J=C3=B6h=C3=A4nn=C3=ABs \"Dsch=C3=B6\" Schind=C3=
=ABlin <Johannes.Schindelin@gmx.de>" a1
+
+git config i18n.commitencoding "ISO-8859-15"
+echo 3 > a1
+git commit --quiet -m "$(iconvfromutf8toiso885915 "set a1 to 3 and som=
e non-ASCII chars: =C3=A1=C3=A6=C3=AF")" --author=3D"$(iconvfromutf8toi=
so885915 "J=C3=B6h=C3=A4nn=C3=ABs \"Dsch=C3=B6\" Schind=C3=ABlin <Johan=
nes.Schindelin@gmx.de>")" a1
+git config --unset i18n.commitencoding
+
+git shortlog HEAD~2.. > out
+
+cat > expect << EOF
+J=C3=B6h=C3=A4nn=C3=ABs "Dsch=C3=B6" Schind=C3=ABlin (2):
+      set a1 to 2 and some non-ASCII chars: =C3=84=C3=9F=C3=B8
+      set a1 to 3 and some non-ASCII chars: =C3=A1=C3=A6=C3=AF
+
+EOF
+
+test_expect_success 'shortlog encoding' 'test_cmp expect out'
=20
 test_done
--=20
1.6.5.3
