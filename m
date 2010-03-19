From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: Fix CDPATH problem
Date: Fri, 19 Mar 2010 18:40:34 -0500
Message-ID: <20100319234033.GA18035@progeny.tock>
References: <d557014b1003191436r4d141825p6c5b8e1b3bee4fc8@mail.gmail.com>
 <7veijgc6md.fsf@alter.siamese.dyndns.org>
 <d557014b1003191525m490d1bfam4e8ce40681ff2214@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Cox <mhcox@bluezoosoftware.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 00:39:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NslnE-0005qk-7F
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 00:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab0CSXjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 19:39:47 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:44774 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab0CSXjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 19:39:46 -0400
Received: by yxe12 with SMTP id 12so829131yxe.33
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lqokxIVlqUyY6jbUcBeuKT+J6PBM8UYTMLEVZGO8AOI=;
        b=rDWzKd0/A3GFxNikJPgVKfaGuSLzxAWPY5NBuqGSRb+Q9S4LfZG6n2U+L8dD/2Kk7u
         nIcubJEC82aBC8pbi6Dm9FBJ9LDcF4hHOtl1kR4p/n0v4Qg4QSX/QRl2JALRnQGjU5IB
         vBdcn1mFB8mmqIjHXVXPIaxeEvK8zPhYry5Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Tcxko/eCcuJJdKqjgBXOntdth6Oj5oalZaHb6/nDXK6w7lt5HOA5WCxRRF6dQ8yILh
         ZGs9ZopQmZltARy1ZkGLA9WTU81MQhgeNR2GqEWYExU0XvQSjl4vIdeSGqsz0YTUPeQ5
         V0i3yOy3Hs8Aka+owXxVmRWeVtBMBZEJDPFdc=
Received: by 10.100.50.12 with SMTP id x12mr8487097anx.217.1269041986028;
        Fri, 19 Mar 2010 16:39:46 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm37561iwn.12.2010.03.19.16.39.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 16:39:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d557014b1003191525m490d1bfam4e8ce40681ff2214@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142662>

CDPATH takes scripts to unexpected places.  For example, with a CDPATH
including a blt directory:

 make -C templates DESTDIR=3D'' install
 make[1]: Entering directory `/users/e477610/exptool/src/git-1.7.0.2/te=
mplates'
 install -d -m 755 '/home/e477610/exptool/share/git-core/templates'
 (cd blt && gtar cf - .) | \
	(cd '/home/e477610/exptool/share/git-core/templates' && umask 022 && g=
tar xof -)
 gtar: This does not look like a tar archive

The CDPATH mechanism does not implicitly add "." at the beginning of
CDPATH, which is the most irritating part.

Most git scripts already protect against use of CDPATH through
git-sh-setup, but the Makefile doesn=E2=80=99t.

Reported-by: Michael Cox <mhcox@bluezoosoftware.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I wouldn=E2=80=99t have guessed that.  Thanks, Junio.

Michael Cox wrote:
> That fixed the build problem.  Thank you!

Here=E2=80=99s a patch to prevent it from happening again.

 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 4387d42..c1f4161 100644
--- a/Makefile
+++ b/Makefile
@@ -317,6 +317,12 @@ SCRIPT_PYTHON =3D
 SCRIPT_SH =3D
 TEST_PROGRAMS =3D
=20
+# Having this variable in your environment would break scripts because
+# you would cause "cd" to be taken to unexpected places.  If you
+# like CDPATH, define it for your interactive shell sessions without
+# exporting it.
+unexport CDPATH
+
 SCRIPT_SH +=3D git-am.sh
 SCRIPT_SH +=3D git-bisect.sh
 SCRIPT_SH +=3D git-difftool--helper.sh
--=20
1.7.0.2.468.g1637
