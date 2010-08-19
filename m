From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] apply: split quoted filename handling into new function
Date: Wed, 18 Aug 2010 20:46:46 -0500
Message-ID: <20100819014646.GA18922@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C65BCD2.6000701@kdbg.org>
 <20100814022625.GA4199@burratino>
 <201008142037.50833.j6t@kdbg.org>
 <20100819014516.GA7175@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 03:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OluF8-00089a-KY
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 03:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052Ab0HSBsa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 21:48:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58414 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab0HSBs3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 21:48:29 -0400
Received: by ywh1 with SMTP id 1so494111ywh.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4PlkFZllyXnHXc61W95HJvDdVXY8jqwGDwAiYSfmFqk=;
        b=LOC1C2CF+pebA9sV6ildTnZ4lgNTfcZ/nK+Nf7bV7H4eLa2kTl4or9FRgPkG2PLhIv
         h0TtvLVVpHc6csDgXuCdc2Q6PwZRmmRp1Bhx/HC+X4UfDK5fCHWIK839yFobA56DWcm5
         3aT+fKXwxFPzk5fc6KmRh0TjcOBLYpLGuSzos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=w95P9nawEdFsbpFJfNai2LRolI+dyXDqD+hqkuM1P7YoANle5qu+zk6wNcb7FAHYUp
         UppK5FZe5Rb/dSeYl5BQpxbiNi1Rmyld/8xP9+KGCyz1pd/jX0mas9bVovv6DE0UIp5R
         dRbxasuSIRoGG4Bv8VBA7fEfRz/hJTgUZh0lM=
Received: by 10.101.173.21 with SMTP id a21mr10422141anp.63.1282182508257;
        Wed, 18 Aug 2010 18:48:28 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id k11sm1388884ani.30.2010.08.18.18.48.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 18:48:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100819014516.GA7175@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153902>

The new find_name_gnu() function handles new-style '--- "a/foo"'
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
1.7.2.1.544.ga752d.dirty
