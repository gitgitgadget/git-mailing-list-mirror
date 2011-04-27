From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] completion: move private shopt shim for zsh to __git_
 namespace
Date: Wed, 27 Apr 2011 16:27:04 -0500
Message-ID: <20110427212704.GB18596@elie>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
 <20110427013534.GA14286@elie>
 <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
 <20110427064033.GB4226@elie>
 <BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
 <20110427091140.GB14849@elie>
 <BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
 <BANLkTikN7iMa_z7wRN8pUS07SMatpyoDPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:27:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFCGR-000553-7F
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 23:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab1D0V1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 17:27:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65264 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab1D0V1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 17:27:08 -0400
Received: by iwn34 with SMTP id 34so1710015iwn.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Cc3xqzGWu/qQKuCV//u/GpGQ05H4ZbsH2tinQ22T4Ko=;
        b=ozI8yh+76V9uZZQDZhYiq8j8gNiEgGev2886OwH2QtMJZKOMPB1ldVf+40pDHfFsUn
         yVbd8xN+g79nugARZN4cF1h8k1G+8++PxGlt5oAzzp33atVet9/0MdLJj2iuOjNZJEyj
         B8QP7HqmW88mzPOaHbtjuXfyrBy1i7FT/VtcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Pw6yX1El1bvh1hJuJfCoIS6zuQBZmldtbYr6D4r22ivSaZeYzsm5r7nors8x88S7+V
         gNw56t5OerLqA8G8bOOMef8TAGc9i4AXr6GrgAEGZUt9npobXRGS4mJYM4SctCPq6cb7
         KSRcgTiGs1Zf/eKeF6EUzhDNxdIJlc4CA+5wk=
Received: by 10.42.3.75 with SMTP id 11mr2061018icn.88.1303939628008;
        Wed, 27 Apr 2011 14:27:08 -0700 (PDT)
Received: from elie (adsl-69-209-61-200.dsl.chcgil.ameritech.net [69.209.61.200])
        by mx.google.com with ESMTPS id xe5sm390474icb.22.2011.04.27.14.27.06
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 14:27:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikN7iMa_z7wRN8pUS07SMatpyoDPQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172275>

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
---
Hi,

Felipe Contreras wrote:

> +++ b/contrib/completion/git-completion.bash
> @@ -75,6 +75,10 @@
> 
>  if [[ -n ${ZSH_VERSION-} ]]; then
>         autoload -U +X bashcompinit && bashcompinit
> +
> +       # 'words' has special meaning in zsh, and only typeset -h seems to
> +       # override that
> +       alias local="typeset -h"
>  fi
> 
>  case "$COMP_WORDBREAKS" in

The above would change the meaning of "local" in the user's
environment and in all shell snippets she sources later.  Are you sure
that's intended?

Actually the completion script already has a problem along the same
lines.  Thanks for a reminder.

 contrib/completion/git-completion.bash |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9150ea6..ab95690 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -629,12 +629,12 @@ __git_refs_remotes ()
 __git_remotes ()
 {
 	local i ngoff IFS=$'\n' d="$(__gitdir)"
-	shopt -q nullglob || ngoff=1
-	shopt -s nullglob
+	__git_shopt -q nullglob || ngoff=1
+	__git_shopt -s nullglob
 	for i in "$d/remotes"/*; do
 		echo ${i#$d/remotes/}
 	done
-	[ "$ngoff" ] && shopt -u nullglob
+	[ "$ngoff" ] && __git_shopt -u nullglob
 	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
 		i="${i#remote.}"
 		echo "${i/.url*/}"
@@ -2800,7 +2800,7 @@ complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
 fi
 
 if [[ -n ${ZSH_VERSION-} ]]; then
-	shopt () {
+	__git_shopt () {
 		local option
 		if [ $# -ne 2 ]; then
 			echo "USAGE: $0 (-q|-s|-u) <option>" >&2
@@ -2823,4 +2823,8 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 			return 1
 		esac
 	}
+else
+	__git_shopt () {
+		shopt "$@"
+	}
 fi
-- 
1.7.5
