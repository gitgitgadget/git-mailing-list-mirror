From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 09 Nov 2010 13:22:10 +0100
Message-ID: <4CD93CF2.2060800@viscovery.net>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>	<1288524860-538-2-git-send-email-avarab@gmail.com>	<4CCFCCC8.7080603@viscovery.net>	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>	<4CD8F965.6050402@viscovery.net>	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>	<4CD918AB.6060206@viscovery.net>	<AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>	<4CD9241F.6070807@viscovery.net>	<AANLkTins_qq=unv101JuV_CVvkp3KbTq5qycva7bZ7sm@mail.gmail.com>	<4CD933BF.6070105@viscovery.net> <AANLkTimhbp3AngtJjBYhHpa173=D-XJOg9L2sd6YMCwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 13:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFnDR-0001P9-0z
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 13:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128Ab0KIMWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 07:22:16 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36047 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754381Ab0KIMWO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 07:22:14 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PFnDH-0003np-8r; Tue, 09 Nov 2010 13:22:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E32611660F;
	Tue,  9 Nov 2010 13:22:10 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTimhbp3AngtJjBYhHpa173=D-XJOg9L2sd6YMCwA@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161038>

Am 11/9/2010 12:57, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> How about if you just replace your tests with "cat". That should give
> a more accurate indication of what speed it *should* be operating at,
> once I fix those Makefile issues.

Just FYI:

$ time (for i in {1..100}; do eval_gettext2 foobar; done) > /dev/null

real    0m14.844s
user    0m11.635s
sys     0m4.372s

Please understand that on Windows there is a difference between cat, se=
d,
etc. and git. There is also a speed difference, which is annoying, but =
it
is fact and *not* a bug. You cannot argue with how the timings "should =
be".

> Anyway, if it's no more expensive than cat(1) (which it shouldn't be)
> it probably won't be a problem to use git-sh-i18n--envsubst.

It *is* more expensive.

BTW, current ab/i18n fails to compile when NO_GETTEXT is specified in
config.mak and libintl.h is not available. I suggest the fix below.

-- Hannes

diff --git a/Makefile b/Makefile
index c55baa6..e9ee142 100644
--- a/Makefile
+++ b/Makefile
@@ -619,9 +619,6 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fsck.o
-ifndef NO_GETTEXT
-LIB_OBJS +=3D gettext.o
-endif
 LIB_OBJS +=3D graph.o
 LIB_OBJS +=3D grep.o
 LIB_OBJS +=3D hash.o
@@ -1539,7 +1536,8 @@ endif

 ifdef NO_GETTEXT
 	COMPAT_CFLAGS +=3D -DNO_GETTEXT
-endif
+else
+	LIB_OBJS +=3D gettext.o

 ifdef NEEDS_LIBINTL
 	EXTLIBS +=3D -lintl
@@ -1552,6 +1550,7 @@ endif
 ifdef GETTEXT_POISON
 	COMPAT_CFLAGS +=3D -DGETTEXT_POISON
 endif
+endif

 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=3DNoThanks
