From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
 'dirty worktree'
Date: Wed, 04 Feb 2009 10:57:09 -0800
Message-ID: <7vbptit4hm.fsf@gitster.siamese.dyndns.org>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de>
 <7vvdrqunog.fsf@gitster.siamese.dyndns.org> <4989CF79.2070209@viscovery.net>
 <7vvdrqt74k.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902041915070.22763@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:59:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUmxe-0004eT-VP
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760457AbZBDS5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760962AbZBDS5U
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:57:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758991AbZBDS5S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:57:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 95B7896356;
	Wed,  4 Feb 2009 13:57:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 23AD996355; Wed,
  4 Feb 2009 13:57:10 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902041915070.22763@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Wed, 4 Feb 2009 19:15:53 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A38A261E-F2ED-11DD-A6DE-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108411>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 4 Feb 2009, Junio C Hamano wrote:
>
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>> > Because if the repository is non-bare, then filter-branch updates the
>> > work-tree at the end of the run; we don't want to overwrite uncommitted
>> > work in this case.
>> >
>> > This behavior is a relic from cg-admin-rewritehist, I think. I've never
>> > found it useful.
>> 
>> Ok, I think "read-tree -m -u HEAD" at the end sort of makes sense, if you
>> filtered the branch you are currently sitting on.  Does that mean we do
>> not have to barf on dirtyness if we can tell if the filter-branch will not
>> touch the current branch at all?  Again, I am not suggesting it as an
>> improvement, but I am trying to see if I am talking a total nonsense.
>
> That's correct.  Checking if we would touch the current branch is too 
> expensive here, that's why we don't do it.

Ok, so these exchange suggests that the commit log message needs a bit
more explanation why the check matters before describing why submodules
should not be checked.  Something like this, perhaps?

    At the end of filter-branch in a non-bare repository, the work tree is
    updated with "read-tree -m -u HEAD", to carry the change forward in
    case the current branch was rewritten.  In order to avoid losing any
    local change during this step, filter-branch refuses to work when
    there are local changes in the work tree.

    This "read-tree -m -u HEAD" operation does not affect what commit is
    checked out in a submodule (iow, it does not touch .git/HEAD in a
    submodule checkout), and checking if there is any local change to the
    submodule is not useful.

While I think it makes sense to ignore submodules for the diff-files
check, I do not think it is correct to do so in the check to see if you
have staged changes.  If you updated what commit should be checked out in
your index, and if you run "read-tree -m -u HEAD", it can conflict the
same way as a staged change to a regular blob.  The most trivial example
would be if your filtering were to remove any submodule.  Your work tree
change wanted to modify while the branch switching is to remove and you
have a modify/remove conflict right there.  Or am I again confused?
