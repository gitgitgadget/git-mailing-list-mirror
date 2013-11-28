From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH] subtree: add squash handling for split and push
Date: Thu, 28 Nov 2013 11:23:09 -0700
Message-ID: <20131128182309.GA3655@comcast.net>
References: <C3EF61D4-5274-4A10-9594-4E631D75C3F4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, greened@obbligato.org, amdmi3@amdmi3.ru,
	john@keeping.me.uk, git@cryptocrack.de, techlivezheng@gmail.com,
	apenwarr@gmail.com, cstanfield@antifusion.net,
	jakub.suder@gmail.com, jesse.greenwald@gmail.com,
	pelle@kodfabrik.se, treese@acm.org, wayne@tickzoom.com
To: Pierre Penninckx <ibizapeanut@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 19:29:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm6LM-0006wD-2x
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 19:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab3K1S3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 13:29:20 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:50523 "EHLO
	qmta02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754818Ab3K1S3T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 13:29:19 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2013 13:29:19 EST
Received: from omta20.emeryville.ca.mail.comcast.net ([76.96.30.87])
	by qmta02.emeryville.ca.mail.comcast.net with comcast
	id v5tc1m0011smiN4A26PDX0; Thu, 28 Nov 2013 18:23:13 +0000
Received: from mmogilvi.dynu.net ([50.183.100.68])
	by omta20.emeryville.ca.mail.comcast.net with comcast
	id v6PA1m00F1UYGSS8g6PA5a; Thu, 28 Nov 2013 18:23:12 +0000
Received: by mmogilvi.dynu.net (Postfix, from userid 501)
	id 1AC111E9601C; Thu, 28 Nov 2013 11:23:10 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <C3EF61D4-5274-4A10-9594-4E631D75C3F4@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1385662993;
	bh=tJgErQkXogIeMbHAW3oerPxAK28WDszon8kkLV4nTuk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=LLcP3asX4EI47X37nVSlyQRbtpXUfiZKqkI+YxQAda2HmgTzVEIqqt2aKQd6l20SJ
	 fVUGz0P7mytiZOR1d1fw3RutwqjH0fGHL7IVAJxHSJcOySYWAwU4IRcpK6eGvFv3vW
	 PrQQ3qILlEF8gg2Hc0zbjlXNnmoKA9TzRvFM2cbBpjl7jnkxw1jty7qa8ziPoRejZG
	 r9VVKWyMsGn+h6zagmAQWjBDcGLYS2Pj5VyUHUuFniCBeyxqdoEAfU/fNfrwfewa1/
	 Md1G7cxXrctf+WNJodeHScqWpfBKrqiL7SBgp69V7UoIgbBSFmG6BjoZRe6iL2ZSRU
	 7M8oty3hBHRKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238501>

On Sat, Nov 23, 2013 at 09:18:56PM +0100, Pierre Penninckx wrote:
> The documentation of subtree says that the --squash option can be used
> for add, merge, split and push subtree commands but only add and merge
> is implemented.

Clarification: The current documentation (correctly) doesn't
actually claim to support "split --squash", but it does erroneously
claim to support "push --squash".

> cmd_split() first lets split do it's job: finding which commits need to
> be extracted. Now we remember which commit is the parent of the first
> extracted commit. When this step is done, cmd_split() generates a squash
> of the new commits, starting from the aforementioned parent to the last
> extracted commit. This new commit's sha1 is then used for the rest of
> the script.

I've been planning to implement something similar to this patch,
but the semantics I am aiming at are slightly different.

It looks like your patch is basically squashing the new subtree commits
together, throwing out those commits completely, and only keeping
the squashed commit in the split --branch.  

I intend to implement slightly different semantics, where
--squash only affects --rejoin, not the printed commit nor
the split-off --branch.  This is intended to provide a better,
third option for --rejoin'ing a subtree with a lot of history,
while preserving history in the split-off branch:

1. (existing/slow) Don't ever use --rejoin at all?  You can use
   "merge --squash" to merge in unrelated changes to the
   split-off project, but every "split" still gets slower
   and slower as each "split" needs to re-sift-through all
   the same history the previous "split"s have sifted
   through. 
   
2. (existing/huge mass of duplicated history) Use "split --rejoin"
   occasionally.  This pulls in the entire history of the
   subtree branch (since the last --rejoin or non-squash merge,
   or everything if neither has been done), which is difficult
   to ignore when looking at global history of the full project,
   especially if it is many pages of commits.  But subsequent
   splits can stop history traversal at the known-common point,
   and will run MUCH faster.
   
3. (new/better) Use "split --rejoin --squash" (or some other
   invocation to be defined).  The subtree branch is generated
   exactly like normal, including fine-grained history.  But
   instead of merging the subtree branch directly, --rejoin
   will squash all the changes to that branch, and merge in
   just the squash (referencing the unsquashed split
   branch tip in the commit message, but not the
   parent).  Subsequent splits can run very fast, while the
   "--rejoin" only generated two commits instead of the 
   potentially thousands of (mostly) duplicates it would pull
   in without the "--squash".

I have this third option half-coded already, but I still need
to finish it.

I'm fairly sure I can make this work without new adverse effects,
but if someone sees something I'm missing, let me know.

Does anyone have any suggestions about the UI?  Do we need to also
support Pierre Penninckx's "split --squash" semantics somehow?  If
so, what command line options would allow for distinguishing the
two cases?

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
