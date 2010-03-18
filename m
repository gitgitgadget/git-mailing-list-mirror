From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH 6/9] fetch: Check if all objects exist after fetching
Date: Thu, 18 Mar 2010 20:36:46 +0100
Organization: SUSE Labs
Message-ID: <201003182036.46874.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de> <d3c00e2a27003dca196d5480007544610cc1e5b8.1268913163.git.agruen@suse.de> <20100318190816.GE10981@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:37:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLWZ-00045M-6w
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab0CRTgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:36:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:41822 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab0CRTgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:36:49 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 56E2593A00;
	Thu, 18 Mar 2010 20:36:48 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20100318190816.GE10981@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142502>

On Thursday 18 March 2010 20:08:16 Shawn O. Pearce wrote:
> Andreas Gruenbacher <agruen@suse.de> wrote:
> > Check if all objects reachable from the fetched refs exist after
> > fetching instead of before: this allows us to distinguish between a
> > repository which is not up to date and a corrupted repository, and to
> > ensure that the repository is up to date and complete after the fetch.
> 
> I'm against this particular change because it looks like it breaks
> the idea of "quickfetch", which we introduced to support faster
> fetches from the parent repository into a shared clone on the
> same disk.

I think you misunderstand the patch.  Before the patch, we were doing a rev-
list to determine if all objects needed are present.  If rev-list fails, this 
can have two reasons: (a) some of the branches or tags needed do not exist, 
(b) all the branches and tags needed do exist, but other objects further up 
the tree are missing (i.e., a corrupted repository).

The patch changes that to first check which needed objects are missing (with 
has_sha1_file()), which is very efficient, by then fetching the objects which 
surely need to be fetched, and by then checking the repository consistency 
with rev-list.  If rev-list then fails, which should only happen in the rarest 
cases, we know that we need to fetch all branches and tags so that we are sure 
to catch missing objects further up the tree.

So we never fetch more than we did before, and in some cases, we fetch less. 
We are also guaranteed to end up with a consistent repository in the end. (The 
old logic does not always guarantee that AFAICT: there seems to be one corner 
case where a fetch succeeds without retrieving missing objects further up the 
tree.)

Thanks,
Andreas
