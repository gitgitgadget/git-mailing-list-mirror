From: Sam Vilain <sam@vilain.net>
Subject: Re: git filter-branch should run git gc --auto
Date: Wed, 23 Jan 2008 18:07:04 +1300
Message-ID: <4796CB78.2070607@vilain.net>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk> <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma> <20080120093436.GA10924@diana.vm.bytemark.co.uk> <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org> <20080121224818.GA8872@untitled> <7vr6gawvkt.fsf@gitster.siamese.dyndns.org> <20080122003911.GA16453@hand.yhbt.net> <7vtzl6vd7v.fsf@gitster.siamese.dyndns.org> <BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org> <7v1w89qmw3.fsf@gitster.siamese.dyndns.org> <60D6C8F5-EF88-48F0-92CA-8E49838C0CB9@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 06:07:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHXqB-0005c4-5Q
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 06:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYAWFHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 00:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbYAWFHM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 00:07:12 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:58767 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbYAWFHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 00:07:10 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 6115F21D115; Wed, 23 Jan 2008 18:07:08 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id C205621D108;
	Wed, 23 Jan 2008 18:07:04 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <60D6C8F5-EF88-48F0-92CA-8E49838C0CB9@sb.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71510>

Kevin Ballard wrote:
> I'm actually considering what the cost would be of switching macports  
> to git (not that it will ever happen - too many anonymous people pull  
> from svn trunk). Right now the svn trunk contains a subfolder for the  
> source code and another subfolder for all ~4400+ Portfiles. In such a  
> theoretical move, I'd want to split that up, probably into two  
> unrelated branches. Doing so would mean running git-filter-branch over  
> a linear commit history that's 31580 objects long, with a tree filter  
> to prune the dports directory away and a msg filter to remove the svn- 
> id stuff that git-svn left behind.

You could have used git-svn --no-metadata :)

Using a commit filter to implement the pruning will be much faster;
you'll need to make a temporary index, use git-read-tree, git-rm, then
git-commit.  This way you avoid the expense of checking out the files
just to delete them in your rewrite hook.

> I'd also have to  
> figure out some way to remove the commit objects entirely that only  
> reference the dports directory. 

This can be done with a parent filter.

> I'd suggest a patch to run git gc --auto, but it looks like you just  
> did in a subsequent email. As for your comments about the reflogs,  
> can't I disable recording those, at least temporarily? I'd rather  
> clean up after myself as I work rather than balloon the repository and  
> collapse it in a single operation at the end.

Honestly, the optimisation I mention above will save you much more time.
 Note that you can run git-repack -d every half hour out of cron, it is
safe and will let it clean as you go.

Sam.
