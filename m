From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] rm: only refresh entries that we may touch
Date: Thu, 14 Jan 2010 22:02:20 +0700
Message-ID: <1263481341-28401-2-git-send-email-pclouds@gmail.com>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 16:06:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVRGv-0000Wh-D5
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 16:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907Ab0ANPDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 10:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584Ab0ANPDT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 10:03:19 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:64539 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab0ANPDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 10:03:16 -0500
Received: by pzk1 with SMTP id 1so8323338pzk.33
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FzfXIZfb7hp6JMheR7GGMPWrCgpu08pxAGUE2zZonZg=;
        b=mW859jIkkcdu3rLVreoBGwDNuxq1r0DvrqHEj/RvqlO7ykxiyCQGB9peKhS8frCEdF
         Ss1yot3HRJlV2U/90GAacvHesMavntekxGQt2ePLiM0hZ/bYwJQp8hlJgoxHT+52Gdkr
         53K9o/rl2VprwnM0v9vpZHFC0PIy5TmIHsyfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=E8rtwQkU4k4iAX35c9SY+Vv9EqtvE/5lnLRFtI9Szx+p3Jo5N10ykc2uNDb9r1Uguo
         ihsLR3yxa8q1xVcyLHbH0N/F9O3E3lQLkYR7utFUsvc8Bj61bpPmrGBWgILFk25Nxzdc
         nIS2aI9kcgAftEjZyUPVcGM+H675ljOMKd/lQ=
Received: by 10.141.89.11 with SMTP id r11mr651383rvl.285.1263481395667;
        Thu, 14 Jan 2010 07:03:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.107])
        by mx.google.com with ESMTPS id 22sm636456pzk.6.2010.01.14.07.03.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 07:03:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 14 Jan 2010 22:02:28 +0700
X-Mailer: git-send-email 1.6.6.181.g5ee6
In-Reply-To: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136998>

This gets rid of the whole tree cache refresh. Instead only path that
we touch will get refreshed. We may still lstat() more than needed,
but it'd be better playing safe.

This potentially reduces a large number of lstat() on big trees. Take
gentoo-x86 tree for example, which has roughly 80k files:

Unmodified Git:

$ time git rm --cached skel.ChangeLog
rm 'skel.ChangeLog'

real    0m1.323s
user    0m0.806s
sys     0m0.517s

Modified Git:

$ time git rm --cached skel.ChangeLog
rm 'skel.ChangeLog'

real    0m0.903s
user    0m0.780s
sys     0m0.100s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-rm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 57975db..4cac3d1 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -169,7 +169,6 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
=20
 	if (read_cache() < 0)
 		die("index file corrupt");
-	refresh_cache(REFRESH_QUIET);
=20
 	pathspec =3D get_pathspec(prefix, argv);
 	seen =3D NULL;
@@ -181,6 +180,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 		struct cache_entry *ce =3D active_cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
+		refresh_cache_entry(ce, 1);
 		add_list(ce->name);
 	}
=20
--=20
1.6.6.181.g5ee6
