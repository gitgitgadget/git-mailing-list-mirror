From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 16:00:45 -0500
Message-ID: <20070221210045.GB26525@spearce.org>
References: <20070221164527.GA8513@ginosko.local> <20070221165636.GH25559@spearce.org> <20070221171738.GA9112@fieldses.org> <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 22:01:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJyaC-0003FK-9T
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 22:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423112AbXBUVA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 16:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423116AbXBUVA5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 16:00:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52328 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423112AbXBUVA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 16:00:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJyZr-0008G3-Ne; Wed, 21 Feb 2007 16:00:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E004020FBAE; Wed, 21 Feb 2007 16:00:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40325>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Anyway, git-convert-objects does kind of give you a starting point. It 
> should be fixed to use "git-fast-import" or repack once in a while (so 
> that it doesn't leave tons and tons of unpacked objects), and it should be 
> fixed to fix up any commit messages that mention SHA1's that it has 
> already converted to something else, but it seems to still work. It would 
> not be impossible at all to extend the tree-rewriting logic to remove some 
> file or a particular SHA1 object you want to replace.

One idea Junio and I kicked around on #git a short while ago
was to arrange for a pipe between the current Git process
and git-fast-import, where the pipe was used from within
write_sha1_file() rather than creating the loose object.

This way an existing process like git-apply or git-convert-objects
could easily spew hundreds of thousands of objects without needing
to worry about repacking in the middle; nor would we need to worry
about the complexity of trying to disentagle the multiobject packing
parts of fast-import into some sort of library.

Obviously this is only a good idea if we are going to be making
enough objects to warrant using a packfile; small 10-20 bursts
of objects from a git-apply doesn't really justify a packfile.
But applying 100s of patches in a row might, if we could keep them
all fed through the same git-fast-import backend (and thus into
the same packfile).

-- 
Shawn.
