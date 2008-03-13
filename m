From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] assume unchanged?
Date: Thu, 13 Mar 2008 00:33:26 -0700
Message-ID: <7vejafyt6h.fsf@gitster.siamese.dyndns.org>
References: <20080227222243.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZhxf-0007Ho-25
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbYCMHdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753829AbYCMHdn
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:33:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbYCMHdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:33:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 59A562C6A;
	Thu, 13 Mar 2008 03:33:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 834512C69; Thu, 13 Mar 2008 03:33:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77046>

しらいしななこ  <nanako3@bluebottle.com> writes:

> I noticed that there is --assume-unchanged option, and I read its
> description three times, but I do not understand it.  What is it good
> for?  Version control systems are used in order to keep track changes,
> and if using that option makes my changes ignored, how can it be a good
> thing?

[offtopic: I wrapped your lines...]

That's an ancient invention but I think it still has two uses (at least,
its ideas, but honestly speaking, I do not know how hard recent built-in
Porcelains tried to keep the concept maintained---the implementation may
have decayed over time):

 - If your build system is broken such that it has a bad habit of
   overwriting a tracked file (e.g. "make depend" overwriting tracked
   Makefile), you would want to ignore such a change and keep going.  Of
   course, you need to remember that you need to drop that assume
   unchanged bit when you really make your own change to such a file,
   which is a minor drawback, but when you do that you would need to clean
   up the unrelated changes your broken build system leaves anyway, so it
   is not a big deal.

 - If your filesystem is slow and you know upfront you are only going to
   work inside a small corer of the source tree, you can tell the system
   that "I won't be touching these paths, and even if I did, they were
   modified by accident".  After that, git does not have to check for
   modifications in the paths you marked as such.

The idea is that if an entry had "assume unchanged" set, then whenever we
check a work tree file for that entry (e.g. "have we changed it from the
index?", "what's the contents of the path? give it to me so that I can
compare it with what's in the HEAD commit", etc.) we instead return what
is in the index.

So it _should_ be usable as an ingredient for a narrow checkout, like:

	git clone -n ;# no checkout
        git read-tree HEAD ;# still no checkout
        git checkout HEAD Documentation/ ;# only that part
        git diff --name-only HEAD -- |
        git update-index --assume-unchanged --stdin ;# set the magic

and after doing that, git shouldn't notice that your work tree is missing
everything outside Documentation/ hierarchy.  At least that is the idea.

I would not, however, be so surprised if this bit is honored only for
files that are actually checked out, as detecting of missing paths happens
much earlier than checking if paths are modified, and the use of the bit
was about "modified".  In addition, no serious workflow ever used this
feature as far as I know in real life, so bugs remaining in the codepath
involved in handling this bit are not so surprising.  It should not be too
hard to fix them, though, if people are really interested.
