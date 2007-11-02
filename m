From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Debugging corrupt object generation
Date: Fri, 2 Nov 2007 01:15:55 -0400
Message-ID: <20071102051555.GB14735@spearce.org>
References: <Pine.LNX.4.64.0711012256080.17812@beast.quantumfyre.co.uk> <alpine.LFD.0.9999.0711011947220.21255@xanadu.home> <Pine.LNX.4.64.0711020018400.18429@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 02 06:17:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inotx-0004Va-Ph
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 06:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbXKBFQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 01:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbXKBFQF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 01:16:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40017 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbXKBFQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 01:16:04 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Inosu-0006Vz-Q8; Fri, 02 Nov 2007 01:15:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 975EF20FBAE; Fri,  2 Nov 2007 01:15:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711020018400.18429@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63063>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Thu, 1 Nov 2007, Nicolas Pitre wrote:
> >
> >Maybe fast-import hasn't flushed the needed data to the pack yet?
> 
> Well, fast-import completes quite happily and outputs the normal summary 
> status.  I can look at logs and trees etc provided that I don't try and 
> look at one particular part of the tree on one particular commit.  I 
> think the problem is that I've managed to do something inside fast-import 
> that corrupts one particular tree object (though I've no idea what that 
> might be).

Ahhh.  I'm betting you messed up the version 0 and version 1 arrays
inside of the struct tree_entry.  This could cause the delta
generator to look at the wrong base information when it creates
the delta, thus causing the delta to be created for a different
base than what the object is actually using in the packfile.

The version[0] is meant to hold the mode and SHA-1 of the tree_entry
in the base object.  The version[1] is meant to hold the current
mode and SHA-1 of the tree_entry in the new object.  A mode of 0
means the entry doesn't exist in that particular tree; so an add
is shown as "version[0].mode = 0; version[1].mode = 0100644".

Look at the store_tree function, this is where we regenerate the
canonical representation of both the version[0] and the version[1]
trees so the store_object function can generate a delta.  Note that
we assume the base object name is root->versions[0].sha1.  Maybe the
version[0] array doesn't actually match the tree named by that sha1?

-- 
Shawn.
