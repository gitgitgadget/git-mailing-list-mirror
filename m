From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently detecting paths that differ from each other only in
 case
Date: Fri, 8 Oct 2010 14:56:58 -0500
Message-ID: <20101008195658.GF14311@burratino>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
 <20101008135034.GC5163@sigill.intra.peff.net>
 <AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 22:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4J8K-0004xY-1Y
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 22:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193Ab0JHUAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 16:00:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40139 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165Ab0JHUAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 16:00:09 -0400
Received: by gyg13 with SMTP id 13so205739gyg.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mWyZ8COz9J3Ef6WYvCzCOkh+cRARe4BfW3Z2Lysi6bQ=;
        b=qHoR83jhEzaTXy5MGAQq5hGGHs6vZH9mZkaCiTYs+Wvw2T0LmoKISm5Dj0wGJHN7Ez
         OyJVu20Yfus1sMJOOOxykYuwZS7NNs5yTWcsmQjw3qxWeKKI6GthmSoxSBCae8bo5MUD
         SAe/WgisTFKP7ufQJxoW+3nyUvAd0NQe94WcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c1TlSQMooIAss8PLC3nIMdiWmDhor4tlykbv8T8XRcGz5Ijg16y1GnjVgAqtkCS032
         gfO53bnmqTBZ1Rzlem/9E9n4jR5aIfd2byUEok0E0IjltJfwP5OpnfNvc1ga/NLHaAaZ
         HYGCms/QzTKg+QEIB7uxDOPXphe2P563fZ+YA=
Received: by 10.100.13.9 with SMTP id 9mr896835anm.234.1286568007287;
        Fri, 08 Oct 2010 13:00:07 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 34sm1244672ibi.14.2010.10.08.13.00.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 13:00:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158532>

Dun Peal wrote:

> git ls-files thus takes a long time, almost a second. Since this is a
> commit-heavy repo, I'd rather avoid that overhead.
> 
> Incidentally, there's an SVN hook that does the exact same thing that
> I want to do:
> 
> http://svn.apache.org/repos/asf/subversion/trunk/contrib/hook-scripts/case-insensitive.py

Well, can't you do the same thing that hook does?

1. Decide on the desired semantics.

Should a broken push of multiple branches be entirely rejected, or
just the broken branches?  The answer determines whether you should
be using a pre-receive or an update hook; see githooks(5).

2. Get a list of added files with git-diff-tree(1) --diff-filter.
3. Break file names into directory + basename.
4. For each directory with new files or subdirectories:
    - List its children in the new version with git-ls-tree(1)
    - Canonicalize path names
    - Find clashes

If this should be general-purpose, take care to handle:

 - new branches (<old-value> = 00000000...)
 - new subdirectory whose name clashes with an existing file
 - filename clash within a new subdirectory

Good luck,
Jonathan
