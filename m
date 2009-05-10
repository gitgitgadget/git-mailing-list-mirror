From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-push --mirror also mirroring refs/remotes/
Date: Sun, 10 May 2009 14:56:21 -0700
Message-ID: <7vskjctyey.fsf@alter.siamese.dyndns.org>
References: <1241984136-2578-1-git-send-email-bryan@shatow.net>
	<200905102225.25508.markus.heidelberg@web.de>
	<4A073E2E.6060403@shatow.net>
	<200905102313.13544.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Drewery <bryan@shatow.net>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun May 10 23:56:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3H0b-0005AP-W2
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 23:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbZEJV4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbZEJV4W
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 17:56:22 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55193 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbZEJV4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 17:56:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510215621.CRLF25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 May 2009 17:56:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id pxwM1b00G4aMwMQ04xwN3q; Sun, 10 May 2009 17:56:22 -0400
X-Authority-Analysis: v=1.0 c=1 a=lnU1J0qAWBQA:10 a=kKjG687s4oAA:10
 a=Of2RA-p65eodMyfxSL4A:9 a=3wVbjfxl5QCqRrL7f5DaLaMGhdoA:4 a=5KVauyKsRKMA:10
X-CM-Score: 0.00
In-Reply-To: <200905102313.13544.markus.heidelberg@web.de> (Markus Heidelberg's message of "Sun\, 10 May 2009 23\:13\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118751>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Bryan Drewery, 10.05.2009:
>> This behavior makes no sense to me. Can we at least add a config option
>> to make it not push remotes? I push my development repository
>> to a remote private repository only as a backup, and push my master/next
>> to a public repository. I see no reason to push my 8 remotes and
>> all their branches to my backup repository.
>
> Why are you disturbed by the remotes, if it's only a backup repository
> where you don't look into in the normal case?

I suspect you got a wrong "backup".

"push --mirror" is about backing up the local repository so that other
people (most likely "you working on some other machine") who usually
interact with the current repository can instead get history from the
repository that you are pushing into, when the current repository is not
reachable for whatever reason.

In other words, "push --mirror" is not a backup in the "archive to tape
for disaster recovery" sense, but is a backup in the "you can go there in
case this is not reachable" sense.  The refspec "remote add --mirror"
creates is set up to support a backup repository in the same sense in the
opposite direction [*1*].

Now, these other people may not have any business looking into remotes
hierarchy of this repository, and we could argue that there is not much
point pushing remotes hierarchy over there (nor stash or topgit for that
matter) in a normal workflow.

But these other people can say "git fetch $here remotes/origin/master"
explicitly when fetching from this repository.  By mirroring everything
under refs/ to its --mirror backup repository, these other people can
substitute $here with its --mirror backup repository and expect it to
still work.  It would be a regression if you stop pushing the refs/remotes
hierarchy, and such a proposal must be backed by an argument that says the
benefit such a change brings in far outweighs the regression it causes.


[Footnote]

*1* If you want a "disaster recovery backup", there is always "tar".  My
recent favourite is to append into an existing squashfs image, though ;-)
