From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [topgit] tg update error
Date: Fri, 13 Feb 2009 01:04:16 -0800
Message-ID: <7v63jebtdb.fsf@gitster.siamese.dyndns.org>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
 <20090212084811.GA14261@piper.oerlikon.madduck.net>
 <20090212092558.GB21074@skywalker>
 <20090212125621.GB5397@sigill.intra.peff.net>
 <7veiy3l689.fsf@gitster.siamese.dyndns.org>
 <20090212214106.GC26573@piper.oerlikon.madduck.net>
 <7vocx7i6xh.fsf@gitster.siamese.dyndns.org>
 <20090213062818.GB16434@piper.oerlikon.madduck.net>
 <7vmycqeqqh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org,
	pasky@suse.cz
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 10:06:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXtzk-0006It-5O
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 10:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbZBMJEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 04:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbZBMJEb
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 04:04:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZBMJE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 04:04:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 117EC9923D;
	Fri, 13 Feb 2009 04:04:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 64F669923A; Fri,
 13 Feb 2009 04:04:18 -0500 (EST)
In-Reply-To: <7vmycqeqqh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 12 Feb 2009 23:32:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50C109EA-F9AD-11DD-B317-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109734>

Junio C Hamano <gitster@pobox.com> writes:

> If you *are* setting HEAD to some ref that is outside refs/heads (or even
> inside refs/heads for that matter), at that point the HEAD is *not*
> detached, so no, it obviously is *not* what is happening.
>
> I am asking why you need to use a ref to do that, *if* it is a tentative
> state while the program is running.  You are probably calling a git
> plumbing or Porcelain command that updates HEAD, and the reason why you
> point HEAD outside refs/heads/ is beause you would want the command you
> call to update one of the refs/top-bases/ ref through HEAD.  I am asking
> why you are not running these commands on a normal detached HEAD, and then
> use update-ref (not symbolic-ref) plumbing to update the refs/top-bases/
> ref you would want to update when it is done.

Ok, I did read the script (yuck).  You do break out of TopGit process when
a merge conflict prevents the update operation to complete and do give
control back to the end user, so you can leave HEAD in a state that points
at a non-branch, and you do use the fact that the HEAD is pointing at
something funny as a sign that you are in the middle of conflicted merge
resolution.

It is just like how vanilla git uses MERGE_HEAD as the marker to signal
that it is in a funny state.

While I think it is a cute idea to use which funny hierarchy HEAD points
at to indicate what funny/intermediate state your interrupted operation is
in, and it may seem to be cleaner than using a marker file like MERGE_HEAD
at first sight, I do not think it is a wise thing to do in the long run.

You can only express two pieces of information (the overall "category of
state" by which funny ref/ hierarchy HEAD points at, and one object name
by storing it in the ref pointed at by HEAD), and if you need more (such
as MERGE_MSG that stores pre-packaged log message pieces is used during a
merge, in addition to MERGE_HEAD), you would need to use more than just
the "cute HEAD" trick to store them *anyway*.  Which means that it is a
bad tradeoff to use "cute HEAD" --- it closes the possibility to detect
user error to point HEAD at an incorrect place and I do not see the
benefit of "cute HEAD" outweigh the downside.
