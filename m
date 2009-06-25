From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 10:25:52 -0700
Message-ID: <7v3a9ogr8f.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
	<7veit9m8cs.fsf@alter.siamese.dyndns.org>
	<863a9oz8lh.fsf@blue.stonehenge.com> <4A43A6B3.5020407@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 19:26:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJsi0-0003WV-Gl
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 19:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbZFYRZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 13:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbZFYRZu
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 13:25:50 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52519 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbZFYRZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 13:25:50 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625172551.SKCJ25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Thu, 25 Jun 2009 13:25:51 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 8HRs1c0084aMwMQ04HRsJS; Thu, 25 Jun 2009 13:25:52 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=YjxVEfEYJ9cA:10 a=MshGkDdrAbR6CWV3s3kA:9
 a=g6l8zi193-e5v0MFGZEA:7 a=-Dn8YDuRPdFlLXFe-24QqZrmA90A:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <4A43A6B3.5020407@gmx.de> (Matthias Andree's message of "Thu\, 25 Jun 2009 18\:32\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122225>

Matthias Andree <matthias.andree@gmx.de> writes:

> Could we ditch the current git-pull --append description? Can then please
> somebody rewrite this paragraph? This somebody must have completely understood

> (1) what this feature is good for (practically speaking)
>
> (2) how it works (technically speaking, to provide reference information)
>
> That would be much more useful, and the use would last longer :-)
>
> I don't dare ask Junio directly.

But if you run blame and mailing list archive search, you would discover
that "fetch --append" was my invention.  After all, the entire Octopus
idea originates from me at 211232b (Octopus merge of the following five
patches., 2005-05-05).  It is interesting to realize that it was actually
a Pentapus made on the day of 5/5/5 ;-)

I thought I was going to take blame on the incomprehensive documentation
and pass it on to me being non-native speaker/writer of English, but the
situation is bit funny.  Documentation/fetch-options.txt says this:

    -a::
    --append::
            Append ref names and object names of fetched refs to the
            existing contents of `.git/FETCH_HEAD`.  Without this
            option old data in `.git/FETCH_HEAD` will be overwritten.

Perhaps there has a cut&paste error?  I haven't looked.

Now answers to (1) and (2).

 (1) The feature was designed exactly for the use case Linus described.

 (2) "git fetch" leaves list of <commit object, repo, branch, flag> for
     each ref fetched from repository in .git/FETCH_HEAD, where flag tells
     if it is meant for merging.  "git pull" runs "git fetch", reads from
     this file to learn which ones to pass to "git merge".  The
     information also is given to "git fmt-merge-msg" to come up with the
     message.

     Usually "git fetch" first empties the existing contents of the file
     and stores the list of refs it fetched.  With --append, it doesn't
     empty the file; refs fetched by the previous invocation of "git
     fetch" will be kept and the refs it fetched are appenede.

     So:

	$ git fetch one a
        $ git fetch --append two b
        $ git pull --apend three c

     will end up having all the three refs from different repositories in
     .git/FETCH_HEAD.  I.e.

	branch a, from repo one, to be merged
	branch b, from repo two, to be merged
	branch c, from repo three, to be merged

     when "git fetch" run by the the last "git pull" returns.  "git pull"
     reads the file and learn what to give to "git fmt-merge-msg" (to come
     up with the message for the merge commit) and "git merge" (to create
     the merge commit).
