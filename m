From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: empty symlink detection breakage
Date: Sun, 22 Feb 2009 02:56:11 +0100
Message-ID: <20090222015611.GA14378@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 22 02:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lb3bI-0006zv-OB
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 02:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbZBVB4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2009 20:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbZBVB4R
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 20:56:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:37296 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016AbZBVB4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 20:56:16 -0500
Received: (qmail invoked by alias); 22 Feb 2009 01:56:13 -0000
Received: from i577BAFDE.versanet.de (EHLO atjola.local) [87.123.175.222]
  by mail.gmx.net (mp025) with SMTP; 22 Feb 2009 02:56:13 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+0wzpngOm0gyugfBVbH0U9a4vz9byZSy16aJYbtH
	DiPpQkAK0g5kJH
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110990>

Hi Eric,=20

seems that the empty symlink stuff gets confused about which revision t=
o
use when looking for the parent's file.

r3 =3D f1a6fcf6b0a1c4a373d0b2b65a3d70700084f361 (tags/1.0.1)
=46ound possible branch point: file:///home/doener/h/svn/tags/1.0 =3D> =
file:///home/doener/h/svn/branches/1.0, 4
=46ound branch parent: (1.0) 63ae640ba01014ecbb3df590999ed1fa5914545b
=46ollowing parent with do_switch
Successfully followed parent
r5 =3D 26fcfef5bcced97ab74faf1af7341a2ae0d272aa (1.0)
=46ound possible branch point: file:///home/doener/h/svn/branches/1.0 =3D=
> file:///home/doener/h/svn/tags/1.0.1, 5
=46ound branch parent: (tags/1.0.1) 26fcfef5bcced97ab74faf1af7341a2ae0d=
272aa
=46ollowing parent with do_switch
Scanning for empty symlinks, this may take a while if you have many emp=
ty files
You may disable this with `git config svn.brokenSymlinkWorkaround false=
'.
This may be done in a different terminal without restarting git svn
=46ilesystem has no item: File not found: revision 3, path '/branches/1=
=2E0/file' at /usr/local/libexec/git-core/git-svn line 3318


Note how it tries to look at revision 3 instead of revision 5 (which it
correctly detected as the parent). The import succeeds when
svn.brokenSymlinkWorkaround is set to false. Testcase below.

Bj=F6rn
--
diff --git a/t/t9136-git-svn-recreated-branch-empty-file.sh b/t/t9136-g=
it-svn-recreated-branch-empty-file.sh
new file mode 100755
index 0000000..733d16e
--- /dev/null
+++ b/t/t9136-git-svn-recreated-branch-empty-file.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description=3D'test recreated svn branch with empty files'
+
+. ./lib-git-svn.sh
+test_expect_success 'load svn dumpfile'  '
+	svnadmin load "$rawsvnrepo" < "${TEST_DIRECTORY}/t9136/svn.dump"
+	'
+
+test_expect_success 'clone using git svn' 'git svn clone -s "$svnrepo"=
 x'
+
+test_done
diff --git a/t/t9136/svn.dump b/t/t9136/svn.dump
new file mode 100644
index 0000000..6b1ce0b
--- /dev/null
+++ b/t/t9136/svn.dump
@@ -0,0 +1,192 @@
+SVN-fs-dump-format-version: 2
+
+UUID: eecae021-8f16-48da-969d-79beb8ae6ea5
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2009-02-22T00:50:56.292890Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 106
+Content-length: 106
+
+K 7
+svn:log
+V 4
+init
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-22T00:50:57.192384Z
+PROPS-END
+
+Node-path: branches
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: tags
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: trunk
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: trunk/file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 0
+Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 2
+Prop-content-length: 105
+Content-length: 105
+
+K 7
+svn:log
+V 3
+1.0
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-22T00:50:58.124724Z
+PROPS-END
+
+Node-path: tags/1.0
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Revision-number: 3
+Prop-content-length: 111
+Content-length: 111
+
+K 7
+svn:log
+V 9
+1.0.1-bad
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-22T00:50:58.151727Z
+PROPS-END
+
+Node-path: tags/1.0.1
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 2
+Node-copyfrom-path: tags/1.0
+
+
+Revision-number: 4
+Prop-content-length: 111
+Content-length: 111
+
+K 7
+svn:log
+V 9
+Wrong tag
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-22T00:50:58.167427Z
+PROPS-END
+
+Node-path: tags/1.0.1
+Node-action: delete
+
+
+Revision-number: 5
+Prop-content-length: 113
+Content-length: 113
+
+K 7
+svn:log
+V 10
+1.0-branch
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-22T00:50:58.184498Z
+PROPS-END
+
+Node-path: branches/1.0
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 4
+Node-copyfrom-path: tags/1.0
+
+
+Revision-number: 6
+Prop-content-length: 113
+Content-length: 113
+
+K 7
+svn:log
+V 10
+1.0.1-good
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-22T00:50:58.200695Z
+PROPS-END
+
+Node-path: tags/1.0.1
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 5
+Node-copyfrom-path: branches/1.0
+
+
