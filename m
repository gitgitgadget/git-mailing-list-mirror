From: Christopher Li <git@chrisli.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 06:38:52 -0400
Message-ID: <20050628103852.GB21533@64m.dyndns.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org> <20050627235857.GA21533@64m.dyndns.org> <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 15:57:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnGZz-00044S-4m
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 15:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVF1N6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 09:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVF1Nzm
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 09:55:42 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5791 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262004AbVF1Nvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 09:51:39 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2005062813513701400r64iee>; Tue, 28 Jun 2005 13:51:37 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 2E9593F17F; Tue, 28 Jun 2005 06:38:53 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

That is all nice improvement to address the space usage issue.

Should people just run repacking once a while or is it automaticly
add new object to the pack file?

Chris


On Mon, Jun 27, 2005 at 08:30:22PM -0700, Linus Torvalds wrote:
> 
> Deltas do exist inside pack-files, yes. They just don't exist as 
> independent objects any more, so you can never get into the situation that 
> you find a delta but you don't find the delta it points to.
> 
> Because in the pack-files, there are only deltas _within_ a pack-file. You 
> can't have a delta that points to outside the pack.
> 
> This means that pack-files with few objects will inevitably be larger than
> they could otherwise be (ie you can never have a pack file that _only_
> contains deltas to the outside world), but it's just incredibly reassuring 
> to me that a pack-file is always self-sufficient. 
> 
> So when/if we start using pack-files for doing "git pull" etc, the 
> pack-file won't actually help pack things for small updates: small updates 
> will probably contain the whole changed file, unless the update has 
> several changes to the same file (which is not unusual, of course), in 
> which case it will only contain one version and then deltas from that.
> 
> But the savings get increasingly bigger the more history we have. That's
> also why the packed git archive is about 1/14th of the size of the fully
> unpacked disk usage of the git project, but a packed kernel archive "only"  
> achieves a packing rate of 1/5th of the fully unpacked kernel archive. The
> git archive is all history, while the kernel archive just "appears", and
> 2/3 of the files have only one single version and thus don't delta-
> compress at all.
> 
> (Another reason is probably that the kernel has bigger files, which means
> that it thus has relatively less loss in filesystem block padding).
> 
> But not having any outside deltas not only makes me feel safer, it also
> means that you can fully validate a pack archive consistency without even
> knowing what project it is from - you can check the SHA1 results of every
> file in the pack against the index of the pack, and check that the SHA1's
> of the pack files themselves are valid. Again, this is just a data
> _consistency_ check, of course - it means that you can validate that it
> downloaded fine, and that you don't have disk corruption, but it doesn't
> mean that the data isn't evil and nasty and buggy ;)
> 
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
