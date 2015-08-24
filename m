From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2] describe --contains: default to HEAD when no commit-ish is given
Date: Mon, 24 Aug 2015 18:15:18 +0200
Message-ID: <1440432918-27751-1-git-send-email-szeder@ira.uka.de>
References: <20150824181417.Horde.2DAlveA2ZaXbdApUl8wLOQ8@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 18:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTuPI-0006aU-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 18:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbbHXQPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 12:15:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52034 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbbHXQPc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 12:15:32 -0400
Received: from x4db0f032.dyn.telefonica.de ([77.176.240.50] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZTuPA-0000K0-Im; Mon, 24 Aug 2015 18:15:30 +0200
X-Mailer: git-send-email 2.5.0.418.gdd37a9b
In-Reply-To: <20150824181417.Horde.2DAlveA2ZaXbdApUl8wLOQ8@webmail.informatik.kit.edu>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1440432930.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276458>

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
options.  While at it, use argv_array_pushv() instead of the loop to
pass commit-ishes to 'git name-rev'.

'git describe's short help already indicates that the commit-ish is
optional, but the synopsis in the man page doesn't, so update it
accordingly as well.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-describe.txt | 4 ++--
 builtin/describe.c             | 8 ++++----
 t/t6120-describe.sh            | 8 ++++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

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
index ce36032b1f..9dadfb58c8 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -443,10 +443,10 @@ int cmd_describe(int argc, const char **argv, con=
st char *prefix)
 			if (pattern)
 				argv_array_pushf(&args, "--refs=3Drefs/tags/%s", pattern);
 		}
-		while (*argv) {
-			argv_array_push(&args, *argv);
-			argv++;
-		}
+		if (argc)
+			argv_array_pushv(&args, argv);
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
2.5.0.418.gdd37a9b
