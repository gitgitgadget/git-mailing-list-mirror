From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH for maint] git-completion: fix zsh support
Date: Thu,  5 May 2011 22:52:24 +0300
Message-ID: <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
References: <20110505185907.GD1377@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 21:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4bL-0008Re-Jg
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab1EETwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 15:52:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60927 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1EETwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:52:38 -0400
Received: by eyx24 with SMTP id 24so775838eyx.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Qm8Ruv6bX2C/KfGqIGW7Fz35GjnVr1ofG4s/biItphA=;
        b=jKLE+6ck/3rdv8V87nIBL8T3edibVnmQdTd9Agb0tIYFrYpZAfLn3/NV7C1fWfJQsL
         w634loNxG888z2tFsBh8C0ocYIz9FkftXx6luUU3dT0NSj/yZTu5v02ShsrvG4eLc4RZ
         cR8VISSsHsMNLXSljSoZxdY+QIkckbVZ7R0CM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TvViOsGkc0V4VBPgoUjj4hKvYx4AP8iWTVEO3YiwnHHcTKXVg7id9lfZTR/WYh4/42
         iJBffd5hfGwEekAxN7wO6kzZ92lg586J83dbIUb6QiIqIECnltRzkNIDcDx1Yrl/UZ/i
         3SE+DogJBNYtEv0jUFvlYT9zLJAfyON4AYGmk=
Received: by 10.213.27.23 with SMTP id g23mr484784ebc.110.1304625157235;
        Thu, 05 May 2011 12:52:37 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 46sm733136ees.25.2011.05.05.12.52.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 12:52:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.1.g638e6
In-Reply-To: <20110505185907.GD1377@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172893>

It turns out 'words' is a special variable used by zsh completion.

There's probably a bug in zsh's bashcompinit:
http://article.gmane.org/gmane.comp.shells.zsh.devel/22546

But in the meantime we can workaround it by using 'typedef -h', which
gets rid of any special meaning.

Currently zsh is completely broken after commit da48616 (bash: get
--pretty=3Dm<tab> completion to work with bash v4), which introduced
_get_comp_words_by_ref() that comes from debian's bash_completion
scripts, and relies on the 'words' variable to behave like any normal
variable.

Comments-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

This patch is meant for the maintenance branch, so Szeder's patches are=
 not
required as dependency (althought they are good by themselves).

v2: fix _gitk() too as Szeder suggested.

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 840ae38..74c0b4d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2710,6 +2710,9 @@ _git ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# 'words' has special meaning in zsh; override that
+		typeset -h words
 	fi
=20
 	local cur words cword
@@ -2761,6 +2764,9 @@ _gitk ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# 'words' has special meaning in zsh; override that
+		typeset -h words
 	fi
=20
 	__git_has_doubledash && return
--=20
1.7.5.1.1.g638e6
