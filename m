From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] test-lib: tests can have multiple prerequisites
Date: Wed, 21 Apr 2010 08:38:06 -0500
Message-ID: <20100421133806.GA5595@progeny.tock>
References: <20100421131255.GA2750@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Don Slutz <Don.Slutz@SierraAtlantic.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 15:38:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4a8B-0002FX-U1
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 15:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599Ab0DUNiO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 09:38:14 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:53767 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0DUNiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 09:38:13 -0400
Received: by bwz25 with SMTP id 25so8147205bwz.28
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ApG3fBkOZTjIju5xHWZqQXX6pYtNkBEBOzZMYaGQXs4=;
        b=inocJIKBrwBX856yA1na9aA/O+Dx6OAw3hxDj/K6+e+wExHZJtcQM+OmUkP2MeGeZh
         IQg6+4WdZnrBhwem3/+vYSNOpolVk7lELKaRepmtTs4mD6m375NAhTZVNJJ563pD9PVM
         mUr0Gh9OIa/x/xep83TS6YOmwmhdmzbp6s274=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X/sz72SKe01nPB39PbVRJ/acmZwHpUOQmsLVT7okuIidBrWNTplBfCehKOHSL9oB++
         iWamZ7srtpxM7SJ7ws728/tKp5M5wGvoPJlCinUoEd7b0P4ol9O3qyw7pEE/ZnmcamAF
         sM4lf/Z29sBJZQ+/HHnVnX3VO6x6pzbYgQFUQ=
Received: by 10.204.136.156 with SMTP id r28mr1911577bkt.112.1271857091928;
        Wed, 21 Apr 2010 06:38:11 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d5sm1954642bkd.7.2010.04.21.06.38.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 06:38:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100421131255.GA2750@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145428>

Treat the prereq argument to test_expect_success and
test_expect_failure as a space-separated list of prerequisites.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Alas, I didn=E2=80=99t notice the thread with the almost identical patc=
h [1]
before writing this one.

Since I am painting it, I prefer this way.  I find it intuitive and
can=E2=80=99t really see where the fuss about using some other coding s=
tyle
came from.  So I would be very happy if someone who does understand
the fuss could come up with a comment to add to the commit message
about this. :)

 t/test-lib.sh |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c582964..a53b6cf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -315,12 +315,15 @@ test_set_prereq () {
 satisfied=3D" "
=20
 test_have_prereq () {
-	case $satisfied in
-	*" $1 "*)
-		: yes, have it ;;
-	*)
-		! : nope ;;
-	esac
+	for prereq_to_test
+	do
+		case $satisfied in
+		*" $prereq_to_test "*)
+			: yes, have it ;;
+		*)
+			return 1 ;;
+		esac
+	done
 }
=20
 # You are not expected to call test_ok_ and test_failure_ directly, us=
e
@@ -370,7 +373,7 @@ test_skip () {
 		esac
 	done
 	if test -z "$to_skip" && test -n "$prereq" &&
-	   ! test_have_prereq "$prereq"
+	   ! test_have_prereq $prereq
 	then
 		to_skip=3Dt
 	fi
--=20
1.7.1.rc1
