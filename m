From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/12] git wrapper: allow setup_git_directory_gently() be
 called earlier
Date: Thu, 5 Aug 2010 21:52:16 -0500
Message-ID: <20100806025216.GG22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 04:54:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhD4V-0001md-01
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 04:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935305Ab0HFCxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 22:53:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49314 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab0HFCxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 22:53:53 -0400
Received: by gxk23 with SMTP id 23so2713686gxk.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vzVsndIfIk9O7kuZrzphGkv+tFKtfIl4+RmcePl3QKM=;
        b=Mco6ReUpIH9M4D6gc825agZTSOcXcRzqk+Ks/FnWs9ROC/M+tpydwsIC70NkeCuQcO
         6VGRzRoGRcaD0XiCJjsgB0ASuc+mWghKn/IaM6CQemfrUZHfr4ldSdHHZWcOZXF+7pz2
         fS+bXaBPJZCofPA2BGvBoFlZqKyOxIhnrOeIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QeGbrliNqcrugA6ftIDrmA+NZAxOfLcYWN57KpcRxHRRuH6hrzY0RG0cUa4pk5z8Qb
         VO1k3t1LR2dSdO3CKP8yyH5/NDeDhmGXfWWHgeCDRhyAksxmSZ86L+lHdSIHj2idEfw/
         L+nwETtlncnk7Xsne0TDjPIHfN1//YqrkCqbo=
Received: by 10.150.55.28 with SMTP id d28mr13143434yba.223.1281063233068;
        Thu, 05 Aug 2010 19:53:53 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id w3sm914892ybl.21.2010.08.05.19.53.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 19:53:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152748>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

In the spirit of v1.4.2-rc3~34^2^2 (Call setup_git_directory() much
earlier, 2006-07-28), let run_builtin() take care of searching for a
repository for built-ins that want to make use of one if present.

So now you can mark your command with RUN_SETUP_GENTLY and use

	nongit =3D !startup_info->have_repository;

in place of

	prefix =3D setup_git_directory_gently(&nongit);

and everything will be the same, except the repository is
discovered a little sooner.

As v1.7.2~16^2 (2010-07-14) explains, this should allow more commands
to robustly use features like "git --paginate" that look at local
configuration before the command is actually run.

This patch sets up the infrastructure.  Later patches will teach
particular commands to use it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 - reordered setup option bits (RUN_SETUP_GENTLY lives next to RUN_SETU=
P now)

 - squashed in "builtin: check pager.<cmd> configuration if
   RUN_SETUP_GENTLY is used"

 git.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 8a8d2b2..c46c996 100644
--- a/git.c
+++ b/git.c
@@ -230,13 +230,14 @@ static int handle_alias(int *argcp, const char **=
*argv)
=20
 const char git_version_string[] =3D GIT_VERSION;
=20
-#define RUN_SETUP	(1<<0)
-#define USE_PAGER	(1<<1)
+#define RUN_SETUP		(1<<0)
+#define RUN_SETUP_GENTLY	(1<<1)
+#define USE_PAGER		(1<<2)
 /*
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NEED_WORK_TREE	(1<<2)
+#define NEED_WORK_TREE		(1<<3)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -255,8 +256,12 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
 	if (!help) {
 		if (p->option & RUN_SETUP)
 			prefix =3D setup_git_directory();
+		if (p->option & RUN_SETUP_GENTLY) {
+			int nongit_ok;
+			prefix =3D setup_git_directory_gently(&nongit_ok);
+		}
=20
-		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
+		if (use_pager =3D=3D -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY=
))
 			use_pager =3D check_pager_config(p->cmd);
 		if (use_pager =3D=3D -1 && p->option & USE_PAGER)
 			use_pager =3D 1;
--=20
1.7.2.1.544.ga752d.dirty
