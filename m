X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 11:36:51 -0500
Message-ID: <20061128163651.GG28337@spearce.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061128154434.GD28337@spearce.org> <200611281629.08636.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 16:37:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611281629.08636.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32547>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp5xC-0001bh-Dv for gcvg-git@gmane.org; Tue, 28 Nov
 2006 17:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935881AbWK1Qg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 11:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935882AbWK1Qg4
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 11:36:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41870 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S935881AbWK1Qgz
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 11:36:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gp5wt-0004f7-2x; Tue, 28 Nov 2006 11:36:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7ACBD20FB7F; Tue, 28 Nov 2006 11:36:51 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2006 November 28 15:44, Shawn Pearce wrote:
> 
> > So HEAD in a submodule is the current content of that submodule.
> > Therefore any update-index call on a submodule should load HEAD
> > (totally ignoring whatever branch it refers to) into the supermodule
> > index.
> 
> I was with you right up until here.
> 
> Why should a submodule do anything to the supermodule?  This is like saying, 
> when I edit a working tree file, it should automatically call update-index.  
> The supermodule index should only be updated in response to a manual 
> update-index (or commit -a I suppose).

You misread my poorly written statement.  :-)

What I meant to say was that update-index run in the supermodule
would load the submodule content into the supermodule index; much
as an update-index on a file would load the content of that file
into the index.
 
> IMO, it should always be possible to take a submodule and work on it in 
> isolation - in an extreme case, by moving it out of the supermodule tree 
> entirely.

Aside from sharing object directories, yes.
 
> In summary, from the supermodule's point of view:
>  * A submodule with changed working directory is "dirty-wd"
>  * A submodule with changed index is "dirty-idx" from the supermodule's
>  * A submodule with changed HEAD (since the last supermodule commit) 
>    is "changed but not updated" and can hence be "update-index"ed into the
>    supermodule
>  * A submodule with changed HEAD that has been added to the supermodule index
>    is "updated but not checked in"
>  * A submodule with changed HEAD (since the last supermodule update-index) is
>    both "changed but not updated" _and_ "updated but not checked in", just 
>    like any normal file.
> 
> What's needed then:
>  * A way of telling git to treat a particular directory as a submodule instead
>    of a directory
>  * git-status gets knowledge of how to check for "dirty" submodules
>  * git-commit-tree learns about how to store "submodule" object types in
>    trees.  The submodule object type will be nothing more than the hash of the
>    current HEAD commit.  (This might be my ignorance, perhaps it's just 
>    update-index that needs to know this)

Err, uhm, more like git-write-tree.  git-commit-tree doesn't
care about the tree content.  And all of the tree reading code.
And all object traversal code (e.g. rev-list --objects).  Martin
Waitz's submodule prototype has been working on those details.
Its non-trivial due to the number of locations affected.

> In my head, it would look something like this:
> 
> $ mkdir supermodule; cd supermodule
> $ git init-db
> $ git clone proto://host/submodule.git
> $ git add --submodule submodule
> $ git update-index submodule
> $ git commit -m "Added submodule to supermodule"
> [ edit submodule ]
> $ git status
> submodule is dirty, the working directory has changed
> [ update-index in submodule ]
> $ git status
> submodule is dirty, the index has changed
> [ commit in submodule ]
> $ git status
> submodule is changed but not updated
> $ git update-index submodule
> $ git status
> submodule is updated but not checked in
> $ git commit -m "Record submodule change in supermodule"

Yes, exactly my thoughts on the matter.
 
> Am I crazy?

Maybe, but I'm not a shrink.  Your email looked sane.  :-)

-- 
