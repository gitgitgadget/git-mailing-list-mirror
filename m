From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git ls-files --error-unmatch weirdness
Date: Fri, 12 Aug 2011 21:17:33 +0700
Message-ID: <CACsJy8D0-SqSY0q2hJ0+w_NeT_s0Uza=Bi8-y37EKWE2VZhYeQ@mail.gmail.com>
References: <20110812132436.GA12147@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 12 16:18:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrsYt-0000tT-Pa
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 16:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab1HLOSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 10:18:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39989 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab1HLOSF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2011 10:18:05 -0400
Received: by bke11 with SMTP id 11so1679915bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cVe2tTsbr3KPSABGlSAyO7lfKhFtokm8ne4F/m8isZ0=;
        b=OThXSODiYSI0dBKDHMEiomckh53bAKNwSPZgIBY8NAbYaL4ZNTjOeE1Nzn+DnSjn9x
         VdZuaqcA2XxvsyffRljireiRM9oYyz/Y+6CUqCjOCpT2VcU22LH+TV7YgL70u7CRcvAF
         jQDJQ7CE1f8DTmzljNMbV2r0/jai6lybeGShY=
Received: by 10.204.143.24 with SMTP id s24mr21025bku.105.1313158683272; Fri,
 12 Aug 2011 07:18:03 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Fri, 12 Aug 2011 07:17:33 -0700 (PDT)
In-Reply-To: <20110812132436.GA12147@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179230>

2011/8/12 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> So, the same 'git ls-files' command is OK when run at the top of the
> worktree, but errors out in a subdirectory. =C2=A0What's going on? =C2=
=A0Is this
> a bug? =C2=A0If not, why not?

report_path_error() in ls-files.c is meant to check pathspecs given by
user. However when in a subdir, get_pathspec() automatically adds a
pathspec (that is prefix). This new pathspec confuses
report_path_error(). The following patch may help (possibly corrupted
because I paste in gmail, but you get the idea)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 0e98bff..e0611ac 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -545,7 +545,8 @@ int cmd_ls_files(int argc, const char **argv,
const char *cmd_prefix)
 	max_prefix_len =3D max_prefix ? strlen(max_prefix) : 0;

 	/* Treat unmatching pathspec elements as errors */
-	if (pathspec && error_unmatch) {
+	if (pathspec && error_unmatch &&
+	    (!prefix || pathspec[1])) {
 		int num;
 		for (num =3D 0; pathspec[num]; num++)
 			;

--=20
Duy
