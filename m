From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 10/10] BROKEN TEST: ObjectLoader stays valid
	across repacks
Date: Wed, 22 Apr 2009 09:33:50 -0700
Message-ID: <20090422163349.GN23604@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org> <1240276872-17893-10-git-send-email-spearce@spearce.org> <1240276872-17893-11-git-send-email-spearce@spearce.org> <200904220116.51076.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 18:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwfPz-0006Lo-GO
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 18:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbZDVQdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 12:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbZDVQdv
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 12:33:51 -0400
Received: from george.spearce.org ([209.20.77.23]:45485 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbZDVQdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 12:33:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0A41338211; Wed, 22 Apr 2009 16:33:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904220116.51076.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117215>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> So, I had an idea and started hacking and suddenly the supposedly ok cases
> started crashing like this.
> 
> org.spearce.jgit.errors.MissingObjectException: Missing unknown 4a75554761c96be80602c05145d1ef41c77e1b72

You broke it!  :-)

> The hash codes printed are the same everytime it crashes, removing
> the invalid flags will create these codes and the test succeeds.

I am not surprised.  The hash codes are derived from the system
identity hash code for the object, which are assigned using a rather
deterministic algorithm.  Given the same sequence of tests through
the JVM and the same heap state, you are likely going to have the
same hash code for the same objects every run.

Actually, I think you missed it, but the two sets of hash codes
you printed here in the email are identical.
 
> One cannot obviously assume they are the same, but the numbers might be a lead to why it crashes here. Looks
> like as hash collision and a failure of the "equals" part to distinguish different WindowedFile's.

Nope, that's not it.  We never use .equals() on WindowedFile,
and we never use that hash field you were printing as any part
of an equality computation.  That hash field is mixed with the
offset of a window to hash it into the WindowCache.  We *always*
use reference equality ("foo.wp == wp") to test a WindowedFile.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
> index 9293eb9..f9e1991 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
> @@ -80,6 +80,8 @@
>  	/** Total number of windows actively in the associated cache. */
>  	int openCount;
>  
> +	boolean invalid;

This shadowed the "invalid" field in PackFile, causing the anonymous
inner class on l.93-103 that subclasses WindowedFile to write to
this new field, while PackFile still read from its own field.

If you had called this "invalid2", or marked it private, you
wouldn't have seen the test failure.


FWIW, I've decided to merge PackFile and WindowedFile together.
There is no point in keeping them separate anymore.  We used to
use WindowedFile for both the .pack and the .idx, but long ago
you showed it was faster to load the entire .idx into memory in
the PackIndex structure.  And this split is causing confusion,
like the one you just stepped in.

-- 
Shawn.
