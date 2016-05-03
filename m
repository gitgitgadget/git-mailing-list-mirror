From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4 01/11] add fetch-pack --diag-url tests for some corner cases
Date: Tue,  3 May 2016 17:50:42 +0900
Message-ID: <1462265452-32360-2-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 10:53:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axW4i-0005Wm-DT
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843AbcECIvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:51:54 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51950 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbcECIvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:51:04 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1axW2e-0008Qp-8u; Tue, 03 May 2016 17:50:52 +0900
X-Mailer: git-send-email 2.8.1.16.gaa70619.dirty
In-Reply-To: <1462265452-32360-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293346>

t5603-clone-dirname uses url patterns that are not tested with
fetch-pack --diag-url, and it would be useful if they were.

Interestingly, some of those tests, involving both a port and a
user:password pair, don't currently pass. Note that even if a
user:password pair is actually not supported by git, the values used
could be valid user names (user names can actually contain colons
and at signs), and are still worth testing the url parser for.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 t/t5500-fetch-pack.sh | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

Note I'm not /entirely/ sure about colons in user names, but ssh happily
sends requests to authenticate with logins containing colons. I however
*do* know it works with at signs (hg.mozilla.org ssh accounts are email
addresses).

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..1f0133f 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -569,12 +569,27 @@ check_prot_host_port_path () {
 	test_cmp expected actual
 }
 
-for r in repo re:po re/po
+test_maybe_fail () {
+	host=$1; shift
+	case $host in
+		git=*)
+		test_expect_success "$@"
+		;;
+		*:*@*)
+		test_expect_failure "$@"
+		;;
+		*)
+		test_expect_success "$@"
+		;;
+	esac
+}
+
+for r in repo re:po re/po re@po
 do
 	# git or ssh with scheme
 	for p in "ssh+git" "git+ssh" git ssh
 	do
-		for h in host user@host user@[::1] user@::1
+		for h in host user@host user@[::1] user@::1 user:password@host user:passw@rd@host
 		do
 			for c in "" :
 			do
@@ -587,9 +602,12 @@ do
 				'
 			done
 		done
-		for h in host User@host User@[::1]
+		for h in host User@host User@[::1] User:password@host User:passw@rd@host
 		do
-			test_expect_success "fetch-pack --diag-url $p://$h:22/$r" '
+			test_maybe_fail "$p=$h" "fetch-pack --diag-url $p://$h:22/$r" '
+				check_prot_host_port_path $p://$h:22/$r $p "$h" 22 "/$r"
+			'
+			test_maybe_fail "$p=$h" "fetch-pack --diag-url $p://$h:22/$r" '
 				check_prot_host_port_path $p://$h:22/$r $p "$h" 22 "/$r"
 			'
 		done
@@ -628,6 +646,18 @@ do
 			check_prot_host_port_path $h:/~$r $p "$h" NONE "~$r"
 		'
 	done
+	#ssh without scheme with port
+	p=ssh
+	for h in host user@host user:password@host user:passw@rd@host
+	do
+		test_maybe_fail "$h" "fetch-pack --diag-url [$h:22]:$r" '
+			check_prot_host_port_path [$h:22]:$r $p $h 22 "$r"
+		'
+		# Do "/~" -> "~" conversion
+		test_maybe_fail "$h" "fetch-pack --diag-url [$h:22]:/~$r" '
+			check_prot_host_port_path [$h:22]:/~$r $p $h 22 "~$r"
+		'
+	done
 done
 
 test_expect_success MINGW 'fetch-pack --diag-url file://c:/repo' '
-- 
2.8.1.16.gaa70619.dirty
