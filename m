From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] builtin: Support RUN_SETUP_GENTLY to set up repository
 early if found
Date: Mon, 12 Apr 2010 21:29:22 -0500
Message-ID: <20100413022922.GG4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:29:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Vsa-0008U2-2G
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658Ab0DMC30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 22:29:26 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38146 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642Ab0DMC3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:29:24 -0400
Received: by gyg13 with SMTP id 13so3218885gyg.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xGGWaTqyeIpn8pfTKhHXPN8BJh7lRNpwzn0huvXlM1I=;
        b=tIDHRQ+cPEN7vQOhpZqpV7DYpGo9p52JRahwv6Y1wt6vYLVV4GcR9qHVePl5gN+PRK
         Ofk+hlKuqj9aIBPSGnOWxF2VJZt1/E9Dh54qsVW2J306ifw1bb7oGBH/as6vByMs+nRj
         dp1IGNkIMDKPx6NwIWd68pgRu/4x0Uo6KrNOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=higWoeBdDPRRcxgHEfMd2QjFTeIiNqtt183kwcnZVKy66eXxDMyVduOEytIw99dXlg
         PCaF/YjtihOSyxwyr1mG/JlOgGIcTNEw+drL1NWH8pdiRLG8jSkK7GJIqTHci/WNjoQI
         vmitf22Y5tfn/DH6qsTqrTuvEgdGosS5W7CaY=
Received: by 10.151.117.14 with SMTP id u14mr4815918ybm.184.1271125763553;
        Mon, 12 Apr 2010 19:29:23 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 20sm4488876iwn.5.2010.04.12.19.29.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:29:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144786>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Attempts to access gitdir are everywhere, even before cmd_*() is
called (examples: alias handling, pager configuration, work tree).
Because the repository has not been found, repository-specific
information (i.e., $GIT_DIR/config) can not be read.  This leads to
obscure bugs.

So the sooner we setup gitdir, the less trouble we may have to deal wit=
h.

This patch sets up the infrastructure.  Later patches will teach
particular commands to use it where applicable.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index b1d51c9..20e9bfc 100644
--- a/git.c
+++ b/git.c
@@ -220,13 +220,14 @@ static int handle_alias(int *argcp, const char **=
*argv)
=20
 const char git_version_string[] =3D GIT_VERSION;
=20
-#define RUN_SETUP	(1<<0)
-#define USE_PAGER	(1<<1)
+#define RUN_SETUP		(1<<0)
+#define USE_PAGER		(1<<1)
 /*
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NEED_WORK_TREE	(1<<2)
+#define NEED_WORK_TREE		(1<<2)
+#define RUN_SETUP_GENTLY	(1<<3)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -245,6 +246,10 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
 	if (!help) {
 		if (p->option & RUN_SETUP)
 			prefix =3D setup_git_directory();
+		if (p->option & RUN_SETUP_GENTLY) {
+			int nongit_ok;
+			prefix =3D setup_git_directory_gently(&nongit_ok);
+		}
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
 			use_pager =3D check_pager_config(p->cmd);
--=20
1.7.0.4
