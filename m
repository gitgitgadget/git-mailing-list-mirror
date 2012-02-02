From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/4] completion: simplify __git_remotes
Date: Thu, 2 Feb 2012 03:05:29 -0600
Message-ID: <20120202090529.GD3823@burratino>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 10:06:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsscf-0002IT-OI
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 10:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab2BBJGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 04:06:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57161 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab2BBJFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 04:05:46 -0500
Received: by iacb35 with SMTP id b35so2855092iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HnEXs05HKwHiEXOYkucNZG5q07O99jlH8ahWDTOWes4=;
        b=Uc8RqxV+j7ByQIpT67VSydXi972TaKSaDvnW7XNVFvFFVjw7S/gbZy/gqJktTEKPz9
         piDWzMObUKkuTe4JzjEO80sz0LApdMxcA7POTEl7qmR/zAfZvmNZm6P4Rmgq0roSIcxo
         2xUq/fCX8aml305jQOjSeH1GYz6CuPjK/JUN8=
Received: by 10.42.152.134 with SMTP id i6mr1777383icw.27.1328173546499;
        Thu, 02 Feb 2012 01:05:46 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vr4sm12160534igb.1.2012.02.02.01.05.45
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 01:05:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189606>

Felipe Contreras wrote:

>   completion: simplify __git_remotes
>   completion: remove unused code

In the same spirit of stealing potential shortlog lines from Junio:

-- >8 --
From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: completion: use ls -1 instead of rolling a loop to do that ourselves

This simplifies the code a great deal.  In particular, it allows us to
get rid of __git_shopt, which is used only in this fuction to enable
'nullglob' in zsh.

[jn: squashed with a patch that actually gets rid of __git_shopt]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The diffstat says it all.

 contrib/completion/git-completion.bash |   37 +-------------------------------
 1 files changed, 1 insertions(+), 36 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 78be1958..4612dde9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -644,12 +644,7 @@ __git_refs_remotes ()
 __git_remotes ()
 {
 	local i ngoff IFS=$'\n' d="$(__gitdir)"
-	__git_shopt -q nullglob || ngoff=1
-	__git_shopt -s nullglob
-	for i in "$d/remotes"/*; do
-		echo ${i#$d/remotes/}
-	done
-	[ "$ngoff" ] && __git_shopt -u nullglob
+	test -d "$d/remotes" && ls -1 "$d/remotes"
 	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
 		i="${i#remote.}"
 		echo "${i/.url*/}"
@@ -2733,33 +2728,3 @@ if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
 complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
 	|| complete -o default -o nospace -F _git git.exe
 fi
-
-if [[ -n ${ZSH_VERSION-} ]]; then
-	__git_shopt () {
-		local option
-		if [ $# -ne 2 ]; then
-			echo "USAGE: $0 (-q|-s|-u) <option>" >&2
-			return 1
-		fi
-		case "$2" in
-		nullglob)
-			option="$2"
-			;;
-		*)
-			echo "$0: invalid option: $2" >&2
-			return 1
-		esac
-		case "$1" in
-		-q)	setopt | grep -q "$option" ;;
-		-u)	unsetopt "$option" ;;
-		-s)	setopt "$option" ;;
-		*)
-			echo "$0: invalid flag: $1" >&2
-			return 1
-		esac
-	}
-else
-	__git_shopt () {
-		shopt "$@"
-	}
-fi
-- 
1.7.9
