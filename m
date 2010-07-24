From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9] setup: do not forget working dir from subdir of gitdir
Date: Sat, 24 Jul 2010 06:29:41 -0500
Message-ID: <20100724112941.GA16338@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:30:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OccwL-00078l-RW
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0GXLap convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 07:30:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35823 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab0GXLao (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:30:44 -0400
Received: by iwn7 with SMTP id 7so1099841iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bWde/RH0fPFr3b5xhZf3QbDSvkQMtGMOa3t/Vlg4qmw=;
        b=Dop9TQ0LvgKvblD80OJuUPbPExnTIMLxPQLljMxSqgt1mMVv38yBOtcyg0YiYfnxz7
         pjfdPrqCFSx+EDTqlIHeqWUjMEYuYaxKU2lEOM3H5yTLZ6Gf1/EV+baltODdWFvcKYum
         zqrprfnAVFfAeCeE2uSA1ZSmkUINM4Gcf4+iU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XelSQXejvHqT1E4m+R1msEXA1q/9ibpe5rCk8G3VJE13wEWyvi3AHhgnlwHgE+n1MU
         QnHkBrNxG+GJtyQHCd96OOOF/ttHKIHwCa85uzCXLC719MqWVsRTnxUQRsb85JD9fpox
         JaUAR2HkFAqDLidDLA+kHTqcTx1CCJnFPm3+E=
Received: by 10.231.152.146 with SMTP id g18mr5320717ibw.48.1279971044128;
        Sat, 24 Jul 2010 04:30:44 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm1254997ibh.22.2010.07.24.04.30.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:30:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151619>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

v1.6.1.3~4^2 (Fix gitdir detection when in subdir of gitdir,
2009-01-16) did not go far enough: when a git directory is
an ancestor of the original working directory, not only
should GIT_DIR be set to point to the .git directory, but
the original working directory should be restored before
carrying out the relevant command.

This way, the effect of running a git command from a subdir
of .git will be the same whether or not GIT_DIR is explicitly
set.

Noticed while investigating v1.6.0.3~1 (rehabilitate 'git
index-pack' inside the object store, 2008-10-20).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 setup.c                 |    2 ++
 t/t4111-apply-subdir.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 5fb9c54..5734a1f 100644
--- a/setup.c
+++ b/setup.c
@@ -369,6 +369,8 @@ static const char *setup_bare_git_dir(const char *w=
ork_tree_env,
 	if (!work_tree_env)
 		inside_work_tree =3D 0;
 	if (offset !=3D len) {
+		if (chdir(cwd))
+			die_errno("Cannot come back to cwd");
 		root_len =3D offset_1st_component(cwd);
 		cwd[offset > root_len ? offset : root_len] =3D '\0';
 		set_git_dir(cwd);
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index 60c2237..57cae50 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -96,7 +96,7 @@ test_expect_success 'apply from .git dir' '
 	test_cmp expected .git/file
 '
=20
-test_expect_failure 'apply from subdir of .git dir' '
+test_expect_success 'apply from subdir of .git dir' '
 	cp postimage expected &&
 	cp preimage .git/file &&
 	cp preimage .git/objects/file
--=20
1.7.2.rc3
