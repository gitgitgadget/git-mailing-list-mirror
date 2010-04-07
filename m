From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] gitk: refresh index before checking for local changes
Date: Tue, 6 Apr 2010 19:43:53 -0500
Message-ID: <20100407004353.GA11346@progeny.tock>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
 <20100406233601.GA27533@progeny.tock>
 <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 02:44:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzJNT-0000wd-6s
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 02:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab0DGAoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 20:44:01 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:48934 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750Ab0DGAn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 20:43:59 -0400
Received: by yxe1 with SMTP id 1so44009yxe.33
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 17:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=adQKXoP84G3Sf0jw1FHSatp/fjJ+C12o6EH7uWFdqEw=;
        b=R8sNLA40l0J9SIMtxD8WKaP2xDEaeD2eb+nD0Xlh+LR43lOiESedntPk1Ox1lGrxK4
         V51xmLAzkxyZWBnSAET4kzry9al4gjzIMRvsn/vNB3EB6E3omu/9sW9S/DxXe3VP46xV
         JgkWzi3FY37SIgBOhMTwEAdWqZ4Bbr3+4T+9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wyRAkq44+ey7q+9gFRx8vI4jd2/QMQJS9jkJ9fPY3WEyjE9CY5pYtS6ZvP22+4U9Kt
         3S9cFIvtlZGnD54asBp1zTZZwBKKI3io8sW1dHQyeoOC3mM39550dw4VyBv/amqzDhBZ
         S1D9hOwn59EsgmzB0zb52+xUYHw4nkhGI8cbw=
Received: by 10.100.233.40 with SMTP id f40mr2421173anh.135.1270601038994;
        Tue, 06 Apr 2010 17:43:58 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm3403246yxh.4.2010.04.06.17.43.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 17:43:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144182>

Most git porcelain silently refreshes stat-dirty index entries.  Teach
gitk to, too; this will make the behavior easier to understand when a
person makes a change to a file and then changes mind and restores the
old version in her editor of choice.

This patch does not change the =E2=80=98checkout=E2=80=99 code path, si=
nce it is
assumed that the index is already being cleaned in that case.

Testing is needed to check if this breaks operation with read-only
access to a repository.

Requested-by: Alexander Gladysh <agladysh@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Alexander Gladysh wrote:
> Jonathan Nieder wrote:

[some nonsense about configurability]

> That's fine as far as I'm concerned.
>=20
> The current behaviour is really annoying.

Maybe that could be added in the future.  From testing this out,
refreshing unconditionally seems fast enough, at least.

 gitk |   50 +++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..2753446 100755
--- a/gitk
+++ b/gitk
@@ -375,7 +375,7 @@ proc start_rev_list {view} {
 	get_viewmainhead $view
     }
     if {$showlocalchanges && $viewmainheadid($view) ne {}} {
-	interestedin $viewmainheadid($view) dodiffindex
+	interestedin $viewmainheadid($view) dorefreshindex
     }
     fconfigure $fd -blocking 0 -translation lf -eofchar {}
     if {$tclencoding !=3D {}} {
@@ -4974,9 +4974,9 @@ proc doshowlocalchanges {} {
=20
     if {$viewmainheadid($curview) eq {}} return
     if {[commitinview $viewmainheadid($curview) $curview]} {
-	dodiffindex
+	dorefreshindex
     } else {
-	interestedin $viewmainheadid($curview) dodiffindex
+	interestedin $viewmainheadid($curview) dorefreshindex
     }
 }
=20
@@ -4992,6 +4992,42 @@ proc dohidelocalchanges {} {
     incr lserial
 }
=20
+# spawn off a process to refresh the index
+proc dorefreshindex {} {
+    global lserial showlocalchanges isworktree vfilelimit curview
+
+    if {!$showlocalchanges || !$isworktree} return
+    incr lserial
+    set cmd "|git update-index --refresh -q"
+    if {$vfilelimit($curview) ne {}} {
+	set cmd [concat $cmd -- $vfilelimit($curview)]
+    }
+    set fd [open $cmd r]
+    fconfigure $fd -blocking 0
+    set i [reg_instance $fd]
+    filerun $fd [list readrefreshindex $fd $lserial $i]
+}
+
+# update-index --refresh -q finished?
+proc readrefreshindex {fd serial inst} {
+    global lserial
+
+    if {$serial !=3D $lserial} {
+	stop_instance $inst
+	return 0
+    }
+    if {[gets $fd line] =3D=3D 0} {
+	# ignore output
+	return 0
+    }
+    if {![eof $fd]} {
+        return 1
+    }
+    stop_instance $inst
+    dodiffindex
+    return 0
+}
+
 # spawn off a process to do git diff-index --cached HEAD
 proc dodiffindex {} {
     global lserial showlocalchanges vfilelimit curview
@@ -7504,13 +7540,9 @@ proc getblobdiffs {ids} {
     global git_version
=20
     set textconv {}
-    if {[package vcompare $git_version "1.6.1"] >=3D 0} {
-	set textconv "--textconv"
-    }
+    set textconv "--textconv"
     set submodule {}
-    if {[package vcompare $git_version "1.6.6"] >=3D 0} {
-	set submodule "--submodule"
-    }
+    set submodule "--submodule"
     set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-commi=
t-id -U$diffcontext"]
     if {$ignorespace} {
 	append cmd " -w"
--=20
debian.1.7.0.3.1.469.g398f8
