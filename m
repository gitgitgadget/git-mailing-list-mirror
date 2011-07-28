From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3] gitweb: Git config keys are case insensitive, make config search too
Date: Thu, 28 Jul 2011 23:38:03 +0200
Message-ID: <201107282338.04954.jnareb@gmail.com>
References: <20110727205118.10439.58875.stgit@localhost.localdomain> <7vtya6kvrz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 23:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmYHa-0000cG-4V
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 23:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab1G1ViO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 17:38:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54402 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab1G1ViM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 17:38:12 -0400
Received: by fxh19 with SMTP id 19so1636413fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=lXAIkRnfuwXkwetCuFtXgu5Les/bTCOgc77/JTYpkHk=;
        b=Wstdzy/4I2uN+reLjkvMAp14+C0ARblsxx2ARg/Tr/QdQDX0uzlQ0hZFGYgipCwbJk
         KKKnuaYOxW1MBoIcS98sety2MMjurK8hsZy5OXzVXvA8d4nSgII2uqxdDX/x9UKvWWvb
         IdtgW6tLxpoVVklcquJE5D5pokFTiVwnK1mTM=
Received: by 10.223.91.75 with SMTP id l11mr645443fam.66.1311889091446;
        Thu, 28 Jul 2011 14:38:11 -0700 (PDT)
Received: from [192.168.1.13] (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id 28sm717295fax.3.2011.07.28.14.38.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 14:38:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtya6kvrz.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178117>

"git config -z -l" that gitweb uses in git_parse_project_config() to
populate %config hash returns section and key names of config
variables in lowercase (they are case insensitive).  When checking
%config in git_get_project_config() we have to take it into account.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Thu, 28 Jul 2011, Junio C Hamano napisa=C5=82:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > "git config -z -l" that gitweb uses in git_parse_project_config() t=
o
> > populate %config hash returns section and key names of config
> > variables in lowercase (they are case insensitive).  When checking
> > %config in git_get_project_config() we have to take it into account=
=2E
> >
> > Gitweb does not (yet?) use git config variables with subsection, so=
 we
> > can simply lowercase $key in git_get_project_config (only subsectio=
n
> > names are case sensitive).
>=20
> Why stop there, I have to wonder, instead of futureproofing with mini=
mum
> cost, even with something na=C3=AFve like:
>=20
> 	if (my ($hi, $mi, $lo) =3D ($key =3D~ /^([^.]*)\.(.*)\.(.*)$)) {
> 		$key =3D join(".", lc($hi), $mi, lc($lo);
> 	} else {
>         	$key =3D lc($key);
> 	}

Well, I thought it would be more involved than this.

Anyway, here it is:

 gitweb/gitweb.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1070805..f858d1b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2526,6 +2526,13 @@ sub git_get_project_config {
=20
 	# key sanity check
 	return unless ($key);
+	# only subsection, if exists, is case sensitive,
+	# and not lowercased by 'git config -z -l'
+	if (my ($hi, $mi, $lo) =3D ($key =3D~ /^([^.]*)\.(.*)\.([^.]*)$/)) {
+		$key =3D join(".", lc($hi), $mi, lc($lo));
+	} else {
+		$key =3D lc($key);
+	}
 	$key =3D~ s/^gitweb\.//;
 	return if ($key =3D~ m/\W/);
=20
--=20
1.7.5
