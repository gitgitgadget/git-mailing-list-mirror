From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] describe --contains: default to HEAD when no commit-ish is given
Date: Fri, 21 Aug 2015 16:50:32 +0200
Message-ID: <1440168632-15412-1-git-send-email-szeder@ira.uka.de>
References: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:51:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSnej-0006dJ-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 16:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbbHUOux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 10:50:53 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:40235 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751443AbbHUOuw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 10:50:52 -0400
Received: from x4db19803.dyn.telefonica.de ([77.177.152.3] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZSneY-0001qI-RU; Fri, 21 Aug 2015 16:50:48 +0200
X-Mailer: git-send-email 2.5.0.416.g84b07b4
In-Reply-To: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1440168648.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276300>

'git describe --contains' doesn't default to HEAD when no commit is
given, and it doesn't produce any output, not even an error:

  ~/src/git ((v2.5.0))$ ./git describe --contains
  ~/src/git ((v2.5.0))$ ./git describe --contains HEAD
  v2.5.0^0

Unlike other 'git describe' options, the '--contains' code path is
implemented by calling 'name-rev' with a bunch of options plus all the
commit-ishes that were passed to 'git describe'.  If no commit-ish was
present, then 'name-rev' got invoked with none, which then leads to the
behavior illustrated above.

Porcelain commands usually default to HEAD when no commit-ish is given,
and 'git describe' already does so in all other cases, so it should do
so with '--contains' as well.

Pass HEAD to 'name-rev' when no commit-ish is given on the command line
to make '--contains' behave consistently with other 'git describe'
options.

'git describe's short help already indicates that the commit-ish is
optional, but the synopsis in the man page doesn't, so update it
accordingly as well.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-describe.txt |  4 ++--
 builtin/describe.c             | 11 +++++++----
 t/t6120-describe.sh            |  8 ++++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describ=
e.txt
index e045fc73f8..c8f28c8c86 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -9,7 +9,7 @@ git-describe - Describe a commit using the most recent =
tag reachable from it
 SYNOPSIS
 --------
 [verse]
-'git describe' [--all] [--tags] [--contains] [--abbrev=3D<n>] <commit-=
ish>...
+'git describe' [--all] [--tags] [--contains] [--abbrev=3D<n>] [<commit=
-ish>...]
 'git describe' [--all] [--tags] [--contains] [--abbrev=3D<n>] --dirty[=
=3D<mark>]
=20
 DESCRIPTION
@@ -27,7 +27,7 @@ see the -a and -s options to linkgit:git-tag[1].
 OPTIONS
 -------
 <commit-ish>...::
-	Commit-ish object names to describe.
+	Commit-ish object names to describe.  Defaults to HEAD if omitted.
=20
 --dirty[=3D<mark>]::
 	Describe the working tree.
diff --git a/builtin/describe.c b/builtin/describe.c
index ce36032b1f..0e31ac5cb9 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -443,10 +443,13 @@ int cmd_describe(int argc, const char **argv, con=
st char *prefix)
 			if (pattern)
 				argv_array_pushf(&args, "--refs=3Drefs/tags/%s", pattern);
 		}
-		while (*argv) {
-			argv_array_push(&args, *argv);
-			argv++;
-		}
+		if (argc)
+			while (*argv) {
+				argv_array_push(&args, *argv);
+				argv++;
+			}
+		else
+			argv_array_push(&args, "HEAD");
 		return cmd_name_rev(args.argc, args.argv, prefix);
 	}
=20
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 57d50156bb..bf52a0a1cc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -115,6 +115,14 @@ check_describe e-3-* --first-parent --tags
=20
 check_describe $(git rev-parse --short HEAD) --exact-match --always HE=
AD
=20
+test_expect_success 'describe --contains defaults to HEAD without comm=
it-ish' '
+	echo "A^0" >expect &&
+	git checkout A &&
+	test_when_finished "git checkout -" &&
+	git describe --contains >actual &&
+	test_cmp expect actual
+'
+
 : >err.expect
 check_describe A --all A^0
 test_expect_success 'no warning was displayed for A' '
--=20
2.5.0.416.g84b07b4
