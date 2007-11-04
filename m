From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 04 Nov 2007 03:41:08 -0800
Message-ID: <7vmytus0ff.fsf@gitster.siamese.dyndns.org>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	<7vd4us1jds.fsf@gitster.siamese.dyndns.org>
	<46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
	<7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
	<46dff0320711040125v111c75davb49e9822537f4b19@mail.gmail.com>
	<46dff0320711040145k1edb1fcaq1daa5469c1158e81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Yin Ping" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iodr7-0007s8-F5
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbXKDLlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbXKDLlP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:41:15 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48960 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbXKDLlO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 06:41:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1C8AB2F0;
	Sun,  4 Nov 2007 06:41:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 723788FF4F;
	Sun,  4 Nov 2007 06:41:32 -0500 (EST)
In-Reply-To: <46dff0320711040145k1edb1fcaq1daa5469c1158e81@mail.gmail.com>
	(Yin Ping's message of "Sun, 4 Nov 2007 17:45:41 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63386>

"Yin Ping" <pkufranky@gmail.com> writes:

> In both case, i think the user should be notified about the inconsistence.
> My patch given in the first letter handles this by two warning messages as
> follows (where $name is module name)
>
> +                       cd $name >&/dev/null || { echo "  Warning: fail to
> chdir to $name" && exit; }

My point was that it is wrong to make this "you do not have that
submodule checked out" a warning.

Think about somebody who does _not_ care about that particular
submodule.  He is working on one branch, and tries to merge
another branch that has some interesting changes outside the
submodule, but that branch also has updates to the submodule.

As he is _not_ interested in the submodule, he does not have it
checked out.  He has not changed the commit bound in his index
with 160000 mode bits for that submodule since the common
ancestor, either (that's what "he does not care about the
submodule" means).

The merge will take the submodule commit object name from the
other branches change, just like the ordinary three-way merge
rule would do (one side changed, the other did not do anything,
so take the change).  Suppose some files in the project proper,
outside the submodule, had conflicts.  He has an unmerged index,
that has the submodule already correctly merged.  But other
parts of his index are unmerged.  git-status would guide him
what are conflicting, and git-commit would show him what he
would be committing.

In that situation, all he needs to know, with respect to the
submodule, is that the submodule has been updated since his HEAD
(and that is given by the runstatus output).  He does not _care_
about what the individual commits in the submodule were.  It is
not an error that the information from the submodule cannot be
shown to him.  He _chose_ to ignore the details of that
submodule by not checking it out to begin with.

Something like this, to be totally quiet, would be more
appropriate.

	for name in $modules
        do
                (
                	... do the range, indexone, headone stuff
                        cd "$name" 2>/dev/null || exit 0
                	echo "* $name $headone...$indexone:"
			... whatever log you show
		) | sed ...
	done

By the way, I do not know about the quoting issues with $modules
variable in the above illustration, as I am not (yet) discussing
about the implementation level of details.
