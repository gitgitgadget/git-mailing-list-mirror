From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] git-prompt.sh: Option to hide prompt for ignored pwd
Date: Wed, 15 Oct 2014 16:28:54 -0400
Message-ID: <543ED906.403@bbn.com>
References: <543D77CC.8060803@bbn.com>  <1412795040-19267-1-git-send-email-jess.austin@gmail.com> <5435A8A7.2030008@bbn.com>  <CANp8Xb8ETG-ZFCqrOk=f-RbxtRxehBmAR1O5ozLH80zimWq_Gw@mail.gmail.com>  <CANp8Xb9MUbQCVZRNYibFBibzTFF=56BqNFFC1G2iTF7WGBNi7g@mail.gmail.com>  <54361F30.8020603@bbn.com> <CANp8Xb_kdpzYjWZxoWFtT+UWwMPpFD0znkoEKVpdukGf61Preg@mail.gmail.com>  <5437078B.6020307@bbn.com> <1413253924-8065-1-git-send-email-jess.austin@gmail.com> <543D6FD7.3090306@kdbg.org> <1413345993-14393-1-git-send-email-jess.austin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jess Austin <jess.austin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:29:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeVBu-0004f0-JU
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 22:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbaJOU26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 16:28:58 -0400
Received: from smtp.bbn.com ([128.33.0.80]:59345 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbaJOU26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 16:28:58 -0400
Received: from socket.bbn.com ([192.1.120.102]:32818)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1XeVBn-0005zi-Al; Wed, 15 Oct 2014 16:28:55 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 15616402CA
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <1413345993-14393-1-git-send-email-jess.austin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-10-15 00:06, Jess Austin wrote:
> @@ -501,6 +506,13 @@ __git_ps1 ()
>  	local f="$w$i$s$u"
>  	local gitstring="$c$b${f:+$z$f}$r$p"
>  
> +	if [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED}" ] &&
> +	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
> +	   git check-ignore -q .
> +	then
> +		printf_format=""
> +	fi
> +
>  	if [ $pcmode = yes ]; then
>  		if [ "${__git_printf_supports_v-}" != yes ]; then
>  			gitstring=$(printf -- "$printf_format" "$gitstring")

This is broken in pcmode due to a Bash bug.  The command:
    printf -v foo "" asdf
is a no-op in Bash.  The variable foo is never changed in any way --
it is neither unset nor set to the empty string.

Also, I noticed that I get an error message if I cd into .git:
    fatal: This operation must be run in a work tree

I think the following change will fix the above issues, and it has the
advantage of avoiding unnecessary work if the directory is ignored:

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 6a4ce53..68ac82a 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -374,6 +374,17 @@ __git_ps1 ()
 	local inside_gitdir="${repo_info##*$'\n'}"
 	local g="${repo_info%$'\n'*}"
 
+	if [ "true" = "$inside_worktree" ] &&
+	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED}" ] &&
+	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
+	   git check-ignore -q .
+	then
+		if [ $pcmode = yes ]; then
+			PS1="$ps1pc_start$ps1pc_end"
+		fi
+		return
+	fi
+
 	local r=""
 	local b=""
 	local step=""
@@ -506,13 +517,6 @@ __git_ps1 ()
 	local f="$w$i$s$u"
 	local gitstring="$c$b${f:+$z$f}$r$p"
 
-	if [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED}" ] &&
-	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
-	   git check-ignore -q .
-	then
-		printf_format=""
-	fi
-
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
 			gitstring=$(printf -- "$printf_format" "$gitstring")

It would be good to add additional test cases for pcmode (two or three
arguments to __git_ps1) and 'cd .git' so that the above issues don't
reappear.

Thanks,
Richard
