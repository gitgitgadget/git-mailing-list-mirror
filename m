From: tboegi@web.de
Subject: [PATCH 1/3] git reset --hard gives clean working tree
Date: Thu, 11 Feb 2016 17:16:06 +0100
Message-ID: <1455207366-24892-1-git-send-email-tboegi@web.de>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 17:14:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTttL-0007dw-72
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 17:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbcBKQOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 11:14:46 -0500
Received: from mout.web.de ([212.227.17.11]:50616 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbcBKQOo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 11:14:44 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MYeys-1aYrfl0Zak-00VS6n; Thu, 11 Feb 2016 17:14:43
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:HtpCWpkP31N5XUQhvlyzq8jYRQ/9FAP7ampoo0DWm2+aL013xdU
 4LwUutEnnA4K872FK58PBw2hAr2KuIRyK/yHho3gcNspfB2jKH1XgVh5/CTauNHr2ZmImt6
 vtaSfWVRI5fZTuq+t7Sbp41C4w0uGSHyuw8K5T0s8qlf13lxnD/x5pDyHH6o8R6akhtFC+g
 5jM7rVSlj1Ovu0D4mZDdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g/3+Qmg6OCk=:DyOzL6ELP73O4q1SUTEtwB
 emqu4zfJqwN7CD+Bp1+NqIFMoha4AcdBOkxWrxeVWHUK/MGmflrDE5lhIBW5n6ukQbUMhqBu0
 psrS7jBIlEgQxPF+fCP+D04Vi2eZU5L+Ng2fsG1I2X10EEM5sUgak38iBcVciboG70x+m6ebp
 B3U2yCVdKMhBj1S4L4uyaQGppuc3lcfUOa8KAAnWKuFaApVUO6TKlgD/hiPjWbfcPLd1YT1yh
 xo7hHIt9UqjnrocHx1EHX/D/eHTUGIcGpyKdPTHCH9GbLNKlvw9jWuwQvGW6U/nwzRzhfswmv
 CN1awDCI7y8MPyVx1pw6Wc7E9irALkdQ+o3zYRd4GaTha44PrksLcXCtiXaccUYmeMaNUO9/d
 6SiwiL5ZzZesFtOYvG9mQP8DWdfQ0JNH8F2s50n7eEwulAzxpMyzrSmAEw7YNHuau7gd6gGXm
 EVBwhqYrtrHy1rJd8BUqKYPo5d28uhwdp8PnK59dtehC/ewS9XkIbBWeQhxaCojRjqu/G51Oi
 1EgMJROgj37ty3TJy68WXfEXXqhdevzIAT8IVHGW3Ma01Qo3XSpGbFxMzEgYGbret/oYQYSw1
 fDiNpggZfCsCieIu+xZybpfNvVCH6MzGYRjUvLuecueK0P4gkN03hoKad0iFBGnC0twSQ9JM6
 jv9djQoQJK/BMB/y4zDwNwZuNgf1qVYcoIRNGpIK97R/8KxuE6l+G1snQXro/EnTCPeh8duXt
 CRRRuHzofyWC5KEdz9mDNwCZN0taNv+MVqxqvxhxQ5vOXO1D5Uw6OoAUA3rAreFAMEB78Gpz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285984>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

We define the working tree file is clean if either:

  * the result of running convert_to_git() on the working tree
    contents matches what is in the index (because that would mean
    doing another "git add" on the path is a no-op); OR

  * the result of running convert_to_working_tree() on the content
    in the index matches what is in the working tree (because that
    would mean doing another "git checkout -f" on the path is a
    no-op).

Add an extra check in ce_compare_data() in read_cache.c, and adjust
the test cases in t0025:
When a file has CRLF in the index, and is checked out into the working =
tree,
but left unchabged, it is not normalized at the next commit.
Whenever the file is changed in the working tree, a line is added/delet=
ed
or dos2unix is run, it may be normalized at the next commit,
depending on .gitattributes.

This patch is a result of a longer discussion on the mailing list,
how to fix the flaky t0025.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
This is my attempt to help to fix flaky t0025:
 - steal the code from Junio
 - Add test case, change the existing if needed.
 - Spice with some optimizations
The commit messages may be in the state "improvable".

 read-cache.c         | 58 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t0025-crlf-auto.sh | 57 ++++++++++++++++++++++++++++++++++++++++++++=
+------
 2 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 394ce14..2948b8f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,17 +156,75 @@ void fill_stat_cache_info(struct cache_entry *ce,=
 struct stat *st)
 		ce_mark_uptodate(ce);
 }
