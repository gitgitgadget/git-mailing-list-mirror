From: tboegi@web.de
Subject: [PATCH v1] correct blame for files commited with CRLF
Date: Tue,  5 Apr 2016 21:23:54 +0200
Message-ID: <1459884234-13026-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 21:20:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anWWv-0003Lq-8U
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 21:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbcDETUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 15:20:44 -0400
Received: from mout.web.de ([212.227.17.11]:60558 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbcDETUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 15:20:43 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Lheqz-1baLt305NB-00mqRN; Tue, 05 Apr 2016 21:20:40
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:cqpbJV3mSJNHavKXxnE4HYaPwbERX5s+kwJZ6J3KBH7/QdMLwM1
 uTG7rgD7c/YxOVpujeXvoeiXhEtGf1b88iDSMS+B0YHlMNyKI8c4sbgShfatUOBcvtAwlRx
 QBypGjWS+3nD9EqSsNleoJ4rfAjMpz53ZMNWHjDzksFXl14NZjKkNisOsni0tLciOjSyjr3
 PoaXVyRgX5YR9SHFQILMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i3SrQuiVAPM=:3UQJAIRIuz+3BuUFAdspyr
 wJ897C/VAVy7nVIS9u3nSOmnPlpShjM4Wjfbt6e6KBH6CPdod6zsUWNRetpFWpGpwcpoWZIRH
 5/idEufTDrukQu55CkA3rrQYIL6gtmwQT7OwVDgeVDyx9J/NIAeLTBxMfgH7792M/d3pmzKO/
 jfynuagpb2nRMASEmJ1sKZ3D0MycL8zeqLEXjBhS+/b62xHcaZK9Zt/ZrPV9YzGUqohilDkHk
 5q4IZZjr1cansfBqyzhA0do4tAdXFd1rw/WBTRk/X3ff76cb6aq+A8DSqo2uN2zIxYbFQFG8K
 itUY2MLnI3KqDPypWfo9zXTpQPUfza6kR/tE3qXdYYttTzn9IrpXdh+/L7oAeFMNojRfTila8
 h+jCjOuBlsbmdEy+Op8QdHJNvBr3HVeMGXoveqw9NldQueonFtsCPLhAM2hrWPbq3lAnjBwFq
 hZ11NoiWvexNf5jHgcMHKvirpW2bZymTLaYLUGUHKmJnnZjgNZBi6OaIIGEm4FjCFAJlzzG19
 D99avCUXmC9fKWT40tk8S8NFTpm2F5acqGflvPBToLGjT6XpFly2vWw/EdgqRiziSpOP8H1AS
 d1qIo3IisbCz0x2ZDNyLoel8589//UGB0QeGKyYjCeGdFnNnqrbVHOWW6FyXjMDp0lCrE/gXx
 QcAvib3aM8TRQ+OUtCHa6e0aa91N30xdA5/d6PZrIvP6udQxJxU9T1bPhHoPGhXwaDVw/j5AR
 qNGOH1cGv/W6j1NltiVNBGjf0VjNbKF0LMAh55csCVYRgct57mb5v4gvIaEXiYm52l/EVTZe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290803>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

git blame reports lines as not "Not Committed Yet" when they have
CRLF in the index, CRLF in the worktree and core.autocrlf is true.

Since commit c48053 "new safer autocrlf handling", files that have CRLF
in the index are not normalized at commit when core.autocrl is set.

Add a call to read_cache() early in fake_working_tree_commit(),
before calling convert_to_git().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 This fix is completely independent of the rest of the series,
 so break out 6/7 from tb/safe-crlf-output.
 The rest of the series will be send in a couple of days, some
 rework is needed.
builtin/blame.c               |  1 +
 t/t8003-blame-corner-cases.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index e982fb8..21f42b0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2307,6 +2307,7 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 	unsigned mode;
 	struct strbuf msg =3D STRBUF_INIT;
=20
+	read_cache();
 	time(&now);
 	commit =3D alloc_commit_node();
 	commit->object.parsed =3D 1;
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases=
=2Esh
index 6568429..a9b266f 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -212,4 +212,18 @@ test_expect_success 'blame file with CRLF attribut=
es text' '
 	grep "A U Thor" actual
 '
=20
+test_expect_success 'blame file with CRLF core.autocrlf=3Dtrue' '
+	git config core.autocrlf false &&
+	printf "testcase\r\n" >crlfinrepo &&
+	>.gitattributes &&
+	git add crlfinrepo &&
+	git commit -m "add crlfinrepo" &&
+	git config core.autocrlf true &&
+	mv crlfinrepo tmp &&
+	git checkout crlfinrepo &&
+	rm tmp &&
+	git blame crlfinrepo >actual &&
+	grep "A U Thor" actual
+'
+
 test_done
--=20
2.8.0.rc2.2.g1a4d45a.dirty
