From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-blame, take 2
Date: Thu, 2 Mar 2006 13:45:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603021338130.22647@g5.osdl.org>
References: <20060302212816.GA11015@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Mar 02 22:45:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEvcE-0002Pm-To
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 22:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWCBVpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 16:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWCBVpk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 16:45:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932313AbWCBVpj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 16:45:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k22LjRDZ003915
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Mar 2006 13:45:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k22LjI5f008978;
	Thu, 2 Mar 2006 13:45:23 -0800
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060302212816.GA11015@c165.ib.student.liu.se>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17109>



On Thu, 2 Mar 2006, Fredrik Kuivinen wrote:
> 
> Here is an updated version of git-blame. The main changes compared to
> the first version are:
> 
> * Use the new revision.h interface to do the revision walking
...
> +
> +	num_args = 0;
> +	args[num_args++] = NULL;
> +	args[num_args++] = "--topo-order";
> +	args[num_args++] = "--remove-empty";
> +	args[num_args++] = argv[1];
> +	args[num_args++] = "--";
> +	args[num_args++] = filename;
> +	args[num_args] = NULL;
> +	
> +	setup_revisions(num_args, args, &rev, "HEAD");

Ok, that wasn't really supposed to be necessary.

I guess the above works fine, but it should be perfectly fine to also just 
do a nicer helper function that just initializes rev_info with something 
like

	memset(revs, 0, sizeof(*revs));
	revs->max_count = -1;
	revs->min_date = -1;
	revs->max_date = -1;
	revs->dense = 1;

and then you can just fill in the things you want to directly. Just add 
the commits you want to populate things with to the "revs->commits" list, 
the paths to "revs->paths", set "revs->limited" to 1, and then do the 
"prepare_revision_walk()" and start walking.

But hey, the above "fake the arguments" thing also works. It makes me 
wince a bit, though.

		Linus
