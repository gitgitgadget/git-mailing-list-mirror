From: Dirk Hoerner <dirker@gmail.com>
Subject: [PATCH v2] git-cvsimport: add support for cvs pserver password scrambling.
Date: Fri, 14 Aug 2009 08:58:31 +0200
Message-ID: <1250233111-19188-1-git-send-email-dirker@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Dirk Hoerner <dirker@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 08:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbqkT-0001N7-UJ
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbZHNG6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 02:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755470AbZHNG6m
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:58:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:19538 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbZHNG6l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 02:58:41 -0400
Received: by qw-out-2122.google.com with SMTP id 8so460080qwh.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 23:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=05zSMCHGzbRoQMr8HDOJQ7WLRdMlSuuBrcVftVHP5mg=;
        b=EizzYebYS0RfrWi73n4B1MV5+0QXDXa2zCeoBHZsfhmL+qeLVIVIpw0uNVV6g7id59
         2z9owM+tpGLaP40iRMzb76vcsIFtNwUbuxELjodrpGH2sADyJQjivv44mcwagLnPM78W
         2baAUb4a2mbrUCfK6fshdtjff4meNnX2f8SXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jA2t7VJgiCt0CkRX1AOQVgCzZERErgsB9M8Z320bczgNg4A5MoAQAJaYa1A4CNDfdh
         mGEumEhsvWbfdHSGjPHli4OaWihyRaf5yUAKeXDDreIdT6elMdfl4gBGFSbELsqJz4Hp
         7+yqlOFqz4NJl0YnUduRKOhN0lOmeSdGSk+j4=
Received: by 10.224.78.227 with SMTP id m35mr2032479qak.178.1250233122474;
        Thu, 13 Aug 2009 23:58:42 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.8])
        by mx.google.com with ESMTPS id 4sm2833134qwe.45.2009.08.13.23.58.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 23:58:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125907>

Instead of a cleartext password, the CVS pserver expects a scrambled one
in the authentication request. With this patch it is possible to import
CVS repositories only accessible via pserver and user/password.

Signed-off-by: Dirk Hoerner <dirker@gmail.com>
---
 git-cvsimport.perl   |   39 ++++++++++++++++++++++++++++++++++++++-
 t/t9600-cvsimport.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e439202..593832d 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -252,7 +252,8 @@ sub conn {
 				}
 			};
 		}
-		$pass="A" unless $pass;
+
+		$pass = $self->_scramble($pass);
 
 		my ($s, $rep);
 		if ($proxyhost) {
@@ -484,6 +485,42 @@ sub _fetchfile {
 	return $res;
 }
 
+sub _scramble {
+	my ($self, $pass) = @_;
+	my $scrambled = "A";
+
+	return $scrambled unless $pass;
+
+	my $pass_len = length($pass);
+	my @pass_arr = split("", $pass);
+	my $i;
+
+	# from cvs/src/scramble.c
+	my @shifts = (
+		  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+		 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+		114,120, 53, 79, 96,109, 72,108, 70, 64, 76, 67,116, 74, 68, 87,
+		111, 52, 75,119, 49, 34, 82, 81, 95, 65,112, 86,118,110,122,105,
+		 41, 57, 83, 43, 46,102, 40, 89, 38,103, 45, 50, 42,123, 91, 35,
+		125, 55, 54, 66,124,126, 59, 47, 92, 71,115, 78, 88,107,106, 56,
+		 36,121,117,104,101,100, 69, 73, 99, 63, 94, 93, 39, 37, 61, 48,
+		 58,113, 32, 90, 44, 98, 60, 51, 33, 97, 62, 77, 84, 80, 85,223,
+		225,216,187,166,229,189,222,188,141,249,148,200,184,136,248,190,
+		199,170,181,204,138,232,218,183,255,234,220,247,213,203,226,193,
+		174,172,228,252,217,201,131,230,197,211,145,238,161,179,160,212,
+		207,221,254,173,202,146,224,151,140,196,205,130,135,133,143,246,
+		192,159,244,239,185,168,215,144,139,165,180,157,147,186,214,176,
+		227,231,219,169,175,156,206,198,129,164,150,210,154,177,134,127,
+		182,128,158,208,162,132,167,209,149,241,153,251,237,236,171,195,
+		243,233,253,240,194,250,191,155,142,137,245,235,163,242,178,152
+	);
+
+	for ($i = 0; $i < $pass_len; $i++) {
+		$scrambled .= pack("C", $shifts[ord($pass_arr[$i])]);
+	}
+
+	return $scrambled;
+}
 
 package main;
 
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 363345f..57c0eac 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -128,4 +128,45 @@ test_expect_success 'import from a CVS working tree' '
 
 test_expect_success 'test entire HEAD' 'test_cmp_branch_tree master'
 
+if ! type nc >/dev/null 2>&1
+then
+	say 'skipping cvsimport pserver test, nc not found'
+	test_done
+	exit
+fi
+
+cat << EOF >expected
+BEGIN AUTH REQUEST
+/cvs
+me
+AyuhedEIc?^]'%=0:q Z,b<3!a>
+END AUTH REQUEST
+EOF
+
+test_expect_success 'connect to pserver with password' '
+
+	echo "I HATE YOU" | nc -l 2401 >actual &
+	test_must_fail git cvsimport -d \
+		:pserver:me:abcdefghijklmnopqrstuvwxyz@localhost:/cvs foo \
+		>/dev/null 2>&1 &&
+	test_cmp expected actual
+'
+
+cat << EOF >expected
+BEGIN AUTH REQUEST
+/cvs
+anonymous
+A
+END AUTH REQUEST
+EOF
+
+test_expect_success 'connect to pserver without password' '
+
+	echo "I HATE YOU" | nc -l 2401 >actual &
+	test_must_fail git cvsimport -d \
+		:pserver:anonymous@localhost:/cvs foo \
+		>/dev/null 2>&1 &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.6.4
