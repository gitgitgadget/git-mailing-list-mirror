From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 03/11] git p4: work around p4 bug that causes empty symlinks
Date: Tue, 21 Jan 2014 18:16:40 -0500
Message-ID: <1390346208-9207-4-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:17:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kZv-0001e3-KZ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbaAUXRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 18:17:52 -0500
Received: from honk.padd.com ([74.3.171.149]:46538 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbaAUXRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:17:51 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 216987112;
	Tue, 21 Jan 2014 15:17:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 890A9200F7; Tue, 21 Jan 2014 18:17:48 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240793>

Damien G=C3=A9rard highlights an interesting problem.  Some p4
repositories end up with symlinks that have an empty target.  It
is not possible to create this with current p4, but they do
indeed exist.

The effect in git p4 is that "p4 print" on the symlink returns an
empty string, confusing the curret symlink-handling code.

Such broken repositories cause problems in p4 as well, even with
no git involved.  In p4, syncing to a change that includes a
bogus symlink causes errors:

    //depot/empty-symlink - updating /home/me/p4/empty-symlink
    rename: /home/me/p4/empty-symlink: No such file or directory

and leaves no symlink.

In git, replicate the p4 behavior by ignoring these bad symlinks.
If, in a later p4 revision, the symlink happens to point to
something non-null, the symlink will be replaced properly.

Add a big test for all this too.

This happens to be a regression introduced by 1292df1 (git-p4:
=46ix occasional truncation of symlink contents., 2013-08-08) and
appeared first in 1.8.5.  But it only shows up only in p4
repositories of dubious character, so can wait for a proper
release.

Tested-by: Damien G=C3=A9rard <damien@iwi.me>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                  |  9 ++++++-
 t/t9802-git-p4-filetype.sh | 66 ++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 5ea8bb8..e798ecf 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2075,7 +2075,14 @@ class P4Sync(Command, P4UserMap):
             # p4 print on a symlink sometimes contains "target\n";
             # if it does, remove the newline
             data =3D ''.join(contents)
-            if data[-1] =3D=3D '\n':
+            if not data:
+                # Some version of p4 allowed creating a symlink that p=
ointed
+                # to nothing.  This causes p4 errors when checking out=
 such
+                # a change, and errors here too.  Work around it by ig=
noring
+                # the bad symlink; hopefully a future change fixes it.
+                print "\nIgnoring empty symlink in %s" % file['depotFi=
le']
+                return
+            elif data[-1] =3D=3D '\n':
                 contents =3D [data[:-1]]
             else:
                 contents =3D [data]
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 94d7be9..66d3fc9 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -267,6 +267,72 @@ test_expect_success SYMLINKS 'ensure p4 symlink pa=
rsed correctly' '
 	)
 '
=20
+test_expect_success SYMLINKS 'empty symlink target' '
+	(
+		# first create the file as a file
+		cd "$cli" &&
+		>empty-symlink &&
+		p4 add empty-symlink &&
+		p4 submit -d "add empty-symlink as a file"
+	) &&
+	(
+		# now change it to be a symlink to "target1"
+		cd "$cli" &&
+		p4 edit empty-symlink &&
+		p4 reopen -t symlink empty-symlink &&
+		rm empty-symlink &&
+		ln -s target1 empty-symlink &&
+		p4 add empty-symlink &&
+		p4 submit -d "make empty-symlink point to target1"
+	) &&
+	(
+		# Hack the p4 depot to make the symlink point to nothing;
+		# this should not happen in reality, but shows up
+		# in p4 repos in the wild.
+		#
+		# The sed expression changes this:
+		#     @@
+		#     text
+		#     @target1
+		#     @
+		# to this:
+		#     @@
+		#     text
+		#     @@
+		#
+		cd "$db/depot" &&
+		sed "/@target1/{; s/target1/@/; n; d; }" \
+		    empty-symlink,v >empty-symlink,v.tmp &&
+		mv empty-symlink,v.tmp empty-symlink,v
+	) &&
+	(
+		# Make sure symlink really is empty.  Asking
+		# p4 to sync here will make it generate errors.
+		cd "$cli" &&
+		p4 print -q //depot/empty-symlink#2 >out &&
+		test ! -s out
+	) &&
+	test_when_finished cleanup_git &&
+
+	# make sure git p4 handles it without error
+	git p4 clone --dest=3D"$git" //depot@all &&
+
+	# fix the symlink, make it point to "target2"
+	(
+		cd "$cli" &&
+		p4 open empty-symlink &&
+		rm empty-symlink &&
+		ln -s target2 empty-symlink &&
+		p4 submit -d "make empty-symlink point to target2"
+	) &&
+	cleanup_git &&
+	git p4 clone --dest=3D"$git" //depot@all &&
+	(
+		cd "$git" &&
+		test $(readlink empty-symlink) =3D target2
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
--=20
1.8.5.2.320.g99957e5
