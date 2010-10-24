From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] setup: save prefix (original cwd relative to toplevel)
 in startup_info
Date: Sun, 24 Oct 2010 03:16:55 -0500
Message-ID: <20101024081655.GD29630@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 10:20:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9vp2-0001sg-8n
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 10:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182Ab0JXIUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 04:20:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61441 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163Ab0JXIUt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 04:20:49 -0400
Received: by gwj21 with SMTP id 21so1944674gwj.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=r5mR+ou0cmHI9OHsHwKC9WK4qwwoRFxEDffdgjn8vbA=;
        b=viptQ5D2EhLLjvJuh+aujWRo67M1QPQJ2SA9goppnfeAw94HzQ3/oAVcqTXLkTESHM
         mqA/kKHfIKeFXR71OToPyvhem8b8Pb8oQJYqlIKuqTXec0CskusTG1TOcqJwvqhVnP7M
         CYydrk8SglHTHY30z4adgYnvjLw3HvtM42Sqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uLguYIRmpe8IbV4Zb+nnbo87fRKtRmqwtenl4kVDPplXqvMs7gpfDmvTultNQ08YLK
         wdakJ6ocZ/vsc5OL+/8I6Dxu0BH2OU5hpvSIaJ1ix5vJ/w72ypdBdynXt5/8Vesq9VcF
         nDM5Dd0vAQDkLxHGFadnExB4+W2Q0gaUR1CXY=
Received: by 10.151.38.21 with SMTP id q21mr6366052ybj.403.1287908447404;
        Sun, 24 Oct 2010 01:20:47 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w5sm5372920ybe.22.2010.10.24.01.20.45
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 01:20:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101024081316.GA29630@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159841>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Save the path from the original cwd to the cwd at the end of the
setup procedure in the startup_info struct introduced in e37c1329
(2010-08-05).  The value cannot vary from thread to thread anyway,
since the cwd is global.

So now in your builtin command, instead of passing prefix around,
when you want to convert a user-supplied path to a cwd-relative
path, you can use startup_info->prefix directly.

Caveat: As with the return value from setup_git_directory_gently(),
startup_info->prefix would be NULL when the original cwd is not a
subdir of the toplevel.

Longer term, this woiuld allow the prefix to be reused when several
noncooperating functions require access to the same repository (for
example, when accessing configuration before running a builtin).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h |    1 +
 setup.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..222d9cf 100644
--- a/cache.h
+++ b/cache.h
@@ -1117,6 +1117,7 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	const char *prefix;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/setup.c b/setup.c
index a3b76de..833db12 100644
--- a/setup.c
+++ b/setup.c
@@ -512,8 +512,10 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	const char *prefix;
=20
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
-	if (startup_info)
+	if (startup_info) {
 		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
+		startup_info->prefix =3D prefix;
+	}
 	return prefix;
 }
=20
--=20
1.7.2.3
