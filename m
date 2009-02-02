From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH,v2] git-bundle(1): add no references required simplest
 case
Date: Sun, 01 Feb 2009 16:45:19 -0800
Message-ID: <7vab95r7j4.fsf@gitster.siamese.dyndns.org>
References: <87tz7i6scg.fsf_-_@jidanni.org> <87pri12078.fsf@jidanni.org>
 <alpine.DEB.1.00.0902020056520.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, gitster@pobox.com, mdl123@verizon.net,
	spearce@spearce.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 02 01:46:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTmxj-0005zG-DM
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 01:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbZBBApb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 19:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbZBBApa
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 19:45:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZBBAp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 19:45:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 082212A416;
	Sun,  1 Feb 2009 19:45:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BC1842A414; Sun, 
 1 Feb 2009 19:45:20 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902020056520.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 2 Feb 2009 01:04:13 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C928E95A-F0C2-11DD-AB2B-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108030>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +A complete bundle is one that does not require you to have any
>
> I have not heard of any "complete" bundle before, and I do not understand 
> the need for such a definition, either.

Sorry, that's mine, not Jidanni's fault.  I agree that we do not
necessarily have to introduce a new term.

>> +as if it was a remote repository, like this:
>> +
>> +----------------
>> +$ git clone /home/me/tmp/file.bdl mine.git
>> +----------------
>> +
>> +This will define a remote called "origin" in the resulting
>> +repository that lets you fetch and pull from the bundle, just
>> +like the previous example lets you do with the remote called
>> +"bundle", and from then on you can fetch/pull to update the
>> +resulting mine.git repository after replacing the bundle you store
>> +at /home/me/tmp/file.bdl with incremental updates.
>
> IMO this paragraph just adds words, not anything the user does not know 
> already by that stage.

True again.

The only justification that an example of cloning from a complete (or
"baseless" or "full" or whatever new term we have already agreed that is
not needed ;-)) bundle in the example I can think of is that by having
such an example way earlier in the example sequence, we could show a full
cycle of sneakernetting into a repository.  You bootstrap it by cloning
from a complete bundle, so that the clone has remotes set up to facilitate
further updates via fetch/pull pointing at a known location.  Then you
drop a new bundle to the same location that is relative to an earlier one,
and pull from it to incrementally keep the repository up-to-date.

In other words, we currently have a very cursory description that says you
can ls-remote and fetch from a bundle at the end, and mention that the
remote configuration can be defined to facilitate repeated sneakernet
operation.  But we could reorganize the example this way (the ones with
asterisk are already in our example section, the ones with plus are
additions):

 * you first create a full bundle without basis

	$ git bundle create mybundle master

 * you make note of the current tip to optimize later bundles

        $ git tag -f lastR2bundle master

 + sneakernet it and clone it to prime the recipient

	... sneakernet mybundle to /home/me/tmp/mybundle
 	$ git clone /home/me/tmp/mybundle mine.git

 + after working more in the original, create an incremental bundle

	$ git bundle create mybundle lastR2bundle..master
	$ git tag -f lastR2bundle master

 + sneakernet it again, and use it to update the recipient
 
	... sneakernet the new mybundle to /home/me/tmp/mybundle
 	$ git pull /home/me/tmp/mybundle mine.git

to show the simplest "full cycle" of sneakernet workflow.  And then show
various variations we already have in the existing examples.

Something like:

    In addition, if you know up to what commit the intended recipient
    repository should have the necessary objects for, you can use that
    knowledge to specify the basis, giving a cut-off point to limit the
    revisions and objects that go in to the resulting bundle.  Here are the
    examples:

     * using a tag present in both to optimize the bundle

            $ git bundle create mybundle master ^v1.0.0

     * using a basis based on time to optimize the bundle

            $ git bundle create mybundle master --since=10.days

     * using the number of commits to optimize the bundle

            $ git bundle create mybundle master -n 10 

    A bundle from a recipient repository's point of view is just like a
    regular repository it fetches/pulls from.  You can for example map
    refs, like this example, when fetching.

            $ git fetch mybundle master:localRef

    Or see what refs it offers

            $ git ls-remote mybundle
