From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Convert read_tree{,_recursive} to support struct
 pathspec
Date: Thu, 24 Mar 2011 21:49:52 +0700
Message-ID: <20110324144952.GA24388@do>
References: <AANLkTinYB=ZUTe29Y9ibLVL5z3KhiYmnCpCGcHx=18RJ@mail.gmail.com>
 <1300977675-6243-1-git-send-email-pclouds@gmail.com>
 <1300977675-6243-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 15:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2lre-0006hG-TG
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 15:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029Ab1CXOuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 10:50:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37907 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932726Ab1CXOuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 10:50:04 -0400
Received: by iwn34 with SMTP id 34so14053iwn.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CFrDx4sALFUIf/HlyVfbCPMw7/t/naJHirC8dQ5uh9Y=;
        b=MsCcPakdbXb2oudykvWhNX5GM4CrvNFxZuyVZxTmOBXoErIG8ktOnb2su47GzgLP4m
         DsiNNABNN2+J1jWPtz0L0sqCUH/dtHk1Q8OS333KAofTAEC1wAcTgTj32qLEiF4wdEoC
         FryS7wbCZTJG3sZD0DiXGeYDVBFGT4zbeNIHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tx4zh7rjpa3EwSqSk7EhPAkpLgFNV+zT3gwVSfHcawxYihUxAgVnKzfxXm4XZRyH+3
         mxBoVnTtZHaT7iDW0p0OwaEDjlZSX45Qv8b4t2tTQrDgwrybJ4SXnYY2daHT6jbKyrdW
         TRB3Zzk4FpWxbuU/EZGoqMge3nqavoams2YhI=
Received: by 10.42.18.67 with SMTP id w3mr5350836ica.470.1300978203510;
        Thu, 24 Mar 2011 07:50:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.209.201])
        by mx.google.com with ESMTPS id c1sm5860119ibe.15.2011.03.24.07.49.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 07:50:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Mar 2011 21:49:52 +0700
Content-Disposition: inline
In-Reply-To: <1300977675-6243-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169921>

On Thu, Mar 24, 2011 at 09:41:15PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> All callers are updated.

Jeez.. I made last minute changes and it broke something. This should
be squashed in, because tree_entry_interesting() does not like struct
pathspec* =3D=3D NULL.

--8<--
diff --git a/builtin/log.c b/builtin/log.c
index 796e9e5..cff39cf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -396,6 +396,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 	struct rev_info rev;
 	struct object_array_entry *objects;
 	struct setup_revision_opt opt;
+	struct pathspec match_all;
 	int i, count, ret =3D 0;
=20
 	git_config(git_log_config, NULL);
@@ -403,6 +404,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 	if (diff_use_color_default =3D=3D -1)
 		diff_use_color_default =3D git_use_color_default;
=20
+	init_pathspec(&match_all, NULL);
 	init_revisions(&rev, prefix);
 	rev.diff =3D 1;
 	rev.always_show_header =3D 1;
@@ -449,7 +451,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			read_tree_recursive((struct tree *)o, "", 0, 0, NULL,
+			read_tree_recursive((struct tree *)o, "", 0, 0, &match_all,
 					show_tree_object, NULL);
 			rev.shown_one =3D 1;
 			break;
--8<--
--=20
Duy
