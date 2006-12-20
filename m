X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Bug: git-svn fails on Mediawiki SVN repo r2992
Date: Wed, 20 Dec 2006 10:37:37 +0100
Message-ID: <20061220093736.GA5402@thorium2.jmh.mhn.de>
References: <20061219235312.GB12756@thorium2.jmh.mhn.de> <20061220013634.GA3901@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
NNTP-Posting-Date: Wed, 20 Dec 2006 09:35:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org, bleher@informatik.uni-muenchen.de
Content-Disposition: inline
In-Reply-To: <20061220013634.GA3901@localdomain>
X-Accept-Language: de, en
X-Operating-System: Linux 2.6.17-10-generic i686
User-Agent: Mutt/1.5.12-2006-07-14
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34913>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwxrA-0000ii-BW for gcvg-git@gmane.org; Wed, 20 Dec
 2006 10:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964926AbWLTJfV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 04:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWLTJfV
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 04:35:21 -0500
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:46963 "EHLO
 mailrelay2.lrz-muenchen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964926AbWLTJfT (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 04:35:19 -0500
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by
 mailout.lrz-muenchen.de for git@vger.kernel.org; Wed, 20 Dec 2006 10:35:16
 +0100
Received: (qmail 17991 invoked from network); 20 Dec 2006 09:35:16 -0000
Received: from thorium2.jmh.mhn.de (HELO localhost.localdomain)
 (10.151.1.138) by cobalt.jmh.mhn.de with SMTP; 20 Dec 2006 09:35:16 -0000
Received: by localhost.localdomain (Postfix, from userid 1000) id 22A1F926DC;
 Wed, 20 Dec 2006 10:37:38 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* Eric Wong <normalperson@yhbt.net> [2006-12-20 02:36]:
> Thomas Bleher <bleher@informatik.uni-muenchen.de> wrote:
> > There is some problem between git-svn (v1.4.4.1.gad0c3) and MediaWiki
> > SVN when cloning their repo.
> > 
> > I just did
> > $ git-svn init http://svn.wikimedia.org/svnroot/mediawiki/trunk/phase3
> > $ git-svn fetch -r 2991:3122
> > and git-svn went into an endless loop, repeatedly downloading and adding
> > the same files from r2992 over and over again.
> 
> I'm not sure that it was 'endless', just unnecesarily repeating itself.
> commit 6173c197c9a23fa8594f18fd2c856407d4af31c1 (included in 1.4.4.2)
> should have fixed your problem...

It fetched every file at least three times, and I had to kill it after
that, it had been running for over an hour already.
I just retried with current next, and it's _much_ faster, under one
minute now for this particular revision.

So consider this problem solved, and thanks a lot!

> > The bad revision can be viewed here:
> > http://svn.wikimedia.org/viewvc/mediawiki?view=rev&revision=2992
> > It adds ~1000 files (mostly small images).
> > I can check out this revision just fine using the svn command line
> > client.
> 
> The latest git-svn in git.git now bundles all the changed files into a
> delta on the server side; and is significantly faster over most network
> connections as a result.

Yeah, this is a huge gain.

> > I found this problem while cloning this repo a while ago, using a
> > slightly older version of git (probably 1.4.3, don't remember exactly).
> > In this repo, some directories appeared in the latest revisions which
> > were deleted a long time ago.
> > 
> > You can temporarily browse this repo here:
> > http://misc.j-crew.de/cgi-bin/gitweb.cgi?p=mediawiki.git
> > HEAD contains the dir Smarty-2.6.2, which was removed in SVN r3122.
> > Strangely, my repo misses all commits between r2991 and r3822.
> > You can see the gap at
> > http://misc.j-crew.de/cgi-bin/gitweb.cgi?p=mediawiki.git;a=shortlog;h=49e761ba51ee0d0a698999451134acbf2e078c03
> > 
> > I didn't notice any strange errors while cloning, but I had to abort and
> > restart git-svn a few times, so maybe there was some error there?
> 
> Hmm, it looks like you ran something like:
> 
> 	git-svn fetch -r0:2991
> 
> and then something along the lines of:
> 
> 	git-svn fetch -r3822:HEAD
> 
> Is that what happened?

Nope. I just ran "git-svn fetch" repeatedly, and stopped it a few times
with ^C (the import was running for several days, and I had to turn off
the computer inbetween). Maybe something broke there?
Anyway, it's working now, so I think we can consider this problem
solved.

Thanks,
Thomas
