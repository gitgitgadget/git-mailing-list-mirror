From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 (for maint)] git-completion: fix zsh support
Date: Mon, 9 May 2011 16:13:16 -0500
Message-ID: <20110509211316.GB22908@elie>
References: <1304973913-5376-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 23:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJXlg-00076S-Fy
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab1EIVNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 17:13:23 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56848 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab1EIVNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:13:22 -0400
Received: by yia27 with SMTP id 27so1946841yia.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zVTsBsIm0B5FOA7NHk1k+q7eKAHU2/4SCKh1ROkSufE=;
        b=BdAMzEA+M3FjqFDsVDwFnh3DCqVBzgwY7m6lgu98rfTwn6C5J3oLiJy43L/bjAw0uR
         bTLZeXVhCsnvu7OnFv2b89W+HatWXleKb15XO+mQwHdKLHbOEWukMbcj9P/AaxkYWOzX
         MlAgUrUTK2qfo3v+wd7n99cLBHZTqVXpjOJDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H/mkzWMw/OCPwA5PKQBbxjD4u/m5A2uQPv9HcixTOkIIe6r/CkqaFwW3pu5QipauZr
         hDJVXh+fnIwCGahWYnFCC2343qZQj+ftWoCVFR0u7EPJx+Rh+QleNjTmFlNxQCS+5cPJ
         b+MAt65GH2JmNqtvXNzt9wRvueVZua+p1rkUo=
Received: by 10.236.115.168 with SMTP id e28mr8072444yhh.334.1304975602094;
        Mon, 09 May 2011 14:13:22 -0700 (PDT)
Received: from elie (adsl-68-255-107-251.dsl.chcgil.sbcglobal.net [68.255.107.251])
        by mx.google.com with ESMTPS id f73sm2792820yhc.41.2011.05.09.14.13.19
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 14:13:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304973913-5376-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173252>

Felipe Contreras wrote:

> It turns out 'words' is a special variable used by zsh completion, sort
> of like 'COMP_WORDS' in bash.

I was not aware that COMP_WORDS was special (rather than just
prepopulated).  Is it?

> This was not isolated correctly in zsh's
> bash completion, so by trying to set it as 'local' in git's completion,
> unexpected results occur; assignations are not propagated to upper
> levels in the call stack.

Does the call stack grow up or down?  I suspect this means:

	zsh's bash completion emulation layer does not sufficiently
	insulate us from that reality.  In particular, the variable
	keeps the "special" attribute (even after a declaration "local
	words"), so assignments within a function are undone whenever
	the function returns.

	In particular, until 3bee6a473 (completion: don't declare
	'local words' to make zsh happy, 2011-04-28), the "words" array
	would be cleared in _git by declaring "local words" and its new
	value would never be propagated from _get_comp_words_by_ref so
	it remained empty and the completion script could not tell that
	there were existing subcommand names on the command line (so
	"git log m<TAB>" would complete subcommand names).

	And even after 3bee6a473 we do not have the ability to modify
	words.  (... explanation of impact of the change goes here ...)

I am not a great writer so that is probably more verbose than needed.
So it might be better for me to describe the goals of a commit message:

 1) the text should be specific about what the commit fixes, so
    someone reading it later (e.g., after bisecting) does not come
    around and accidentally break it
 
 2) in particular, the text should be specific about the observable
    symptoms, so it can be easier to check if a later change has
    broken it.

> This is now fixed in the latest master branch of zsh[1] by simply
> defining 'words' as hidden (typeset -h), which removes the special
> meaning inside the emulated bash function. It probably won't be released
> until version 4.3.12.
>
> In the meantime, we can workaround the issue by doing the same; defining
> words as hidden (typeset -h) as soon as possible.

It might make sense to reverse the order of these: first explain the
fix in the context of the problem being solved, and then add a note
mentioning that the fix will not be needed for long and that the
method is the same as what zsh is planning to use.

Meanwhile this doesn't address the risk that functions called by the
completion script will use $words.  Outside the context of the commit
message I think you've said something about that (e.g., that the zsh
developers prefer this fix --- a reference would be nice so we could
steal their rationale).  Maybe the best thing to say would be "that is
a risk, but let's wait and see", to give future readers more
confidence that that was considered but it is ok to fix it if it comes
up?

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2710,6 +2710,10 @@ _git ()
>  	if [[ -n ${ZSH_VERSION-} ]]; then
>  		emulate -L bash
>  		setopt KSH_TYPESET
> +
> +		# workaround zsh's bashinit's bug that leaves 'words' as a
> +		# special variable in versions < 4.3.12
> +		typeset -h words

I don't think the comment clarifies much.  What is the intended
message to the reader?  For example if it is "don't remove this line
unless you use zsh 4.3.12 or greater", I'd say something like

		# bashcompinit versions after 4.3.12 already hide the
		# special "words" variable already.  We do it
		# again ourselves to support older zsh versions.

Hope that helps,
Jonathan
