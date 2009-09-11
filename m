From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ JGIT ] incompatiblity found in DirCache
Date: Fri, 11 Sep 2009 08:05:23 -0700
Message-ID: <20090911150522.GI1033@spearce.org>
References: <4AA7FA2B.4090707@writeme.com> <200909092311.07145.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Adam W. Hawks" <awhawks@writeme.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 17:05:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm7gn-0002E3-QK
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 17:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbZIKPFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 11:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbZIKPFU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 11:05:20 -0400
Received: from george.spearce.org ([209.20.77.23]:55936 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZIKPFU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 11:05:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 23F243815E; Fri, 11 Sep 2009 15:05:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200909092311.07145.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128198>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> onsdag 09 september 2009 20:55:39 skrev "Adam W. Hawks" <awhawks@writeme.com>:
> > When using the DirCache interface to the index you can create a
> > invalid/corrupt tree for git 1.6.5.
> > 
> > The problem seems to be you can add a path to the index that starts
> > with a "/" and DirCache creates a entry with a mode but no path.
> > This causes git 1.6.5 to fail with a corrupt tree.
> 
> I think there are more ways of entering bad stuff. Preventing a
> deliberate programmatic creation of invalid trees is probably not
> the most important thing, but then again, validating the data to
> prevent e.g. the EGit plugin from doing it by mistake due to bugs
> could probably be worthwhile.

We already check for and fail fast on a 0 mode in DirCache, as this
mode is also not valid in the index, or in a git tree.

We should be doing the same thing for an empty path name.  "a//b" is
not a valid path in the index, as "" is not a valid tree entry path.
For the same reason, "/a" is not a valid path in the index.

Unfortunately our API also allows you to try and create a name of
"a\u0000b", which is a valid Java string, but will create a corrupt
tree.  \u0000 in a name with more than 4095 bytes will also create
a corrupt index (shorter strings are semi-valid because shorter
strings use a Pascal like string format, and longer ones use a C
like string format).  Though C git is unable to access a path whose
name contains "\u0000", no matter how long the string is.

I think we should try a bit harder in DirCache to prevent these sorts
of really bad entries from being constructed by application code.
Yes, applications should not do this, but I think the library also
should not write known bogus trash to the disk and claim it is OK.

I'll try to work up a patch for this today.

-- 
Shawn.
