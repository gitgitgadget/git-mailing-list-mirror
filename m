From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] t0001: check syntax of sample hooks
Date: Sat, 10 Jul 2010 19:45:19 -0500
Message-ID: <20100711004518.GA5658@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 02:46:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXkgZ-0004t2-8d
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 02:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab0GKAqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 20:46:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45685 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab0GKAqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 20:46:05 -0400
Received: by iwn7 with SMTP id 7so3482000iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=t3qV96cUFQNEY5Vtr4ekw9ErjITLJm9f66YnxrxK6W4=;
        b=pxrSK7NsfJF+MFr6WHqj44s08M8AWu/8S/e2FbyaJb3ews5TbSG97/Hd4bPxV7CdNp
         pgE9EYNJK7/8pmrHQ4ddAIWoSwCQkpw1Vuk2hJV3UQa1Tz8jCzNzmZ9lhW2sdnpU9GnI
         kpzYD7wX+ZEGcJx4ufw1P7owniiSLvsgmlkTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=L56yjpqkNOMZltF6j6snfQBuU7s3TKbu+RhMBJeQemtPfVb24RWWv4nPO5tb68lXlU
         5mbRmdQCds+pIBI/8iEK+qYHqAoYgn9k43dk9cwbyrlMOREbac3vz8dQalKvMAB1sq2b
         FGJeeWzQc4AIiZWL30JVrjHuqnloCrlfqFrac=
Received: by 10.231.178.103 with SMTP id bl39mr11211965ibb.138.1278809163401;
        Sat, 10 Jul 2010 17:46:03 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm11748712ibk.7.2010.07.10.17.46.02
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 17:46:02 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150737>

Make sure that the sample hooks do not use any shell features
that the shell used to execute them does not support.

The documentation at the end of the sample pre-rebase script will
never be executed, but "sh -n" does not know that.  Convert it to
a HERE document to avoid spurious failures.

If the shell specified in a hook=E2=80=99s #! line has a space in it, t=
he
new test will break it into words, not even taking quoting into
account.  So

 #!"c:/Program Files/bin/bash.exe"

specifies a shell named =E2=80=98"c:/Program=E2=80=99 with argument =E2=
=80=98Files/bin/bash.exe"=E2=80=99.
On Unix, that is exactly what exec() would do; on Windows, it is close
to what the exec() compatibility layer does (actually, the
=E2=80=98Files/bin/bash.exe"=E2=80=99 argument is thrown away by parse_=
interpreter()).
To honor quoting during tests would be to set unreasonable
expectations for runtime.

The user may want to avoid specifying a path to the shell at all, by
building with

 make 'SHELL_PATH=3D/usr/bin/env bash'

The rules used in tests and at runtime on Unix allow this.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before[1], the real motivation is the change to appease sh -n for
pre-rebase, since I occasionally run a test like this locally.
Patch is against master.

Thoughts?

[1] http://thread.gmane.org/gmane.comp.version-control.git/145281

 t/t0001-init.sh                    |   18 ++++++++++++++++++
 templates/hooks--pre-rebase.sample |    3 +++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7c0a698..8421b86 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -141,6 +141,24 @@ test_expect_success 'reinit' '
 	test_cmp again/empty again/err2
 '
=20
+test_expect_success 'sample hooks use acceptable syntax' '
+	rm -fr hook-syntax &&
+	git init hook-syntax &&
+	(
+		cd hook-syntax &&
+		test -d .git/hooks &&
+		fail=3Df &&
+		for i in .git/hooks/*.sample
+		do
+			read shebang <"$i" &&
+			shell=3D${shebang#"#!"} &&
+			$shell -n $i ||
+			fail=3Dt
+		done &&
+		test "$fail" =3D f
+	)
+'
+
 test_expect_success 'init with --template' '
 	mkdir template-source &&
 	echo content >template-source/file &&
diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-=
rebase.sample
index 053f111..6182192 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -91,6 +91,7 @@ fi
 exit 0
=20
 ################################################################
+: <<\EOF
=20
 This sample hook safeguards topic branches that have been
 published from being rewound.
@@ -167,3 +168,5 @@ To compute (2):
 	git rev-list master..topic
=20
 	if this is empty, it is fully merged to "master".
+
+EOF
--=20
1.7.2.rc2.532.g65d9b.dirty
