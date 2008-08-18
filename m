From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Best method of detecting if list of commit refs is a parent
Date: Sun, 17 Aug 2008 21:41:15 -0700
Message-ID: <7vfxp3ndec.fsf@gitster.siamese.dyndns.org>
References: <e47324780808171924j237688faj9e13740f89e75fdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Thomas Harning Jr." <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 06:42:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUwZW-0002MO-VT
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 06:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYHRElW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 00:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbYHRElW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 00:41:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbYHRElW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 00:41:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8927D66D5A;
	Mon, 18 Aug 2008 00:41:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DB8B166D59; Mon, 18 Aug 2008 00:41:17 -0400 (EDT)
In-Reply-To: <e47324780808171924j237688faj9e13740f89e75fdf@mail.gmail.com>
 (Thomas Harning, Jr.'s message of "Sun, 17 Aug 2008 22:24:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7532F7E-6CDF-11DD-A20B-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92678>

"Thomas Harning Jr." <harningt@gmail.com> writes:

> I'm working on my 'Stick' git bug-tracking tool and am working on the
> functionality to get a list of relevant bug-items at a specific point
> in history.
>
> Before I get into figuring out the 'best' way to do this, I thought
> I'd at least get the simple single-item case of detecting if a
> specific commit can be walked to from another commit...

It is unclear from your description what you are trying to do here, but if
you want to know if a commit A is reachable from commit B, the standard
way to do so is:

        git merge-base A B

If the output from the command is the object name of commit A, that means
A is reachable from B.  Otherwise A is not reachable from B.

This is because "merge-base" computes the set of ancestors common to A and
B that are not reachable from other ancestors common to A and B.

Examples.

(1) This one is obvious.

        A---o---o---o---B

(2) Merge-base between A and B is M.  The one before M is also an ancestor
    common to A and B, but because it is reachable from M which is another
    ancestor common between A and B, it won't be part of the merge-base
    output.

              o---A
             /
        o---M---o---B

If you have bunch of commits A B C D E F and if you would want to know
which one of them is reachable from X, you could of course run merge-base
once for each of A..F.  Another way to do this would be to run:

	git rev-list A B C D E F ^X

and look at the output.  The ones among A..F that appear in the output are
not reachable from X.  The ones that are reachable from X do not appear in
the output.

This is because "rev-list" outputs everything reachable from the given
commits without ^ prefix, excluding the ones that are reacahble from the
ones prefixed with ^.
