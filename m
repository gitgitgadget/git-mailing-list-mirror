From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/12] ls-remote: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:20:08 -0500
Message-ID: <20100806032007.GN22369@burratino>
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
X-From: git-owner@vger.kernel.org Fri Aug 06 05:21:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDV8-0000no-UF
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933063Ab0HFDVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:21:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64334 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab0HFDVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:21:37 -0400
Received: by ywh1 with SMTP id 1so2693971ywh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sEIXZBGX2MlN6S4E/8gjLKEq/dpacZelKw17jDhL6wE=;
        b=a0hOhUEsWmVqtRGZApexmFZbNLW0yVw6iB9zHE+yGbwY65NXKyj6KxfMBOv2P2uMMD
         TRq6uwnFPvTI6povQYVyOv6uA6PghkVQRvqfm1GAFOhjS12ygwioM1DoBv6TSMD9bIZQ
         1dNLopw+wdoRUtYQ7iGCa62GzCjx4PL3hreYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Y92//aXcnzcyKaHp0xdSiISjWIuajHnyd+bD4xTBKOMvFh0qr2IkFkhiTBz/7lSRX5
         Kxuc4Wg/XuxhLMBpmq0oEIKfaGhDoanXA4yB/fYSO0nNRv6+SZfH0T14w3JScr2+gmlk
         vYTdU8sO7+o8Az7zHH9V6uyPFTvXyPKRzSpfY=
Received: by 10.100.164.6 with SMTP id m6mr13115854ane.54.1281064896739;
        Thu, 05 Aug 2010 20:21:36 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t24sm1292297ano.32.2010.08.05.20.21.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:21:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152755>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

ls-remote already runs a repository search unconditionally to learn
about remote nicknames and "[url] insteadof" shortcuts.  Run that
search a little sooner, and now one can try

	[pager]
		ls-remote

to automatically paginate ls-remote output, or use repository-local

	[core]
		pager =3D whatever

with "git --paginate ls-remote <url>".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before, aside from the commit message.

 builtin/ls-remote.c |    3 ---
 git.c               |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 34480cf..97eed40 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -32,7 +32,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 {
 	int i;
 	const char *dest =3D NULL;
-	int nongit;
 	unsigned flags =3D 0;
 	int quiet =3D 0;
 	const char *uploadpack =3D NULL;
@@ -42,8 +41,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
=20
-	setup_git_directory_gently(&nongit);
-
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
diff --git a/git.c b/git.c
index 92ec5d3..63630e7 100644
--- a/git.c
+++ b/git.c
@@ -345,7 +345,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-		{ "ls-remote", cmd_ls_remote },
+		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
@@ -366,7 +366,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 		{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
 		{ "patch-id", cmd_patch_id },
-		{ "peek-remote", cmd_ls_remote },
+		{ "peek-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
--=20
1.7.2.1.544.ga752d.dirty