=20
+/*
+ * Compare the data in buf with the data in the file pointed by fd and
+ * return 0 if they are identical, and non-zero if they differ.
+ */
+static int compare_with_fd(const char *input, ssize_t len, int fd)
+{
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t chunk_len, read_len;
+
+		chunk_len =3D sizeof(buf) < len ? sizeof(buf) : len;
+		read_len =3D xread(fd, buf, chunk_len ? chunk_len : 1);
+
+		if (!read_len)
+			/* EOF on the working tree file */
+			return !len ? 0 : -1;
+
+		if (!len)
+			/* we expected there is nothing left */
+			return -1;
+
+		if (memcmp(buf, input, read_len))
+			return -1;
+		input +=3D read_len;
+		len -=3D read_len;
+	}
+}
+
 static int ce_compare_data(const struct cache_entry *ce, struct stat *=
st)
 {
 	int match =3D -1;
 	int fd =3D open(ce->name, O_RDONLY);
=20
+	/*
+	 * Would another "git add" on the path change what is in the
+	 * index for the path?
+	 */
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
 			match =3D hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
+	if (!match)
+		return match;
+
+	/*
+	 * Would another "git checkout -f" out of the index change
+	 * what is in the working tree file?
+	 */
+	fd =3D open(ce->name, O_RDONLY);
+	if (fd >=3D 0) {
+		enum object_type type;
+		unsigned long size;
+		void *data =3D read_sha1_file(ce->sha1, &type, &size);
+
+		if (type =3D=3D OBJ_BLOB) {
+			struct strbuf worktree =3D STRBUF_INIT;
+			if (convert_to_working_tree(ce->name, data, size,
+																	&worktree)) {
+				free(data);
+				data =3D strbuf_detach(&worktree, &size);
+			}
+			if (!compare_with_fd(data, size, fd))
+				match =3D 0;
+		}
+		free(data);
+		close(fd);
+	}
 	return match;
 }
=20
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index c164b46..4a7e5c0 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -14,6 +14,8 @@ test_expect_success setup '
=20
 	for w in Hello world how are you; do echo $w; done >LFonly &&
 	for w in I am very very fine thank you; do echo ${w}Q; done | q_to_cr=
 >CRLFonly &&
+	cp CRLFonly CRLFonly1 &&
+	cp CRLFonly CRLFonly2 &&
 	for w in Oh here is a QNUL byte how alarming; do echo ${w}; done | q_=
to_nul >LFwithNUL &&
 	git add . &&
=20
@@ -23,6 +25,28 @@ test_expect_success setup '
 	CRLFonly=3D$(git rev-parse HEAD:CRLFonly) &&
 	LFwithNUL=3D$(git rev-parse HEAD:LFwithNUL) &&
=20
+	cp CRLFonly CRLFonly.orig &&
+	for w in I am very very fine thank YOU; do echo ${w}Q; done | q_to_cr=
 >CRLFonly.changed &&
+	cat >expnorm  <<-EOF &&
+		MIQ
+		MamQ
+		MveryQ
+		MveryQ
+		MfineQ
+		MthankQ
+		MyouQ
+		PI
+		Pam
+		Pvery
+		Pvery
+		Pfine
+		Pthank
+		PYOU
+	EOF
+	cat >expunor  <<-EOF &&
+		MyouQ
+		PYOUQ
+	EOF
 	echo happy.
 '
