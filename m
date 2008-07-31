From: =?UTF-8?B?RWRkeSBQZXRyaciZb3I=?= <eddy.petrisor@gmail.com>
Subject: [PATCH] git svn: should not display zombie externals
Date: Fri, 01 Aug 2008 01:33:19 +0300
Message-ID: <48923DAF.7070900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 00:34:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgj6-0000NF-0m
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbYGaWd1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 18:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbYGaWd1
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:33:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:59598 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYGaWd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 18:33:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so397224fgg.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=rw2Fw9Vk8HdlukjrhWITSs8qwtyOZxWghApbepR4sro=;
        b=LM5fio9upMMfepykFjxtDDnGpy6tq+MrxlZcYaxZ/2DEpoR9UBvZ1EkSireCAQUJd5
         WEDQRX93ovjx7ILCv7OH5ATKU2ZmzHqVoyXGH3mmXx3Fl6EBhlD7MxSs3N/m5qNYFrYu
         LK808HUDTbjlI1GaTY6JCu9YOoVG21xlxZSq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=QyzOXM/pjvdNj8kw4jSxry1fi5l6Gn3GzwijT+5S+QcjFX1wCLXTdnAhUwyjhgbyj8
         ZOrvLmHRThehqseaTPkr94QTo09sQDk9SCksdgtYH5/+rnjO/XbDTDytcKu4mKsMzZlX
         1Zq0yTVWexWT4kBbeeG95oX9FZGqeVnnYePaw=
Received: by 10.86.71.1 with SMTP id t1mr6618728fga.36.1217543604793;
        Thu, 31 Jul 2008 15:33:24 -0700 (PDT)
Received: from ?192.168.77.3? ( [78.97.158.176])
        by mx.google.com with ESMTPS id e11sm431490fga.4.2008.07.31.15.33.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 15:33:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080509 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91009>


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
