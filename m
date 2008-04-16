From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Wed, 16 Apr 2008 11:36:26 -0700
Message-ID: <7v3aplsl3p.fsf@gitster.siamese.dyndns.org>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
 <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
 <7vej96v2pk.fsf@gitster.siamese.dyndns.org>
 <32541b130804160946s343d53d2l271b9391d89a7953@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org, "Avery Pennarun" <apenwarr@versabanq.com>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 20:56:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmCVh-0001IY-8y
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 20:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYDPSgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 14:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbYDPSgp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 14:36:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbYDPSgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 14:36:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D170A29D6;
	Wed, 16 Apr 2008 14:36:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AAD2129D1; Wed, 16 Apr 2008 14:36:33 -0400 (EDT)
In-Reply-To: <32541b130804160946s343d53d2l271b9391d89a7953@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 16 Apr 2008 12:46:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79722>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 4/16/08, Junio C Hamano <gitster@pobox.com> wrote:
>> apenwarr@gmail.com writes:
>>  > This adds a From: line (based on the commit's author information) when
>>  > sending to svn.  It doesn't add if a From: or Signed-off-by: header already
>>  > exists for that commit.
>>
>> I admit that I do not use git-svn, but I am confused.  Where are you
>>  adding that "From:"?  You grab a commit log message out of git (which does
>>  not have such "From:", add such a line at the beginning of the commit
>>  message using the authorship information and send the resulting commit log
>>  message to svn?  Why?
>
> When git-svn copies a commit from git to svn, svn eats the authorship
> information; it always sets the svn author field to the username of
> the person logged into the svn server.

Let me rephrase that to see if I understand what you are saying.  If you
look at the "svn log" output (not "git svn log"), you see that the result
of "git-svn dcommit" does not record the same 'author' as git side does;
instead it uses whoever ran git-svn to propagate the commit to the SVN
side.

> With the (existing) --use-log-author option, git-svn will pull From:
> and Signed-off-by: lines from svn's log entries when pulling back into
> git, which helps with this problem.  However, it only works with
> commits that have a Signed-off-by: or From: already included.

Ah, that is because the way the commit is propagated is (1) you read git
commit; (2) you make a corresponding SVN commit using the log message you
read in step (1); (3) you read that SVN commit back, and create a _new_
git commit and replace what you read in step (1).  The new git commit is
marked with the authorship information you obtain from the SVN side,
unless the commit log message you read back from the SVN side has these
special markers (and you are using the --use-log-author option).

Is that what is happening?

And your solution is to add these markers in step (2).

If that is the case, I understand how and why this would work around the
issue.  A possible downside with this approach is that such a commit in
SVN (from SVN person's point of view) has extra information that is
unusual in the log message part (namely "From: ").

It makes me wonder if there is a better way.

For example, CVS honors LOGNAME to allow you to "lie" who the author of a
change was, which is the behaviour inherited from RCS.  I have to wonder
if SVN has a similar mechanism to tell it "Excuse me, but I am just a
secretary recording changes for my boss."

But perhaps there isn't and that was why you did it this way (and that is
why --use-log-author was invented 5 months ago).  And the issue that the
commit on the SVN side has unusual (again, from SVN person's point of
view) information not in the original commit on the git side might not be
so grave, so it probably is Ok.

Eric? Sam?
