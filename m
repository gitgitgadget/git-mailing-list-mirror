From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Development strategy
Date: Mon, 02 Jun 2008 16:35:35 -0700
Message-ID: <7vr6bf5s1k.fsf@gitster.siamese.dyndns.org>
References: <48441715.4010507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@eaglescrag.net>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 01:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3JZv-0002zl-NP
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 01:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYFBXfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 19:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbYFBXfs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 19:35:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbYFBXfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 19:35:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BDA42250;
	Mon,  2 Jun 2008 19:35:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 72B4B224E; Mon,  2 Jun 2008 19:35:38 -0400 (EDT)
In-Reply-To: <48441715.4010507@gmail.com> (Lea Wiemann's message of "Mon, 02
 Jun 2008 17:51:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9ECA7056-30FC-11DD-B1D6-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83595>

Lea Wiemann <lewiemann@gmail.com> writes:

> ! 2f15087248 perl/Git.pm: add get_hash method
>   abd799435c gitweb: use Git.pm, and use its get_hash method
> ! 5e53e2e67e t/test-lib.sh: add test_external
> ! c5c97f896c Git.pm: fix documentation of hash_object
> ! 8db2d73809 test suite for Git.pm
>   261a54ff5b gitweb: removed unused parse_ref method [not posted yet]
>   e9166526a3 Git.pm: add get_type method [not posted yet]
>
> The patches marked "!" I cannot change without breaking at least one
> subsequent patch, so every time I want to make a change to one of
> those, I also need to change at least one subsequent commit, and
> worse, resubmit it to the mailing list.  (E.g. the the recent rename
> from parse_rev to get_hash necessitated two extra patches to
> accommodate the change.)

If the need to cascade changes is about something minor like naming, do
not be too picky while you are presenting the progress.  I personally
think the method for getting the output from rev-parse should be named
rev_parse and not get_hash, if only not to confuse plumbing users, but do
not scramble and rebase -i many patches only because I said so today.

That will be a waste of your time.  Something small like that, I do not
think anybody would mind if at the very end of the series there is a patch
that modifies all users of get_hash to use rev_parse and rename the
method.  I certainly wouldn't.

If on the other hand the issue is about a design mistake you had in
earlier patches in the series, well, you may have to re-roll the later
ones to adjust to the interface change _if_ you want to eradicate the
design mistake from the history.  But this too depends on the nature of
the mistake.

For example, you may introduce a new sub "foo" in commit #1 to support a
small feature or two you add in commit #2 and #3.  Later, you would want
add yet another new thing that can use something very close to what "foo"
already does, but realize that you need to call "foo" slightly differently
by giving an additional parameter.

You might wish that you had a perfect foresight to have that extra
parameter from the beginning.  But _nobody has perfect foresight_.  I
would not want you to start amending from commit #1 in such a case.  Just
make commit #4 to be "Enhance 'foo' to deal with this new situation", and
that commit will change the implementation of "foo" and add the necessary
extra parameter to the existing calling site you introduced in commit #2
and #3.  Then commit #5 will use that new interface to introduce the new
feature you needed an enhanced "foo" and you go on.  Such a case of "the
helper introduced in earlier round was too limited and it is later found
that it needs enhancement" is not even a mistake you would want to remove
from the history.  It is just a normal course of code evolution. 

Keep your commits small, logically independent steps.

Do not _artificially_ squash the commits --- it is _much worse_ than
following up with enhancement patches.  I think your current patch
granularity is quite fine (in good/bad sense not in big/small sense) and
makes pleasant read.
