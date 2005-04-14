From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 20:12:24 +0200
Message-ID: <20050414181224.GA16126@elte.hu>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:13:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM8p2-0004dt-JJ
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVDNSPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVDNSPU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:15:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40123 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261594AbVDNSMs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 14:12:48 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 643623197AB;
	Thu, 14 Apr 2005 20:11:38 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id AFE301FC2; Thu, 14 Apr 2005 20:12:27 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> I've been looking at tracking file revisions. One proposed solution 
> was to have a separate revision history for individual files, with a 
> new kind of 'filecommit' object which parallels the existing 'commit', 
> referencing a blob instead of a tree. Then trees would reference such 
> objects instead of referencing blobs directly.
> 
> I think that introduces a lot of redundancy though, because 99% of the 
> time, the revision history of the individual file is entirely 
> reproducible from the revision history of the tree. It's only when 
> files are renamed that we fall over -- and I think we can handle 
> renames fairly well if we just log them in the commit object.

how about the following structure:

    - tree_new --->
    - tree_old ---> rename_commit -> blob

the rename_commit object just contains a pointer to the file content 
blob. If a rename happens then the old tree references the rename_commit 
object (instead of the blob), and the new tree references it too. This 
way there's no need to list the rename via namespace means: if a tree 
entry points to a rename_commit object then a rename happened and the 
rename_commit object is looked up in the old tree to get the old name.

there's no redundancy caused by this method: only renames (which are 
rare) go through the rename_commit redirection. (to speed up the lookup 
the rename_commit object could cache the offset of the two names within 
their tree objects.)

	Ingo
