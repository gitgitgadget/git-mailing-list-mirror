From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git-submodule.sh respects submodule.$name.update in .git/config
 but not .gitmodules
Date: Mon, 9 Dec 2013 23:35:06 +0100
Message-ID: <20131209223506.GF9606@sandbox-ub>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Charlie Dyson <charlie@charliedyson.net>
X-From: git-owner@vger.kernel.org Mon Dec 09 23:35:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq9Q2-0000IG-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 23:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab3LIWfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 17:35:10 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:40355 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab3LIWfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 17:35:09 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vq9Pv-0002WR-Nc; Mon, 09 Dec 2013 23:35:07 +0100
Content-Disposition: inline
In-Reply-To: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239115>

On Fri, Dec 06, 2013 at 03:48:46PM +0000, Charlie Dyson wrote:
> gitmodules(5) states that submodule.$name.update should be defined in
> .gitmodules. However in cmd_update() in git-submodule.sh, git config
> is used with "-f .gitmodules". Consequently this flag is only
> respected in .git/config
> 
> Tested against: 1.8.2.1 [sorry! I've checked the relevant bit of
> source and it's the same]
> 
> Steps to reproduce:
> $ git init
> $ git submodule add -b master someproject
> $ git config -f .gitmodules --add submodule.someproject.update merge
> $ # Go to someproject and commit something
> $ git submodule update --remote
> 
> The latter does not perform a merge, and behaviour is visibly
> different to adding --merge.

This is because of histerical reasons. When submodules were first
implemented the notion was that .gitmodules should only be used as a
starting point to initialise the configuration in .git/config when init
was called.

This notion has changed in a way that only the url (by that the name)
should be copied on init. The default for everything else should come
from .gitmodules or gits own default.

The update configuration option was implemented before we realized that.
So currently it is still copied when submodule init is called. The main
reason is that we have not found the time to change that.

> I would submit a patch but I'm not completely sure what the behaviour
> would be - simply adding "-f .gitmodules" would hurt users that have
> adopted the practice of specifying their update preference in
> .git/config.

Well .gitmodules should only be the fallback if there is nothing in
.git/config.

> Perhaps the right thing to do is read from .git/config and fall back
> to .gitmodules using get_submodule_config().

Yes IMO that is the right thing to do. If you implement it that way (and
remove the automatic copying on init) you should not break peoples
expectations. So if you want to go ahead please send a patch.

Cheers Heiko
