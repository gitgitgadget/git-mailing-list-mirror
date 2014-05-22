From: David Turner <dturner@twopensource.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 15:26:29 -0400
Organization: Twitter
Message-ID: <1400786789.18134.27.camel@stross>
References: <1400775763.1933.5.camel@stross>
	 <20140522164634.GB30419@sigill.intra.peff.net>
	 <1400782096.18134.1.camel@stross>
	 <20140522182303.GA1167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 21:26:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnYdQ-0006YX-3a
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbaEVT0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:26:32 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:39371 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbaEVT0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:26:31 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so6401251qge.26
        for <git@vger.kernel.org>; Thu, 22 May 2014 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=bwcSisxOKWmXTJx7fTA3L9TtPV0tA1KvXR4lw8gmxI4=;
        b=h0+cVYNqZXP4Q+2gVJNemONUQsVynLPiOqM7jGy7U4tvv+nz6bBaNfiFEATstBcC+j
         BBeIV/fwkGevNrsPFQew0e5eOXnfwlfET2gbKMXRbyVLBlXcaVdXjF7XxneTQHDiV+Yn
         ZkkFjLs9ELfLPNXYMxzHyNvrDGPz2AkTHTfXFPPtedOi+MVoZXQO3wnz3pZylpgCltgJ
         Ob7byJfPNgpyYxE/t1ij9HHASSz7iEir4c37FwSb1DAAIs2cG+hhvyV9TnYnb5DkxJso
         e4azvQJTIlM1NtsAOEoxqpJKs0lvoK3FbSMg0U8OeZF+M76phaHY9OichkC3I5Vn+Kv0
         qHvQ==
X-Gm-Message-State: ALoCoQm34Ax+eAoykFxSmMz+RWqYvdyV+BVdtzzVo9O2GGI7zNOb/xqpBPCQ8wdSw0WfwP7wF6Gq
X-Received: by 10.140.42.165 with SMTP id c34mr80110011qga.40.1400786791194;
        Thu, 22 May 2014 12:26:31 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id 6sm1068207qam.44.2014.05.22.12.26.29
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 12:26:30 -0700 (PDT)
In-Reply-To: <20140522182303.GA1167@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249937>

On Thu, 2014-05-22 at 14:23 -0400, Jeff King wrote:
> On Thu, May 22, 2014 at 02:08:16PM -0400, David Turner wrote:
> 
> > On Thu, 2014-05-22 at 12:46 -0400, Jeff King wrote:
> > > On Thu, May 22, 2014 at 12:22:43PM -0400, David Turner wrote:
> > >
> > > > If I have a git repository with a clean working tree, and I delete the
> > > > index, then I can use git reset (with no arguments) to recreate it.
> > > > However, when I do recreate it, it doesn't come back the same.  I have
> > > > not analyzed this in detail, but the effect is that commands like git
> > > > status take much longer because they must read objects out of a pack
> > > > file.  In other words, the index seems to not realize that the index (or
> > > > at least most of it) represents the same state as HEAD.  If I do git
> > > > reset --hard, the index is restored to the original state (it's
> > > > byte-for-byte identical), and the pack file is no longer read.
> > >
> > > Are you sure it's reading a packfile?
> >
> > Well, it's calling inflate(), and strace says it is reading
> > e.g. .git/objects/pack/pack-....{idx,pack}.
> >
> > So, I would say so.
> 
> That seems odd that we would be spending extra time there. We do
> inflate() the trees in order to diff the index against HEAD, but we
> shouldn't need to inflate any blobs.

I just did a fresh clone of linux.git, and it doesn't have TREE (and
spends time in inflate).  Then I did a reset --hard, and it gained TREE
(and stopped spending time in inflate).  Then I did a checkout -b, and
TREE was lost again (time in inflate).  hard reset again (to HEAD, so no
change), and TREE returns and status is fast again.

Committing doesn't seem to create a TREE extension where one doesn't
exist.
