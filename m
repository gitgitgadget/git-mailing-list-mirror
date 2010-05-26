From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] fsck: fix bogus commit header check
Date: Wed, 26 May 2010 16:50:34 -0500
Message-ID: <20100526215034.GA6872@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 23:50:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHOUr-0006x6-Tr
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 23:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab0EZVug convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 17:50:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58184 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab0EZVuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 17:50:35 -0400
Received: by gyg13 with SMTP id 13so3366467gyg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=qcuqGqYWXwHG8tBEQeFA8cz/8NreUARJbQDgsP4po50=;
        b=Vr+nx53CCzuokvm90LITiNHBLBBf5yPIYa/ADlNjVNyCFPS2kdm11iYBuel7i8jlcl
         kunP2ovjwimoJUPqFwGJs+CU+oILD3HCmMbBpMA7oYsc9Yd6DuLxnePywV64X/1wxryr
         crRUD8JdMzCxTph5fMMWe9K4QJ+4cS0vCCWiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=vOAflBsuBiyEWg/5V7wfc+qUHvT08XiQFM8EZchRAApZQAvnQZIb9fgCoJ2ZpiADdZ
         0kcnb0ehTrpC7iOZPCG77nf6VD1m41ymPD2/g8BQEcMHvNTs/DR4YkqTzdXlFd27dzfD
         3QuN75qBs8aae5k7L+txw8dnlgy+tcJYSHwAM=
Received: by 10.101.134.6 with SMTP id l6mr11992874ann.50.1274910633727;
        Wed, 26 May 2010 14:50:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm219656gxk.7.2010.05.26.14.50.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 14:50:32 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147826>

daae1922 (fsck: check ident lines in commit objects, 2010-04-24)
taught fsck to expect commit objects to have the form

  tree <object name>
  <parents>
  author <valid ident string>
  committer <valid ident string>

  log message

The check is overly strict: for example, it errors out with the
message =E2=80=9Cexpected blank line=E2=80=9D for perfectly valid commi=
ts with an
"encoding ISO-8859-1" line.

Later it might make sense to teach fsck about the rest of the header
and warn about unrecognized header lines, but for simplicity, let=E2=80=
=99s
accept arbitrary trailing lines for now.

Reported-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Patch is against jn/fsck-ident (daae1922).

As you might expect, this triggers for some real-world repos.
Many thanks to Tuncer for the catch.

 fsck.c          |    2 --
 t/t1450-fsck.sh |    8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index ae9ae1a..3d05d4a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -311,8 +311,6 @@ static int fsck_commit(struct commit *commit, fsck_=
error error_func)
 	err =3D fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	if (*buffer !=3D '\n')
-		return error_func(&commit->object, FSCK_ERROR, "invalid format - exp=
ected blank line");
 	if (!commit->tree)
 		return error_func(&commit->object, FSCK_ERROR, "could not load commi=
t's tree %s", sha1_to_hex(tree_sha1));
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 22a80c8..759cf12 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -5,7 +5,9 @@ test_description=3D'git fsck random collection of tests=
'
 . ./test-lib.sh
=20
 test_expect_success setup '
+	git config i18n.commitencoding ISO-8859-1 &&
 	test_commit A fileA one &&
+	git config --unset i18n.commitencoding &&
 	git checkout HEAD^0 &&
 	test_commit B fileB two &&
 	git tag -d A B &&
@@ -28,6 +30,12 @@ test_expect_success 'loose objects borrowed from alt=
ernate are not missing' '
 	)
 '
=20
+test_expect_success 'valid objects appear valid' '
+	{ git fsck 2>out; true; } &&
+	! grep error out &&
+	! grep fatal out
+'
+
 # Corruption tests follow.  Make sure to remove all traces of the
 # specific corruption you test afterwards, lest a later test trip over
 # it.
--=20
1.7.1.232.g3072.dirty
