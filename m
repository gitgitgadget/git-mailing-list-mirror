From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 7/9] ls-files: add --narrow-match=spec option to test
	narrow matching
Date: Fri, 15 Aug 2008 21:26:56 +0700
Message-ID: <20080815142656.GA10750@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0If-00069p-8w
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758918AbYHOO1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758909AbYHOO1N
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:27:13 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:30238 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255AbYHOO1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:27:11 -0400
Received: by yx-out-2324.google.com with SMTP id 8so740227yxm.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YqAbEfLR9FHKCgRfA7L1sg72ExiYM070IMp/Zexj5JA=;
        b=MDDefYS7e3TsZGTN+n3NlY7Hm7Kh4aS1Vsmytm8ap5Mo1zulTTwNw9tPx7HB1WJ+oc
         16ki6vI17f8Cj3P2G3a8RJ6C4VkBbHP2cSc912l4z2c7gxZUfIqwqrcdMDRM5/H0+obJ
         dw49wM5Jx1re70IWtrzpWC2PF3OQ+cwSkHiDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=P/d2O9FpHz+nvuprU/i7m7CM+6Tu634DKN5j1gg9rVwilks0EOYO7fFqg6ABwHzhNk
         /Gkcx1914As52umOfz27IW8pPe/tLG6k6PxNPzrzO1PIZszVAgVB/HyQ/lxL15YiPqKF
         DMaaFcvwYd0fmhfQXPkBvaRA4gPZp0SAGJ1qM=
Received: by 10.115.91.2 with SMTP id t2mr2564416wal.62.1218810429813;
        Fri, 15 Aug 2008 07:27:09 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id y11sm337883pod.5.2008.08.15.07.27.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:27:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:26:56 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92480>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index bcb1536..0064f73 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -29,6 +29,7 @@ static const char **pathspec;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
+static const char *narrow_spec;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -219,6 +220,7 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 	write_name_quoted(ce->name + offset, stdout, line_terminator);
 }
=20
+int match_narrow_spec(const char *spec_, const char *path); /* unpack-=
trees.c */
 static void show_files(struct dir_struct *dir, const char *prefix)
 {
 	int i;
@@ -248,6 +250,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 				continue;
 			if (show_checkout && ce_no_checkout(ce))
 				continue;
+			if (narrow_spec && !match_narrow_spec(narrow_spec, ce->name))
+				continue;
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
@@ -429,7 +433,7 @@ static const char ls_files_usage[] =3D
 	"git ls-files [-z] [-t] [-v] (--[cached|checkout|deleted|others|stage=
|unmerged|killed|modified])* "
 	"[ --ignored ] [--exclude=3D<pattern>] [--exclude-from=3D<file>] "
 	"[ --exclude-per-directory=3D<filename> ] [--exclude-standard] "
-	"[--full-name] [--abbrev] [--] [<file>]*";
+	"[--narrow-match=3Dnarrowspec] [--full-name] [--abbrev] [--] [<file>]=
*";
=20
 int cmd_ls_files(int argc, const char **argv, const char *prefix)
 {
@@ -472,6 +476,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			show_checkout =3D 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--narrow-match=3D")) {
+			narrow_spec =3D arg+15;
+			continue;
+		}
 		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted =3D 1;
 			continue;
--=20
1.6.0.rc3.250.g8dd0
