From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9] Revert "rehabilitate 'git index-pack' inside the
 object store"
Date: Sat, 24 Jul 2010 06:30:49 -0500
Message-ID: <20100724113049.GB16338@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OccxU-0007af-F7
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab0GXLb4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 07:31:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51337 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab0GXLbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:31:55 -0400
Received: by iwn7 with SMTP id 7so1100480iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TDDV+LxvpsDvEnpV9Y/EVe9n6GDfgqiJFiXFgvphcwc=;
        b=CX1cS6k/gUKwyBgetu5r07RdjZB4kTLYPRSSuNwS7TVt7gnRFMh8Y0iGOnp5VqpbjC
         GmVFQ4LRaIwqrLwiiL16H5qPIxT/XvKz/89Lexw5slnd10myy0I1ntteCiJcfLjAJJy7
         EaS/U/Zk49w39NX1NLgGB45VQHn/xAfSJX8Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NhDvEsdGFkpn5YbzJcXXDZjl1WdIKXGxQYMHibCFOeCvu2n6HC2XPOsfA9G8thj3Vo
         ZM6q8bcrzSdBXwcfwHALqWyoAaUFLCDS4J1Gms+1kC436BoSSfe4raL2mU6HmLksO14/
         Z4reXgN2nE8ybpalpxDmec2P/0p/PjWtVbJxA=
Received: by 10.231.139.212 with SMTP id f20mr5080187ibu.166.1279971110457;
        Sat, 24 Jul 2010 04:31:50 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm1261042ibe.11.2010.07.24.04.31.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:31:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151620>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Now setup_git_directory_gently behaves sanely even from subdirs of
=2Egit, so simplify index-pack by no longer protecting against that.

This reverts commit a672ea6ac5a1b876bc7adfe6534b16fa2a32c94b
(excluding tests).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series.  Thanks for reading.

Good night,
Jonathan

 builtin/index-pack.c |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a89ae83..89a1f12 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -880,29 +880,15 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
+	int nongit;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
=20
-	/*
-	 * We wish to read the repository's config file if any, and
-	 * for that it is necessary to call setup_git_directory_gently().
-	 * However if the cwd was inside .git/objects/pack/ then we need
-	 * to go back there or all the pack name arguments will be wrong.
-	 * And in that case we cannot rely on any prefix returned by
-	 * setup_git_directory_gently() either.
-	 */
-	{
-		char cwd[PATH_MAX+1];
-		int nongit;
-
-		if (!getcwd(cwd, sizeof(cwd)-1))
-			die("Unable to get current working directory");
-		setup_git_directory_gently(&nongit);
-		git_config(git_index_pack_config, NULL);
-		if (chdir(cwd))
-			die("Cannot come back to cwd");
-	}
+	prefix =3D setup_git_directory_gently(&nongit);
+	git_config(git_index_pack_config, NULL);
+	if (prefix && chdir(prefix))
+		die("Cannot come back to cwd");
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
--=20
1.7.2.rc3.593.g19611.dirty
