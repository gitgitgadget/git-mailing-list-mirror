From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Sun, 30 Dec 2007 13:31:46 +0300
Message-ID: <20071230103146.GU13968@dpotapov.dyndns.org>
References: <1198593316-7712-1-git-send-email-dpotapov@gmail.com> <Pine.LNX.4.64.0712292334080.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 11:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8vSn-0000tz-LG
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 11:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbXL3Kbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 05:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbXL3Kbt
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 05:31:49 -0500
Received: from smtp01.mtu.ru ([62.5.255.48]:63482 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbXL3Kbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 05:31:48 -0500
Received: from smtp01.mtu.ru (localhost [127.0.0.1])
	by smtp01.mtu.ru (Postfix) with ESMTP id C664AADDC5A;
	Sun, 30 Dec 2007 13:31:42 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-14.pppoe.mtu-net.ru [85.141.191.14])
	by smtp01.mtu.ru (Postfix) with ESMTP id 8FBEDADD96E;
	Sun, 30 Dec 2007 13:31:42 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1J8vSM-0005mF-6p; Sun, 30 Dec 2007 13:31:46 +0300
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712292334080.14355@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp01.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69343>

Hi,

On Sat, Dec 29, 2007 at 11:36:51PM +0100, Johannes Schindelin wrote:
> 
> On Tue, 25 Dec 2007, Dmitry Potapov wrote:
> 
> > 'git-filter-branch branch' could fail producing the error:
> > "Which ref do you want to rewrite?" if existed another branch
> > or tag, which name was 'branch-something' or 'something/branch'.
> > 
> > Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> > ---
> >  git-filter-branch.sh     |    2 +-
> >  t/t7003-filter-branch.sh |   10 ++++++++++
> >  2 files changed, 11 insertions(+), 1 deletions(-)
> > 
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index dbab1a9..b89a720 100755
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -219,7 +219,7 @@ do
> >  	;;
> >  	*)
> >  		ref="$(git for-each-ref --format='%(refname)' |
> > -			grep /"$ref")"
> > +			grep '^refs/[^/]\+/'"$ref"'$')"
> 
> Hmm.  I wonder if this is a proper solution.  It still does not error out 
> when you have a tag and a branch of the same name.
> 

Are you sure? I had created a tag and a branch with the same name, and
then tried git filter-branch on it, and it did error out:
===
warning: refname 'test1' is ambiguous.
Which ref do you want to rewrite?
===

Maybe, my fix is not a perfect solution, but it works correctly in all
known to me situations, while the original code is clearly broken in
most common cases, like when you have created a tag with a name that
consists of the name of a branch plus some arbitrary suffix. When you
run git-filter-branch on that branch, you only get: "Which ref do you
want to rewrite?", which is very confusing, because you have only one
reference with the given name.


Dmitry