=20
@@ -39,7 +63,7 @@ test_expect_success 'default settings cause no change=
s' '
 	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
-test_expect_success 'crlf=3Dtrue causes a CRLF file to be normalized' =
'
+test_expect_success 'crlf=3Dtrue causes an unchanged CRLF file not to =
be normalized' '
=20
 	# Backwards compatibility check
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
@@ -49,10 +73,10 @@ test_expect_success 'crlf=3Dtrue causes a CRLF file=
 to be normalized' '
 	# Note, "normalized" means that git will normalize it if added
 	has_cr CRLFonly &&
 	CRLFonlydiff=3D$(git diff CRLFonly) &&
-	test -n "$CRLFonlydiff"
+	test -z "$CRLFonlydiff"
 '
=20
-test_expect_success 'text=3Dtrue causes a CRLF file to be normalized' =
'
+test_expect_success 'text=3Dtrue causes an unchanged CRLF file not to =
be normalized' '
=20
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	echo "CRLFonly text" > .gitattributes &&
@@ -61,7 +85,7 @@ test_expect_success 'text=3Dtrue causes a CRLF file t=
o be normalized' '
 	# Note, "normalized" means that git will normalize it if added
 	has_cr CRLFonly &&
 	CRLFonlydiff=3D$(git diff CRLFonly) &&
-	test -n "$CRLFonlydiff"
+	test -z "$CRLFonlydiff"
 '
=20
 test_expect_success 'eol=3Dcrlf gives a normalized file CRLFs with aut=
ocrlf=3Dfalse' '
@@ -114,7 +138,7 @@ test_expect_success 'autocrlf=3Dtrue does not norma=
lize CRLF files' '
 	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
-test_expect_success 'text=3Dauto, autocrlf=3Dtrue _does_ normalize CRL=
=46 files' '
+test_expect_success 'text=3Dauto, autocrlf=3Dtrue  causes an unchanged=
 CRLF file not to be normalized' '
=20
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf true &&
@@ -126,7 +150,7 @@ test_expect_success 'text=3Dauto, autocrlf=3Dtrue _=
does_ normalize CRLF files' '
 	LFonlydiff=3D$(git diff LFonly) &&
 	CRLFonlydiff=3D$(git diff CRLFonly) &&
 	LFwithNULdiff=3D$(git diff LFwithNUL) &&
-	test -z "$LFonlydiff" -a -n "$CRLFonlydiff" -a -z "$LFwithNULdiff"
+	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
 test_expect_success 'text=3Dauto, autocrlf=3Dtrue does not normalize b=
inary files' '
@@ -152,4 +176,25 @@ test_expect_success 'eol=3Dcrlf _does_ normalize b=
inary files' '
 	test -z "$LFwithNULdiff"
 '
=20
+test_expect_success 'crlf=3Dtrue causes a changed CRLF file to be norm=
alized' '
+	git config core.autocrlf false &&
+	echo "CRLFonly1 crlf" > .gitattributes &&
+	# Note, "normalized" means that git will normalize it if added
+	cp CRLFonly.changed CRLFonly1 &&
+	git add CRLFonly1 &&
+	git diff --cached CRLFonly1 |
+	tr "\015" Q | sed -ne "/^[+-][a-zA-Z]/p" | tr "+-" PM >actual1 &&
+	test_cmp expnorm actual1
+'
+
+test_expect_success 'autocrlf=3Dtrue causes a changed CRLF file not to=
 be normalized' '
+	git config core.autocrlf true &&
+	echo > .gitattributes &&
+	# Note, "normalized" means that git will normalize it if added
+	cp CRLFonly.changed CRLFonly2 &&
+	git add CRLFonly2 &&
+	git diff --cached CRLFonly2 |
+	tr "\015" Q  | sed -ne "/^[+-][a-zA-Z]/p" |	tr "+-" PM >actual2 &&
+	test_cmp expunor actual2
+'
 test_done
--=20
2.7.0.303.g2c4f448.dirty
