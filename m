From: Adam Tkac <atkac@redhat.com>
Subject: Re: [PATCH v2] If `egrep` is aliased, temporary disable it in
 bash.completion
Date: Thu, 6 Dec 2012 15:05:42 +0100
Message-ID: <20121206140541.GA4892@redhat.com>
References: <20121129151418.GA19169@redhat.com>
 <7vpq2wqr3v.fsf@alter.siamese.dyndns.org>
 <7vk3t4qpoe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 15:06:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tgc6E-0005GV-LF
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 15:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674Ab2LFOGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 09:06:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29810 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab2LFOGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 09:06:33 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qB6E6REl017384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 6 Dec 2012 09:06:27 -0500
Received: from localhost (evileye.atkac.brq.redhat.com [10.34.4.30])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id qB6E6Q8D004520;
	Thu, 6 Dec 2012 09:06:26 -0500
Content-Disposition: inline
In-Reply-To: <7vk3t4qpoe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211166>

On Thu, Nov 29, 2012 at 09:33:53AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Adam Tkac <atkac@redhat.com> writes:
> >
> >> Subject: Re: [PATCH v2] If `egrep` is aliased, temporary disable it in bash.completion
> >
> > The code does not seem to do anything special if it is not aliased,
> > though, so "If ..." part does not sound correct; perhaps you meant
> > "just in case egrep is aliased to something totally wacky" or
> > something?
> >
> > The script seems to use commands other than 'egrep' that too can be
> > aliased to do whatever unexpected things.  How does this patch get
> > away without backslashing them all, like
> >
> > 	\echo ...
> >         \sed ...
> >         \test ...
> >         \: comment ...
> > 	\git args ...
> >
> > and still fix problems for users?  Can't the same solution you would
> > give to users who alias one of the above to do something undesirable
> > be applied to those who alias egrep?
> >
> > Puzzled...
> 
> Sorry for having been more snarky than necessary (blame it to lack
> of caffeine).  What I was trying to get at were:
> 
>  * I have this suspicion that this patch exists only because you saw
>    somebody who aliases egrep to something unexpected by the use of
>    it in this script, and egrep *happened* to be the only such
>    "unreasonable" alias.  The reporter may not have aliased echo or
>    sed away, or the aliases to these command *happened* to produce
>    "acceptable" output (even though it might have been slightly
>    different from unaliased one, the difference *happened* not to
>    matter for the purpose of this script).
> 
>  * To the person who observes the same aliasing breakage due to his
>    aliasing sed to something else, you would solve his problem by
>    telling him "don't do that, then".  If that is the solution, why
>    wouldn't it work for egrep?
> 
>  * The next person who aliased other commands this script uses in
>    such a way that the behaviour of the alias differs sufficiently
>    from the unaliased version, you will have to patch the file
>    again, with the same backslashing.  This patch is not a solution,
>    but a band-aid that only works for a particular case you
>    *happened* to have seen.
> 
>  * A complete solution that follows the direction this patch
>    suggests would involve backslashing *all* commands that can
>    potentially aliased away.  Is that really the direction we would
>    want to go in (answer: I doubt it)?  Is that the only approach to
>    solve this aliasing issue (answer: I don't know, but we should
>    try to pursue it before applying a band-aid that is not a
>    solution)?
> 
> Is there a way to tell bash "do not alias-expand from here up to
> there"?  Perhaps "shopt -u expand_aliases" upon entry and restore
> its original value when we exit, or something?
> 
> IOW, something along this line?

This won't work, unfortunately, because shopt settings aren't inherited by
subshell (and for example egrep is called in subshell).

I discussed this issue with colleagues and we found basically two "fixes":

1. Tell people "do not use aliases which breaks completion script"
2. Prefix all commands with "command", i.e. `command egrep` etc.

In my opinion "2." is better long time solution, what do you think?

Regards, Adam

> 
>  contrib/completion/git-completion.bash | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git i/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
> index 0b77eb1..193f53c 100644
> --- i/contrib/completion/git-completion.bash
> +++ w/contrib/completion/git-completion.bash
> @@ -23,6 +23,14 @@
>  #    3) Consider changing your PS1 to also show the current branch,
>  #       see git-prompt.sh for details.
>  
> +if shopt -q expand_aliases
> +then
> +	_git__aliases_were_enabled=yes
> +else
> +	_git__aliases_were_enabled=
> +fi
> +shopt -u expand_aliases
> +
>  case "$COMP_WORDBREAKS" in
>  *:*) : great ;;
>  *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
> @@ -2504,3 +2512,8 @@ __git_complete gitk __gitk_main
>  if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
>  __git_complete git.exe __git_main
>  fi
> +
> +if test -n "$_git__aliases_were_enabled"
> +then
> +	shopt -s expand_aliases
> +fi
> 
> 

-- 
Adam Tkac, Red Hat, Inc.
