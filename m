From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: rewrite history
Date: Thu, 16 Jun 2011 17:33:42 -0400
Message-ID: <4DFA76B6.5030407@xiplink.com>
References: <362053118.20110616231758@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 23:33:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXKCL-0003b2-LF
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 23:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059Ab1FPVdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 17:33:51 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:49766 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608Ab1FPVdu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 17:33:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp57.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 07EB1F87C5;
	Thu, 16 Jun 2011 17:33:50 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp57.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D4D17F86D9;
	Thu, 16 Jun 2011 17:33:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Thunderbird/3.1.10
In-Reply-To: <362053118.20110616231758@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175934>

On 11-06-16 03:17 PM, Ilya Basin wrote:
> Hi list. There were 2 branches. One's HEAD was modified to match a
> specific commit at another branch. Now, how to merge them according to
> this scheme?
> 
> A---B---X---E---F
>                      =>  C---D---X---E---F
> C---D---X'
> 
> X and X' have no difference. I tried to write a script to cherry-pick
> E and F, but some of commits are merges and cherry-pick fails.
> 
> ...
> 
> git diff X X' is empty

It sounds like you really want to apply X--E--F on top of D, but I don't know
how you can do that since you need to do *something* to D in order to get a
tree that matches X, and that something is (presumably) *different* from the
change that X applied to B.  So if

	diff B X  !=  diff D X'

then I think Junio's right that the best you can do is change the meta-data
in X' (commit message, Author, etc) to match X then apply E and F on top of
that.  But filter-branch seems like overkill to me here -- I'd just use
"rebase -p" but not quite as Peff described:

	git checkout X'
	git commit --amend ....   # Replaces X' with X"
	git rebase -p --onto HEAD X F

Giving you

	C---D---X"---E---F

where

	diff D X'  ==   diff D X"
and	meta_data(X") == meta_data(X)

But if you're happy with C---D---X'---E---F then you can skip the "git commit
--amend" step.

		M.
