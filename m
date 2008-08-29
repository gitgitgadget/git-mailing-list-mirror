From: =?utf-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>
Subject: [PATCH] git svn: should not display zombie externals
Date: Fri, 29 Aug 2008 03:02:57 +0300
Message-ID: <1219968179-14156-1-git-send-email-eddy.petrisor@gmail.com>
References: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 02:04:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrTA-0003an-Ky
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbYH2ADA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 20:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbYH2ADA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:03:00 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:29494 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYH2AC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:02:59 -0400
Received: by fk-out-0910.google.com with SMTP id 18so408964fkq.5
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PWS6gJhEaqpEBpwFjxkCGKc0ws5PjfAbFf92UZ16Alo=;
        b=wVDKaj4gXaZbVGhMEJL9UqEfc64hme2O3o70wB03aMEJxlVgUFxI5e/BZgQsQiFtC6
         mYE+lNxewovwBUARyY3UbTV28fcHfMV1OSRRtzmxnI8AgY6PIZPT3Q9RniIDTxEiNU8P
         0Wadql8IkKogCIrqVGVhZ9PmrZuWBMSzq6x18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L6O4uyZK5AxrUZUb8Mjw9g4SxyDGeAX3/CDQWH664CqznJAfPJ20ZDY25wVXnHawee
         co4dy1pH0ZzWWcaBdIuyenRfUKCJgDUreKk5m7drwyoHuAOmuq8tGG2wlDRhwHkXVyAA
         wQsHntC9bT+fpNWO8VDRfz2BKuco+w31vlDvw=
Received: by 10.181.28.18 with SMTP id f18mr2909828bkj.88.1219968177423;
        Thu, 28 Aug 2008 17:02:57 -0700 (PDT)
Received: from eddy.petrisor@gmail.com ( [78.97.158.176])
        by mx.google.com with ESMTPS id k29sm1393478fkk.2.2008.08.28.17.02.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 17:02:56 -0700 (PDT)
Received: by eddy.petrisor@gmail.com (sSMTP sendmail emulation); Fri, 29 Aug 2008 03:02:59 +0300
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94222>

subversion does not process in any way empty svn:externals properties
and doesn't list them in any way; git svn externals shouldn't do that
either

Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
---
 t/t9101-git-svn-props.sh |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index f420796..e174b30 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -211,7 +211,29 @@ EOF
=20
 test_expect_success 'test proplist' "
 	git-svn proplist . | cmp - prop.expect &&
-	git-svn proplist nested/directory/.keep | cmp - prop2.expect
+	git-svn proplist nested/directory/.keep | cmp - prop2.expect &&
+	cd ..
+	"
+
+test_expect_success 'show external' "
+	cd test_wc &&
+		svn mkdir zombie &&
+		svn propset svn:externals 'externaldir file:///fake/external' zombie=
 &&
+		svn ci -m 'added a fake svn:external' &&
+	cd .. &&
+	git-svn fetch &&
+	git-merge git-svn &&
+	git-svn show-externals | grep -q 'externaldir'
+	"
+
+test_expect_failure 'remove external' "
+	cd test_wc &&
+		svn propset svn:externals '' zombie &&
+		svn ci -m 'deleted the fake external' &&
+	cd .. &&
+	git-svn fetch &&
+	git-merge git-svn &&
+	git-svn show-externals | grep -v ^# | grep -v ^$ | grep -q -v '^/zomb=
ie'
 	"
=20
 test_done
--=20
1.5.6.3
