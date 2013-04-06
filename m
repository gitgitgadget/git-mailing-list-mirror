From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/7] remote-bzr: add utf-8 support for pushing
Date: Fri,  5 Apr 2013 21:49:23 -0600
Message-ID: <1365220163-13581-8-git-send-email-felipe.contreras@gmail.com>
References: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 20:08:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSH-0001b9-Nb
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163241Ab3DFDx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 23:53:58 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:41898 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759Ab3DFDx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 23:53:57 -0400
Received: by mail-ob0-f180.google.com with SMTP id un3so88443obb.25
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 20:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=s4i9ui/oN2KwGV9/bAArzGvPrL1bGRiqnNPzUwk9UTs=;
        b=mo0Y8pEmVZhzg+qTh4RzpctgojyFDiXMhrkDkdV9sfuJ2I0TxRTWgKkrs1P+FIinWt
         nsRnfkMFE+GvPHUe+m/ouw6LXzp4UVN9vW/jGsYmNmSS2Xx0ybWU/W5RbEWUAhchDtop
         ETbyoumSNG7anDQmQPkH/Ka6SdWmOXOk/rie72M7S5UmmQ6mGGtXwWtWGClmI6QnDtbC
         fa0hf8pm1hnYZJgm1DsS+58xqF2vVBQTXtWQqe2R0AMF28Ax53pqS3u6ZLPj4KqiRo63
         WyFJZc8nhCSDv1NGCDofqhKstGS7Puetc7Ducjt54CLAmCPvozzxsMNJ49A2nsYbFPmD
         BMdg==
X-Received: by 10.60.92.201 with SMTP id co9mr9452907oeb.113.1365220437131;
        Fri, 05 Apr 2013 20:53:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id d10sm15200248oeh.7.2013.04.05.20.53.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 20:53:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220257>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr |  6 ++++++
 contrib/remote-helpers/test-bzr.sh    | 31 +++++++++++++++++++++++++++=
++++
 2 files changed, 37 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-hel=
pers/git-remote-bzr
index 0bd0759..fad4a48 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -512,6 +512,11 @@ class CustomTree():
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
@@ -551,6 +556,7 @@ def parse_commit(parser):
             f =3D { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
+        path =3D c_style_unescape(path).decode('utf-8')
         files[path] =3D f
=20
     repo =3D parser.repo
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index e468079..f4c7768 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -190,4 +190,35 @@ test_expect_success 'fetch utf-8 filenames' '
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
