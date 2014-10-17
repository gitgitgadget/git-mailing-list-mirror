From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] t1304: Set LOGNAME even if USER is unset or null
Date: Fri, 17 Oct 2014 14:39:00 -0700
Message-ID: <12975d1f2b5b1cd4cc6052b829bf4814300a7ffd.1413581788.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 23:39:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfFEy-00042Y-4T
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 23:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbaJQVjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Oct 2014 17:39:12 -0400
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:58941 "EHLO
	resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751352AbaJQVjL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2014 17:39:11 -0400
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
	by resqmta-po-01v.sys.comcast.net with comcast
	id 4MeP1p0044xDoy801MfAzs; Fri, 17 Oct 2014 21:39:10 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by resomta-po-05v.sys.comcast.net with comcast
	id 4Mf91p008152l3L01Mf9sT; Fri, 17 Oct 2014 21:39:10 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 816C4141DE4D; Fri, 17 Oct 2014 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1413581948; bh=AsAl4h6+Jtw3sP09jd2RKWeb5ZN1AC+YkGriRpxWLCg=;
	h=From:To:Cc:Subject:Date;
	b=mp6eEK8DscbzTEFaczz8zMK7qnRYM4tgTdioOy085UbtxlySVH3Az2hepvAUk1vHL
	 8fGlE4wWtZODJT0y79UBqum7EOy10TEVLHelFty+ScPaZoCtPjnLkuZKznovg/EYv1
	 EZslstV697saXXUekFcFvnbvFbBbUwDOkK87Sszo=
X-Mailer: git-send-email 2.0.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1413581950;
	bh=zgHauukPZ7dpVD9DEdWJG0TpfO5zIwnaW7H2hbhe214=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id:
	 MIME-Version:Content-Type;
	b=p8yF7QUidHSuwCbaKZLOwLWHsId7eHR+PdNMQ3xeQsA5MuBwad0lftH8IeUab4t8v
	 nuBSq9yeAqL67sDayeisF48Cf+Sk/TdA0LFB1LMgMFN8wUJ01iNWKOf8Uh2LH9lqM7
	 dG3ZjaJxfY1gGOWiDX4FV6e2exmmL1yxVhC+m1RUeCuM+D2WIX1p2MMICn05dEN6C6
	 qnQ35eBbc4ADAdW3jz0HJmzVHtnyNTzPfsT+Nygf5VN5yjbKUSXrlwPVg5/mOmVUTv
	 FJRdx/WPTh/30oJTwH1ublwB8DaF6xHX+5UyQlvB/DhbIU92CAHLz1+/5xry9tViQk
	 0d9zogvfh4g9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid:

  # ./t1304-default-acl.sh
  ok 1 - checking for a working acl setup
  ok 2 - Setup test repo
  not ok 3 - Objects creation does not break ACLs with restrictive umas=
k
  #
  #               # SHA1 for empty blob
  #               check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8=
b29ae775ad8c2e48c5391
  #
  not ok 4 - git gc does not break ACLs with restrictive umask
  #
  #               git gc &&
  #               check_perms_and_acl .git/objects/pack/*.pack
  #
  # failed 2 among 4 test(s)
  1..4

on systems where USER isn't set.  It's usually set by the login
process, but it isn't set when launching some Docker images.  For
example:

  $ docker run --rm debian env
  HOME=3D/
  PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  HOSTNAME=3Db2dfdfe797ed

'id -u -n' has been in POSIX from Issue 2 through 2013 [1], so I don't
expect compatibility issues.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/id.html

Signed-off-by: W. Trevor King <wking@tremily.us>
---
The patch is based on the current maint branch.

Previous LOGNAME discussion:

* Michael Gruber on 2011-05-06 suggesting a discussing a whoami
  fallback [1] (but whoami isn't POSIX).
* Ren=C3=A9 Scharfe on 2011-10-14 suggesting USER as a fallback for
  LOGNAME [2].
* Matthieu Moy on 2012-09-17 suggesting dropping $LOGNAME in
  favor of numerical user IDs 'id -u' for a system with multiple
  usernames sharing the same user ID [3].

Obviously, you can work around the problem with:

  # USER=3D$(id -u -n) ./t1304-default-acl.sh

so the question is really "Are empty-USER systems worth supporting out
of the box?".

Cheers,
Trevor

[1]: http://thread.gmane.org/gmane.comp.version-control.git/172883/focu=
s=3D172961
[2]: http://thread.gmane.org/gmane.comp.version-control.git/183586
[3]: http://thread.gmane.org/gmane.comp.version-control.git/205690/focu=
s=3D205703

 t/t1304-default-acl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 79045ab..f5422f1 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -26,7 +26,7 @@ test_expect_success 'checking for a working acl setup=
' '
=20
 if test -z "$LOGNAME"
 then
-	LOGNAME=3D$USER
+	LOGNAME=3D"${USER:-$(id -u -n)}"
 fi
=20
 check_perms_and_acl () {
--=20
2.1.0.60.g85f0837
