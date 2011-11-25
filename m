From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 2/3] t9301: Add 2nd testcase exposing bugs in fast-import's
 notes fanout handling
Date: Fri, 25 Nov 2011 01:09:46 +0100
Message-ID: <1322179787-4422-3-git-send-email-johan@herland.net>
References: <Pine.GSO.4.63.1111231137350.5099@shipon.roxen.com>
 <1322179787-4422-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, johan@herland.net
To: grubba@grubba.org
X-From: git-owner@vger.kernel.org Fri Nov 25 02:10:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTkJA-0006hP-TE
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 02:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab1KYBKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Nov 2011 20:10:16 -0500
Received: from smtp.getmail.no ([84.208.15.66]:55121 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab1KYBKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 20:10:06 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Nov 2011 20:10:04 EST
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LV600HD9WGPGC60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 25 Nov 2011 01:10:01 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3CDB1179912E_ECEDCD9B	for <git@vger.kernel.org>; Fri,
 25 Nov 2011 00:10:01 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D61E417962F3_ECEDCD8F	for <git@vger.kernel.org>; Fri,
 25 Nov 2011 00:10:00 +0000 (GMT)
Received: from alpha.herland ([84.208.177.71]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LV600D70WGNSC30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 25 Nov 2011 01:10:00 +0100 (MET)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1322179787-4422-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185922>

The previous patch exposed a bug in fast-import where _removing_ an exi=
sting
note fails (when that note resides on a non-zero fanout level, and was =
added
prior to this fast-import run).

This patch demostrates the same issue when _changing_ an existing note
(subject to the same circumstances).

Discovered-by: Henrik Grubbstr=C3=B6m <grubba@roxen.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t9301-fast-import-notes.sh |   54 ++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.s=
h
index fd08161..57d85a6 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -505,6 +505,60 @@ test_expect_success 'verify that non-notes are unt=
ouched by a fanout change' '
 	test_cmp expect_non-note3 actual
=20
 '
+
+# Change the notes for the three top commits
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/many_notes
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
+data <<COMMIT
+changing notes for the top three commits
+COMMIT
+from refs/notes/many_notes^0
+INPUT_END
+
+rm expect
+i=3D$num_commits
+j=3D0
+while test $j -lt 3
+do
+	cat >>input <<INPUT_END
+N inline refs/heads/many_commits~$j
+data <<EOF
+changed note for commit #$i
+EOF
+INPUT_END
+	cat >>expect <<EXPECT_END
+    commit #$i
+    changed note for commit #$i
+EXPECT_END
+	i=3D$(($i - 1))
+	j=3D$(($j + 1))
+done
+
+test_expect_failure 'change a few existing notes' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=3Drefs/notes/many_notes git log -n3 refs/heads/many_com=
mits |
+	    grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_expect_failure 'verify that changing notes respect existing fanou=
t' '
+
+	# None of the entries in the top-level notes tree should be a full SH=
A1
+	git ls-tree --name-only refs/notes/many_notes |
+	while read path
+	do
+		if test $(expr length "$path") -ge 40
+		then
+			return 1
+		fi
+	done
+
+'
+
 remaining_notes=3D10
 test_tick
 cat >input <<INPUT_END
--=20
1.7.5.rc1.3.g4d7b
