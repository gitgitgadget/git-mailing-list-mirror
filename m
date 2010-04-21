From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] Permit tests to be run as a (fake) root user
Date: Wed, 21 Apr 2010 09:20:59 -0500
Message-ID: <20100421142058.GC5595@progeny.tock>
References: <20100421131255.GA2750@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sylvain Rabot <sylvain@abstraction.fr>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	"Fernando J. Pereda" <ferdy@ferdyx.org>,
	Lea Wiemann <lewiemann@gmail.com>,
	Panagiotis Issaris <takis@issaris.org>,
	Mike Hommey <mh@glandium.org>,
	Marco Nelissen <marcone@xs4all.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 16:21:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4ane-0006H1-Kt
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 16:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab0DUOVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 10:21:04 -0400
Received: from mail-pz0-f186.google.com ([209.85.222.186]:36851 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab0DUOVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 10:21:00 -0400
Received: by pzk16 with SMTP id 16so3550847pzk.22
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BqP3DUVjT+gts6xcFrcqpX3T8s1c6D8ig7BdxJ0eyOc=;
        b=v9qbT8/erHAU4ps/zNdYyqBHE0KjSovzo++fvG902EKi8TnOERyeGljnleMampPK8R
         4gCBy4ZFYy9U0xEh66cDU8Lpf1NoQO1C6NMz+WsqKGP9w4wRJok4HAMNkN9xtOyqt63Q
         M+MPz7pCQA4d8I7xPtIsqBxDDMqVXvAY3hfuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oxBWnj05zB4F0FIXH2tf3+5ZKrsB4G3b5UsHvQKx5Wj1obe16w4/1hMJBKn+ACscc8
         mvDpuudJUEyF/0NQzj3TfYmvJFQ3IKAZTocBbOVXbfCqUozUfC7RCRMM2W//qxfWhQVk
         FZrJy5jNIw441dsgza8Ijrqvx0O/nwRBb6rc0=
Received: by 10.142.74.1 with SMTP id w1mr3798507wfa.258.1271859660145;
        Wed, 21 Apr 2010 07:21:00 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e40sm259739wfj.23.2010.04.21.07.20.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 07:20:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100421131255.GA2750@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145432>

Skip tests that require sane behavior wrt permissions if the current
uid is 0.

So now if you run

  fakeroot sh -c '
	make all test install install-doc prefix=3D/usr/local \
		DESTDIR=3Dwherever >packaged-git.log 2>&1 &&
	cd wherever &&
	tar -cf - . |
	gzip
  ' >packaged-git.tar.gz

then this should successfully build a binary tarball for git, running
some tests while at it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Goals
 -----
 Before the POSIXPERM mechanism existed (which makes this change too
 easy to avoid considering), I think many people wanted to discourage
 running tests as root to avoid hosing people=E2=80=99s machines.  Whic=
h makes
 some sense.
=20
 But it is possible and may even be valuable to run tests in a
 sandbox. [1] [8] If that were the only reason to run tests as root, I
 would suggest requiring some particular environment variable to be
 set as a safety.
=20
 In Debian, I think it might be policy to allow building as =E2=80=9Cro=
ot=E2=80=9D.  In
 this context, that almost always happens through some sort of ptrace o=
r
 LD_PRELOAD hack like fakeroot.  If a user knows to, it is easy to fall
 back to building as an unprivileged user, but really I think a user
 should not have to know to. [2] [3]  If some non-POSIXPERM test fails
 when run as (fake) root, that is something that would be nice to
 know. [4]
=20
 Which prerequisite?
 -------------------
 It is possible to use autoconf-style tests to check for each
 capability we would like to lack. [5]  Certainly, POSIXPERM does not
 actually describe the exact set of abilities one gains by running as
 an unprivileged user. [6]  But unsetting POSIXPERM does successfully
 convey a simple truth: if you run tests as root, you have lost the abi=
lity
 to pay attention to permissions and keep your sanity. [7]
=20
 [1] http://thread.gmane.org/gmane.comp.version-control.git/86885/focus=
=3D87664
 [2] http://thread.gmane.org/gmane.comp.version-control.git/140128
 [3] http://thread.gmane.org/gmane.comp.version-control.git/17904/focus=
=3D17910
 [4] http://thread.gmane.org/gmane.comp.version-control.git/75561/focus=
=3D75568
 [5] http://thread.gmane.org/gmane.comp.version-control.git/18667
 [6] http://thread.gmane.org/gmane.comp.version-control.git/121502/focu=
s=3D121531
 [7] http://thread.gmane.org/gmane.comp.version-control.git/116729/focu=
s=3D118385
 [8] http://thread.gmane.org/gmane.comp.version-control.git/52654/focus=
=3D52689
     Holy cow, that Solaris bug is still not fixed [9].  Maybe it
     would be worthwhile to make an unlink() wrapper in compat/ to
     avoid new uses leaving users on such operating systems in danger.
 [9] http://bugs.opensolaris.org/view_bug.do?bug_id=3D6581318

Thanks for reading.  I hope the story was not too dull.

 t/test-lib.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a53b6cf..0f51757 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -782,7 +782,10 @@ case $(uname -s) in
 	# exec does not inherit the PID
 	;;
 *)
-	test_set_prereq POSIXPERM
+	if test $(id -u) !=3D 0
+	then
+		test_set_prereq POSIXPERM
+	fi
 	test_set_prereq BSLASHPSPEC
 	test_set_prereq EXECKEEPSPID
 	;;
--=20
1.7.1.rc1
