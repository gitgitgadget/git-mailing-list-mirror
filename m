From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 1 Jun 2016 19:31:00 +0100
Message-ID: <20160601183100.GN1355@john.keeping.me.uk>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
 <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
 <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
 <20160601163747.GA10721@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 20:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8AvD-0001Cb-46
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbcFASbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 14:31:10 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:33618 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750742AbcFASbJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 14:31:09 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 2767BBF225;
	Wed,  1 Jun 2016 19:31:07 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 2011820D86;
	Wed,  1 Jun 2016 19:31:07 +0100 (BST)
X-Quarantine-ID: <ntxT1hCdLmD5>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: 0.551
X-Spam-Level: 
X-Spam-Status: No, score=0.551 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, KAM_INFOUSMEBIZ=0.75,
	URIBL_BLOCKED=0.001] autolearn=no autolearn_force=no
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ntxT1hCdLmD5; Wed,  1 Jun 2016 19:31:04 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 487465FD8F;
	Wed,  1 Jun 2016 19:31:02 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20160601163747.GA10721@sigill.intra.peff.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296147>

On Wed, Jun 01, 2016 at 12:37:47PM -0400, Jeff King wrote:
> On Wed, Jun 01, 2016 at 09:19:06AM -0700, Junio C Hamano wrote:
> > diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
> > index 79bc135..5503ec0 100755
> > --- a/t/t7403-submodule-sync.sh
> > +++ b/t/t7403-submodule-sync.sh
> > @@ -62,13 +62,13 @@ test_expect_success 'change submodule' '
> >  '
> >  
> >  reset_submodule_urls () {
> > -	local root
> > -	root=$(pwd) &&
> >  	(
> > +		root=$(pwd) &&
> >  		cd super-clone/submodule &&
> >  		git config remote.origin.url "$root/submodule"
> >  	) &&
> >  	(
> > +		root=$(pwd) &&
> >  		cd super-clone/submodule/sub-submodule &&
> >  		git config remote.origin.url "$root/submodule"
> 
> Hmm. Isn't $root always just going to be $TRASH_DIRECTORY here? There's
> only one caller, which appears to pass an argument which is ignored (?).
> 
> It's probably worth doing the minimal thing now and leaving further
> cleanup for a separate patch, though. Cc-ing John Keeping, the author of
> 091a6eb0feed, which added this code.

I can't shed any light on what this is trying to do; I had a look
through the mailing list and this arrived in the final version of the
series without any comment.

Looking at it now I can't see why this is a separate function (that is
called with a parameter it never uses).  I wonder if my original
approach was to call this via test_when_finished from the two tests
following this function definition, but that's pure speculation now.

Junio's change is obviously correct as a minimal fix.

I wonder if it's relevant that the "local root" line isn't &&-chained?
Is it possible that on some shells we ignore an error but everything
still works?
