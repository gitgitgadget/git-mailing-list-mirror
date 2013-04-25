From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v2 1/1] templates: pre-push hook: check for missing GPG signatures
Date: Thu, 25 Apr 2013 14:19:16 +0200
Message-ID: <51791F44.9090406@physik.tu-berlin.de>
References: <7vppxjbt6t.fsf_-_@alter.siamese.dyndns.org> <cover.1366890748.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, joel@trustly.com, git@drmicha.warpmail.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 25 14:19:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVL8p-0006sR-BU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 14:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757721Ab3DYMS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 08:18:59 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:42082 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756751Ab3DYMS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 08:18:58 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UVL8b-00005W-E1; Thu, 25 Apr 2013 14:18:57 +0200
Received: from [141.23.96.137] (wlan-141-23-96-137.tubit.tu-berlin.de [141.23.96.137])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 7ADFF11401;
	Thu, 25 Apr 2013 14:18:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
In-Reply-To: <cover.1366890748.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222382>

Also added a missing colon that caused my bash 4.2.45(2)-release to
complain about an empty if.

Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
---
 templates/hooks--pre-push.sample | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-pu=
sh.sample
old mode 100644
new mode 100755
index 15ab6d8..a16283c
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-# An example hook script to verify what is about to be pushed.  Called=
 by "git
+# An example hook script to verify what is about to be pushed.	Called =
by "git
 # push" after it has checked the remote status, but before anything ha=
s been
 # pushed.  If this script exits with a non-zero status nothing will be=
 pushed.
 #
@@ -14,22 +14,22 @@
 # Information about the commits which are being pushed is supplied as =
lines to
 # the standard input in the form:
 #
-#   <local ref> <local sha1> <remote ref> <remote sha1>
+#	<local ref> <local sha1> <remote ref> <remote sha1>
 #
-# This sample shows how to prevent push of commits where the log messa=
ge starts
-# with "WIP" (work in progress).
+# This sample shows how to prevent pushing commits without good GPG si=
gnatures
+# or where the log message starts with "WIP" (work in progress).
=20
 remote=3D"$1"
 url=3D"$2"
=20
 z40=3D0000000000000000000000000000000000000000
+exitcode=3D0
=20
-IFS=3D' '
 while read local_ref local_sha remote_ref remote_sha
 do
 	if [ "$local_sha" =3D $z40 ]
 	then
-		# Handle delete
+		: # Handle delete
 	else
 		if [ "$remote_sha" =3D $z40 ]
 		then
@@ -45,9 +45,16 @@ do
 		if [ -n "$commit" ]
 		then
 			echo "Found WIP commit in $local_ref, not pushing"
-			exit 1
+			exitcode=3D1
 		fi
+
+		# Check for missing good GPG signatures
+		for commit in `git log --format=3D"%G? %h" "$range" | grep -v '^G' |=
 cut -d\  -f2`
+		do
+			echo "Commit $commit does not have a good GPG signature"
+			exitcode=3D1
+		done
 	fi
 done
=20
-exit 0
+exit $exitcode
--=20
1.8.2
