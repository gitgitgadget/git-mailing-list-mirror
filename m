From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] builtins: setup repository before print unknown
 command error
Date: Fri, 26 Mar 2010 15:58:48 -0500
Message-ID: <20100326205848.GB11395@progeny.tock>
References: <1269524295-24569-1-git-send-email-pclouds@gmail.com>
 <1269524295-24569-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 22:06:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvGiZ-0004oH-Og
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 22:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab0CZVFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 17:05:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab0CZVFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 17:05:15 -0400
Received: by pwi5 with SMTP id 5so5438512pwi.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jiTx2xCCkb4sCooglvufrvggIYtl4KDgrEsa97t09+w=;
        b=QkbwnDMbLZJYeLy2U127Q8/VIVGD332liXifheL3jGCGio/upQKXS/fzixe6wAeYUn
         8LW9bCZQHZCZKW3TzbaRsiU9DtvoXN2v/TmmSoKk/U2DZG2u0iwC10c6agy+EcmsdIsV
         R0cHOvxCX3Uc5TrVJwDD69pxhwtbJy+H6Kim0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hOP7ldSVvUHEi5Orjh4JR1Zm/+Wvq0nHChzf24pMb6V0tB+bVM1nsEZMUk389wzKAn
         7tNBVmYTz5YQ8me9ExGr21d1N1LBuiEV1O2IWIS5EFVmRtV4xPHOBg3PsKvfOJZUuLRX
         pPBmWflmfIMVsHNAIdPwqxW89JLpmeNKV4Sd4=
Received: by 10.141.88.15 with SMTP id q15mr1564877rvl.241.1269637112916;
        Fri, 26 Mar 2010 13:58:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1121306iwn.13.2010.03.26.13.58.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 13:58:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269524295-24569-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143285>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> As it is now, because
>  - alias handling will always be done before help_unknown_cmd()
>  - alias handling code will search and set up repository if found
>  - alias handline code will not undo repository setup
>=20
> These ensure that repository will always be set up (or attempted to
> set up) before help_unknown_cmd(), so there is no issue. But the setu=
p
> dependency here is subtle. It may break some day if someone reorders
> the loop, for example.

It took me a while to figure out what was going on here.  I think it is
too complicated.  Could it make sense to use

	/*
	 * help_unknown_cmd() requires that the repository has searched
	 * for and set up if found.
	 * Luckily, the alias handling code already took care of this.
	 */
	if (!startup_info->have_run_setup_gitdir)
		die("internal error handling unknown command");

instead, to document the current assumption?

Alternatively, one might add a new ensure_git_directory_is_set_up() fun=
ction
that only runs setup_git_repository_gently if it has not already been r=
un.
I do not like that so much --- too easy to hide bugs.

Better to run setup_git_repository_gently once unconditionally, before
handle_argv.  Unfortunately, that breaks git-init.  Actually, the curre=
nt
series breaks git-init when run through an alias.

Thoughts?

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6757734..792abe2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -33,6 +33,21 @@ test_expect_success 'plain' '
 	check_config plain/.git false unset
 '
=20
+test_expect_failure 'plain through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
+		HOME=3D$(pwd)/alias-config &&
+		export HOME &&
+		mkdir alias-config &&
+		echo "[alias] aliasedinit =3D init" >alias-config/.gitconfig &&
+		mkdir plain-aliased &&
+		cd plain-aliased &&
+		git aliasedinit
+	) &&
+	check_config plain-aliased/.git false unset
+'
+
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
 		unset GIT_DIR
