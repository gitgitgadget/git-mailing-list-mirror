From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test case for git-config-set
Date: Fri, 18 Nov 2005 11:48:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511181136400.8037@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511172249410.18285@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5kypjv2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 11:50:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed3nj-00043z-PF
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 11:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbVKRKsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 05:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbVKRKsu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 05:48:50 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56737 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161006AbVKRKsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 05:48:50 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 04A8D140024; Fri, 18 Nov 2005 11:48:49 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D2DC29F350; Fri, 18 Nov 2005 11:48:48 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B44FD9CC6E; Fri, 18 Nov 2005 11:48:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9EF75140024; Fri, 18 Nov 2005 11:48:48 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5kypjv2.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12222>

Hi,

On Thu, 17 Nov 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +test_expect_failure 'ambiguous unset' \
> > +	'git-config-set --unset nextsection.nonewline'
> 
> I am not so sure about this case.  Shouldn't this remove both?

No. The common case should be a variable with a unique key/value pair. And 
in that case, it should be treated as an error if there are already more 
than one pair.

> For example, if a Porcelain wants to force pull.twohead to be
> resolve and nothing else, and it wants to do it unconditionally,
> it would first want to empty whatever multivalue there are
> currently, and then insert its own, and I'd imagine the way to
> say that would be like this:
> 
> 	git-config-set --unset pull.twohead '^'
>         git-config-set pull.twohead resolve
> 
> More simply (I do not think you have a test case for this):
> 
>         git-config-set pull.twohead resolve '^'

This is a slippery slope. Giving a wrong regex by accident may destroy 
*all* your settings. Not what I want.

> I think it is the easiest to explain and understand the
> semantics of config_set_multivalue if it were to first remove all
> existing key-value for matching ones, and then insert what was
> provided by the user.

I'd be very, very careful about that. For sure, I'd want to make the 
removing of multiple values a single operation, which leaves a backup of 
.git/config behind.

> Extending that multivalue example a bit more, I think it is a
> bit cumbersome for a Porcelain to set pull.twohead to recursive
> and then resolve, with your interface.  Even if you had the
> emptying behaviour I suggested above, you would have to say
> something awkard like this:
> 
> 	git-config-set --unset pull.twohead '^'
>         git-config-set pull.twohead recursive
>         git-config-set pull.twohead resolve no-such-value-should-be-there

Really, I don't see the point in making twohead a multivar:

	[diff]
		twohead = resolve recursive blabla

This looks much nicer to me, and should be easy to parse (even for human 
eyes, who do not particularly like to find one value at the top of 
.git/config, and the second on the bottom, which is perfectly possible in 
your setup).

> Maybe we could have the shell-level interface like this:
> 
> 	git-config-set [--remove rx] section.key [value...]

As I said, I'd be *very* careful to remove multiple values. So, I would 
like to *require* two steps for this.

> 	git-config-set section.key
> 
> confusingly enough is --unset

Okay. That was my original code before introducing multivars, where I did 
not have --unset. This will go.

> 	git-config-set pull.twohead recursive resolve

Oh yes, yes. Just quote "recursive resolve"! Note that it is somewhat 
uncommon to make the behaviour of a variable in an ini file depend on its 
position... (this is meant as one more point in favor of just one pair).

> The C-level interface would become something like:
> 
> 	git_config_set_multivar(const char *key,
>         			const char *remove_value_regex,
>                                 const char **values)
> 
> where values is a NULL terminated list of values.

The normal use case (for things like "proxy.command", which will hopefully 
not become very common) will be to set/replace/unset exactly one value. 
For what you want, your proposal might be good, but I deem a unique 
key/value pair with a space separated list of methods a better solution.

> BTW, do we want to remove the section after removing the last
> key and making it empty?

No, because you might have comments in there. I am not willing to go as 
far as removing something like

	[diff]
		;might want to use that someday
		;twohead = recursive megacool

Ciao,
Dscho
