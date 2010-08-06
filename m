From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/12] var: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:21:40 -0500
Message-ID: <20100806032139.GO22369@burratino>
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
X-From: git-owner@vger.kernel.org Fri Aug 06 05:23:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDWX-00016t-Pj
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534Ab0HFDXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:23:04 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51757 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759148Ab0HFDXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:23:02 -0400
Received: by gxk23 with SMTP id 23so2718288gxk.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/oz6dgIqPFhSY3oUHTiZZNPU5EcLDZioImv2f9QmWCU=;
        b=RJNZmwCICDQ38c1IgwNkk2s5r0RI8Zyy1LyuNsar+RYlsvzW1FhUuPP9CMJK6uuL/+
         5krpxtoK35qqdUVJ7jS7gB63O5mDQSuCpOYv9BLWQE85Kucs7WYMlKbAzkGVzuPLiFLe
         Nnqw1V4ZMPAXrkikLKX4sJ4izp5jo/7QUin14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=m8EVkk1fHtI6uEU2/RpvJ8E7s6Wv5d/Za127aN9/H44DuylgpiB155dDQHf4DK1oHY
         +0dQ/rBsgenWhaUZyVJEGaz5e3u4mKWxrJSVgrW4NT7jjznw4kpXKOnv/cQKXjkj8Boy
         F5zbUynV4mpaHMYy5Lq3TbTMIJwx3qS+/6YMA=
Received: by 10.100.167.2 with SMTP id p2mr13015075ane.148.1281064981636;
        Thu, 05 Aug 2010 20:23:01 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id r7sm1295514anb.35.2010.08.05.20.22.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:23:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152756>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Part of a campaign to make repository-local configuration
available early (simplifying the startup sequence for
built-in commands).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
snuck in a little vertical compression while at it ;-)

 builtin/var.c |    9 ++-------
 git.c         |    2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 70fdb4d..0744bb8 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -74,14 +74,9 @@ static int show_config(const char *var, const char *=
value, void *cb)
=20
 int cmd_var(int argc, const char **argv, const char *prefix)
 {
-	const char *val;
-	int nongit;
-	if (argc !=3D 2) {
+	const char *val =3D NULL;
+	if (argc !=3D 2)
 		usage(var_usage);
-	}
-
-	setup_git_directory_gently(&nongit);
-	val =3D NULL;
=20
 	if (strcmp(argv[1], "-l") =3D=3D 0) {
 		git_config(show_config, NULL);
diff --git a/git.c b/git.c
index 63630e7..84bef76 100644
--- a/git.c
+++ b/git.c
@@ -398,7 +398,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
-		{ "var", cmd_var },
+		{ "var", cmd_var, RUN_SETUP_GENTLY },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
--=20
1.7.2.1.544.ga752d.dirty
