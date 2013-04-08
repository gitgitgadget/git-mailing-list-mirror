From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/7] remote-bzr: add utf-8 support for pushing
Date: Mon,  8 Apr 2013 12:27:16 -0500
Message-ID: <1365442036-25732-8-git-send-email-felipe.contreras@gmail.com>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFs7-0001ex-QC
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934816Ab3DHR2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 13:28:40 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:44570 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934770Ab3DHR2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:28:39 -0400
Received: by mail-ob0-f178.google.com with SMTP id ni5so1435784obc.23
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=/NPPdezpZttH1n3AMuYq36Wl/qsxyAjMjr60mVRP6yk=;
        b=gfV8DVYuyMhwBKNRnjdOuwIIYMzByG+RhBnSEvF6FZIUsVheb7Bp0iOvJyTkyZGzjt
         CxKGwSlV0EHbffJLSFPKxLO61eIN+KIk5gyybJ3CoziGvCWHVvkwgeIJJT3CpO+nON04
         HSfhvzwL868Hiff2HaEztZw+iBN2T+QC4xqm1LNUALCLepoMr5mXIMx9JnVptEEXMQ2s
         EZw8LSeDZkCa89K2V+C/n0gCOz63vOTZBw/J07YTp+bKeXOIicLVjpXMlenOBw4NGjqe
         6fiy1kHPZPRfeHaNV90mDqmJmaEzf8h376ftW5xhfWqSwW20NnDEed7HrhSQB7lDq4oz
         PZCQ==
X-Received: by 10.182.204.5 with SMTP id ku5mr16230283obc.22.1365442118597;
        Mon, 08 Apr 2013 10:28:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id c4sm24905434obo.9.2013.04.08.10.28.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:28:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220470>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr |  6 ++++++
 contrib/remote-helpers/test-bzr.sh    | 31 +++++++++++++++++++++++++++=
++++
 2 files changed, 37 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-hel=
pers/git-remote-bzr
index 64b35c7..bd25e08 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -513,6 +513,11 @@ class CustomTree():
     def get_symlink_target(self, file_id):
         return self.updates[file_id]['data']
=20
+def c_style_unescape(string):
+    if string[0] =3D=3D string[-1] =3D=3D '"':
+        return string.decode('string-escape')[1:-1]
+    return string
+
 def parse_commit(parser):
     global marks, blob_marks, bmarks, parsed_refs
     global mode
@@ -552,6 +557,7 @@ def parse_commit(parser):
             f =3D { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
+        path =3D c_style_unescape(path).decode('utf-8')
         files[path] =3D f
=20
     repo =3D parser.repo
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index 9a510a8..e800c97 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -197,4 +197,35 @@ test_expect_success 'fetch utf-8 filenames' '
   test_cmp expected actual
 '
=20
+test_expect_success 'push utf-8 filenames' '
+  mkdir -p tmp && cd tmp &&
+  test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
+
+  export LC_ALL=3Den_US.UTF-8
+
+  (
+  bzr init bzrrepo &&
+  cd bzrrepo &&
+
+  echo one >> content &&
+  bzr add content &&
+  bzr commit -m one
+  ) &&
+
+  (
+  git clone "bzr::$PWD/bzrrepo" gitrepo &&
+  cd gitrepo &&
+
+  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  git add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  git commit -m utf-8 &&
+
+  git push
+  ) &&
+
+  (cd bzrrepo && bzr ls > ../actual) &&
+  echo -e "content\n=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" > expected &&
+  test_cmp expected actual
+'
+
 test_done
--=20
1.8.2
