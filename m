From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Thu, 05 Feb 2009 11:46:24 +0100
Organization: private
Message-ID: <86fxit9n5r.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 11:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV1m6-0006sh-Ap
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 11:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbZBEKqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 05:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZBEKqg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 05:46:36 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:60182 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZBEKqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 05:46:34 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEL00ILJ9XD1F80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 05 Feb 2009 11:46:25 +0100 (CET)
Received: from localhost ([80.203.29.216]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEL00NQI9XD1G00@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 05 Feb 2009 11:46:25 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108549>

* Kjetil Barvik schrieb:
| And, yes, since each lstat() call cost approximately 44 microseconds
| compared to 12-16 for each lstat() on my Linux box, there was a little
                             ^^^^^^^ fstat()?

  Yes, is is the fstat() call which takes 12-16 microseconds on my Linux
  box.

| performance gain from this patch.

* Johannes Sixt <j.sixt@viscovery.net>
| This does look like a good gain. But do you have hard numbers that back
| the claim?
|
| If you can squeeze out a 10% improvement on Linux with this patch, we
| should take it, and if it turns out that it doesn't work on Windows, we
| could trivially throw in an #ifdef MINGW (or even #ifdef WIN32 if Cygwin
| is affected, too) that skips the fstat() optimization.
| 
| But we really should have numbers that justify this effort.

  I have been working on a long running test script latly, but then I
  started to play with the 'git repack' command, so it was not top
  priority.  But, I can finish the script today, and run it while I am
  sleeping tonight.

| BTW, the statement from the Windows documentation was:
|
|  "The only guarantee about a file timestamp is that the file time is
|   correctly reflected when the handle that makes the change is closed."
|
| In the case of this patch, the timestamp is queried via the handle
| that made the change, and in this case special case the timestamp
| could be correct nevertheless. The guarantee doesn't cover this case,
| but it would be natural, and perhaps it Just Works?

  Yes it could perhaps "just works".  But, then I guess that when it
  does not work, the user would not notice it _except_ for more time
  used.  Since I can to this:

kjetil@localhost ~/git/git $ git status 
# On branch lstat_fstat_v6
nothing to commit (working directory clean)
kjetil@localhost ~/git/git $ touch var.c
kjetil@localhost ~/git/git $ git status 
# On branch lstat_fstat_v6
nothing to commit (working directory clean)
kjetil@localhost ~/git/git $ 

  ... I think that git will have to check the content and read each byte
  and do a SHA1 of the file var.c in this case (since the timestamps do
  not match), which is a more time and CPU hungry opperation, to decide
  if there is a difference inside the file or not.

  And, maybe some other platform also have problems with this trick?

  OK, I do the time tests and let the numbers talk.

  -- kjetil
