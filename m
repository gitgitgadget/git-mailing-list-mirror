From: skillzero@gmail.com
Subject: Re: How to merge from newer branch to older branches?
Date: Wed, 22 Apr 2009 10:44:06 -0700
Message-ID: <2729632a0904221044q20e6cabau7dd06b3020a8ce49@mail.gmail.com>
References: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com>
	 <20090421193615.GB7832@coredump.intra.peff.net>
	 <7vmya946fg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:45:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwgW5-0001vQ-CC
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 19:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbZDVRoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 13:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbZDVRoJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 13:44:09 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:36439 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbZDVRoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 13:44:08 -0400
Received: by qyk16 with SMTP id 16so188668qyk.33
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JIRt+sP2sGE7AbnS2K/CktjmCqVVFTr9hVGEKhkvwLQ=;
        b=lvAfZ9deq0aJ7/663qUFjbgoRjSOErZIMS0YDkpciv76iL2D8CXZORpI9DBPp/L/+5
         13ZiOipRAqn2q8mQWfE34mruvNyLzYQ7Xei1RjlslJCzI3RR4J3r8U0VFPgAPgHR7pMl
         oPXGkNZtNdcXJFYT2tBmtVbvGuoaMKnvgZ0JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g1Ck8fiiGSynxt/T0tr1HUEwEIszSLqP2Facjio/VfOnF/j6mxy826M/UStq7xVGLU
         kpyYAwNXnUDYUE2SRB/NJu9fMu96dovXwpmQ3wPvNpPiVJE9gzijYw4aCv/L4CfAgWSV
         AQd3z1vN88ln4MfV9znxlEq5ntQH+WqcQ7Cnw=
Received: by 10.224.37.74 with SMTP id w10mr86545qad.14.1240422246939; Wed, 22 
	Apr 2009 10:44:06 -0700 (PDT)
In-Reply-To: <7vmya946fg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117222>

Based on the help from this discussion and the rebase documenation,
what I ended up doing that seemed to require the fewest conflicts is
to use git merge-base to find the merge-base of master and 1.1 (the
oldest branch I wanted the feature) then I found the commit
immediately before the first commit on the feature branch (feature~3
in this case or commit a^). Then I rebased feature:

git rebase --onto merge-base-of-1.1-and-master feature-before-first feature

Turning this (hopefully not mangled by gmail):

future o-o-o-o-o-o-o
        \   \       \
1.2      \   o-o-o   \
          \           \
1.1        o-o-o       \
                        \
feature                  o-o-o
                         a b c

into this:

future  o-o-o-o-o-o-o
        |\   \
1.2     | \   o-o-o
        |  \
1.1     |   o-o-o
         \
feature   o-o-o
          a b c

I can merge 'feature' into 1.1, 1.2, etc. then theoretically, I should
be able to apply bug fixes to 'feature' later and re-merge into 1.1,
1.2, etc. to pick up just the bug fixes, right?

When I merged 'feature' into 'v1.1', it resulted in the same conflicts
I originally ran into when cherry-picking, but when I looked at it, I
realized this was because I had manually integrated some changes into
1.1 from master (I'm trying to move our tree from CVS to git so I had
to manually move in some stuff from CVS instead of doing a proper git
merge).

It seems like this merge conflict is going to cause problems if I try
to re-merge to pick up a bug fix to 'feature' in the future. Looking
at the documentation, it sounds like 'git rerere' can help by
re-applying the manual conflict resolution I did?

BTW...Is there a way to find the first commit of a branch? I had to
just look at the log manually to see what I remembered to be the first
commit.
