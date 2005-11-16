From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Support setting SymrefsOnly=true from scripts
Date: Wed, 16 Nov 2005 01:49:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511160127130.4334@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511152233430.2152@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfypxh5mn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 01:49:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcBUR-0000Ys-W9
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 01:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbVKPAt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 19:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbVKPAt3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 19:49:29 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25474 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965132AbVKPAt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 19:49:29 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 147F413F878; Wed, 16 Nov 2005 01:49:28 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E6009B51F2; Wed, 16 Nov 2005 01:49:27 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C326C59124; Wed, 16 Nov 2005 01:49:27 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B0C6B13F878; Wed, 16 Nov 2005 01:49:27 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfypxh5mn.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11981>

Hi,

On Tue, 15 Nov 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	- set SymrefsOnly=true right from the start with
> > 		git-init-db --dont-use-symrefs
> 
> I am almost tempted to say that we should be doing --template=
> option to git-init-db for something like this, and make the
> template instantiation first thing before even reading the
> config file.

Well, problem is that if you use templates to install a .git/config, the 
code in init-db which checks for safe filemode no longer gets called. And 
we don't know yet what else we might want to write into the config from 
init-db, or from anywhere else for that matter.

Furthermore: if you have a nice template which says that SymrefsOnly=true, 
init-db will still create HEAD as a symlink! (Note that my patch sets 
the *global* only_use_symrefs from the command line option, not a 
local variable!)

So, if you want a repository to explicitely force symrefs, you have to 
have special handling in init-db. And for consistency, you should 
modify/write the config file to include "SymrefsOnly=true" right away.

Alternatively, or in addition to my patch, you could do a git_config() 
just after copy_templates() (you allude to this, but note that init-db 
does not read the config at any stage yet).

However! This only works if you are sure that the templates you need are 
installed. I *never* install git, but *always* have my private working 
directory in the PATH. So, I never have templates installed. Neither do I 
plan to.

> The rest might be useful to better support end-users, but I am
> not sure.  Is it that much hassle to them to edit an .ini file?

Obviously, I'd prefer to have at least the patch adding git_config_set() 
applied. This is core plumbing. It actually checks if the name is valid, 
and it automatically escapes the value when needed. Before doing anything, 
it checks that the config file is valid. It does locking. It creates a 
simple config if none was there yet. And it's small.

As for git-config-set, I guess it would be rather handy for Porcelains 
(and t/blabla-config.sh), but I could be convinced otherwise.

Ciao,
Dscho
