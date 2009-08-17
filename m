From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 09:46:03 -0700
Message-ID: <7vvdkmwfqs.fsf@alter.siamese.dyndns.org>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <200908142223.07994.jnareb@gmail.com>
 <7veird4yyi.fsf@alter.siamese.dyndns.org>
 <200908160137.30384.jnareb@gmail.com>
 <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
 <7vtz06xxao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5Li-0003BI-SQ
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196AbZHQQqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757075AbZHQQqM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:46:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbZHQQqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:46:11 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5589BE38F;
	Mon, 17 Aug 2009 12:46:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46676E38D; Mon, 17 Aug
 2009 12:46:05 -0400 (EDT)
In-Reply-To: <7vtz06xxao.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 17 Aug 2009 08\:41\:35 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7837AFC4-8B4D-11DE-A4C9-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126225>

Junio C Hamano <gitster@pobox.com> writes:

> Local changes in git do not belong to any particular branch.  They belong
> to the work tree and the index.  Hence you (1) can switch from branch A to
> branch B iff the branches do not have difference in the path with local
> changes, and (2) have to stash save, switch branches and then stash pop if
> you have local changes to paths that are different between branches you
> are switching between.
>
> How should assume-unchanged play with this philosophy?
>
> I'd say that assume-unchanged is a promise you make git that you won't
> change these paths, and in return to the promise git will give you faster
> response by not running lstat on them.  Having changes in such paths is
> your problem and you deserve these chanegs to be lost.  At least, that is
> the interpretation according to the original assume-unchanged semantics.

Having said that, we could (re)define assume-unchanged to mean "I may or
may not have changes to these paths, but I do not mean to commit them, so
do not show them as modified when I ask you for diff.  But the changes are
precious nevertheless".

I think the writeout codepath pays attention to assume-unchanged bit
already for that reason (CE_MATCH_IGNORE_VALID is all about this issue).

So with that, how should assume-unchanged play with the "local changes
belong to the index and the work tree"?

 - When adding to the index, the changes should be ignored;

 - When checking out of the index?  I.e. the user tells "git checkout
   path" when path is marked as assume-unchanged.  Such an explicit
   request should probably lose the local changes in the work tree.

 - When checking out of a commit?  The same deal.

 - When switching branches?

   - If the branches do not touch assume-unchanged paths, we should keep
     changes _and_ assume-unchanged bit.  I do not know if that is what
     the current code does.

   - If the branches do touch assume-unchanged paths, what should happen?
     We shouldn't blindly overwrite the local changes, so at least we
     should change the code to error out if we do not already do so.  But
     then what?  How does the user deal with this?  Perhaps...

     - Drop assume-unchanged temporarily;
     - Stash save;
     - Switch;
     - Stash pop;
     - Add assume-unchanged again.

     ???

Is such an updated (or "corrected") assume-unchanged any different from a
sparse checkout?  After all, paths that are not to be checked out in a
sparse checkout are "pretend that the lack of these paths are illusion--they
are logically there.  I do not intend to commit their removal, and I do not
want to lose the sparseness across branch switch".

There is one nit about this.  If a path is outside the checkout area,
should it unconditionally stay outside the checkout area when you switch
branches?  I may be interested in not checking out Documentation/
subdirectory and that may hold true for all _my_ branches, and it is a
sane thing not to complain "Oops, you actually removed Makefile in
Documentation/ in your work tree in reality, and you are switching to
another branch that has a different Makefile --- it is a delete-modify
conflict you need to resolve, and we won't let you switch branches" in
such a case.

But is that generally true in all "sparse checkout" settings?

It is unfortunate that this message raises more questions than it answers,
but I think a sparse checkout will have to answer them, whether it uses a
bit separate from assume-unchanged or it reuses the assume-unchanged bit.
