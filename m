From: =?UTF-8?B?VG9yIEFybmUgVmVzdGLDuA==?= <tavestbo@trolltech.com>
Subject: [PATCH next] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 15:39:50 +0100
Message-ID: <496DF936.3060308@trolltech.com>
References: <496CF21C.2050500@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 15:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN6rG-0004ki-DF
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 15:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942AbZANOfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 09:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754668AbZANOfM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 09:35:12 -0500
Received: from hoat.troll.no ([62.70.27.150]:34383 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936AbZANOfK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 09:35:10 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id B7EC940058;
	Wed, 14 Jan 2009 15:35:04 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id A17E340054;
	Wed, 14 Jan 2009 15:35:04 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n0EEZ40U013645;
	Wed, 14 Jan 2009 15:35:04 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Wed, 14 Jan 2009 15:35:03 +0100 (CET)
In-Reply-To: <7v3afm758u.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901132339270.3586@pacific.mpi-cbg.de>
References: <7v3afm758u.fsf@gitster.siamese.dyndns.org>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105633>

The tests adds a third commit with a multi-line note. The output of
git log -2 is then checked to see if the note lines are wrapped
correctly, and that there's a line separator between the two commits.

Also, changed from using 'git diff' to test expect vs. output to use
'test_cmp', as I had problems getting correct results using the former.

Signed-off-by: Tor Arne Vestb=F8 <tavestbo@trolltech.com>
---
 t/t3301-notes.sh |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index ba42c45..76bb6dd 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -8,8 +8,8 @@ test_description=3D'Test commit notes'
 . ./test-lib.sh
=20
 cat > fake_editor.sh << \EOF
-echo "$MSG" > "$1"
-echo "$MSG" >& 2
+echo -e "$MSG" > "$1"
+echo -e "$MSG" >& 2
 EOF
 chmod a+x fake_editor.sh
 VISUAL=3D./fake_editor.sh
@@ -59,7 +59,36 @@ EOF
 test_expect_success 'show notes' '
 	! (git cat-file commit HEAD | grep b1) &&
 	git log -1 > output &&
-	git diff expect output
+	test_cmp expect output
+'
+test_expect_success 'create multi-line notes (setup)' '
+	: > a3 &&
+	git add a3 &&
+	test_tick &&
+	git commit -m 3rd &&
+	MSG=3D"b3\nc3c3c3c3\nd3d3d3" git notes edit
+
+'
+
+cat > expect-multiline << EOF
+commit 1584215f1d29c65e99c6c6848626553fdd07fd75
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes:
+    b3
+    c3c3c3c3
+    d3d3d3
+EOF
+
+echo >> expect-multiline
+cat expect >> expect-multiline
+
+test_expect_success 'show multi-line notes' '
+	git log -2 > output &&
+	test_cmp expect-multiline output
 '
=20
 test_done
--=20
1.6.0.2.GIT
