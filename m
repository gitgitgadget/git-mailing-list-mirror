From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Two bugs with renaming
Date: Wed, 19 Mar 2008 21:45:53 -0700
Message-ID: <7vbq5aypdq.fsf@gitster.siamese.dyndns.org>
References: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
 <alpine.LFD.1.00.0803192059120.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcCfw-00080v-Av
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbYCTEqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbYCTEqH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:46:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbYCTEqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 00:46:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 14F75171F;
	Thu, 20 Mar 2008 00:46:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 22476171B; Thu, 20 Mar 2008 00:45:56 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803192059120.3020@woody.linux-foundation.org>
 (Linus Torvalds's message of "Wed, 19 Mar 2008 21:12:02 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77626>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Now, arguably, it should just see them as two independent issues, and then 
> the rename detection will notice that the "files/delete.me" file got 
> renamed as "files.upstream/delete.me", so *after* rename detection there 
> will be no D/F conflict in the end result, but we see the conflict before 
> that all even happens.

The common ancestor had files/delete.me.

Our side (test_branch) deleted files/delete.me, created
files.upstream/delete.me and created files.

Their side (master)kept files/delete.me without changing, created foo.

So I would think we should not even trigger D/F conflict at all.

 - files/delete.me is deleted by only one side (our side) and it should go.

 - files and files.upstream/delete.me are created by only one side (ours)
   and it should stay.

 - foo is created by only one side (theirs) and it should come.

However, we wanted to allow policy decision to happen after read-tree, and
we traditionally kept "one side removes" case as an internal conflict in
the index, later to be resolved by merge-one-file (and merge-recursive).

So I think the resulting index should look like this:

        100644 xxxxxxx 0	files.upstream/delete.me
        100644 xxxxxxx 1	files/delete.me
        100644 xxxxxxx 3	files/delete.me
        120000 xxxxxxx 0	files
        100644 xxxxxxx 0	foo

or (if we also want to leave policy decision for "one side adds" case to
merge-one-file and merge-recursive) even:

        100644 xxxxxxx 1	files/delete.me
        100644 xxxxxxx 3	files/delete.me
        120000 xxxxxxx 2	files
        100644 xxxxxxx 2	files.upstream/delete.me
        100644 xxxxxxx 2	foo

But that is not what is happening here.  In fact, if you did not have
"files" in the test branch, here is what you will see:

        100644 xxxxxxx 0	files.upstream/delete.me
        100644 xxxxxxx 1	files/delete.me
        100644 xxxxxxx 3	files/delete.me
        100644 xxxxxxx 0	foo

and merge-recursive knows how to match up the first three entries and if
there are changes between stages #1 and #3 of files/delete.me, that is
carried forward to files.upstream/delete.me

Your unpack_trees() is bug-to-bug compatibile with Daniel's that is in
1.5.4.  Both "read-tree -m -u" bails out with the same error, without
even leaving higher stage entries in the index.
