From: Peter Jones <pjones@redhat.com>
Subject: [PATCH] Handle "git show" output correctly.
Date: Wed, 12 Sep 2012 11:26:11 -0400
Message-ID: <1347463571-16831-1-git-send-email-pjones@redhat.com>
Cc: Peter Jones <pjones@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 12 17:26:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBopc-0001rY-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 17:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab2ILP0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 11:26:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60975 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644Ab2ILP0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 11:26:16 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8CFQF75031010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 12 Sep 2012 11:26:15 -0400
Received: from eddie.install.bos.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q8CFQDrm011987;
	Wed, 12 Sep 2012 11:26:14 -0400
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205300>

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 git-am.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/git-am.sh b/git-am.sh
index c682d34..ebcbff7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -216,6 +216,21 @@ check_patch_format () {
 		read l2
 		read l3
 		case "$l1" in
+                "commit "*)
+                        case "$l2" in
+                        "Author: "*)
+                                case "$l3" in
+                                "Date: "*)
+                                        patch_format=gitshow
+                                        ;;
+                                *)
+                                        ;;
+                                esac
+                                ;;
+                        *)
+                                ;;
+                        esac
+                        ;;
 		"From "* | "From: "*)
 			patch_format=mbox
 			;;
@@ -321,6 +336,37 @@ split_patches () {
 		this=
 		msgnum=
 		;;
+        gitshow)
+		this=0
+		for stgit in "$@"
+		do
+			this=`expr "$this" + 1`
+			msgnum=`printf "%0${prec}d" $this`
+			# Perl version of The first nonemptyline after an
+                        # empty line is the subject, and the body starts with
+                        # the next nonempty line.
+			perl -ne 'BEGIN { $subject = 0 }
+				if ($subject > 1) { print ; }
+				elsif (/^\s+$/) { next ; }
+				elsif (/^Author:/) { s/Author/From/ ; print ;}
+				elsif (/^(From|Date)/) { print ; }
+                                elsif (/^commit/) { next ; }
+				elsif ($subject) {
+					$subject = 2 ;
+					print "\n" ;
+                                        s/^    // ;
+					print ;
+				} else {
+					print "Subject: ", $_ ;
+					$subject = 1;
+				}
+			' < "$stgit" > "$dotest/$msgnum" || clean_abort
+		done
+		echo "$this" > "$dotest/last"
+		this=
+		msgnum=
+		;;
+
 	hg)
 		this=0
 		for hg in "$@"
-- 
1.7.11.4
