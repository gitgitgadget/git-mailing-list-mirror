From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: workdirs: cannot clone a local workdir directory
Date: Wed, 15 Jul 2015 20:25:52 +0700
Message-ID: <20150715132552.GA28574@lanh>
References: <CA+cck7GR1Gs+OvhweQZFs0=5uKu=RwEgY=0_0CZSCDqtDWrR2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: bjornar@snoksrud.no
X-From: git-owner@vger.kernel.org Wed Jul 15 15:25:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFMgP-0001o0-GV
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 15:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbbGONZC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2015 09:25:02 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34641 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbGONZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 09:25:00 -0400
Received: by pacan13 with SMTP id an13so24428423pac.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sn+fVQRyB+ZmWny7gZo5zZmc5TOOorgsCxsFFu6RiKQ=;
        b=w3ilzVKfwZX5m+MoCG6R7jdcsg5zqNoqmnz90QWQ8ed4SNhO3pzUIW0X9eez6f4G7v
         tFTYbRHoThVcRLJPvMlhlcTHkwywCrJQU0dWV1o+oNRGg+so1jZ0tnP+TyVAT9ZcI++Y
         leDfekYGxc/QBZYHNCY2qpCKs5tRyikq1gfS3EsMnpmdkmfAdOtJS/aBa8m9ByYZUy7W
         UznXH1CShZeV1owQJRXJbweXmKZSRxI9UL3EuOt1lsic+oe/W0t2pymzN8NplpNXR8gY
         x/GH7iiDkTC7zhOEyiMpk0xeILdMNqOvHFCqAhJdV6YW+6ofYQXfopb87WES+dv33oTb
         fz9Q==
X-Received: by 10.67.3.9 with SMTP id bs9mr8207665pad.136.1436966700427;
        Wed, 15 Jul 2015 06:25:00 -0700 (PDT)
Received: from lanh ([115.73.0.251])
        by smtp.gmail.com with ESMTPSA id u8sm4742748pdj.46.2015.07.15.06.24.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2015 06:24:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 15 Jul 2015 20:25:52 +0700
Content-Disposition: inline
In-Reply-To: <CA+cck7GR1Gs+OvhweQZFs0=5uKu=RwEgY=0_0CZSCDqtDWrR2A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273985>

On Wed, Jul 15, 2015 at 11:40:18AM +0200, Bj=F8rnar Snoksrud wrote:
> I reported this before, but now I have a nice topic to hang it on -
>=20
> I have re-reproduced the bug using a build from master as of today,
> using the new worktree commands.

Something like the following patch should work if you need it now.

Because this may conflict (in the test cases) with Eric's series to
move "git checkout --to" to "git worktree add", and because the next
release is already delayed to let "git worktree add" in, I think we
could keep this patch out of tree for now. I will split it up, add
tests and resubmit once the release is out. Please remind me if you
see nothing from me for too long.

Note to self, "git clone --reference" remains broken.

-- 8< --
diff --git a/builtin/clone.c b/builtin/clone.c
index 00535d0..0e594f1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -373,8 +373,10 @@ static void clone_local(const char *src_repo, cons=
t char *dest_repo)
 	} else {
 		struct strbuf src =3D STRBUF_INIT;
 		struct strbuf dest =3D STRBUF_INIT;
-		strbuf_addf(&src, "%s/objects", src_repo);
-		strbuf_addf(&dest, "%s/objects", dest_repo);
+		get_common_dir(&src, src_repo);
+		get_common_dir(&dest, dest_repo);
+		strbuf_addstr(&src, "/objects");
+		strbuf_addf(&dest, "/objects");
 		copy_or_link_directory(&src, &dest, src_repo, src.len);
 		strbuf_release(&src);
 		strbuf_release(&dest);
diff --git a/path.c b/path.c
index 10f4cbf..7f7b56f 100644
--- a/path.c
+++ b/path.c
@@ -416,18 +416,22 @@ const char *enter_repo(const char *path, int stri=
ct)
 		}
 		if (!suffix[i])
 			return NULL;
-		gitfile =3D read_gitfile(used_path) ;
+		gitfile =3D read_gitfile(used_path);
 		if (gitfile)
 			strcpy(used_path, gitfile);
 		if (chdir(used_path))
 			return NULL;
 		path =3D validated_path;
 	}
-	else if (chdir(path))
-		return NULL;
+	else {
+		const char *gitfile =3D read_gitfile(used_path);
+		if (gitfile)
+			path =3D gitfile;
+		if (chdir(path))
+			return NULL;
+	}
=20
-	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
-	    validate_headref("HEAD") =3D=3D 0) {
+	if (is_git_directory(".")) {
 		set_git_dir(".");
 		check_repository_format();
 		return path;
-- 8< --
