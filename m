X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GIT - releases workflow
Date: Wed, 13 Dec 2006 05:56:14 -0500
Message-ID: <20061213105614.GB9484@spearce.org>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com> <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de> <1166001019.19098.4.camel@localhost.localdomain> <Pine.LNX.4.63.0612131133160.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 10:56:30 +0000 (UTC)
Cc: Matthias Kestenholz <lists@spinlock.ch>,
	Sean Kelley <sean.v.kelley@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612131133160.3635@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34207>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuRmk-0000a2-6Q for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932288AbWLMK4U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 05:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWLMK4U
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:56:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59617 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932288AbWLMK4U (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 05:56:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuRmX-0007vu-AF; Wed, 13 Dec 2006 05:56:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 64E6620FB6E; Wed, 13 Dec 2006 05:56:14 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Tue, 12 Dec 2006, Sean Kelley wrote:
> > > 
> > > > I was wondering if anyone could share ideas on how best to use GIT to 
> > > > handle releases for those working with a remote GIT repository?  Do you 
> > > > create a branch and push it to the remote?  Thus you have a new branch 
> > > > referencing the particular release?
> 
> BTW, if the maintenance releases are sparse and long between, you can 
> actually create the branch from the tag, fix, and tag with the new version 
> number. No need to start the branches early.

Indeed.

I actually have a fancy (==~800 poorly written lines) Perl script that:

 * Creates a "build" git repository using objects/info/alternates.
   The user can reuse an existing directory if they have one.
   (Obviously reusing an existing directory is faster, less files
   to setup in the working directory.)

 * Offers the user a menu of top 10 most recent tags to choose as
   a base version.  Tags are displayed first sorted by which tag
   is considered to be in which runtime environment (QA testing,
   end user testing, production release), then by tag date for
   those tags not in any specific environment.

 * Offers the user a menu of branches in a pre-configured namespace
   (e.g. refs/heads/ready) which have commits not yet merged into
   the selected base.  Users can attempt to pull as many branches
   as they like, the script merges each in turn until none remain
   or the user says "build!".

 * Increments the last component of the 'version number' of the tag
   and makes an annotated tag object in the local build repository.

 * Runs the project's configured build command (from repo-config
   taken from builder.command variable).

 * If builder.command is successful pushes the tag back to the origin
   repository; if builder.command fails pushes the HEAD revision
   up as a branch (e.g. refs/heads/failed/foo) so that someone more
   skilled in the art of failed builds can look into the matter.

The script is really meant for QA people to take in topic branches
from developers and apply them to a specific version, test that new
version, then ship that new version.  Some of the QA people I work
with aren't developers and have a somewhat difficult time making
a build from source; this script makes it a pretty simple process.

The version number incrementor is smart; its based off commit
lineage.  It can automatically create a "2.0.1" tag when "2.1"
has already been made but "2.0.1" is a bugfix of "2" or "2.0".

I should clean it up some and post it, just in case others may
be interested.  I'll try to do that this weekend.

-- 
