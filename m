From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: Merging using only fast-forward
Date: Thu, 17 Jan 2008 22:58:50 -0800
Message-ID: <402c10cd0801172258p9a1a97bt682fa012fcebd13c@mail.gmail.com>
References: <loom.20080116T151930-575@post.gmane.org>
	 <863asxivlj.fsf@blue.stonehenge.com>
	 <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 07:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFlCD-0002vS-Mb
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 07:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbYARG6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 01:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbYARG6x
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 01:58:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:7797 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYARG6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 01:58:52 -0500
Received: by fg-out-1718.google.com with SMTP id e21so936281fga.17
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 22:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lXg4f6W9eZ7kHxtpUPP+H3IFq9tiFFZn0Y02X7BiyZQ=;
        b=bne41N+qPdRV+bwo7Xcz4Q02lc6j5ZTkJ3chIQkSgULpUjID/2/zLHmNeztSktXckR+1X0Gb3SLNQpuX5x+3OHEjrnq8dGgiol77JO5P12zcgL6NTJ3adv5sHnndCARgnjVTfU+ncTuCLI4urUBpzQj0gmRkK63tDJka8K9ffdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B4uLPauXN7pNqIRxUoW6pGjgmkOOFVYXNX6/Wne73eTKDHIbZlu5oT5gWwP1/4NzYTT4QQpeAHZvoFp+o0LB5NwPFNxsL5akR6+Prm+zuIwB9A3Fak7IIbdJbnB/SR2IQkHRxILOllswx+3aW4Evot/oAtR489SgrjwupGkL1LI=
Received: by 10.82.181.7 with SMTP id d7mr5397143buf.4.1200639530313;
        Thu, 17 Jan 2008 22:58:50 -0800 (PST)
Received: by 10.82.172.18 with HTTP; Thu, 17 Jan 2008 22:58:50 -0800 (PST)
In-Reply-To: <402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70968>

On Jan 16, 2008 10:53 PM, Sverre Hvammen Johansen <hvammen@gmail.com> wrote:
> We need to consider cases where the branch we are merging with is an
> ancestor or an descendant of HEAD.  The patch only take descendants
> into account.  There may also be more than one branch we are merging
> with.  All these cases must be considered.  In the case of an octopus, the
> cases are slightly more complicated.

I have been testing octopus merges and figured it is not very smart with
respect to fast forward.  I would like it to do a fast forward whenever it
makes sense to do that.  Consider the following:

     -- c1 -- A
   /              /  \
c0 -- c2 --      C
   \              \  /
     -- c3 -- B

A is a merge between c1 and c2, B is a merge between c2 and c3, and C is a
merge between A and B.

c1 merged with A does a fast forward to A, A merged with C does a fast forward
to C, but an octopus merge of c1 with A and C does not fast forward to
C.  I would
expect it to fast forward to C.  The commit graph above have several other cases
where an octopus merge can be reduced to a fast forward or a recursive merge.

I suggest a separate pass before we choose merge strategy.  Remove commits
that can be fast forwarded to any of the other commits from the
equation and fast
forward the current branch if possible.  The remaining commits are then taken
into consideration.  This may reduce the number of commits and thus result in
a fast forward or another merge strategy.

I intend to make the patch for the option --ff-only as simple as
possible, where it
will fail where more than two commits are involved.  If the above suggested pass
is implemented it should also take affect for --ff-only.

Does this make sense?

-- 
Sverre Hvammen Johansen
