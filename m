From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 4/9] git rm: display a warning for every unremovable file
Date: Sat, 10 Apr 2010 19:23:45 +0100
Message-ID: <1270923830-11830-5-git-send-email-peter@pcc.me.uk>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fMN-0007O3-Dm
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0DJSYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 14:24:14 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37790 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926Ab0DJSX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:56 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLV-0006qR-Gw; Sat, 10 Apr 2010 19:23:53 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-00036H-Em; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144565>

When =E2=80=98git rm=E2=80=99 was built in (d9b814cc, 2006-05-19), its
semantics changed: before, it just removed files until it
encountered an error and then would error out, whereas since
then, it makes an attempt to either remove all files or remove
none at all.  In particular, if =E2=80=98git rm=E2=80=99 fails to remov=
e a
file after other files have already been removed, it does not
abort but instead silently accepts the error.

Better to warn the user in this case!

This problem is particularly noticeable when dealing with submodules
because the rmdir operation will fail for every initialised submodule.
The removal of the contents of an initialised submodule directory
should always be user controlled, due to the possibility of
unpropagated changes to the submodule.  Therefore, the user should
always be informed of any such removal failures.

Based-on-work-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 builtin/rm.c  |    2 ++
 t/t3600-rm.sh |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index f3772c8..05a5158 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -259,6 +259,8 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 			}
 			if (!removed)
 				die_errno("git rm: '%s'", path);
+			else
+				warning("git rm: '%s': %s", path, strerror(errno));
 		}
 	}
=20
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5186844..ecddd67 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -180,6 +180,21 @@ test_expect_success 'Message when first removal fa=
ils' '
 ! test -e plugh || chmod 775 plugh
 rm -fr msg plugh xyzzy
=20
+test_expect_success 'Message when second removal fails' '
+	touch plugh &&
+	mkdir -p xyzzy &&
+	touch xyzzy/plugh &&
+	git add plugh xyzzy/plugh &&
+	git commit --allow-empty -a -m "two files to remove" &&
+	chmod a-w xyzzy &&
+
+	git rm plugh xyzzy/plugh 2>msg &&
+
+	grep "git rm: '\''xyzzy/plugh'\'':" msg
+'
+! test -e xyzzy || chmod 775 xyzzy
+rm -fr expect actual plugh xyzzy
+
 test_expect_success '"rm" command printed' '
 	echo frotz > test-file &&
 	git add test-file &&
--=20
1.6.5
