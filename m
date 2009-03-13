From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 13:02:26 -0700
Message-ID: <7v4oxxgpil.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
 <43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 21:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiDbz-0001Va-7d
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 21:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbZCMUCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 16:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbZCMUCg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 16:02:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZCMUCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 16:02:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 10601525F;
	Fri, 13 Mar 2009 16:02:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2B14C525D; Fri,
 13 Mar 2009 16:02:28 -0400 (EDT)
In-Reply-To: <43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com>
 (John Tapsell's message of "Fri, 13 Mar 2009 08:25:05 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3D07D70-1009-11DE-BE9D-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113220>

John Tapsell <johnflux@gmail.com> writes:

> 2009/3/13 Peter Krefting <peter@softwolves.pp.se>:
>> Hi!
>>
>> Doing "git push remote" pushes all my local branches by default. Is there a
>> way to set it to *not* do that, and (for this particular remote repository)
>> just push the current branch?
>
>> Or failing that, not allow me to run "git
>> push" without specifying a branch?
>
> I've been pushing for this behaviour, and there was a patch a few days
> ago to do this.  I'm not sure if it is/will be committed.

The current status of the series is roughly as follows:

 * Finn Arne sent out a 6 patch series that consists of:

   0e118fe remote: Make "-" an alias for the current remote
   5a18380 New config option push.default
   0b9dcb9 git push: New options --matching and --current
   bf8552b git push: Display warning on unconfigured default push
   cf9d5ab git push: Document that "nothing" is the future push default
   3c2bcc2 git push: Change default for "git push" to nothing.

 * The main topic of the series are patches 2, 4, 5, 6:

   - Introduce a new configuration push.default;

   - Issue a warning when push.default is not set and 'git push' is run
     without saying what refspecs to push, and tell the users that the
     warning can be squelched by setting the configuration (set it to
     'matching' to keep the traditional, 'nothing' to get what Peter
     wants);

   - Reword the warning that the default will change to 'nothing';

   - Switch the default to 'nothing'.

   Which is a reasonable transition plan _if_ we were to change the
   default (except that I think the last one should still keep giving
   warning for people who learned git from the current documentation and
   the start using it after the default is changed).

   If you are changing the default, you have to make people who like the
   current "matching" behaviour suffer no matter how you go about it.  The
   above "start warning early, give chance to people to say 'I want to
   keep my default' before the default changes, and then finally change
   the default" would ease the pain of transition for them.  And the
   configuration option will help people who want new default to set it
   right away.

 * The series is queued in 'pu' for now, as it has a few issues (see mail
   archive for discussions):

   - The first "-" one; even though it may be useful to be able to say
     "the remote the current branch is associated with by default", using
     "-" as a short-hand for that might be harmful to the long term UI
     health, and further study was requested, which hasn't been responded
     yet.

   - The third "--matching/--current" one; --matching is unnecessary as we
     already have ":", --current turns out to be different from HEAD and
     is misnamed.  There also was somebody with an opinion that --current
     adds unnecessary complexity only to encourage a wrong workflow.

   In any case, these two do not have anything to do with the issue that
   "'matching refs' behaviour of a lazy 'git push' that does not say what
   refspecs to push is not always a useful default", and should be done as
   separate patches.  They should come after the dust settles after either
   applying the first two of the main part of the series or deciding to
   drop the main part of the series.

   Also the last one needs to adjust the tests because majority of them
   rely on the current 'matching' behaviour.  As the series lacks it,
   merging it all to 'pu' would make the result not pass the test suite,
   and I excluded the last few patches from 'pu' for now.

   The size of such a patch would be a rough indication how much pain you
   are proposing to incur on existing users.

 * Finn Arne sent the first one of a "replacement" patch series, which I
   looked at, but haven't had time to actually replace the ones that are
   queued in 'pu' (and I haven't seen the second and subsequent ones yet,
   so there is no rush on my end to do so at this moment).
