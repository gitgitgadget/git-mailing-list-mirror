From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git workflow
Date: Mon, 10 Mar 2008 22:15:20 -0700
Message-ID: <7vr6ehg7tj.fsf@gitster.siamese.dyndns.org>
References: <1205152663.3470.12.camel@tigger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Gordon <peter@pg-consultants.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 06:16:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYwqf-0001Kp-Ja
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 06:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbYCKFPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 01:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbYCKFPf
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 01:15:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYCKFPf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 01:15:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA0E518E0;
	Tue, 11 Mar 2008 01:15:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CF56818BF; Tue, 11 Mar 2008 01:15:27 -0400 (EDT)
In-Reply-To: <1205152663.3470.12.camel@tigger> (Peter Gordon's message of
 "Mon, 10 Mar 2008 14:37:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76794>

Peter Gordon <peter@pg-consultants.com> writes:

> ... When we have finished
> working on the branch, we move back to the HEAD, with 
> git-checkout master, do a 
> git-pull
> and then git-cherry-pick sha1.....
> ...
> 1) Is this the normal way to work with git.

It does not look "normal" in that I do not see anything that pushes
your change back so others can build on top of it.  Also cherry-pick is
valid but it probably is easier to use "git rebase" frontend.

You need to answer one policy question at the project level.  Do you want
the shared central repository to be a place for your developers to also
share their not-quite-ready-for-master-work-in-progress? 

Assuming you don't, for the sake of simplicity for now, you can simplify
the workflow by dividing it conceptually into two levels:

 * shared repository 'master' branch is where everybody meets.  Birds-eye
   view of what you do is:

   (0) git clone;

   (1) work locally to advance your 'master';

   (2) "git fetch origin", followed by "git rebase remotes/origin" to make
       sure your changes come on top of whatever others have done while
       you were working in step (1);

   (3) "git push origin master", which pushes back your 'master', so that
       others can build on what you did in step (1);

   (4) go back to (1) to work further.

 * because you always push your 'master' in step (3) above, as long as you
   have what you want in your 'master' at that point, it does not matter
   _how_ you work towards that state in step (1) above.

   You can employ local topic branches (or you can use guilt patch stack),
   and nobody else needs to know about it.  If you have a long-running
   work that won't be ready for the shared 'master', you may locally:

   (a) "git checkout -b my-topic master";

   (b) work locally whenever you find time;

   (c) "git checkout master" if you get interrupted and have more urgent
       things to do;

   (d) "git checkout my-topic" to continue, but from time to time, it
       would be a good idea to "git rebase remotes/origin" while on that
       branch, and when you are finally done with my-topic, then

   (e) after making sure with (2) above that your 'master' is up-to-date,
      "git checkout master", "git merge my-topic".

   (f) then finally "git push origin master".

   But you can consider these steps (a)-(e) merely "implementation
   details" of how you would perform (1) above.

Once you got comfortable with the workflow without topics, more advanced
developers among you would find local topic branches handy way to organize
their work.  But you do not have to.  And if you do not use local topics,
there is no reason to avoid working directly on 'master'.
