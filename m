From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 17/21] Convert refresh_index to take struct pathspec
Date: Fri, 11 Jan 2013 21:19:39 +0700
Message-ID: <20130111141939.GA28448@lanh>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
 <1357903275-16804-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 15:19:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtfSW-0006PI-OZ
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 15:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab3AKOT2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 09:19:28 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:39692 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab3AKOT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 09:19:27 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so792277dak.6
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sSTsojFdRYrUQ2gGmCR2EzzNjwnVkojGyq7lCUO3msM=;
        b=XkTUnBHhlodA4e9DIhfT5aKaPl+loFjtsjGUjg9qK/nUr95r8jzJKTOxzcGGQ+ijZi
         unkFqMGzXI50OKWw2y3lM9KHbTIj/JljZLJ2ZHNJxTMWacGjuCRttvncz1OyyzSIuQ1H
         MG9Z2kK5gWnwz7Sbd9dhLJiwMN6JG3vWbQ3JuAlTUfpihHO9DYqWRVE86Ho9/STR9MNM
         C0dLdxDIvO/HBxi2BCMjw08xUpH1AeYirS5GP6pfcIScFKi1ed+NLzmnXlUQdu6ODcis
         NprM2o+UhfKAK91n1s14r1HUiSIvKqpoTBYmQAi6A9prxArDMxV14pdlkSQiDD8O/7AX
         6vVA==
X-Received: by 10.68.137.234 with SMTP id ql10mr227890630pbb.158.1357913967415;
        Fri, 11 Jan 2013 06:19:27 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id qt2sm2866918pbb.24.2013.01.11.06.19.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 06:19:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 21:19:39 +0700
Content-Disposition: inline
In-Reply-To: <1357903275-16804-18-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213217>

On Fri, Jan 11, 2013 at 06:21:11PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> -	for (i =3D 0; i < specs; i++) {
> +	for (i =3D 0; i < pathspec->nr; i++) {
>  		if (!seen[i])
> -			die(_("pathspec '%s' did not match any files"), pathspec[i]);
> +			die(_("pathspec '%s' did not match any files"), pathspec->raw[i])=
;
>  	}

This needs the following fixup on top. I don't want to send another
reroll just a couple hours after I flooded git@vger. I did not plan to
work on the series this soon but somehow another problem got me back
here.

-- 8< --
diff --git a/builtin/add.c b/builtin/add.c
index 1235eb9..e1bcdb9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -159,7 +159,8 @@ static void refresh(int verbose, const struct paths=
pec *pathspec)
 		      pathspec, seen, _("Unstaged changes after refreshing the index=
:"));
 	for (i =3D 0; i < pathspec->nr; i++) {
 		if (!seen[i])
-			die(_("pathspec '%s' did not match any files"), pathspec->raw[i]);
+			die(_("pathspec '%s' did not match any files"),
+			    pathspec->items[i].match);
 	}
         free(seen);
 }
-- 8< --

and the baaad reason: pathspec->items[] are sorted because of 86e4ca6
(tree_entry_interesting(): fix depth limit with overlapping pathspecs
- 2010-12-15). But raw[] are _not_. So raw[i] does not correspond to
item[i].

Now seen[] array returned from match_pathspec() has the order
corresponding to raw[]. On the other hand match_pathspec_depth()
returns seen[] corresponds to items[]. This patch converts
match_pathspec() to match_pathspec_depth() so we need to use the
correct pathspec array.

I'll put these explanation in the next reroll. And don't worry about
this subtle difference. My next email kills match_pathspec() for good.
