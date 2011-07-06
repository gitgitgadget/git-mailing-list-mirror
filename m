From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: generation numbers (was: [PATCH 0/4] Speed up git tag --contains)
Date: Wed, 06 Jul 2011 07:26:53 -0700 (PDT)
Message-ID: <m3mxgr4has.fsf_-_@localhost.localdomain>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
	<20110706064012.GA927@sigill.intra.peff.net>
	<20110706065623.GB14164@elie>
	<20110706070311.GA3790@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 06 16:27:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeT4A-0003xj-PH
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 16:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab1GFO05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 10:26:57 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:53940 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961Ab1GFO04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 10:26:56 -0400
Received: by fxd18 with SMTP id 18so136290fxd.11
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xJUw6PBoeiFDMCYmtSMJnXCxuSSlff3ZcTxE8kgylm8=;
        b=jfqEnkp45BwtMu0avhFn1WNzjYYKnjPKo+u1+vHERNdUFiP6i0poZRQXl4xcd5hthi
         tKeyMaexKpYIROuQVbG6b7dfXVFy0se7NbbsHNavRDYy1W12VnnZJS5zEXnhmw6FplZ+
         XPkh9yp1TNJYv/zJJVDMVl1EPbUd2cRxxWrHo=
Received: by 10.223.76.212 with SMTP id d20mr13246737fak.5.1309962414409;
        Wed, 06 Jul 2011 07:26:54 -0700 (PDT)
Received: from localhost.localdomain (abvw74.neoplus.adsl.tpnet.pl [83.8.220.74])
        by mx.google.com with ESMTPS id w15sm6053827faj.23.2011.07.06.07.26.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 07:26:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p66EQBK2011991;
	Wed, 6 Jul 2011 16:26:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p66EPn9T011984;
	Wed, 6 Jul 2011 16:25:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110706070311.GA3790@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176705>

Jeff King <peff@peff.net> writes:
> On Wed, Jul 06, 2011 at 01:56:23AM -0500, Jonathan Nieder wrote:
> > Jeff King wrote:
> > 
> > > The problem is that existing objects don't have this generation number.
> > > It's easy to calculate, though, and we could in theory use a notes-cache
> > > to store it externally. Obviously the complexity and performance aren't
> > > going to be as good as if it were just in the commit object, but we're
> > > sadly 6 years too late to make that decision.
> > 
> > I am still digesting the rest of what you wrote, but wouldn't this be
> > easy to do today?  One could just use a notes-cache while prototyping
> > and if it seems to work well, introduce new loose and packed object
> > formats that include a field for the cached generation number.
> 
> Yes, that's exactly how to do it. I'm just not sure "introduce new loose
> and packed object formats" is "easy to do". Though I'm not sure we need
> new formats. It is really just a new header in the commit object. And if
> we write the code carefully, we should be able to transparently use
> newly-generated objects with the field, and fall back to a notes-cache
> (with autogeneration) when it isn't there.

I understand that you would do autogeneration at least when you create
a commit, and at least one of parents does not have generation number.

You can also autogenerate notes-cache when following commits, and
encountering commit object without generation number.  

Or make "git gc" autogenerate cache-notes for generation number,
perhaps with an option (i.e. probably not for "git gc --auto").
 
> Existing git will ignore the new generation field. It does mean that old
> and new git will generate different sha1s for the exact same commit. I
> don't know how big a deal this is in practice. It matters a lot more for
> blobs and trees. But for commits, even if you are replaying a commit,
> you should be updating the commit timestamp, which is going to give a
> new sha1.
> 
> The other thing I worry about is performance. You are building a full
> notes tree and looking up every commit in the traversal. I don't know
> how bad that will be (though from my other back-of-the-envelope tests,
> it may not actually be that bad; notes were designed to be fast for
> exactly this case).

Well, one thing that it would test our notes infrastructure...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
