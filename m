From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 10:47:00 +0100
Message-ID: <200704111047.01271.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 15:26:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbZQ2-0001UI-PC
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 11:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXDKJrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 05:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbXDKJrK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 05:47:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:9844 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbXDKJrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 05:47:08 -0400
Received: by ug-out-1314.google.com with SMTP id 44so79201uga
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 02:47:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AYlidWtNvqFy3AsZkqHTOVogFGHmWX67Q2DwD9DL2RZ27vVfvDr65f9n/56D4Klr2H7KbXDHKT9PHiYV83vAsP25KIr478PygHsPBIfaZnQ82YHT9cOOoYU2R8JUduuCQdOnmZfcg4sHIisPtkarwnddycndZnNqMxkivxRb1rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X1xgiwgTm7G28l1lhzJFafMxPq0jerzxKYjZL8C0y1sm1+P/mf01BH/aPUR5YwFqMWBoOiB/fJPg252dDV+bjPOU+9J5g/GxFAeOIgX44IpwQJXETKLms5JZUtfsFjaWgUZzlHP+r2uV/QWxSIf24QUoEXEMV3FAe74gOFbII4A=
Received: by 10.66.232.10 with SMTP id e10mr326585ugh.1176284826389;
        Wed, 11 Apr 2007 02:47:06 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm15285054ika.2007.04.11.02.47.04;
        Wed, 11 Apr 2007 02:47:05 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <20070411080641.GF21701@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44230>

On Wednesday 2007 April 11 09:06, Martin Waitz wrote:

> The only thing I disagree with you is in using HEAD of the submodule:

I know we've had this discussion before, but I'm going to bring it up again - 
mainly because Linus's implementation exactly matches what I envisaged when 
we originally spoke of this.  I think in your "Updating the branch which HEAD 
points to is dangerous" section, the main thing you're not taking into 
account is that git can make detached checkouts.  Updating HEAD is not 
dangerous - updating refs is; and I don't think anyone is proposing that a 
submodule ref should ever be updated by a supermodule.

I think you're also too strongly focussed on the idea that the supermodule 
tracks submodule branches - it cannot branches are not part of "the" 
repository they point at "a" repository.  References are outside the 
repository pointing in, and hence the supermodule cannot refer to them at its 
core.

Now, if you check out a revision in the supermodule, that's going to look up 
the submodule revision stored in the DIRLINK tree entry which will recurse 
into the submodule and checkout that revision - almost certainly as a 
detached HEAD.  There are three possibilities then:
 - The submodule revision is in the past and no submodule branch points at it
 - The submodule revision is current and a submodule branch points at it
 - The submodule revision is current and multiple submodule branches point at 
   it
The supermodule checkout will have to make a decision whether to update the 
submodule HEAD (in one case it's obvious: a revision in the past has to be 
detached HEAD as there is no suitable branch).  It's also possible that the 
single submodule branch case is easy - undetach HEAD; however I don't think 
that is universally correct.

I know you're very much in favour of making branches in the submodule 
correspond to branches in the supermodule, but I just don't see a way of 
making it work - the supermodule cannot know about submodule branches, 
branches are not part of the repository, they just point at the repository.  
My branches could be different from your branches.

It may be that some handy configuration settings and some clever porcelain 
could keep them in sync for your working repository - but it's never going to 
be the case that checking out "master" in the supermodule can be universally 
resolved to mean "checkout master in the submodule".

The way submodules should be treated is that the whole submodule is analogous 
to a single repository-tracked file - that's essentially what a submodule is 
in the end but the content of the "file" is the submodule revision.

There is one difference from ordinary files, a submodule has two "modified" 
states, not one:
 1. HEAD of submodule is different from DIRLINK revision
 2. Submodule is dirty

In state (1) the submodule has to have git-add run on it in the supermodule, 
just as you would with a modified file, to get it into the index (or not if 
you don't want to commit that change).  In state (2) it should be impossible 
to git-add, because the state of the submodule doesn't represent something 
that could be restored - there is nothing reasonable that could be written to 
the DIRLINK tree object.  This is certainly a porcelain issue, because it's 
only really a warning that "git-add" isn't doing what you think it's doing 
when the submodule is dirty.

Now, if you change branch in the submodule, the supermodule will see that as a 
change in the submodule (as it should).  If you changed back, it will be 
restored and the supermodule will again see it as unchanged.  If you commit 
on the submodule, the supermodule will see that as a change and you'll have 
to git-add the submodule and commit in the supermodule.  The submodule is on 
whatever branch it is on - at all times.

The only time I can see this causing difficulties is when you want to checkout 
the tip of a submodule branch - how is the supermodule to know when it is 
correct to change HEAD from being detached to being attached?  I suppose it's 
got to be config-based; and out-of-tree config at that.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
