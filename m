From: Mike Hommey <mh@glandium.org>
Subject: fast-import should not care about core.ignorecase
Date: Tue, 9 Dec 2014 09:12:11 +0900
Message-ID: <20141209001211.GA13386@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 01:12:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy8Pw-0005si-PR
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 01:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbaLIAMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 19:12:37 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:34694 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755752AbaLIAMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 19:12:36 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Xy8PT-0003aT-Dn
	for git@vger.kernel.org; Tue, 09 Dec 2014 09:12:11 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261100>

Hi,

As you now know, I'm working on a mercurial remote helper for git. As
such, it uses fast-import.

In the mercurial history of mozilla-central, there have been various
renames of files with only case changes, and it so happens that my
remote helper blows things up on case insensitive file systems. The
reason is git clone probing the file system and setting core.ignorecase
appropriately.

While it makes sense for checkouts and local commits, it doesn't make
sense to me that using git fast-import with the same import script would
have a different behavior depending on whether the file system is
case-sensitive or not.

Reduced testcase:

$ git init
$ git fast-import <<EOF
blob
mark :1
data 2
a

commit refs/FOO
committer <foo@foo> 0 +0000
data 0

M 644 :1 a

commit refs/FOO
committer <foo@foo> 0 +0000
data 0

R a A
EOF

This is what you get on a case sensitive FS:

$ git log refs/FOO -p -M
commit be1497308f30f883343eefd0da7ddf1e747133f8
Author:  <foo@foo>
Date:   Thu Jan 1 00:00:00 1970 +0000

diff --git a/a b/A
similarity index 100%
rename from a
rename to A

commit 8d37f958cfc0702c577b918c86769a902fe109f8
Author:  <foo@foo>
Date:   Thu Jan 1 00:00:00 1970 +0000

diff --git a/a b/a
new file mode 100644
index 0000000..7898192
--- /dev/null
+++ b/a
@@ -0,0 +1 @@
+a

This is what you get on a case insensitive FS:

$ git log refs/FOO -p -M
commit 208c0c4cf58cd54512301e0de33ccb8a78d6b226
Author:  <foo@foo>
Date:   Thu Jan 1 00:00:00 1970 +0000

commit 8d37f958cfc0702c577b918c86769a902fe109f8
Author:  <foo@foo>
Date:   Thu Jan 1 00:00:00 1970 +0000

diff --git a/a b/a
new file mode 100644
index 0000000..7898192
--- /dev/null
+++ b/a
@@ -0,0 +1 @@
+a

Note, this applies equally to filerename commands or filedelete +
filemodify combinations.

Mike
