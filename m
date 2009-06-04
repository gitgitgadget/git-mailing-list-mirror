From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 03 Jun 2009 23:57:05 -0700
Message-ID: <7v63fc1o72.fsf@alter.siamese.dyndns.org>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
	<20090602213439.GA7584@coredump.intra.peff.net>
	<alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
	<7vfxeidqoz.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
	<7vtz2x6mor.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906031431100.4880@localhost.localdomain>
	<7v8wk96knh.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906031504080.4880@localhost.localdomain>
	<7vmy8p54fr.fsf@alter.siamese.dyndns.org>
	<20090603224413.GA2902@coredump.intra.peff.net>
	<alpine.LFD.2.01.0906031547480.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 08:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC6tf-0003D5-Gy
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 08:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbZFDG5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 02:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbZFDG5F
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 02:57:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60654 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264AbZFDG5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 02:57:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090604065705.YJKI17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jun 2009 02:57:05 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id zix51b0034aMwMQ04ix5wP; Thu, 04 Jun 2009 02:57:05 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=vab_pU7WfN8A:10 a=vn0Xwkm_Dc8A:10
 a=Z4Rwk6OoAAAA:8 a=Mb5dA6VzMDwwJl9t0TgA:9 a=iOdKtn2ifbk_hPhwdncA:7
 a=MjzIpvdhzFRyNWJ6cS5VMzHT4SQA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120680>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And doing good diffs for a merge is _hard_. The "--cc" thing is supremely 
> useful - it's just that it's useful for data conflicts, not for metadata 
> issues.
>
> It's in fact somewhat dubious if you actually want to see the file removal 
> as a _diff_ in a merge, exactly because it's so verbose and yet often so 
> uninteresting (ie the removal may well be intentional). 

Thinking about this a bit more, a "good" diff for merge that catches this
kind of "broken merge" would likely require redoing a merge when you ask
for a diff.

Earlier, in my "Here is a crude attempt" patch, I mentioned that the
merges in the beginning part of the output are uninteresting while the one
that merges "Build-in git-clone" is interesting (and "crude attempt" was
not useful because it shows both).

The reason?  The uninteresting ones match mechanical merge result, while
the interesting one does not.  For example, 17d778e (the first one in the
output --- an uninteresting one) is a merge between 5e97f46 and 450f437;
the former branch removes the path in question (git-clone.sh) compared to
their merge base, while the latter does not change it, hence the
mechanical resolution to remove the path matches what the final merge
records.  On the other hand, b84c343 (Merge branch 'db/clone-in-c') merges 
0dbaa5b (modifies "git-clone.sh" since the merge base) and b50c846
(removes) and the mechanical merge results in a conflict.

I think the original example can be handled in the same way.  A side
branch created a new file since the merge base, but a merge lost the file
by mistake.  The recorded result does not resemble the mechanical merge
result and we can flag it by detecting this condition (that is, if we
wanted to --- I do not think we want to spend cycles to recreate a merge
while traversing the history with "log --stat" by default).
