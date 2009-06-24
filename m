From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] `git push', branch management, and "(forced update)"?
Date: Wed, 24 Jun 2009 09:31:11 -0700
Message-ID: <7v8wjhwq40.fsf@alter.siamese.dyndns.org>
References: <200906241034.18550.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 18:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJVNa-0000pL-US
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 18:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbZFXQbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 12:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZFXQbK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 12:31:10 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44589 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbZFXQbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 12:31:09 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090624163112.PXTS17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Wed, 24 Jun 2009 12:31:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 7sXB1c00T4aMwMQ04sXBEc; Wed, 24 Jun 2009 12:31:11 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=GsLwheLVEYEA:10 a=z5y-QQxDAAAA:8
 a=Vt2AcnKqAAAA:8 a=FP58Ms26AAAA:8 a=qspcmS6rPGCE_QlczZgA:9
 a=KSzdSCgjo7wCjUis4kwA:7 a=lB-HydWFrUjKt2SW6rH6IfgTmgwA:4 a=jOEKoBmLuUkA:10
X-CM-Score: 0.00
In-Reply-To: <200906241034.18550.brian.foster@innova-card.com> (Brian Foster's message of "Wed\, 24 Jun 2009 10\:34\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122142>

Brian Foster <brian.foster@innova-card.com> writes:

>    L is a clone of M, where other work has also been committed,
>    in master.  So now-and-then my colleague pulls M into L:
>
>      o--o--o--o--*--* master
>                \
>                 r--r--f--f TOPIC
>
>   My colleague then pushes the result to B.  End result is B
>   is essentially M plus TOPIC.
>
>    As it happens (mostly by design), the changes on TOPIC
>   are independent of the `*' ones on master.  So, working
>   in L, my colleague often rebases, and this is (always?)
>   a fast-forward:
>
>      o--o--o--o--*--* master
>                      \
>                       r--r--f--f TOPIC

When he rebases the TOPIC, he is not making this topology.
Instead, this is what he is making:

                       r'-r'-f'-f' TOPIC
                      /
      o--o--o--o--*--* master
                \
                 r--r--f--f

The tip of the TOPIC before (the rightmost commit on the lower side branch
in this picture) is not an ancestor of the tip of the TOPIC after the
rebase.  It is not a fast-forward.

>    In a simple simulation test I tried, it not only worked
>   for me, but the subsequent pull from simulated-B into
>   simulated-R said the TOPIC was a "(forced update)".
>   What does that mean?

The remote side B (and its mirror R) still points at the rightmost commit
on the lower side branch with TOPIC.  He forces a non-fast-forward push to
B using "+:" (that is "leading plus to force a push" followed by "solitary
colon to mean push matching refs"), violating a simple rule "do not rebase
what others already have seen".  Push from B to its mirror R then will be
in the same situation.

This may be a good food-for-thought:

    http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg39091.html

Incidentally the message explains why it would be bad if your
"now-and-then" above is too often.
