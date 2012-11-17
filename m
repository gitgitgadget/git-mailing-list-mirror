From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 0/7] completion: fix expansion issues with compgen
Date: Sat, 17 Nov 2012 12:05:46 +0100
Message-ID: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 12:06:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgEH-0006sj-Qt
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab2KQLGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:06:15 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:56289 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2KQLGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:06:14 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M6c40-1TLSil1OEO-00wXal; Sat, 17 Nov 2012 12:06:03 +0100
X-Mailer: git-send-email 1.8.0.220.g4d14ece
X-Provags-ID: V02:K0:kzDano+/o8ZhCM5EM8aKHeWPx5fyI/KDkYI4aYMNDlS
 J65c7Rwm9gUlaQVZ4ERIFivqBHLKqCnDRY7DAap5oMgUVt5M9R
 xpkwmqWZGlqDAYm/zWbWDWTUGMXHwj6XsrsnXcexTLFVBN7cmz
 xyIwESLyvRiDxDCAD7TOHnyWJN9xQ8lnRvcNVK2LjjJcxUKu6b
 Hw/o/bb1SMN6vxtcXDmjykYs64+uETrrgAMavQAdef8p3m8V1K
 bIfq8XUcFOPXEy1gBzWPBPgaCUX4OsNYEFxr+pz3X+1/G18yc9
 CdxpJMa0dehHxxW9tXLydSEejPgDdIwN4BR3883F8Tuf9wp4Ua
 H5gJc3HqBO9i2RWVOmH6GY6Nr2nh5ujvzZu6bAO1z36X7OCIh9
 pKTDUPDQuxjfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209940>

This series fixes the expansion issues with compgen reported by Jeroen
Meijer a while ago in

  http://article.gmane.org/gmane.comp.version-control.git/201596

The problem is that the compgen Bash-builtin performs expansion on all
words in the wordlist given to its -W option, breaking Git's completion
script when e.g. refs or filenames contain expandable substrings.  Sinc=
e
compgen has no option to turn off this expansion and we only use a smal=
l
subset of compgen's functionality, this series replaces compgen in
__gitcomp() and __gitcomp_nl() by some shell logic and a small awk scri=
pt,
respectively.

Patches 1 and 2 are test enhancements and fixes, while 3 and 4 add new
tests to make sure I don't break anything and to demonstrate the issues=
,
respectively.  The actual bugfixes are in patches 5 and 6.  Finally, pa=
tch
7 is a cleanup made possible by patch 6 (could be squashed into 6).

In the future we might want/need to fill COMPREPLY directly when
completing a path in the <tree>:<path> notation instead using
__gitcomp_nl() there, because paths can contain newlines, too.

Compared to Felipe's series from yesterday, this series has more tests,
more descriptive commit messages, and it's faster.  However, it doesn't
include his 1/5 (completion: get rid of empty COMPREPLY assignments).


=46ootnote: check the patchlist below, and notice how format-patch put
patches 4 and 5 into the same line.

SZEDER G=C3=A1bor (7):
  completion: make the 'basic' test more tester-friendly
  completion: fix args of run_completion() test helper
  completion: add tests for the __gitcomp_nl() completion helper
    function
  completion: add tests for invalid variable name among completion word=
s  completion: fix expansion issues in __gitcomp_nl()
  completion: fix expansion issue in __gitcomp()
  completion: remove the now unused __gitcomp_1() internal helper
    function

 contrib/completion/git-completion.bash |  57 ++++++++-------
 t/t9902-completion.sh                  | 123 +++++++++++++++++++++++++=
+++++---
 2 files changed, 147 insertions(+), 33 deletions(-)

--=20
1.8.0.220.g4d14ece
