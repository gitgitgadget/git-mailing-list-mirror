From: =?UTF-8?B?RWRkeSBQZXRyaciZb3I=?= <eddy.petrisor@gmail.com>
Subject: [PATCH] git svn: should not display zombie externals
Date: Fri, 01 Aug 2008 01:37:09 +0300
Message-ID: <48923E95.2020302@gmail.com>
References: <48923DAF.7070900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 00:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgmn-0001Ui-Qs
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbYGaWhN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755985AbYGaWhM
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:37:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:60723 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbYGaWhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 18:37:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so397784fgg.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=UqZhy88OGOVchD46nn5p3EeapCtDlKLf8GDLAP1p0Fw=;
        b=KKC0MUg3jcdpms/GJUW0q6+DXCUqHBil1EdQTVVCQ94+GAmJ/ANnJTfdXHxNZfP7Br
         WxDckPZ//C6QE7EQtpSRGv2r1WoVT29+3SnBFLJCPFtyLnFZvCsfktbFbY4bwySeGJMd
         gu13qOveQdrtf4KZWzmZezfsmC2F9RDbd5y9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=d9AH8jInivStuoBu5I9e8baBA7CGiM6UZxslH3jqgddVeanI5j6WcqWLIdA0yflQGX
         z6Rqub4OxhRHc6LPhoh52XTNImmpQLYmdmAdeNLclwK+gdA+Tf/ZVJh9q50zof9dC93W
         SBHSHuhubCqtBPUwfW9x19vFRxKQNEx+1bX/I=
Received: by 10.86.27.19 with SMTP id a19mr6605847fga.56.1217543829257;
        Thu, 31 Jul 2008 15:37:09 -0700 (PDT)
Received: from ?192.168.77.3? ( [78.97.158.176])
        by mx.google.com with ESMTPS id e20sm449571fga.1.2008.07.31.15.37.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 15:37:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080509 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <48923DAF.7070900@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91012>


during the history of a repo a svn:external could be added and later
removed; such externals shouldn't be displayed since only the current
state is relevant

I have encountered the broken behaviour on a git-svn repo with the svn
origin a repo served via https (git 1:1.5.6-1~bpo40+1 from Debian Etch
backports.) I hope this bug doesn't have to do with the svn repo being
served via https.

Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@gmail.com>
---
  t/t9101-git-svn-props.sh |   23 ++++++++++++++++++++++-
  1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index f420796..e5ab748 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -211,7 +211,28 @@ EOF

  test_expect_success 'test proplist' "
  	git-svn proplist . | cmp - prop.expect &&
-	git-svn proplist nested/directory/.keep | cmp - prop2.expect
+	git-svn proplist nested/directory/.keep | cmp - prop2.expect &&
+	cd ..
+	"
+
+test_expect_success 'show external' "
+	cd test_wc &&
+		svn propset svn:externals 'zombie file:///fake/external' . &&
+		svn ci -m 'added a fake svn:external' &&
+	cd .. &&
+	git-svn fetch &&
+	git-merge git-svn &&
+	git-svn show-externals | grep -q 'zombie'
+	"
+
+test_expect_success 'remove external' "
+	cd test_wc &&
+		svn propdel svn:externals . &&
+		svn ci -m 'deleted the fake external' &&
+	cd .. &&
+	git-svn fetch &&
+	git-merge git-svn &&
+	git-svn show-externals | grep -q -v 'zombie'
  	"

  test_done
--=20
1.5.6.3


This one is properly formated (the previous one was a copy/paste from t=
he output of the console).
