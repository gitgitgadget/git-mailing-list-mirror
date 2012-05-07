From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Arguments to git hooks
Date: Mon, 07 May 2012 23:17:51 +0100
Message-ID: <4FA84A0F.6060608@pileofstuff.org>
References: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 00:18:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRWFl-0005mH-LC
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 00:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546Ab2EGWR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 18:17:57 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:21831 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757270Ab2EGWR4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 18:17:56 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120507221754.WUSR28930.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Mon, 7 May 2012 23:17:54 +0100
Received: from [192.168.0.3] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120507221754.LXPE3795.aamtaout02-winn.ispmail.ntl.com@[192.168.0.3]>;
          Mon, 7 May 2012 23:17:54 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=yqP5zQRIxvXerE2vXL8A:9 a=fFLV0aY6A8NLHGSejwgA:7 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197321>

On 06/05/12 19:35, jaseem abid wrote:
> Hello all,
> 
> I am trying to write a hook '.git/hooks/commit-msg' to be run before
> every commit.
> 
> How can I pass arguments to the script? Now by default the only arg I
> am getting is `.git/COMMIT_EDITMSG'`. I would love to get the list of
> files I tried to commit also into the script so that I can run a lint
> program on it before committing it. How can I get this done?

First, a standard warning - consider using a pre-receive hook instead of
a pre-commit hook.  A lot of git's power comes from making commits as
cheap as possible, so rules like "no committing until your code is
pretty" tend to stifle people.  For example, I often commit changes
before running lint-type operations, then use `git add -p` and `git
checkout -p` to selectively accept/reject individual changes.  When I'm
done, I `git commit --amend` to pretend the original commit never
happened.  A pre-receive hook gives you most of the same guarantees as a
pre-commit hook with almost none of the cost.

Having said that, there are situations where pre-commit hooks are a good
idea (like catching "DO NOT COMMIT" comments).  I've played with this a
little before, and never found a very satisfactory solution.  Here are
some important cases:

# git status will sometimes tell you the file that will be committed:
# edit foo
git add foo
git commit


# git status will sometimes need a bit of careful parsing:
# edit foo
# edit bar
git add foo
git commit


# git status sometimes tells you the right file but the wrong contents:
# edit foo
git add foo
# edit foo again
git commit


# but often git status will tell you the wrong file altogether:
# edit foo
# edit bar
git add foo
git commit bar


The best solution I've found is a `git commit` wrapper that does
something like `CHANGES="$(git commit $@ --dry-run -v)"` to get a
reliable diff, then starts work from there.

	- Andrew
