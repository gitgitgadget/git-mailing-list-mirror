From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: .gittattributes handling has deficiencies
Date: Mon, 22 Oct 2007 01:01:11 -0400
Message-ID: <20071022050111.GL14735@spearce.org>
References: <1192956535617-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710210204580.4818@asgard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Oct 22 07:01:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjpPs-0008UA-K4
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbXJVFBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXJVFBQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:01:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45224 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbXJVFBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:01:15 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjpPd-0005ns-SX; Mon, 22 Oct 2007 01:01:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DF36B20FBAE; Mon, 22 Oct 2007 01:01:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710210204580.4818@asgard>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61932>

david@lang.hm wrote:
> On Sun, 21 Oct 2007, Steffen Prohaska wrote:
> >If a .gitattributes is in the work tree and we checkout a
> >different head, the .gitattributes of the head we are switching
> >to must have precedence.
> >
> >Maybe the gitattributes of a file should be part of the per-file
> >flags in the index. Thus we could verify if the flags changed and
> >if so, adjust the work tree accordig to the new flags.  I'm
> >lacking a deeper insight into the git internals.  Therefore, I
> >can't really say if the index is the right place.  But it looks
> >to me as if changing an attribute should be treated similar to a
> >changing sha1, as far as the work tree is concerned.
> 
> the problem with this is that each attribute ends up needing it's own 
> flag, which severely limits extending things (see the discussions on file 
> permissions for examples). it's also much harder to manipulate them then 
> in a file.

Yea, you really don't want to copy .gitattributes into the per-file
records in the index.  That's not going to scale as more types of
attributes are defined.

Fortunately the .gitattributes file format was designed to be
readable even when there's merge conflicts; that is it is a
very simple line-oriented record format.  One could difference
the old .gitattributes currently found in the index against the
.gitattributes we are switching to (from the target tree-ish),
scan the lines removed/added, find which files those match against
in the target tree-ish, and just add those files to the list of
things we need to checkout.

If any of those files is dirty then we just refuse the checkout,
just as if the file was modified and we were switching branches.
The user then needs to decide how to continue (probably stash the
file and then restart the checkout).

Rather simple IMHO.  Of course I haven't gone into that part of
read-tree recently, and the .gitattribute parser reads from the
working directory, so you need to make sure you checkout the target
.gitattributes file before anything else in the "to process list".

-- 
Shawn.
