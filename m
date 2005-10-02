From: Blaisorblade <blaisorblade@yahoo.it>
Subject: StGit command completions - and Git ones?
Date: Sun, 2 Oct 2005 13:03:44 +0200
Message-ID: <200510021303.44960.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q67PD2LaizDb1Uu"
X-From: git-owner@vger.kernel.org Sun Oct 02 13:05:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM1da-0000jO-1x
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 13:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVJBLD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 07:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVJBLD6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 07:03:58 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:43886 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751075AbVJBLD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2005 07:03:58 -0400
Received: (qmail 94247 invoked from network); 2 Oct 2005 11:03:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Message-Id;
  b=D/3FwVDBqcnP+wJCH6df+p/D/c4u39AJPraB9EKGdxLQf2Ui3/QX06qz8U9i62Z3fNQGbP0Bw1+mAZz9flmy0TuOd1ZWZSK86E+nmz3uFI3qx4678O4m4QBWj25IIgF1xnps3LINtjMdqkLMj1IEVxSQHSQNz8yCYL4h2xjzSag=  ;
Received: from unknown (HELO zion.home.lan) (blaisorblade@62.11.75.57 with login)
  by smtp004.mail.ukl.yahoo.com with SMTP; 2 Oct 2005 11:03:55 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
User-Agent: KMail/1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9615>

--Boundary-00=_Q67PD2LaizDb1Uu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I noticed in your TODO you talk about adding command line completions. I've 
been doing it for my needs, and the thing is still very incomplete, even if 
it's not a "XXX hack hack hack", and I wanted to send this first draft.

Note: I've not tried to add any completion which isn't StGit specific:
a) I didn't need them

b) they should be implemented for git and cogito first

c) not everything is clear. For instance, I think that SHA1 completion is 
pretty useless (I never type a SHA1), while only branch and tag completion 
is, but maybe other disagree: there's support for it in Cogito, in fact, and 
a shortened SHA1 is used as kernel revision.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_Q67PD2LaizDb1Uu
Content-Type: text/plain;
  charset="us-ascii";
  name="stg-compl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="stg-compl"

_stg () 
{
	local cur cmd cmds 
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=()
	if [ $COMP_CWORD -eq 1 ]; then
		cmds=$(stg help|tail +4|awk '{print $1}')
		COMPREPLY=( $(compgen -W "${cmds}" -- $cur) )
	else
		local cmd=${COMP_WORDS[1]}
		local prev=${COMP_WORDS[COMP_CWORD-1]}
		#if [ $COMP_CWORD -eq 2 -o "$prev" = "-t" -o "$prev" = "--to" -o "$prev" = "-r" ]; then
		local patches
		#Add -b support - pass "-b branch" to unapplied and applied.
		case $cmd in
			push)
			patches=$(stg unapplied)
			;;
			pop|mail)
			patches=$(stg applied)
			;;
			diff|id)
			patches=$((stg applied; stg unapplied)|while read i; do echo $i/; done)
			;;
		esac
		case $cmd in
			push)
			if [ "$prev" = "-t" -o "$prev" = "--to" ]; then
				if [ "${cur#*:}" != "${cur}" ]; then
					COMPREPLY=( $(compgen -W "${patches}" -- ${cur#*:}) )
				else
					COMPREPLY=( $(compgen -W "${patches}" -- $cur) )
				fi
			else
				cmds="-a --all -n --number -t --to --reverse --undo -h --help"
				COMPREPLY=( $(compgen -W "${cmds} ${patches}" -- $cur) )
			fi
			;;

			pop)
			if [ "$prev" = "-t" -o "$prev" = "--to" ]; then
				COMPREPLY=( $(compgen -W "${patches}" -- $cur) )
			else
				cmds="-a --all -n --number -t --to -h --help"
				COMPREPLY=( $(compgen -W "${cmds}" -- $cur) )
			fi
			;;

			mail)
			if [ "$prev" = "-r" -o "$prev" = "--range" ]; then
				if [ "${cur#*:}" != "${cur}" ]; then
					COMPREPLY=( $(compgen -W "${patches}" -- ${cur#*:}) )
				else
					COMPREPLY=( $(compgen -W "${patches}" -- $cur) )
				fi
			else
				cmds="-a --all -r --range --to --cc --bcc -v --version \
				-t --template -f --first -s --sleep --refid -u --smtp-user \
				-p --smtp-password -b --branch -h --help"

				COMPREPLY=( $(compgen -o bashdefault -W "${cmds} ${patches}" -- $cur) )
			fi
			;;
			diff)
			if [ "$prev" = "-r" ]; then
				if [ "${cur#*:}" != "${cur}" ]; then
					COMPREPLY=( $(compgen -W "${patches}" -- ${cur#*:}) )
				else
					COMPREPLY=( $(compgen -W "${patches}" -- $cur) )
				fi
			else
				cmds="-r -s --stat -h --help"

				COMPREPLY=( $(compgen -W "${cmds}" -- $cur) )
			fi
			;;
			id)
				cmds="-b --branch -h --help"
				COMPREPLY=( $(compgen -W "${cmds} ${patches}" -- $cur) )
			;;
			*)
			COMPREPLY=( $(compgen -f -- $cur) )
			;;
		esac
		#else
			#COMPREPLY=( $(compgen -f -- $cur) )
		#fi
	fi
}

complete -o default -F _stg stg

# vi: set ft=sh:

--Boundary-00=_Q67PD2LaizDb1Uu--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
