From: Joe Perches <joe@perches.com>
Subject: Re: problem when using --cc-cmd
Date: Tue, 19 Apr 2011 20:03:50 -0700
Message-ID: <1303268630.24766.9.camel@Joe-Laptop>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
	 <20110419215239.GA22632@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 05:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCNhu-00073t-AY
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 05:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab1DTDDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 23:03:53 -0400
Received: from mail.perches.com ([173.55.12.10]:4844 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab1DTDDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 23:03:52 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id D070324368;
	Tue, 19 Apr 2011 20:03:43 -0700 (PDT)
In-Reply-To: <20110419215239.GA22632@elie>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171837>

On Tue, 2011-04-19 at 16:52 -0500, Jonathan Nieder wrote:
> Thiago Farina wrote:
> > when I run:
> > $ git send-email --to linux-kernel@vger.kernel.org --cc-cmd
> > scripts/get_maintainer.pl foo
> > I'm getting some lines like:
> > Use of uninitialized value $cc in string eq at
> > /home/tfarina/libexec/git-core/git-send-email line 964.
> Yes, sounds like a bug.  Cc-ing some send-email people for tips.

I haven't seen this.

What versions of ./scripts/get_maintainer.pl and git are
you using?

> On the other hand, using --cc-cmd=scripts/get_maintainer.pl does not
> sound like a great idea to me.  On one hand the output of
> get_maintainer.pl is not an unadorned address per line like --cc-cmd
> expects.  On the other hand, at least some versions of
> get_maintainer.pl returned more addresses than are likely to be
> interested people (by using --git by default).
> 
> I think get_maintainer.pl is meant to be a starting point for tracking
> down who might be interested in a patch and should be followed by
> careful investigation.  (That means making sure that there is a
> reasonable number of people and the reasons given by --roles ouput
> make sense, and maybe even glancing at some messages by them from the
> relevant mailing list to make sure the script has not gone haywire.)

Jonathan is basically correct in the what he writes above.

I also think git history isn't a very good mechanism to
rely on for determining MAINTAINERS, it should only be a
fallback to determine who should receive a copy of a patch.

That said, I use scripts/get_maintainer.pl to generate
to's and cc's.  I do not use --git or --git-fallback
and rely only on the MAINTAINERS file pattern matching.

Here are the settings I use:

$ cat ~/.gitconfig
[sendemail]
	chainreplyto = false
	thread = false
	suppresscc = self
	tocmd = ~/bin/to.sh
	cccmd = ~/bin/cc.sh

$ cat ~/bin/to.sh
#!/bin/bash

opts="--nogit --nogit-fallback --norolestats --pattern-depth=1"

if [[ $(basename $1) =~ ^0000- ]] ; then
    ./scripts/get_maintainer.pl --nom $opts $(dirname $1)/*
else
    maint=$(./scripts/get_maintainer.pl --nol $opts $1)

    if [ "$maint" == "" ] ; then
	echo "linux-kernel@vger.kernel.org"
    else
	echo "$maint"
    fi
fi

$ cat ~/bin/cc.sh
#!/bin/bash

opts="--nogit --nogit-fallback --norolestats"

if [[ $(basename $1) =~ ^0000- ]] ; then
    ./scripts/get_maintainer.pl --nom $opts $(dirname $1)/*
else
    ./scripts/get_maintainer.pl $opts $1
fi
