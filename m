From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] commit: add --cleanup=scissors
Date: Sat, 22 Feb 2014 07:58:56 +0700
Message-ID: <20140222005856.GA9231@lanh>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
 <1392639332-7703-1-git-send-email-pclouds@gmail.com>
 <1392639332-7703-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 01:58:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH0vT-0004KB-If
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 01:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbaBVA6k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Feb 2014 19:58:40 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:60529 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbaBVA6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 19:58:39 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so4167655pab.16
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 16:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xYwVz3HyTsOpl2JtGiktq/1W9aJdIuqvzSlSFaPshfY=;
        b=mpKglYaFq663rWBXEHeiyaiyJBqobHO5Rdx8FZnHK7eDAIe7EaJxvpuhn/lMH6hYQQ
         ez6WRrzQps2Re18f81MvPrHapkj58ppdKSPcRr40iufgMmI/VagbcFvxZWTFMJ8LcgGN
         wQ6PsTamm1eephfiXAIAKRGb9RkQfxeAAMaUn2MyIhp9aLrcjq0TK3Gs22PPAJTer/nr
         7yNI0CUBW4nGCM+8PrZmenAZkdguGVnWduxbyrZagBVUCe4uTCRgSlvITQ5F//CRk6f6
         nPuUQMa7u7OKx7s2JctvzGN7Gm1icx3ByO0Tu+MYZRa2KnLdB7FRIw0sgfyIJWmpapUM
         zyiw==
X-Received: by 10.68.164.229 with SMTP id yt5mr12432772pbb.28.1393030718883;
        Fri, 21 Feb 2014 16:58:38 -0800 (PST)
Received: from lanh ([115.73.213.219])
        by mx.google.com with ESMTPSA id c7sm25557209pbt.0.2014.02.21.16.58.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 16:58:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Feb 2014 07:58:56 +0700
Content-Disposition: inline
In-Reply-To: <1392639332-7703-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242497>

On Mon, Feb 17, 2014 at 07:15:32PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> @@ -777,6 +778,8 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>  				_("Please enter the commit message for your changes."
>  				  " Lines starting\nwith '%c' will be ignored, and an empty"
>  				  " message aborts the commit.\n"), comment_line_char);
> +		else if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
> +			wt_status_add_cut_line(s->fp);
>  		else /* CLEANUP_SPACE, that is. */
>  			status_printf(s, GIT_COLOR_NORMAL,
>  				_("Please enter the commit message for your changes."

This cut line does not cover the merge conflict message before it. The
following patch should be squashed in to move the cut line up in that
case.

-- 8< --
diff --git a/builtin/commit.c b/builtin/commit.c
index ea2912f..1033c50 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -755,7 +755,9 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
 	if (use_editor && include_status) {
 		char *ai_tmp, *ci_tmp;
-		if (whence !=3D FROM_COMMIT)
+		if (whence !=3D FROM_COMMIT) {
+			if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
+				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence =3D=3D FROM_MERGE
 				? _("\n"
@@ -771,6 +773,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 				git_path(whence =3D=3D FROM_MERGE
 					 ? "MERGE_HEAD"
 					 : "CHERRY_PICK_HEAD"));
+		}
=20
 		fprintf(s->fp, "\n");
 		if (cleanup_mode =3D=3D CLEANUP_ALL)
@@ -778,7 +781,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\nwith '%c' will be ignored, and an empty"
 				  " message aborts the commit.\n"), comment_line_char);
-		else if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
+		else if (cleanup_mode =3D=3D CLEANUP_SCISSORS && whence =3D=3D FROM_=
COMMIT)
 			wt_status_add_cut_line(s->fp);
 		else /* CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
-- 8< --
