From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] git-am: Don't accept an mbox on stdin of we already have
 a .dotest directory
Date: Wed, 19 Jul 2006 22:28:00 +0200
Organization: Chalmers
Message-ID: <44BE95D0.9090708@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 19 22:28:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3IeN-0003sQ-4V
	for gcvg-git@gmane.org; Wed, 19 Jul 2006 22:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWGSU2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 19 Jul 2006 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWGSU2E
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 16:28:04 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:20970 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S1030278AbWGSU2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jul 2006 16:28:01 -0400
X-Medic-Info: 137.44be95d0.0 aatFtTl63qUA70IY dynamic-client
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	by anubis.medic.chalmers.se (Postfix) with ESMTP id BB97D192F2;
	Wed, 19 Jul 2006 22:28:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24007>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---

It makes no sense to accept an mbox via stdin when we
won't accept it on the commandline.

The patch helps the following scenario:

# git init-db
"add file1 with content"
# git checkout -b apply
"edit file1 && commit"

# git checkout -b conflict master
"edit file1 && commit"

# git checkout -b ok master
"add file2"

# git checkout apply
# git format-patch -k -3 master..conflict | git am -k -3
=3D> git-am fails with a conflict message
# git reset --hard

# git format-patch -k -3 master..ok | git am -k -3
=3D> git am fails with the same conflict message as above,
=3D> since it's trying to apply the old .dotest directory

With the patch it complains about an old .dotest
directory instead.

 git-am.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3a129e0..04f0119 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -156,8 +156,10 @@ fi
=20
 if test -d "$dotest"
 then
-	test ",$#," =3D ",0," ||
-	die "previous dotest directory $dotest still exists but mbox given."
+	if test ",$#," !=3D ",0," || ! tty -s
+	then
+		die "previous dotest directory $dotest still exists but mbox given."
+	fi
 	resume=3Dyes
 else
 	# Make sure we are not given --skip nor --resolved
--=20
1.4.1.g59817
