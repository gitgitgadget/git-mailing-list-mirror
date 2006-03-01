From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Wed, 1 Mar 2006 07:53:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603010745320.22647@g5.osdl.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
 <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu>
 <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
 <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org> <20060301065138.GC21684@hand.yhbt.net>
 <44056BF1.6000109@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 16:54:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FETeA-0001ey-Ds
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 16:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWCAPxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 10:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWCAPxr
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 10:53:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932408AbWCAPxr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 10:53:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21FrcDZ009405
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 07:53:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21FrV4x004448;
	Wed, 1 Mar 2006 07:53:33 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44056BF1.6000109@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16983>



On Wed, 1 Mar 2006, Andreas Ericsson wrote:
>
> Eric Wong wrote:
> > 
> > Should rev-parse be taught to be less strict and look for basenames
> > that can't be found in heads/ and tags/ in other directories?
> 
> It already does. The search order is this, for a ref named 'foo':
> 	$GIT_DIR/foo
> 	$GIT_DIR/refs/foo
> 	$GIT_DIR/refs/tags/foo
> 	$GIT_DIR/refs/heads/foo

Yes, but I think Eric wanted to avoid having to write the prefix part, 
which git won't let you do right now.

If you have a ref in .git/refs/svn-tracker/git-svn-HEAD, you would have to 
write out all of "svn-tracker/git-svn-HEAD", because unlike a "real 
branch", get_sha1() won't look into the "svn-tracker" without it being 
explicitly mentioned.

Now, some tools will actually do "for_each_ref()" and check the ref-name 
against each of them (so if you pass in "foo", it will check them afainst 
_any_ ref-subdirectory that contains "foo"). But get_sha1() won't.

We could fix get_sha1(), but part of the logic was that other 
subdirectories are special, and as such they _should_ be mentioned, so 
that a file in such a special directory isn't ever confused with a real 
branch.

But if you were to use for example .git/refs/git-svn/tracking as the 
svn-tracking reference head, and then you'd be perfectly able to use

	git log git-svn/tracking..

to see what you've done since the last svn import?

(or use HEAD, if you prefer that over "tracking")

		Linus
