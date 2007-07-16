From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Mon, 16 Jul 2007 22:04:04 +0200
Message-ID: <20070716200404.GT999MdfPADPa@greensroom.kotnet.org>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707160054340.14781@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAWo0-0002C7-L9
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 22:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759433AbXGPUEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 16:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbXGPUEJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 16:04:09 -0400
Received: from smtp14.wxs.nl ([195.121.247.5]:41680 "EHLO smtp14.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759386AbXGPUEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 16:04:06 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JLA00GVLFQSJR@smtp14.wxs.nl> for git@vger.kernel.org; Mon,
 16 Jul 2007 22:04:04 +0200 (CEST)
Received: (qmail 13947 invoked by uid 500); Mon, 16 Jul 2007 20:04:04 +0000
In-reply-to: <Pine.LNX.4.64.0707160054340.14781@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52713>

On Mon, Jul 16, 2007 at 01:38:11AM +0100, Johannes Schindelin wrote:
> Didn't I mention that it was a severe limitation to think of the sha1 
> mapping of a 1-to-1 mapping?  Think of it more as a relation.

The mapping is used in several operations.
First, there are several things that can happen to a commit

- it's pruned.  This includes, for me, path pruning, matching
  and a commit filter returning no SHA1s.
- it's rewritten to another commit that can be considered the
  "moral equivalent" of that commit.  This occurs when a commit
  is not pruned, but something else happened to the commit itself or
  one of its ancestors.  This excludes, for me, the case
  where a commit filter returns more than one SHA1.
- it's replaced by more than one SHA1.  This can only happen
  in a commit filter.

There are at least four operations in which this mapping is used:

- if the parents of a commit have been rewritten to one or more
  commits, then they are replaced by the new commits.
  If any parent has been pruned, then it is replaced by
  the result of applying this operation on _its_ parents.
- any reference (in refs/) that points to a rewritten or pruned
  commit is removed and
    * if the commit was rewritten to a single commit, then it is
      replaced by this commit
    * otherwise, there is no moral equivalent single commit, but
      we want to ensure we can still access the new commits, so
      I create several references, either to each of the many
      commits the old commit was rewritten to, or to each of
      its nearest unpruned ancestors (i.e., the same set as
      described in the previous operation).
- a SHA1 of a commit that appears in a commit message is replaced
  by the rewritten commit iff it was rewritten to a single commit.
  That is, if the commit was pruned or rewritten (through a commit
  filter to more than one commit), then the SHA1 is left alone.
- the mapping available to filters
    * if the commit was pruned, an empty file is created
    * otherwise a file is created containing all rewritten SHA1s

I understand you want the second operation to only apply
to refs explicitly mentioned on the command line.
What else would you like to change?

skimo
