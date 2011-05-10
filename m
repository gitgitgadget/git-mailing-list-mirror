From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] completion: move private shopt shim for zsh to __git_
 namespace
Date: Mon, 9 May 2011 22:00:27 -0500
Message-ID: <20110510030027.GC26619@elie>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
 <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
 <20110510025529.GA26619@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 05:00:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJdBe-00024M-OY
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 05:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab1EJDAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 23:00:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42528 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab1EJDAd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 23:00:33 -0400
Received: by iwn34 with SMTP id 34so4859174iwn.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 20:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5xAMEh8u14T+jHUfhsD8QXJg01V2O0ub1wFmPd4YP6M=;
        b=p6OT+x+ZFDj1mH9aroRJh9A67viGQvpUMQT3t6efPFbjWp+SFCPoSr/W7FbreQcX+w
         hVE51YPmsudD8Hm7xX9l0ytW17VuJlug0jy1MkDfkzBlqxGzKuRNdBeDxiGvvh0iSDH0
         SJII7CkR2RFdbzNHALDyf3oQx2bcWho7Y7jtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fbFJ2/l/P697EGwh9iYy2+q+f+BdE9bJTP0URJ2IqhlCoOnGQ5dinPGzx+Y7Ycu0Pz
         SbZNVrAvJryAQ9px5gAqj2OmOsSTPpSUJLGqhvhuagVFXR+xHr6nqNzqeHZBCu2X/EzE
         ZTYRYulsFTmGdHVOqVOx7S8RqcO4gtDZ8sP0Q=
Received: by 10.42.144.65 with SMTP id a1mr263619icv.63.1304996431550;
        Mon, 09 May 2011 20:00:31 -0700 (PDT)
Received: from elie (wireless-165-232.uchicago.edu [128.135.165.232])
        by mx.google.com with ESMTPS id uh10sm2658083icb.6.2011.05.09.20.00.29
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 20:00:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110510025529.GA26619@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173301>

Most zsh users probably probably do not expect a custom shopt function
to enter their environment just because they ran "source
~/.git-completion.sh".

Such namespace pollution makes development of other scripts confusing
(because it makes the bash-specific shopt utility seem to be available
in zsh) and makes git's tab completion script brittle (since any other
shell snippet implementing some other subset of shopt will break it).
Rename the shopt shim to the more innocuous __git_shopt to be a good
citizen (with two underscores to avoid confusion with completion rules
for a hypothetical "git shopt" command).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
Thanks again.

 contrib/completion/git-completion.bash |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index da586e5..a236234 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -628,12 +628,12 @@ __git_refs_remotes ()
 __git_remotes ()
 {
 	local i ngoff IFS=3D$'\n' d=3D"$(__gitdir)"
-	shopt -q nullglob || ngoff=3D1
-	shopt -s nullglob
+	__git_shopt -q nullglob || ngoff=3D1
+	__git_shopt -s nullglob
 	for i in "$d/remotes"/*; do
 		echo ${i#$d/remotes/}
 	done
-	[ "$ngoff" ] && shopt -u nullglob
+	[ "$ngoff" ] && __git_shopt -u nullglob
 	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.url'=
 2>/dev/null); do
 		i=3D"${i#remote.}"
 		echo "${i/.url*/}"
@@ -2701,7 +2701,7 @@ complete -o bashdefault -o default -o nospace -F =
_git git.exe 2>/dev/null \
 fi
=20
 if [[ -n ${ZSH_VERSION-} ]]; then
-	shopt () {
+	__git_shopt () {
 		local option
 		if [ $# -ne 2 ]; then
 			echo "USAGE: $0 (-q|-s|-u) <option>" >&2
@@ -2724,4 +2724,8 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 			return 1
 		esac
 	}
+else
+	__git_shopt () {
+		shopt "$@"
+	}
 fi
--=20
1.7.5.1
