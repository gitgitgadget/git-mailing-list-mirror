From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] archive: fix segfault from too long --format parameter
Date: Sun, 7 Feb 2010 01:10:46 -0600
Message-ID: <20100207070811.GA26338@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 08:18:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne1P6-0007t0-F0
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 08:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab0BGHKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 02:10:49 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:53966 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab0BGHKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 02:10:48 -0500
Received: by iwn39 with SMTP id 39so5691465iwn.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 23:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=axpD/hJaKE+m021lruc3SON1og2kH4pxVp+PKS1PPFI=;
        b=lJnmPdI4JwKg2XO2RexGR8ABPkLCq2ZMPqdXdP7wwdLRNsVDhr1nMXOk+Wl3kEyPVZ
         ZQH6ZDWedl7Dn094sRHNKWgLYXLDyxtO4zKHWBhjd1LMDJ/VM3ULmV5zy+7BIVA3+HQT
         k8/1DBtMuRHZ1O5/rmNjopDbESbyjz5bVla8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=GQVrVKQpP58UvdrSxRycItlEruwTqbuAYzqmEy9WEldcy+poOkgWP9dq/B8claJhQ4
         HBSqPtr2lOFgFfc1Uma2Hu3jPOWfh/E3HvAnrfA3uYSrvU/gJoZ0ImMi2ZMk/ntyAwD3
         HCb9PdXsPcivlH9FV3NAvek+FyRgGxRLCv/1U=
Received: by 10.231.161.138 with SMTP id r10mr2428766ibx.34.1265526647165;
        Sat, 06 Feb 2010 23:10:47 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3019128iwn.2.2010.02.06.23.10.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 23:10:46 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139223>

=E2=80=98git archive --format=3D<string of 25 characters or more>=E2=80=
=99 overflows a
local buffer, producing a segfault here.

The context: in commit 0f4b377 (git-archive: infer output format from
filename when unspecified, 2009-09-14), the cmd_archive wrapper
learned to produce a format argument for the local or remote archive
machinery in a local buffer, but that code was missing a bounds check.

So add the missing check.  As a belt-and-suspenders measure, also use
snprintf to make sure the copy afterwards does not overflow.

Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: Dmitry Potapov <dpotapov@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I noticed this while reading over the archive code.  Thoughts?

 builtin-archive.c   |    4 +++-
 t/t5000-tar-tree.sh |    6 ++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 3fb4136..94db00d 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -107,7 +107,9 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
 	}
=20
 	if (format) {
-		sprintf(fmt_opt, "--format=3D%s", format);
+		if (strlen(format) > sizeof(fmt_opt) - sizeof("--format=3D"))
+			die("git archive: format is too long: %.50s", format);
+		snprintf(fmt_opt, sizeof(fmt_opt), "--format=3D%s", format);
 		/*
 		 * We have enough room in argv[] to muck it in place,
 		 * because either --format and/or --output must have
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 0037f63..cf114b2 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -174,6 +174,12 @@ test_expect_success \
 '
=20
 test_expect_success \
+    'git archive --format=3D<long nonsense string>' \
+    'format=3Dabacadabra &&
+    format=3D"${format}${format}${format}zip" &&
+    test_must_fail git archive "--format=3D$format" HEAD'
+
+test_expect_success \
     'git archive --format=3Dzip' \
     'git archive --format=3Dzip HEAD >d.zip'
=20
--=20
1.7.0.rc1
