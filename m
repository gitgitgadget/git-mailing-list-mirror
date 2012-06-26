From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] t9010: Open backflow FIFO once to work around kernel race condition
Date: Tue, 26 Jun 2012 18:30:06 -0400
Message-ID: <1340749806-22734-1-git-send-email-andersk@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Anders Kaseorg <andersk@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:35:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjeLz-0003GX-0j
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab2FZWfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 18:35:16 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:42080 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754382Ab2FZWfP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 18:35:15 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2012 18:35:14 EDT
X-AuditID: 1209190e-b7fb56d0000008b2-6b-4fea37f43884
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C3.C8.02226.4F73AEF4; Tue, 26 Jun 2012 18:30:12 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id q5QMUCIQ022111;
	Tue, 26 Jun 2012 18:30:12 -0400
Received: from localhost (VPN-18-101-24-140.MIT.EDU [18.101.24.140])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id q5QMU8Kx022126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 26 Jun 2012 18:30:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixG6novvF/JW/wfUOa4tTz9ewWHRd6Way
	aOi9wmzx9uYSRgcWjz135jJ57Jx1l93j4iVlj8+b5AJYorhsUlJzMstSi/TtErgy3n7rZy7o
	5a541LOEqYHxF0cXIweHhICJxM4zOl2MnECmmMSFe+vZuhi5OIQE9jFKfLl4mh3C2cAocbv5
	CSOEc5xJ4sb824wgLWwCahJzN0xmB7FFgOyJbYdYQIqYBfoYJX70/GAGSQgLhEjcunGFBcRm
	EVCVmPZlNVicV8BeYu/zzSwQuxUljvzbwQQRF5Q4OfMJC8h5zALqEuvnCYGEmQXkJZq3zmae
	wMg/C0nVLISqWUiqFjAyr2KUTcmt0s1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSndxAgKWU5J
	vh2MXw8qHWIU4GBU4uGNYHnlL8SaWFZcmXuIUZKDSUmUN9IUKMSXlJ9SmZFYnBFfVJqTWnyI
	UYKDWUmE97cuUI43JbGyKrUoHyYlzcGiJM57JeWmv5BAemJJanZqakFqEUxWhoNDSYK3Ghib
	QoJFqempFWmZOSUIaSYOTpDhPEDDt5qBDC8uSMwtzkyHyJ9iVJQS5w0CaRYASWSU5sH1wlLK
	K0ZxoFeEebNBqniA6Qiu+xXQYCagwRybXoAMLklESEk1MGrt0PnYwNxV/dphaWvezufOC/L+
	1le+Xb5ud3Nt2JfSrbP3G+as8vspbLI9x3Hail35V+ztm5a7LN3wcMfJ4Gdur6ZZKqtJtDxN
	Cuoo4U3xSfl6QVjxF9uNNT8v33vzeqP8wwfKS32s5irwJxfPMy+f4vU5uk425PLE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200694>

Linux=E2=80=99s implementation of open() on FIFOs suffers from a race
condition (see http://marc.info/?l=3Dlinux-kernel&m=3D134071285509470 )
that causes t9010-svn-fe.sh to occasionally fail with
  t9010-svn-fe.sh: 27: eval: cannot create backflow: Interrupted system=
 call
Although I can=E2=80=99t reproduce this locally, it happens particularl=
y often
on the Launchpad PPA builders.

Sidestep this problem by opening the backflow FIFO once for
read+write.  Also, replace the stream FIFO with a shell pipe so we
don=E2=80=99t have to do manual process management.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 t/t9010-svn-fe.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed24..c52a7de 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -11,9 +11,9 @@ reinit_git () {
 		return 127
 	fi
 	rm -fr .git &&
-	rm -f stream backflow &&
+	rm -f backflow &&
 	git init &&
-	mkfifo stream backflow
+	mkfifo backflow
 }
=20
 try_dump () {
@@ -22,10 +22,9 @@ try_dump () {
 	maybe_fail_fi=3D${3:+test_$3} &&
=20
 	{
-		$maybe_fail_svnfe test-svn-fe "$input" >stream 3<backflow &
-	} &&
-	$maybe_fail_fi git fast-import --cat-blob-fd=3D3 <stream 3>backflow &=
&
-	wait $!
+		$maybe_fail_svnfe test-svn-fe "$input" |
+		$maybe_fail_fi git fast-import --cat-blob-fd=3D3
+	} 3<>backflow
 }
=20
 properties () {
--=20
1.7.11.1
