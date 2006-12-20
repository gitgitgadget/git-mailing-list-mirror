X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Bug: git-svn fails on Mediawiki SVN repo r2992
Date: Tue, 19 Dec 2006 17:36:34 -0800
Message-ID: <20061220013634.GA3901@localdomain>
References: <20061219235312.GB12756@thorium2.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 01:36:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061219235312.GB12756@thorium2.jmh.mhn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34887>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwqNw-0003TZ-Ck for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964770AbWLTBgi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932943AbWLTBgi
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:36:38 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34269 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932912AbWLTBgh
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 20:36:37 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 98AA77DC02A; Tue, 19 Dec 2006 17:36:34 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 19 Dec 2006
 17:36:34 -0800
To: git@vger.kernel.org, bleher@informatik.uni-muenchen.de
Sender: git-owner@vger.kernel.org

Thomas Bleher <bleher@informatik.uni-muenchen.de> wrote:
> There is some problem between git-svn (v1.4.4.1.gad0c3) and MediaWiki
> SVN when cloning their repo.
> 
> I just did
> $ git-svn init http://svn.wikimedia.org/svnroot/mediawiki/trunk/phase3
> $ git-svn fetch -r 2991:3122
> and git-svn went into an endless loop, repeatedly downloading and adding
> the same files from r2992 over and over again.

I'm not sure that it was 'endless', just unnecesarily repeating itself.
commit 6173c197c9a23fa8594f18fd2c856407d4af31c1 (included in 1.4.4.2)
should have fixed your problem...

> The bad revision can be viewed here:
> http://svn.wikimedia.org/viewvc/mediawiki?view=rev&revision=2992
> It adds ~1000 files (mostly small images).
> I can check out this revision just fine using the svn command line
> client.

The latest git-svn in git.git now bundles all the changed files into a
delta on the server side; and is significantly faster over most network
connections as a result.

> I found this problem while cloning this repo a while ago, using a
> slightly older version of git (probably 1.4.3, don't remember exactly).
> In this repo, some directories appeared in the latest revisions which
> were deleted a long time ago.
> 
> You can temporarily browse this repo here:
> http://misc.j-crew.de/cgi-bin/gitweb.cgi?p=mediawiki.git
> HEAD contains the dir Smarty-2.6.2, which was removed in SVN r3122.
> Strangely, my repo misses all commits between r2991 and r3822.
> You can see the gap at
> http://misc.j-crew.de/cgi-bin/gitweb.cgi?p=mediawiki.git;a=shortlog;h=49e761ba51ee0d0a698999451134acbf2e078c03
> 
> I didn't notice any strange errors while cloning, but I had to abort and
> restart git-svn a few times, so maybe there was some error there?

Hmm, it looks like you ran something like:

	git-svn fetch -r0:2991

and then something along the lines of:

	git-svn fetch -r3822:HEAD

Is that what happened?

Looking at the pre-delta git-svn code, it seems that using -r with fetch
at any time other than the initial fetch will result in botched
history...

-- 
