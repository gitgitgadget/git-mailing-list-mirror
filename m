From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working
    directory
Date: Mon, 13 Apr 2009 12:41:17 +0200
Message-ID: <49E316CD.7030001@lsrfire.ath.cx>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com> 	<1239260490-6318-2-git-send-email-pclouds@gmail.com> <1239260490-6318-3-git-send-email-pclouds@gmail.com> 	<1239260490-6318-4-git-send-email-pclouds@gmail.com> <7vws9u2ov4.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 12:45:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtJf0-0007Gk-An
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 12:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbZDMKlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 06:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbZDMKlb
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 06:41:31 -0400
Received: from india601.server4you.de ([85.25.151.105]:38781 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbZDMKla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 06:41:30 -0400
Received: from [10.0.1.101] (p57B7FFE1.dip.t-dialin.net [87.183.255.225])
	by india601.server4you.de (Postfix) with ESMTPSA id 9CC102F8056;
	Mon, 13 Apr 2009 12:41:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116424>

Nguyen Thai Ngoc Duy schrieb:
> 2009/4/9 Junio C Hamano <gitster@pobox.com>:
>> It would affect a bit more tests, but I think you would want to test both
>> the new "normal" mode of operation (generate archives with "git archive"
>> and "git tar-tree" without options and compare, for example), instead of
>> adding --fix-attributes everywhere.
> 
> There is a new test to test the new "normal" mode. I'll think of more.

The following patch, which can be applied before yours, makes the tests
still pass after your changes by avoiding to use worktree attributes.  I
think it makes sense to create a separate script for the new tests and
eventually move the existing archive attribute tests there.


diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7641e0d..abb41b0 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,7 +50,7 @@ test_expect_success \
 test_expect_success \
     'add ignored file' \
     'echo ignore me >a/ignored &&
-     echo ignored export-ignore >.gitattributes'
+     echo ignored export-ignore >.git/info/attributes'
 
 test_expect_success \
     'add files to repository' \
@@ -64,7 +64,7 @@ test_expect_success \
 test_expect_success \
     'create bare clone' \
     'git clone --bare . bare.git &&
-     cp .gitattributes bare.git/info/attributes'
+     cp .git/info/attributes bare.git/info/attributes'
 
 test_expect_success \
     'remove ignored file' \
@@ -139,10 +139,11 @@ test_expect_success \
 
 test_expect_success \
     'create archives with substfiles' \
-    'echo "substfile?" export-subst >a/.gitattributes &&
+    'cp .git/info/attributes .git/info/attributes.before &&
+     echo "substfile?" export-subst >>.git/info/attributes &&
      git archive HEAD >f.tar &&
      git archive --prefix=prefix/ HEAD >g.tar &&
-     rm a/.gitattributes'
+     mv .git/info/attributes.before .git/info/attributes'
 
 test_expect_success \
     'extract substfiles' \
