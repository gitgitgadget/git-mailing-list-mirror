From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 2/2] test-lib.sh: Dynamic test for the prerequisite SANITY
Date: Tue, 27 Jan 2015 16:39:01 +0100
Message-ID: <54C7B115.7020405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 16:39:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG8EQ-0004by-G1
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 16:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826AbbA0PjF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 10:39:05 -0500
Received: from mout.web.de ([212.227.17.12]:61705 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941AbbA0PjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 10:39:04 -0500
Received: from macce.lan ([78.68.171.17]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MKIv4-1YEUKm1fIE-001hTg; Tue, 27 Jan 2015 16:39:02
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:Y38ywO8kfHHHcy2j+/auhm7mkeB1SDIMcerrfukAYbU/9ZaYFy/
 KlmMsrh/YJ3H8P/samMMqOBQ4oG5WdnOfyKkoNbvK+zUD9o4iRv2kMAK3rJvDWuUaHSMWxD
 IDvr0wYCO+XQxRgLwRdmJqmlYx8fQHjh2Ses7CfplKD12SRrrAr3SACimK+EXMncmpD/177
 Dtqo0RpN3/MwEFpWV+geg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263071>

The SANITY precondition was not set when running as root,
but this is not 100% reliable for CYGWIN:

A file may be allowed to be deleted when the containing
directory does not have write permissions.

See
https://technet.microsoft.com/en-us/library/bb463216.aspx
"...In UNIX, the write permission bit on a directory permits both
the creation and removal of new files or sub-directories in the directo=
ry.
On Windows, the Write_Data access right controls the creation of new
sub-files and the Delete_Child access right controls the deletion. ....=
"

We may argue that the translation of the POSIX write permission bit
into "Windows access rights" can be improved in CYGWIN.

A dynamic test handles all cases: when the sequence
$ mkdir SANETESTD &&
$ chmod +w SANETESTD &&
$ >SANETESTD/x &&
$ ! rm SANETESTD/x
succeeds the prerequisite SANITY is true.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/test-lib.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 93f7cad..887e986 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1038,8 +1038,23 @@ test_lazy_prereq NOT_ROOT '
=20
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
+# Special check for CYGWIN (or Windows in general):
+# A file can be deleted, even if the containing directory does'nt
+# have write permissions
 test_lazy_prereq SANITY '
-	test_have_prereq POSIXPERM,NOT_ROOT
+	mkdir SANETESTD &&
+	chmod +w SANETESTD &&
+	>SANETESTD/x &&
+	chmod -w SANETESTD ||
+	error "bug in test sript: cannot prepare SANETESTD"
+
+	! rm SANETESTD/x
+	status=3D$?
+
+	chmod +w SANETESTD &&
+	rm -rf SANETESTD ||
+	error "bug in test sript: cannot clean SANETESTD"
+	return $status
 '
=20
 GIT_UNZIP=3D${GIT_UNZIP:-unzip}
--=20
2.2.0.rc1.26.g3e3a70d
