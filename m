From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 13:01:42 -0800
Message-ID: <7veiy3l689.fsf@gitster.siamese.dyndns.org>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
 <20090212084811.GA14261@piper.oerlikon.madduck.net>
 <20090212092558.GB21074@skywalker>
 <20090212125621.GB5397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, madduck@debian.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiiO-0007qv-Bl
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758789AbZBLVBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758227AbZBLVBx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:01:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758202AbZBLVBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:01:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 39E4499E93;
	Thu, 12 Feb 2009 16:01:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3909499E90; Thu,
 12 Feb 2009 16:01:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5EA98C40-F948-11DD-84E8-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109650>

Jeff King <peff@peff.net> writes:

> Junio, I think we should probably revert b229d18 (and loosen
> symbolic-ref's check to just "refs/"). Even if you want to argue that
> topgit should be changed to handle this differently, we are still
> breaking existing topgit installations, and who knows what other scripts
> which might have relied on doing something like this.

I'm Ok with the revert (and I agree it is absolutely the right thing to do
at least for the short term).

But I still do agree with the reasoning for the change stated in its
commit log message:

    commit b229d18a809c169314b7f0d048dc5a7632e8f916
    Author: Jeff King <peff@peff.net>
    Date:   Thu Jan 29 03:30:16 2009 -0500

        validate_headref: tighten ref-matching to just branches

        When we are trying to determine whether a directory contains
        a git repository, one of the tests we do is to check whether
        HEAD is either a symlink or a symref into the "refs/"
        hierarchy, or a detached HEAD.

        We can tighten this a little more, though: a non-detached
        HEAD should always point to a branch (since checking out
        anything else should result in detachment), so it is safe to
        check for "refs/heads/".

        Signed-off-by: Jeff King <peff@peff.net>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

It would be nice to hear TopGit people defend why setting HEAD to outside
refs/heads/ is justified, why doing so should not break other things, and
why it was needed.

The last one is particularly important to avoid this kind of issue in the
future.  Perhaps they _knew_ some things refuse to work on refs outside
refs/heads/ and wanted to take advantage of that fact to protect their own
refs from vanilla git tools, but if that really is the case, the rules
they want have to be spelled out.

"git checkout" would refuse to switch to "refs/top-bases/frotz", because
it currently considers HEAD pointing outside refs/heads/ is insane, for
example.  But the revert of the above commit *means* that it is not
insane, and somebody may add an option to switch to any refs inside refs/
hierarchy.  If the reason TopGit points HEAD outside refs/heads hierarchy
were because they assume "git checkout" would never do so, such a change
would break them again (I am not seriously suggesting to add such an
option to "git checkout", but I am just using it to illustrate the point.
We would not know what other assumption, warranted or unwarranted, it is
making).
