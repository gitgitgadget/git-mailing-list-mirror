From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/7] completion: get rid of compgen
Date: Wed, 10 Apr 2013 01:57:55 -0500
Message-ID: <1365577077-12648-6-git-send-email-felipe.contreras@gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 08:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPp0A-0007kM-S6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab3DJG7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 02:59:21 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:59285 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3DJG7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:59:17 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so61092qcs.20
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tY9SVJuJDrZvmqalDrX6HdJRs2PxkdPjZiMv5BHYXZE=;
        b=K0wPjV0SeEitpBNy/JLKhCqV+fVfFkv8sb82C3HCSTH96FrJpyddvzCDBM3x/4r+E0
         JwvPmab4TlwMEAp2twHZuefDoisRHdCcnBWpssvr9b6iwSSCavAxj4QP1SuiJId6PRou
         SvPVJay6WeOb2dhoPwYAYkMT4saIPSCzi4ywV/n0UAuux/dnm3Swyfm8LtLkFvNITsQ1
         fZ/ENjaREPyB3Ycwm7MP/Y0tHVfReZbrylS70E01014Qfs1pb9jBtvfbNfTCHYRDyzVK
         kdR5qO3PWL1Vc9itgtoBmyw9EY4Inqx2fPcusGq5BS3a/0dbcvP174svuudmegePpt+Z
         m26A==
X-Received: by 10.229.113.79 with SMTP id z15mr308280qcp.76.1365577156906;
        Tue, 09 Apr 2013 23:59:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u3sm14750922qab.1.2013.04.09.23.59.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 23:59:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220668>

The functionality we use from compgen is not much, we can do the same
manually, with drastical improvements in speed, specially when dealing
with only a few words.

This patch also has the sideffect that brekage reported by Jeroen Meije=
r
and SZEDER G=C3=A1bor gets fixed because we no longer expand the result=
ing
words.

Here are some numbers filtering N amount of words:

  =3D=3D 1 =3D=3D
  original: 0.002s
  new: 0.000s
  =3D=3D 10 =3D=3D
  original: 0.002s
  new: 0.000s
  =3D=3D 100 =3D=3D
  original: 0.003s
  new: 0.002s
  =3D=3D 1000 =3D=3D
  original: 0.012s
  new: 0.011s
  =3D=3D 10000 =3D=3D
  original: 0.056s
  new: 0.066s
  =3D=3D 100000 =3D=3D
  original: 2.669s
  new: 0.622s

If the results are not narrowed:

  =3D=3D 1 =3D=3D
  original: 0.002s
  new: 0.000s
  =3D=3D 10 =3D=3D
  original: 0.002s
  new: 0.001s
  =3D=3D 100 =3D=3D
  original: 0.004s
  new: 0.004s
  =3D=3D 1000 =3D=3D
  original: 0.020s
  new: 0.015s
  =3D=3D 10000 =3D=3D
  original: 0.101s
  new: 0.355s
  =3D=3D 100000 =3D=3D
  original: 2.850s
  new: 31.941s

So, unless 'git checkout <tab>' usually gives you more than 100000
results, you'll get an improvement :)

Other possible solutions perform better after 1000 words, but worst if
less than that:

  COMPREPLY=3D($(awk -v cur=3D"$3" -v pre=3D"$2" -v suf=3D"$4"
	'$0 ~ cur { print pre$0suf }' <<< "$1" ))

  COMPREPLY=3D($(printf -- "$2%s$4\n" $1 | grep "^$2$3"))

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++++++-----
 t/t9902-completion.sh                  |  6 +++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 90b54ab..d8009f5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -197,11 +197,16 @@ fi
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
@@ -221,8 +226,8 @@ __gitcomp ()
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
index b752f4d..6d9d141 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -165,7 +165,7 @@ test_expect_success '__gitcomp - suffix' '
 	EOF
 '
=20
-test_expect_failure '__gitcomp - doesnt fail because of invalid variab=
le name' '
+test_expect_success '__gitcomp - doesnt fail because of invalid variab=
le name' '
 	__gitcomp "$invalid_variable_name"
 '
=20
@@ -204,7 +204,7 @@ test_expect_success '__gitcomp_nl - no suffix' '
 	EOF
 '
=20
-test_expect_failure '__gitcomp_nl - doesnt fail because of invalid var=
iable name' '
+test_expect_success '__gitcomp_nl - doesnt fail because of invalid var=
iable name' '
 	__gitcomp_nl "$invalid_variable_name"
 '
=20
@@ -332,7 +332,7 @@ test_expect_success 'complete tree filename with sp=
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
1.8.2.1
