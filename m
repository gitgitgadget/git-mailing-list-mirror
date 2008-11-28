From: =?ISO-8859-1?Q?Dirk_H=F6rner?= <dirker@gmail.com>
Subject: [PATCH] git-cvsimport: add support for cvs pserver password scrambling.
Date: Fri, 28 Nov 2008 20:06:40 +0200
Message-ID: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 28 19:08:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L67lR-0007YO-IG
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 19:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYK1SHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 13:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYK1SHE
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 13:07:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:52019 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbYK1SHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 13:07:02 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2048358ugf.37
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=2B0Gm5pSUiaOBOi5sE1vI0rJ2yFlhSQLOHBJWdceWhs=;
        b=hSq66u/H/KfSXocHlnFVHOim1QXTIyWTge2rzQ3NW21xJ/vYTf6M/AvLMVNCzibI7t
         MzP9Lgo0NDyz1RTNhWVKA+XbXlckysMNOzyD430+e4oARMhzBAIQxCRmOGUCJ0+m3hBy
         LHStbBgSMnXK+ITLrwY2QJ1BJGV2qF98vdj28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=WGw8kxH0xDmRy+JwdqAZl4/U3H6yeoyab1rh/FiZk5KjV3j9ipPTM6wRuPvFsgaozv
         TpWnVEn2Tbw3i8O/sjgbNPAlU/GP47GDiyRxCbXpkhhmKfHbuAtcve38jsYm8Ua9rlxa
         Zjb53SCtBH8ZWzZJgvl8bt1tiafIlrdy0FEB4=
Received: by 10.67.40.15 with SMTP id s15mr1153656ugj.89.1227895620200;
        Fri, 28 Nov 2008 10:07:00 -0800 (PST)
Received: from ACA8144B.ipt.aol.com (mymail.dr-gav.co.il [199.203.56.34])
        by mx.google.com with ESMTPS id j4sm1163504ugf.16.2008.11.28.10.06.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Nov 2008 10:06:59 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101880>

Instead of a cleartext password, the CVS pserver expects a scrambled one
in the authentication request. With this patch it is possible to import
CVS repositories only accessible via pserver and user/password.

Signed-off-by: Dirk Hoerner <dirker@gmail.com>
---
  git-cvsimport.perl |   39 ++++++++++++++++++++++++++++++++++++++-
  1 files changed, 38 insertions(+), 1 deletions(-)

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

-- 
1.6.0.4.837.gae258
