From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 5 Mar 2007 16:58:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <esgm1m$33f$1@sea.gmane.org>
 <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EC3905.7070406@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Mon Mar 05 16:58:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOFa6-0006Rg-4V
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 16:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564AbXCEP6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 10:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933568AbXCEP6I
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 10:58:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:44003 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933564AbXCEP6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 10:58:07 -0500
Received: (qmail invoked by alias); 05 Mar 2007 15:58:05 -0000
X-Provags-ID: V01U2FsdGVkX1/2PMU4EJP2YD1z39ToOau4FeewtZMACKXhyymyjF
	KLk77Q9gQVH9ca
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EC3905.7070406@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41454>

Hi,

On Mon, 5 Mar 2007, Paolo Bonzini wrote:

> >> +	/* Try with a wildcard match now.  */
> >> +	sscanf(value, "refs/%*[^/]/*:%nrefs/remotes/%*[^/]/*%n",
> >> +	       &len_first, &len_second);
> >> +	if (len_first != -1 && len_second != -1
> >> +	    && (len_second - 2) - len_first == remote_len + 13
> >> +	    && !strncmp(value + len_first, start_ref, remote_len + 13)) {
> >> +		/* Replace the star with the remote branch name.  */
> >> +		asprintf(&config_repo, "%.*s%s",
> >> +			 len_first - 3, value,
> >> +			 start_ref + remote_len + 13);
> > 
> > Same here:
> > 
> > 	else if (!prefixcmp(value, "refs/") && (p = strchr(value, ':')) &&
> > 			!memcmp(p + 1, start_ref, remote_len) &&
> > 			!strcmp(p + 1 + remote_len, "/*")) {
> > 		config_repo = xstrdup(value);
> > 		config_repo[p - value] = '\0';
> > 	}
> 
> This is not what my code does.

You are completely correct. I overlooked the need to check for "/*" 
in the first part. So, this should go before the memcmp() line:

			!prefixcmp(p - 2, "/*") &&

I also forgot to replace "*" by the branch name. The if block should look 
like this, then:

		config_repo = xmalloc(p - value + start_len - remote_len);
		strncpy(config_repo, value, p - 1 - value);
		strcat(config_repo, start_ref + remote_len);

As usual, completely untested.

> Are you saying that yours is correct, or that it should actually be the 
> same in practice, or just that I should avoid sscanf/asprintf (which I 
> won't do, since I got mildly insane after writing half of the function 
> without sscanf -- and then decided that the C library is there to be 
> used).

Well, you make a good case there. I am only mildly concerned that this 
might not work on some obscure platforms (including Windows and SunOS), 
and that we are not even realizing that because you do not check the 
return value of sscanf().

Ciao,
Dscho
