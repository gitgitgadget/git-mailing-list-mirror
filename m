From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] apply: Split quoted filename handling into new function
Date: Fri, 23 Jul 2010 20:09:25 -0500
Message-ID: <20100724010925.GB13670@burratino>
References: <20100724010618.GA13670@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Giuseppe Iuculano <iuculano@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 03:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTG3-0000Tw-Tb
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab0GXBK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 21:10:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63651 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720Ab0GXBK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 21:10:26 -0400
Received: by iwn7 with SMTP id 7so744258iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gMpe0bc97JruqKwFCkdvIBZBqnuHGgrXR/f4Bn6mBtI=;
        b=BJ6n3MkxcQpvrAdfC7ivzbnw6+oz44XWAq4LexsYRP2Jj09jVEpeKEi2o6m3L16/4y
         DJk2awEL2AdtbxghVTKivJRF+T9E1dYa4llO2ldW1iWOc7WtoWDEuPCJsWyeAKODsoLR
         0tde0up3HPDiJRaRRCAxq+xzdZqowQghRKx88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uAI/V+8weWKHVVK8I3siOzQoIypxJxKZ3EOFxWHUeXGHrWzNyyP/XTxTnzDA7sna68
         bV1kB3FmFWcw7/huVidgosXHuTfMZrmD1fU2isHGjmlN0h7lx6OfYucjOORFMN5Nwdrz
         ULB/pC8kBzoZbTqa7RCeE2IK9lh4+uiDRSxRE=
Received: by 10.231.159.203 with SMTP id k11mr4573844ibx.115.1279933824096;
        Fri, 23 Jul 2010 18:10:24 -0700 (PDT)
Received: from burratino ([64.134.164.56])
        by mx.google.com with ESMTPS id h8sm761083ibk.15.2010.07.23.18.10.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 18:10:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724010618.GA13670@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151591>

The new find_name_gnu() function handles new-style =E2=80=98--- "a/foo"=
=E2=80=99
patch header lines, leaving find_name() itself a bit less
daunting.

=46unctional change: do not clobber the p-value when there are not
enough path components in a quoted file name to honor it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/apply.c       |   70 +++++++++++++++++++++++++++--------------=
-------
 t/t4120-apply-popt.sh |   35 ++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 12ef9ea..efc109e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -416,44 +416,52 @@ static char *squash_slash(char *name)
 	return name;
 }
=20
+static char *find_name_gnu(const char *line, char *def, int p_value)
+{
+	struct strbuf name =3D STRBUF_INIT;
+	char *cp;
+
+	/*
+	 * Proposed "new-style" GNU patch/diff format; see
+	 * http://marc.theaimsgroup.com/?l=3Dgit&m=3D112927316408690&w=3D2
+	 */
+	if (unquote_c_style(&name, line, NULL)) {
+		strbuf_release(&name);
+		return NULL;
+	}
+
+	for (cp =3D name.buf; p_value; p_value--) {
+		cp =3D strchr(cp, '/');
+		if (!cp) {
+			strbuf_release(&name);
+			return NULL;
+		}
+		cp++;
+	}
+
+	/* name can later be freed, so we need
+	 * to memmove, not just return cp
+	 */
+	strbuf_remove(&name, 0, cp - name.buf);
+	free(def);
+	if (root)
+		strbuf_insert(&name, 0, root, root_len);
+	return squash_slash(strbuf_detach(&name, NULL));
+}
+
 static char *find_name(const char *line, char *def, int p_value, int t=
erminate)
 {
 	int len;
 	const char *start =3D NULL;
=20
+	if (*line =3D=3D '"') {
+		char *name =3D find_name_gnu(line, def, p_value);
+		if (name)
+			return name;
+	}
+
 	if (p_value =3D=3D 0)
 		start =3D line;
-
-	if (*line =3D=3D '"') {
-		struct strbuf name =3D STRBUF_INIT;
-
-		/*
-		 * Proposed "new-style" GNU patch/diff format; see
-		 * http://marc.theaimsgroup.com/?l=3Dgit&m=3D112927316408690&w=3D2
-		 */
-		if (!unquote_c_style(&name, line, NULL)) {
-			char *cp;
-
-			for (cp =3D name.buf; p_value; p_value--) {
-				cp =3D strchr(cp, '/');
-				if (!cp)
-					break;
-				cp++;
-			}
-			if (cp) {
-				/* name can later be freed, so we need
-				 * to memmove, not just return cp
-				 */
-				strbuf_remove(&name, 0, cp - name.buf);
-				free(def);
-				if (root)
-					strbuf_insert(&name, 0, root, root_len);
-				return squash_slash(strbuf_detach(&name, NULL));
-			}
-		}
-		strbuf_release(&name);
-	}
-
 	for (;;) {
 		char c =3D *line;
=20
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index b463b4f..2b2d00b 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -10,21 +10,50 @@ test_description=3D'git apply -p handling.'
 test_expect_success setup '
 	mkdir sub &&
 	echo A >sub/file1 &&
-	cp sub/file1 file1 &&
+	cp sub/file1 file1.saved &&
 	git add sub/file1 &&
 	echo B >sub/file1 &&
 	git diff >patch.file &&
-	rm sub/file1 &&
-	rmdir sub
+	git checkout -- sub/file1 &&
+	git mv sub s=C3=BCb &&
+	echo B >s=C3=BCb/file1 &&
+	git diff >patch.escaped &&
+	grep "[\]" patch.escaped &&
+	rm s=C3=BCb/file1 &&
+	rmdir s=C3=BCb
 '
=20
 test_expect_success 'apply git diff with -p2' '
+	cp file1.saved file1 &&
 	git apply -p2 patch.file
 '
=20
 test_expect_success 'apply with too large -p' '
+	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.file 2>err &&
 	grep "removing 3 leading" err
 '
=20
+test_expect_success 'apply (-p2) traditional diff with funny filenames=
' '
+	cat >patch.quotes <<-\EOF &&
+	diff -u "a/"sub/file1 "b/"sub/file1
+	--- "a/"sub/file1
+	+++ "b/"sub/file1
+	@@ -1 +1 @@
+	-A
+	+B
+	EOF
+	echo B >expected &&
+
+	cp file1.saved file1 &&
+	git apply -p2 patch.quotes &&
+	test_cmp expected file1
+'
+
+test_expect_success 'apply with too large -p and fancy filename' '
+	cp file1.saved file1 &&
+	test_must_fail git apply --stat -p3 patch.escaped 2>err &&
+	grep "removing 3 leading" err
+'
+
 test_done
--=20
1.7.2.rc3
