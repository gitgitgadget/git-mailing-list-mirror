From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --abort
Date: Thu, 19 Feb 2009 21:24:49 -0800
Message-ID: <7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
 <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
 <43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 06:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaNuO-0004gs-Dc
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 06:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbZBTFZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 00:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbZBTFZK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 00:25:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbZBTFZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 00:25:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D7C152B865;
	Fri, 20 Feb 2009 00:25:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F348B2B854; Fri,
 20 Feb 2009 00:24:52 -0500 (EST)
In-Reply-To: <43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
 (John Tapsell's message of "Fri, 20 Feb 2009 04:47:39 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D434832C-FF0E-11DD-A01B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110797>

John Tapsell <johnflux@gmail.com> writes:

> 2009/2/19 Jay Soffian <jaysoffian@gmail.com>:
>> On Thu, Feb 19, 2009 at 8:34 AM, John Tapsell <johnflux@gmail.com> wrote:
>>> There's no reliable way of getting back to the state before the merge?
>>
>> Sure there is. Commit or stash before you merge, so that your index
>> and working copy are clean.
>
> Could a stash be done automatically by the merge command, for just a case?

It cuts both ways.  For people who work on a well organized project
(i.e. highly modularized) and tend to keep local changes in the work tree
while doing a lot of merges, running "stash" every time would (1) remove
the local change from the work tree, which he has to remember to manually
unstash after resolving conflicts in the merge (which would not have
conflicted with the local change anyway), which is an additional work for
no real gain, and (2) clutter his stash.  My gut feeling is that it is a
change that affects the way the end user has to work that is sufficiently
different and disruptive for no real gain.

If you read the original message more carefully, you will notice that the
suggested "git merge --abort" would break down *only* if the user messes
with the state conflicted merge left.  And an unmanageable conflicts are
much rare compared to most merges that autoresolve, so you should optimze
for the common case while giving a way to gain safety only when needed.

Probably a much better workflow, if we add "merge --abort", would be:

    $ edit ;# unrelated local changes are still here
    $ git pull ;# or merge or whatever
    ... oops, large conflict ...
    ... look and see if it can easily be resolved ...
    ... otherwise
    $ git merge --abort
    $ git stash
    $ git pull ;# or whatever, try again
    ... the same conflict but this time you only need to worry
    ... about the merge itself
    ... resolve, review, test to convince yourself that your
    ... resolution is good and then...
    $ git commit
    $ git stash pop
