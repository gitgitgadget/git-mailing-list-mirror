From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [POC PATCH 5/5] completion: avoid compgen to fix expansion issues in
 __gitcomp_nl()
Date: Fri, 28 Sep 2012 12:09:35 +0200
Message-ID: <1348826975-2225-5-git-send-email-szeder@ira.uka.de>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 12:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THXWZ-0005cK-Og
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 12:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465Ab2I1KKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 06:10:10 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:61511 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464Ab2I1KKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 06:10:07 -0400
Received: from localhost6.localdomain6 (p5B130716.dip0.t-ipconnect.de [91.19.7.22])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MPqr4-1TMTCF42LK-00512H; Fri, 28 Sep 2012 12:10:02 +0200
X-Mailer: git-send-email 1.7.12.1.438.g7dfa67b
In-Reply-To: <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:b9W3QlXHk94LJW7SvOiNOJJq5NTPrLa7eIKyjsaG8EF
 dW20O/djh3jELAV/TcJ7j7SRXDSjjLAbJhFF0pg55lBeqU3xcB
 vplZX0MA5Jv+Ocmt/Q+BWOiNwddcNYC0QwUfzsXSNOI/adhJCF
 MWRQXQ9USWk+iFOPQkRjUnJ2HeWyRW7gDFgRR42UcfAPGC9aFg
 szd//F7gT5JmxxWN75pLfUvA4zzHd50vOJX1EyaaOcS8pBD8Wk
 dyEj/qntwj/V42OPR49tBsr7JJFcJ5OSRWeNH7Oo8LwQNl/Gm5
 UbG7QrSpzTkCy1sMSdIMGQ23vW4ONW3Ug5b+Doaq4ksQOgZ46m
 SuJeMcMHTXHBqvFvdl2NFlZTGQHUVwkZ261/8nBkCiqRdXC9+Q
 KNMziDECImYKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206552>

compgen performs expansion on all words in the list given to its -W
option.  This breaks completion in various ways if one of those words
can be expanded, as demonstrated by failing tests added in a previous
commit.

In __gitcomp_nl() we use only a small subset of compgen's
functionality: to filter matching possible completion words, and to
add a prefix and/or suffix to each of them.  Since the list of words
is newline-separated, we can do all these just as well with a little
sed script.  This way we can get rid of compgen and its additional
expansion of all words and don't need to perform excessive quoting to
circumvent it.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

We can also get rid of compgen in __gitcomp(); I already have working c=
ode
for that, but it still needs a bit of cleanup and commit messages.

 contrib/completion/git-completion.bash | 6 +++++-
 t/t9902-completion.sh                  | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index be800e09..2df865fd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -261,7 +261,11 @@ __gitcomp ()
 __gitcomp_nl ()
 {
 	local IFS=3D$'\n'
-	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}")=
)
+	COMPREPLY=3D($(echo "$1" |sed -n "/^${3-$cur}/ {
+		s/^/${2-}/
+		s/$/${4- }/
+		p
+	}"))
 }
=20
 __git_heads ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4af2a149..0ee91f64 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -209,7 +209,7 @@ test_expect_success '__gitcomp_nl - suffix' '
 	test_cmp expected out
 '
=20
-test_expect_failure '__gitcomp_nl - expandable words' '
+test_expect_success '__gitcomp_nl - expandable words' '
 	sed -e "s/Z$//" >expected <<-\EOF &&
 	$foo Z
 	$(bar) Z
--=20
1.7.12.1.438.g7dfa67b
