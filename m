From: Antoine Pelisse <apelisse@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20remote-hg=3A=20Fix=20cloning=20and=20sharing=20bug?=
Date: Sun,  4 Aug 2013 12:38:03 +0200
Message-ID: <1375612683-9104-1-git-send-email-apelisse@gmail.com>
References: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?J=C3=B6rn=20Hees?= <dev@joernhees.de>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 04 12:39:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5viN-0000kM-P2
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 12:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053Ab3HDKir convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Aug 2013 06:38:47 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:50089 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab3HDKiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 06:38:46 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so1667595wgg.22
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8fdCs7fR482HGg6M/C8FOCLqO7Mf8/42lfSDioqVgTc=;
        b=kGpbBZB6P0bs1+ido1LfhxXxVbeGyyVeLluzvmKEBW9fWBr5SOPg2HFpeKV8r5xKJI
         oyDoXEqLPjiW72TKvhV6j+SPkClOUmBhu+nI7D2fxii+nVpHztxPZC8PglOJjLvy45sk
         1fxtV/P8oLxA1gSsFZh3WrWL9XNFlXNijW0S+yt1L8IKPVaLw3J7/u7KS5gvx6KgbpFl
         wZoOogp0cz0M7ax0fulLi1Dw7pF6dn4AnjCFjtUVOiUCR5kSkTMEs2xkEdz2xXj5IGmi
         kM5GJ8isO+aPId/g6HVgEArZ1qpcO0D/BmXfSmuO+0c0kw5JvoHtjcsrcSfXn5wzPmCa
         Cg9A==
X-Received: by 10.180.90.202 with SMTP id by10mr3361305wib.39.1375612725259;
        Sun, 04 Aug 2013 03:38:45 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id j20sm14414410wie.7.2013.08.04.03.38.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 04 Aug 2013 03:38:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231622>

6796d49 (remote-hg: use a shared repository store) introduced sharing
repository capability, but it broke backward-compatibility with already
existing repositories.

Indeed, 6796d49 assumes that .git/hg/.hg (the shared repository) will
exist if .git/hg exists.
This can be false for already existing clones. It can also be false for
local repository that are not cloned.

=46ixes the compatibility break by always cloning into .git/hg/.shared
(even for local repositories). In order to avoid expensive clone
retrieval from slow remotes, also look for already existing clones in
=2Egit/hg/$aliases/clone.

Reported-by: Joern Hees <dev@joernhees.de>
Suggested-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
Hey,

OK, I think this version will work in all cases.
Either you clone local and then remote, or remote and then local,
or old version local and then remote, or old version remote and then lo=
cal:
You will always either have .shared repo already cloned, or will find a=
 way to
create it: either by using an already existing clone, or by cloning the=
 given
url (and that last step can't be done if we don't use .shared).

I also decided to always clone local repositories because what J=C3=B6r=
n Hees
said makes sense:
If you have a local clone of a big repository, and then want to add a s=
low
remote, you would have to reclone everything.
I think the trade-off is good, because clone from local should not be t=
hat
time expensive (maybe it can be on disk-space though).

As I changed indentation, the patch may deserve a second look with -w.

Cheers,
Antoine

 contrib/remote-helpers/git-remote-hg |   47 ++++++++++++++++++++------=
--------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-help=
ers/git-remote-hg
index 0194c67..487c13d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -385,33 +385,42 @@ def get_repo(url, alias):

     extensions.loadall(myui)

-    if hg.islocal(url) and not os.environ.get('GIT_REMOTE_HG_TEST_REMO=
TE'):
-        repo =3D hg.repository(myui, url)
-        if not os.path.exists(dirname):
-            os.makedirs(dirname)
-    else:
-        shared_path =3D os.path.join(gitdir, 'hg')
-        if not os.path.exists(shared_path):
+    hgdir =3D os.path.join(gitdir, 'hg')
+    try:
+        os.mkdir(hgdir)
+    except OSError:
+        pass
+
+    shared_path =3D os.path.join(hgdir, '.shared')
+    if not os.path.exists(shared_path):
+        for remote in os.listdir(hgdir):
+            try:
+                hg.clone(myui, {}, os.path.join(hgdir, remote, 'clone'=
),
+                         shared_path, update=3DFalse, pull=3DTrue)
+                break
+            except error.RepoError:
+                pass
+        else:
             try:
                 hg.clone(myui, {}, url, shared_path, update=3DFalse, p=
ull=3DTrue)
             except:
                 die('Repository error')

-        if not os.path.exists(dirname):
-            os.makedirs(dirname)
+    if not os.path.exists(dirname):
+        os.makedirs(dirname)

-        local_path =3D os.path.join(dirname, 'clone')
-        if not os.path.exists(local_path):
-            hg.share(myui, shared_path, local_path, update=3DFalse)
+    local_path =3D os.path.join(dirname, 'clone')
+    if not os.path.exists(local_path):
+        hg.share(myui, shared_path, local_path, update=3DFalse)

-        repo =3D hg.repository(myui, local_path)
-        try:
-            peer =3D hg.peer(myui, {}, url)
-        except:
-            die('Repository error')
-        repo.pull(peer, heads=3DNone, force=3DTrue)
+    repo =3D hg.repository(myui, local_path)
+    try:
+        peer =3D hg.peer(myui, {}, url)
+    except:
+        die('Repository error')
+    repo.pull(peer, heads=3DNone, force=3DTrue)

-        updatebookmarks(repo, peer)
+    updatebookmarks(repo, peer)

     return repo

--
1.7.9.5
