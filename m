From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 5 Mar 2007 17:09:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051701331.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <esgm1m$33f$1@sea.gmane.org>
 <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC35B2.2070808@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 17:10:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOFlL-0002jR-1j
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 17:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbXCEQJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 11:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXCEQJd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 11:09:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:59169 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751954AbXCEQJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 11:09:32 -0500
Received: (qmail invoked by alias); 05 Mar 2007 16:09:30 -0000
X-Provags-ID: V01U2FsdGVkX19omckyYYNoMb5VXGhLR+awimrsnDcRV+EoIbGhMi
	4yI5XOIOQRIa85
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EC35B2.2070808@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41456>

Hi,

On Mon, 5 Mar 2007, Paolo Bonzini wrote:

> >> +	/* Try an exact match first.  */
> >> +	sscanf(value, "refs/%*[^:]:%n", &len_first);
> > 
> > This is the first time I saw that sscanf format type. How portable is it?
> 
> It is.  At the very least it is in OpenGroup.

That is not very reassuring for me. However, I learnt something new about 
sscanf(), so it was not lost on me.

> >> +		/* Truncate the value before the colon.  */
> >> +		asprintf(&config_repo, "%.*s", len_first - 1, value);
> > 
> > asprintf() is a GNU extension. I guess it is better to just
> > 
> > 	config_repo = xstrdup(value);
> > 	config_repo[p - value] = '\0';
> 
> git has nfvasprintf -- I'll just use that one.

Which forces you to build a va_list first, and which is horribly 
inefficient. Not that it matters for git-branch...

> > FWIW I don't think .trackIntoLocalBranches" is needed. Opinions?
> 
> That's because I'd like to make it the default for me...  Also, look at 
> patch 3/3.

I am not only mildly opposed to switching trackIntoLocalBranches off. It 
is a _very_ useful feature for new Git users, as it will (I am sure) 
reduce the number of "Huh?" moments dramatically.

Also, I am opposed to make this a remote.<name>.trackIntoLocalBranches 
variable.

IMHO a global flag should be enough, if you really need it at all. Your 
code now makes sure that the defaults will be set only if there is a 
proper fetch entry for the corresponding remote name, so it is safe. 
People wanting to prevent that behaviour can use "--no-track", and those 
who don't know about "--no-track" are probably better off _with_ DWIM 
defaults for the new branch.

> >> @@ -333,7 +424,9 @@ static void create_branch(const char *name, const char *start_name,
> >>  	if (start_sha1)
> >>  		/* detached HEAD */
> >>  		hashcpy(sha1, start_sha1);
> >> -	else if (get_sha1(start_name, sha1))
> >> +	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref) > 1)
> >> +		die("Ambiguous object name: '%s'.", start_name);
> > 
> > I know, I should have said that earlier, but I just found out myself: 
> > We have a config variable core.warnambiguousrefs, and maybe we should 
> > _not_ complain and set the defaults when the global variable 
> > warn_ambiguous_refs is 0.
> 
> If warn_ambiguous_ref == 0, dwim_ref is never going to answer anything > 
> 1...

Right. Thank you!

Ciao,
Dscho
