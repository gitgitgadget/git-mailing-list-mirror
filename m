From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Support setting SymrefsOnly=true from scripts
Date: Tue, 15 Nov 2005 17:09:05 -0800
Message-ID: <7v8xvpe6vi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511152233430.2152@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfypxh5mn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511160127130.4334@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 02:09:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcBnU-0005MW-GQ
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 02:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVKPBJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 20:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVKPBJJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 20:09:09 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:34045 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965144AbVKPBJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 20:09:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116010807.TMYO26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 20:08:07 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511160127130.4334@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 16 Nov 2005 01:49:27 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11983>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 15 Nov 2005, Junio C Hamano wrote:
>
>> I am almost tempted to say that we should be doing --template=
>> option to git-init-db for something like this, and make the
>> template instantiation first thing before even reading the
>> config file.
>
> Well, problem is that if you use templates to install a .git/config, the 
> code in init-db which checks for safe filemode no longer gets called. And 
> we don't know yet what else we might want to write into the config from 
> init-db, or from anywhere else for that matter.
>
> Furthermore: if you have a nice template which says that SymrefsOnly=true, 
> init-db will still create HEAD as a symlink!

Funny.  These two are what I meant by "make the template
instantiation first thing".  So instead of the hardcoded
only_symbolic_ref assignment and filemode check code, can't we
do something like this?

 - copy the template; if the commandline specifies where the
   templates are, take them from there otherwise use the
   built-in location.

 - read from config; note if you actually read any (may not have
   config in your template suite, or you might not have
   templates at all).

 - do filemode check, and maybe git_config_set() there and write
   the result back as the new config for that repository.

 - create the rest, including the HEAD ref.

The user could even have more than one template set (one for
VFAT and another for non VFAT).  Once we go that route, we may
not even need the special filemode check code in init-db.  No?
