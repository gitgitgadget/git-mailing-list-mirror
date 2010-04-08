From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] apply: Allow blank *trailing* context lines to match beyond
 EOF
Date: Thu, 08 Apr 2010 06:14:31 +0200
Message-ID: <4BBD5827.7030003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 08 06:14:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzj8d-00040s-8M
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 06:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab0DHEOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 00:14:38 -0400
Received: from mail-ew0-f222.google.com ([209.85.219.222]:61926 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab0DHEOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 00:14:35 -0400
Received: by ewy22 with SMTP id 22so851188ewy.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 21:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=YkbE8NOChVGnyH7r/qR5EI2OLrd2J++jmrMGMK9FFnM=;
        b=l/w3qFBtYgWc+IsY7TNFpcRuBOoHRAbjmK1l3EcTv64tFhKzDNRbSZkOm1GpL1WUuf
         fyRiNw3cvmrqrEBPRAA+BkfK//EGUErBo+OC08gjG3Fnl9BSv4x5hOD6e0tsTQ0Pe/v3
         D698njkDq6GDTpQUs0JOztXEBXLZi9mWizd28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=HF02pjxR/EviLT92jO6XuJGedOushSALY5KQFKxRdYGMdtbCve+R7V5sp8c9fcLYbR
         bNpNsAlbm7eyT6hewmfBzjkynAIv7XUHcy8Ztm1OKdKoX8GmgSZrEp1SyPMNd8L8FBQl
         we+AI7D/UFXpytyZHTzOZw2jzaV6mINPQxOKg=
Received: by 10.213.40.201 with SMTP id l9mr3646606ebe.28.1270700073696;
        Wed, 07 Apr 2010 21:14:33 -0700 (PDT)
Received: from [10.0.1.10] (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 14sm8597557ewy.2.2010.04.07.21.14.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 21:14:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144310>

In 51667147be, "git apply --whitespace=3Dfix" was extended to
allow a blank context line to match beyond the end of the file,
but only if the context line was in the leading part of the
hunk (i.e. the hunk inserted additional contents at the end
of the file).

Drop the restriction that the context line must be in the
leading part of the hunk, thus allowing a file to be changed
from:

 a
 (blank line)

to:

 b
 a
 (blank line)

Note that the blank line will be kept, because "--whitespace=3Dfix"
only removes trailing blank lines that a hunk would add, never
trailing blank lines in the context.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
This patch should fix the problem observed by Junio, but note that
there will be one or more blank lines left at the end of the
file.

I am not sure whether that should be fixed. In this particular
case, the blank lines are part of the context but not part of
the file being patched, so it could be argued that the blank
lines should not be added back.

But there are already other circumstances in which
"--whitespace=3Dfix" does not guarantee that the file does
not end with blank lines, for instance if we have:

 a
 b
 (blank line)
 (blank line)
 (blank line)
 (blank line)
 c
 d

and then delete the "c" and "d" lines:

 a
 b
 (blank line)
 (blank line)
 (blank line)
 (blank line)

In this case, not all of the blank lines are even part of the context,
so even if we'll change the rules and remove blanks line in the context=
,
there would still be blank lines left at the end of the file.


 builtin/apply.c          |   12 ++++++------
 t/t4124-apply-ws-rule.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7ca9047..d17e046 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1864,13 +1864,13 @@ static int match_fragment(struct image *img,
 		if (match_end && (preimage->nr + try_lno !=3D img->nr))
 			return 0;
 	} else if (ws_error_action =3D=3D correct_ws_error &&
-		   (ws_rule & WS_BLANK_AT_EOF) && match_end) {
+		   (ws_rule & WS_BLANK_AT_EOF)) {
 		/*
-		 * This hunk that matches at the end extends beyond
-		 * the end of img, and we are removing blank lines
-		 * at the end of the file.  This many lines from the
-		 * beginning of the preimage must match with img, and
-		 * the remainder of the preimage must be blank.
+		 * This hunk extends beyond the end of img, and we are
+		 * removing blank lines at the end of the file.  This
+		 * many lines from the beginning of the preimage must
+		 * match with img, and the remainder of the preimage
+		 * must be blank.
 		 */
 		preimage_limit =3D img->nr - try_lno;
 	} else {
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index fb9ad24..451d75e 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -325,6 +325,18 @@ test_expect_success 'two missing blank lines at en=
d with --whitespace=3Dfix' '
 	test_cmp one expect
 '
=20
+test_expect_success 'missing blank line at end, insert before end, --w=
hitespace=3Dfix' '
+	{ echo a; echo; } >one &&
+	git add one &&
+	{ echo b; echo a; echo; } >one &&
+	cp one expect &&
+	git diff -- one >patch &&
+	echo a >one &&
+	test_must_fail git apply patch &&
+	git apply --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
 test_expect_success 'shrink file with tons of missing blanks at end of=
 file' '
 	{ echo a; echo b; echo c; } >one &&
 	cp one no-blank-lines &&
--=20
1.7.0.2.157.gb7e7f
