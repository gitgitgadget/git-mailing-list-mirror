From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/10] setup: save prefix (original cwd relative to toplevel)
 in startup_info
Date: Wed, 1 Dec 2010 17:33:22 -0600
Message-ID: <20101201233322.GJ31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:33:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNwBA-0002er-Av
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526Ab0LAXdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 18:33:33 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50252 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448Ab0LAXdc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:33:32 -0500
Received: by qyk12 with SMTP id 12so9625723qyk.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uZPRr8WwNFmS0ExP/L0UEa64wBWHlk73Ij9lprE9T54=;
        b=kYEyrbbzUpL/yB63G4Fn9ARNNFHBZ2Qjpi/jo3mRbWFKNHEyKg4LlUq6ia+tnAINHD
         OdabZ4bXYJQpyvmBktiYDsjNo0RJ/EiCtLoKGLQSozBpExWmKWvZEgwQSScWCMlJ4RGV
         BfhymNPJKX29LoIBk0utc8RQAVllsNvmawxM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lkHWaL7nSabMmT0dqmSlKcSHXIED26tDd42kHG2+FfZSfFKGMjVfFtFwnvz8Ir8dn0
         yY+4pzPcCgbU3Bx0vI4dC3b9eEW2dVn5n2w3ijZcIWMPCfNEM21DiYAaehi3airgSmiD
         XNzpskehoU+l4ZIaLcttbb8EZ5yktitbo6MuE=
Received: by 10.224.47.84 with SMTP id m20mr1150591qaf.66.1291246411474;
        Wed, 01 Dec 2010 15:33:31 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id m7sm354843qck.13.2010.12.01.15.33.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:33:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162647>

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

Longer term, this would allow the prefix to be reused when several
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
