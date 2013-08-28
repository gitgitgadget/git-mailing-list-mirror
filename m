From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 14:23:06 -0500
Message-ID: <1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElPR-0003PU-O1
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab3H1T2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 15:28:00 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:54145 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3H1T16 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:27:58 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so8225490oag.21
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pDLDn7y1L242RRTqeUb5TxvnEIQVbQLlMJo1pr1Sd2I=;
        b=QTjpzVHDLsRqH2dRqb4HQfAy3m6gJ6e7KxuqiH+vvtymSO/G2oT/TwOxQGKySdq25i
         WSWX9aVzvFkYXw/+C/2mmELsdsBoa6e4djUVthJnoj2LfAZm4NDN0/7hpYlgamsBPZYX
         /whF0H3DkCCbxnTEhWEAEQSWxe49stl5NWaqOIlo0cgz4Cjfqjy58Ni3H9bodXuZUf3B
         4W7SzqjGteIgoX+ihlbDrUL8br/GkqKV0QS5A3d9YmGGUsAGdcgokwqxRjLnavqUtdrc
         lwv9fzWdJG7m3OWOtLUBmjFvOx8rhYe/A0D6M7bD0JzD9CmdQEPZI/Yek1Zh+FhhJtcc
         4yNQ==
X-Received: by 10.60.42.168 with SMTP id p8mr1716109oel.73.1377718077854;
        Wed, 28 Aug 2013 12:27:57 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm28333669oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:27:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233194>

Reported-by: Joakim Verona <joakim@verona.se>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr |  1 +
 contrib/remote-helpers/test-bzr.sh    | 30 +++++++++++++++++++++++++++=
+++
 2 files changed, 31 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-hel=
pers/git-remote-bzr
index c3a3cac..08b0b61 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -168,6 +168,7 @@ class Parser:
         if not m:
             return None
         _, name, email, date, tz =3D m.groups()
+        name =3D name.decode('utf-8')
         committer =3D '%s <%s>' % (name, email)
         tz =3D int(tz)
         tz =3D ((tz / 100) * 3600) + ((tz % 100) * 60)
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index dce281f..ef8992a 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -358,4 +358,34 @@ test_expect_success 'strip' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'export utf-8 authors' '
+	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=3DC && unset GIT=
_COMMITTER_NAME" &&
+
+	LC_ALL=3Den_US.UTF-8
+	export LC_ALL
+
+	GIT_COMMITTER_NAME=3D"Gr=C3=A9goire"
+	export GIT_COMMITTER_NAME
+
+	bzr init bzrrepo &&
+
+	(
+	git init gitrepo &&
+	cd gitrepo &&
+	echo greg >> content &&
+	git add content &&
+	git commit -m one
+	git remote add bzr "bzr::../bzrrepo" &&
+	git push bzr
+	) &&
+
+	(
+	cd bzrrepo &&
+	bzr log | grep "^committer: " > ../actual
+	) &&
+
+	echo "committer: Gr=C3=A9goire <committer@example.com>" > expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.4-fc
