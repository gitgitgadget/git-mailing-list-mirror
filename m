From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset
 --hard"
Date: Thu, 11 Sep 2008 14:34:43 -0700
Message-ID: <7vd4jas6x8.fsf@gitster.siamese.dyndns.org>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
 <eafc0afe0809101914lff5b23ehaf625d702fbd9b5d@mail.gmail.com>
 <51419b2c0809101938v30e5a1aflf944027aedc2d900@mail.gmail.com>
 <loom.20080911T204256-821@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdtpi-0007ah-A0
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 23:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143AbYIKVez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 17:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757511AbYIKVey
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 17:34:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499AbYIKVex (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 17:34:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C5E7760D22;
	Thu, 11 Sep 2008 17:34:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC65060D21; Thu, 11 Sep 2008 17:34:45 -0400 (EDT)
In-Reply-To: <loom.20080911T204256-821@post.gmane.org> (Eric Raible's message
 of "Thu, 11 Sep 2008 20:50:27 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75C7C086-8049-11DD-98A0-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95649>

Eric Raible <raible@gmail.com> writes:

> Yes, you have a 100% correct understand of what I'm trying to say.
> But can you see a downside to "git reset --hard" treating newly
> added files as "git reset"?

Of course.  The --hard option is called --hard without inviting short
option for a reason.

I am actually somewhat sympathetic to your point, but you would want
"reset --hard" to remove that path when a path does not exist in the HEAD
but in index in other cases.  And it is my experience (and I presume you
can guess I have longer git experience than any of you ;-) that far more
often than not that is what is desirable.

Consider:

 (1) Your branch does not have "path";

 (2) You once thought you want addition of the "path" made in another
     branch;

 (3) So you did:

    $ git checkout another -- path

 (4) After more hacking, it turns out that the avenue you chose to reach
     your goal, including the addition of the "path", was a mistake, and
     you regret having wasted some time.  You want to go back to the
     current HEAD:

    $ git reset --hard

The state after (3) is "HEAD does not have path, index and work tree has
it".  In step (4) you would want "git reset --hard" to get rid of such a
path.

And it is no different from the case where you add the path manually to
the index.  Both are "you thought you wanted it, but you changed your
mind".

Another example is getting rid of crufts from a conflicted merge.  It may
bring in many new paths in your index and the working tree.  You would
want a "git reset --hard" to get rid of all of them.  Not removing the
paths that are not in HEAD but in index and working tree is far worse in
this case because merging is often done from other people's tree that you
may not be familiar with (i.e. you wanted to study their tree after
merging), so it is harder for you to hand-clean after "reset" if a hard
reset does not do it for you.
