From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 15:50:23 -0700
Organization: Hewlett Packard
Message-ID: <20060224225023.GA28538@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain> <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain> <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain> <20060224192354.GC387@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241438521.31162@localhost.localdomain> <20060224204022.GA15962@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241544270.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 23:51:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FClmF-0005Cu-Bx
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 23:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWBXWuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 17:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWBXWuu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 17:50:50 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:7603 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932626AbWBXWuu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 17:50:50 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel8.hp.com (Postfix) with ESMTP id 5C80A3556E;
	Fri, 24 Feb 2006 17:50:49 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 836D31D00;
	Fri, 24 Feb 2006 22:50:23 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 550F5BFA3; Fri, 24 Feb 2006 15:50:23 -0700 (MST)
To: Nicolas Pitre <nico@cam.org>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602241544270.31162@localhost.localdomain>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16746>

On Fri, Feb 24, 2006 at 04:12:14PM -0500, Nicolas Pitre wrote:
> On Fri, 24 Feb 2006, Carl Baldwin wrote:
> > After the twelve large objects were packed into individual packs the
> > rest of the packing went very quickly and git v1.2.3's date reuse worked
> > very well.  This was sort of my attempt at simulating how things would
> > be if git avoided deltification of each of these large files. I'm sorry
> > to have been so harsh earlier I just didn't understand that
> > incrementally packing one-by-one was going to help this much.
> 
> Hmmmmmmm....
> 
> I don't think I understand what is going on here.
> 
> You say that, if you add those big files and incrementally repack after 
> each commit using git repack with no option, then it requires only about 
> one second each time.  Right?

Well, actually I was packing them individually by calling
git-pack-objects directly on each blob.

I'll try doing it exactly as you describe...

Ok, I tried it.  Basically I do the following.

% mkdir test
% cd test
% git init-db
% cp ../files/binfile.1 binfile
% time git add binfile

real    0m2.459s
user    0m2.443s
sys     0m0.019s
% git commit -a -m "Rev 1"
% time git repack
[snip]

real    0m1.111s
user    0m1.046s
sys     0m0.061s
% for i in $(seq 2 12); do
    cp ../files/binfile.$i binfile
    time git commit -a -m "Rev $i"
    time git repack
done

Each commit takes around 2.8-3.5 seconds and each repack takes about
1.2-1.5 seconds.  These are prettly reasonable.

Now, I try 'git repack -a -f' (or even without -f) and it goes out to
lunch.  I think it would take on the order of a day to actually finish
because it wasn't very far after an hour.

[snip]
> How many files besides those 12 big blobs do you have?

This repository has been completely stripped to the 12 revisions of the
one file.  So, there are 36 objects.

12 blobs.
12 trees.
12 commits.

That is all.

[snip]
> If you can add them into a single .tgz with instructions on how 
> to reproduce the issue and provide me with an URL where I can fetch it 
> that'd be perfect.

I will do this in an email off of the list because these files really
shouldn't be available on a public list.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
