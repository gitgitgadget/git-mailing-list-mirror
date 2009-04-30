From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why is the name of a blob SHA1("$type $size\0$data") and not
	SHA1("$data")?
Date: Thu, 30 Apr 2009 13:02:17 -0700
Message-ID: <20090430200217.GU23604@spearce.org>
References: <49FA0214.70009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Srbecky <dsrbecky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 22:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzcSh-00072c-Uf
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 22:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbZD3UCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 16:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbZD3UCS
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 16:02:18 -0400
Received: from george.spearce.org ([209.20.77.23]:59839 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbZD3UCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 16:02:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 66C143806F; Thu, 30 Apr 2009 20:02:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49FA0214.70009@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118043>

David Srbecky <dsrbecky@gmail.com> wrote:
>
> I started digging into the details and there is one thing that is really  
> bugging me - why is the name of a blob SHA1("$type $size\0$data") and  
> not SHA1("$data")?  I mean, wouldn't it be beautiful if the name of the  
> blob would really just be the SHA1 of the uncompressed file content? :-)

Well, a commit is stored in the same namespace as a blob (file
content).  So the type being included in the SHA1 computation helps
to break them apart and say "this is really a commit" vs. "this
is a file that just happens to have the same content as a commit".
It does help consistency checkers like `git fsck` to know that the
object is used in the right context.

I can't guess what Linus had in mind when he wrote Git, but I would
wager it was something along the lines that storing everything in
a single directory structure was simpler/more elegant than having
a different directory structure per object type.  Today I would
probably have made the same design decision, but I'm biased by
Git already so who knows if I'm just mimicing Linus' brilliance or
would have arrived at the same result myself.

Including the length is overkill, yes, but its in the header of the
data so that git can immediately allocate a properly sized memory
buffer before it inflates the rest of the object content.  Its a
performance improvement.  Its probably a historical accident that
it got included in the SHA1 computation, as notice its position
between the type and the data... it likely was just easier to
include it in the SHA1 than to exclude it.

> I would really appriciate some comments on the design decisions so that  
> I can sleep well at night :-)

Then I won't mention pack files... which aren't as simple to read
as just inflating a file on disk.  :-)

-- 
Shawn.
