From: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: Problems with git fetch confusing foo and foo.git repos
Date: Sat, 18 Aug 2012 15:49:43 +0100
Message-ID: <1345301383.27428.55.camel@ted>
References: <1345299904.27428.50.camel@ted>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Ashfield, Bruce" <Bruce.Ashfield@windriver.com>,
	"saul.wold" <saul.wold@intel.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 16:50:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2kLg-00039Z-NK
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 16:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab2HROt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 10:49:56 -0400
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:61097 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab2HROty (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 10:49:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7IEno9I018539;
	Sat, 18 Aug 2012 15:49:50 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 14272-08; Sat, 18 Aug 2012 15:49:45 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7IEngPt018533
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 18 Aug 2012 15:49:43 +0100
In-Reply-To: <1345299904.27428.50.camel@ted>
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203675>

On Sat, 2012-08-18 at 15:25 +0100, Richard Purdie wrote:
> A while ago I reported a problem[1] where having:
> 
> /somewhere/foo
> and
> /somewhere/foo.git
> 
> as bare repositories and trying to clone them using alternates could
> cause git to confuse them.
> 
> The "conclusion" was that I needed to do:
> 
> git clone -s -n /somewhere/foo/ x
> 
> to stop it looking at the .git version. Ok, fine. Ugly but I can live
> with it and we added the workaround[2].
> 
> I've now discovered we only half solved the problem. Whilst the
> alternates might get setup correctly, the branch names and revisions get
> fetched from the .git version still.
> 
> It appears that even if you have a repository setup with an origin url
> of "/somewhere/foo/", when you run git fetch origin -f  refs/*:refs/*,
> it will look at foo.git if it exists.
> 
> The problem is the trailing slash is stripped off by the code in
> git-fetch itself. It appears to have done this since it was converted
> from a .sh function. It means it appears impossible to fetch the
> branchnames/revisions from foo when foo.git exists.
> 
> I work with build systems that build complete linux systems and we're
> running into failures caused by this. I really need pre-existing
> versions of git to work so I can't even patch git to work around the
> problem without significant cost. So far the only way I've figured out
> to avoid this is to create a symlink to /somewhere/foo/ and then set url
> to point at the symlink. This way I can prevent it from finding the
> other directory.
> 
> I thought I'd mention this in the hopes git can be fixed to behave
> better in this situation and perhaps I can drop the hacks I'm going to
> have to add sometime in the future.

I'd add that I think the commit made for the original problem[1] has
fixed this scenario since it now will prefer foo over foo.git also in
the fetch case even if the / is removed from the url. My test machines
don't have that version yet though and I'm left with a problem where git
is older than 1.7.9.2. 

[1]http://git.kernel.org/?p=git/git.git;a=commit;h=b3256eb8b35937192e85725d0c2bcb422295790c

Cheers,

Richard
