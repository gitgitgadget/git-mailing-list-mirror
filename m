From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 09/13] Replace inefficient new String(String)
	constructor to silence FindBugs
Date: Wed, 29 Apr 2009 13:22:42 -0700
Message-ID: <20090429202242.GI23604@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org> <1240953146-12878-9-git-send-email-spearce@spearce.org> <1240953146-12878-10-git-send-email-spearce@spearce.org> <200904292210.49627.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Simon <yann.simon.fr@gmail.com>,
	Matthias Sohn <matthias.sohn@sap.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:23:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzGJC-0000EK-1Y
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758994AbZD2UWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbZD2UWn
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:22:43 -0400
Received: from george.spearce.org ([209.20.77.23]:48734 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbZD2UWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:22:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3867438069; Wed, 29 Apr 2009 20:22:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904292210.49627.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117939>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdag 28 april 2009 23:12:22 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > FindBugs keeps reporting that our usage of new String(String)
> > is not the most efficient way to construct a string.
> 
> I think we should find better ways of silencing FindBugs,, than addiing obscure
> coding patterns that are worse than what FindBugs warns against. 

Heh.  Yea, well...  I also wasn't too happy with FindBugs for
this one.

As far as I can tell there isn't anything in the documentation that
suggests that new String(String) behaves the way I want it to here.

It seems a JRE may be free to reuse the same internal char[] as
the source string, and just produce a new String wrapper.  What I
really want is a deep copy of that char[] to shed what I know is
garbage around the interesting part.

The use of StringBuilder makes this sort of anti-optimization
more difficult, as most JRE implementations would likely
assume they should alloc the internal char[] at the size
given in the constructor, and will deep-copy the chars during
append(String,int,int) because they would expect to see more
characters appended after this append call.

Perhaps the only way to really enforce the behavior I want here is
to convert the String segment to a char[], and then convert that
char[] into a String.  Ick, that's two copies.

Maybe we just stick a comment here.  Two different people have
come up with the same FindBugs issue, trying to get them to share
configuration files sounds hard.
 
> Options are: 
> 	Add a comment 
> 	Customize findbugs rules
> 	Findbugs specific annotations

-- 
Shawn.
