From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] replace_object: add mechanism to replace objects
 found in "refs/replace/"
Date: Wed, 07 Jan 2009 00:41:02 -0800
Message-ID: <7vmye3a4pt.fsf@gitster.siamese.dyndns.org>
References: <20090107084341.1554d8cd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 09:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKTzi-0006rd-JU
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 09:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbZAGIlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZAGIlL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 03:41:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZAGIlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 03:41:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C6FE1BFCB;
	Wed,  7 Jan 2009 03:41:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 234991BFCA; Wed, 
 7 Jan 2009 03:41:04 -0500 (EST)
In-Reply-To: <20090107084341.1554d8cd.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed, 7 Jan 2009 08:43:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDCA8128-DC96-11DD-B859-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104776>

Christian Couder <chriscool@tuxfamily.org> writes:

> In "parse_commit_buffer", the parent sha1s from the original commit
> or from a commit graft that match a ref name in "refs/replace/" are
> replaced by the commit sha1 that has been read in the ref.

I may be reading this wrong, but if you replace the parent of the commit,
that won't improve anything over the graft mechanism, which we already
have.

What I was hoping to see was to give replacing commit back when a commit
is asked for by normal callers, while not replacing the objects when
reachability traversal (prune, pack transfer and fsck) wants to read the
commit.  That way:

 (1) Normal callers will see the rewritten history (which is the same as
     graft); and

 (2) We will kill the design bug of the current graft mechanism that graft
     information cannot be transferred to the other end.  By using object
     replacement, you can fetch objects reachable from refs/replace/ at
     the other end and place them in the same refs/replace/ hierarchy
     locally, if you choose to use the same altered history, or you can
     choose not to use the replacement yourself.  The resulting repository
     is fully connected either way.

 (3) We will also kill the design bug of the current graft mechanism that
     graft information hides repository corruption to fsck.  The problem
     with this is that if you and then remove the grafts, you will end up
     with a corrupt repository, because these operations do look at grafts
     (this is justified only partly because otherwise you will lose
     objects that are reachable only via grafts, but is broken at the same
     time because you can lose the true parents by letting graft hide them
     from a reachable commit).

     By doing fsck and prune always using the true reachability, and using
     refs in the refs/replace/ hierarchy for protecting objects that are
     involved in this new way of grafting, you will ensure the integrity
     of the repository.  Removal of a ref from the refs/replace/ hierarchy
     won't result in such a corruption we can have today.

And that is exactly the reason why I was hoping the hook will be at
read_sha1_file() that gives you a rewritten object contents when you ask
for the original object, not at parse_commit_buffer which does not give
you a rewritten object, but makes you follow to a rewritten object when
parsing a commit (which itself is not replaced if it is the starting
point).

Doing replacement at parse_commit_buffer() time is one step too late.  For
example, if you have replacement information for the commit that sits at
the tip of 'master' branch, I think your "git log master" will ignore that
replacement information.  Creating one new commit on top of it and saying
"git log master" then will show the new commit, and suddenly starts
showing the replacement commit for the one you used to have at the tip of
the branch.
