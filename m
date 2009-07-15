From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto-merge after push?
Date: Wed, 15 Jul 2009 12:31:00 -0700
Message-ID: <7v1vohg2vf.fsf@alter.siamese.dyndns.org>
References: <20090511142326.GA18260@redhat.com>
 <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302>
 <20090511201705.GA21045@redhat.com>
 <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de>
 <20090611104020.GA12036@redhat.com> <20090711203831.GA10875@redhat.com>
 <alpine.DEB.1.00.0907120441440.3155@pacific.mpi-cbg.de>
 <7vocrplhbv.fsf@alter.siamese.dyndns.org> <20090715145430.GB9075@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 21:31:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRACF-00024b-4P
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 21:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091AbZGOTbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 15:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbZGOTbK
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 15:31:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbZGOTbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 15:31:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DDA55323;
	Wed, 15 Jul 2009 15:31:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 44B385320; Wed,
 15 Jul 2009 15:31:02 -0400 (EDT)
In-Reply-To: <20090715145430.GB9075@redhat.com> (Michael S. Tsirkin's message
 of "Wed\, 15 Jul 2009 17\:54\:30 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A5EE558-7176-11DE-ADFE-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123331>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> So, let me summarize the issues:
> - if the tree is pushed into while files are being actively read
>   (e.g. built from), the build will get an inconsistent state
> - even worse if one of the files is open for editing or is being written
>   into: the file will get corrupted
> - if there are uncommitted changes in the tree, the push is denied
>
> Are there others?

 - If you choose to detach-on-push, the user who _thought_ was advancing
   the history of a branch using the work tree will get very confusing
   results.  The branch will be advanced by the push, and the work tree
   user is required to notice the situation, later at some point merging
   the work done in the work tree that went to the detached HEAD state.

 - What happens if the automerge gets conflict?

Having said that, I think it is a _wrong_ approach to try summarizing the
issues along these lines, without stating the most fundamental restriction.

If the push-from-sideways is done without any coordination between the
person pushes and the person who uses the work tree, _any_ solution that
modifies the work tree behind the back of that work-tree person will not
work without surprising him, so listing the possible surprises is
pointless.

On the other hand, all of the above "issues" (including yours) will become
only implementation details of a workflow when there is a coordination
between the pusher and the work-tree person.  In the most trivial case,
both are you, and the repository with the work tree is your private
working area.

So I would suggest stressing the need for this coordination before
starting to list the "issues".

Be it "detach" or "automerge", the workflow helped with the patch is
merely a deviation of the mothership-satellite configuration (look for
"satellite" in the FAQ) where you push from satellite to mothership (each
has its own work tree) to achieve logically what you would want to perform
with a pull in the other direction, that is:

 satellite$ git push mothership:project master:refs/remotes/satellite/master
 satellite$ ssh mothership 'cd project && git merge remotes/satellite/master'

The necessary "coordination" between the two repositories is that the last
step, "merge what was pushed", must be done when the work tree checked out
in the mothership repository is in a state that is suitable for performing
the merge, e.g. no extra change to the index that is unrelated to the
merge, no local change that interferes with the merge, etc.

The auto-merge-upon-push patch by Dscho, however, places a further
restriction on top of the stock satellite-mothership configuration,
exactly because it is automated.  In an unautomated workflow, you can
afford to choose _when_ to merge, independent from when to push:

 satellite$ git push mothership:project master:refs/remotes/satellite/master
 satellite$ ssh mothership
 mothership$ cd project
 ... work further to finish off what you did on the mothership ...
 mothership$ git commit
 mothership$ git merge remotes/satellite/master

Typically, when you are done (for the day, for example) on satellite, you
push it out to the mothership, even though the mothership repository's
work tree may have independent local changes (aka WIP) you have left when
you last worked there.  After switching to work in the mothership, you
can continue working on the WIP to finish it before merging what you did
on the satellite the previous day.

The automated way will trade this flexibility off with convenience (you do
not have to have the interactive session on the mothership only to perform
the merge), so you will be required to leave the mothership work tree and
the index in a good shape any time you might want to push into it from the
satellite.  It is a small price to pay, and depending on the situation
(the most obvious is when you do not even have an interactive shell access
to the mothership) you may not even have that flexibility to begin with,
in which case there is no downside.
