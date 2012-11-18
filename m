From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 5/8] completion: get rid of compgen
Date: Sun, 18 Nov 2012 11:56:50 +0100
Message-ID: <1353236213-13471-6-git-send-email-felipe.contreras@gmail.com>
References: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2ZO-0007zS-FP
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab2KRK5c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 05:57:32 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab2KRK5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:31 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IX41+nRmJR0iu1j6X8UGwh5HfTZcQtrOSPo4NH84YFc=;
        b=T3SmF8uc5UZeKrAyFAb0IskBFutHIMPKuHmG5RQ8GYY4+Xw5mwnqcHhjfJc1NTGfaO
         kYkOBkhdN/6Zybo+CO4cQw5GhPLaBF7hyWmXKOlQsakiBjVza9bolnY3R4Yb8xXnRMKF
         gaxMKCM+A03JRQBU+7TZVDmdpTE+VBZAsXSsOt09WSm5vHmpmjoGARj0uMSZBHGgbwRu
         kS8BLeKiwN+jM6L24aeL5OHrU9ZK958Qv5uMlX/aJlWOY6NdJhi1rnep4n0Cv2mws3hQ
         S9tVmIkPA5Nr1jvMbnMR1gLnRpzlYQpzqGc1vocR6DHmJ2tglLJFC0iW8FfT6WwxVZVY
         PdzA==
Received: by 10.204.12.202 with SMTP id y10mr1066557bky.51.1353236250867;
        Sun, 18 Nov 2012 02:57:30 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id q22sm878899bkv.16.2012.11.18.02.57.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:29 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210017>

The functionality we use from compgen is not much, we can do the same
manually, with drastical improvements in speed, specially when dealing
with only a few rods.

This patch also has the sideffect that brekage reported by Jeroen Meije=
r
and SZEDER G=C3=A1bor gets fixed because we no longer expand the result=
ing
words.

Other solutions with awk and sed are possible and more efficient when
dealing with tens of thousands of words. But is rarely the case. For th=
e
common cases, this solution is faster.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++++++-----
 t/t9902-completion.sh                  |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 19e18a8..0b72f24 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -227,11 +227,16 @@ fi
=20
 __gitcompadd ()
 {
-	COMPREPLY=3D($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
+	local i=3D0
+	for x in $1; do
+		if [[ "$x" =3D=3D "$3"* ]]; then
+			COMPREPLY[i++]=3D"$2$x$4"
+		fi
+	done
 }
=20
-# Generates completion reply with compgen, appending a space to possib=
le
-# completion words, if necessary.
+# Generates completion reply, appending a space to possible completion=
 words,
+# if necessary.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
@@ -251,8 +256,8 @@ __gitcomp ()
 	esac
 }
=20
-# Generates completion reply with compgen from newline-separated possi=
ble
-# completion words by appending a space to all of them.
+# Generates completion reply from newline-separated possible completio=
n words
+# by appending a space to all of them.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words, separated by a single newline.
 # 2: A prefix to be added to each possible completion word (optional).
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 35fc31b..7fb5b50 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -340,7 +340,7 @@ test_expect_success 'complete tree filename with sp=
aces' '
 	EOF
 '
=20
-test_expect_failure 'complete tree filename with metacharacters' '
+test_expect_success 'complete tree filename with metacharacters' '
 	echo content >"name with \${meta}" &&
 	git add . &&
 	git commit -m meta &&
--=20
1.8.0
