From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diffcore and directory renames
Date: Mon, 01 Sep 2008 15:50:22 -0700
Message-ID: <7vfxojtr9t.fsf@gitster.siamese.dyndns.org>
References: <20080901213904.GP4985@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 00:51:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIFH-0004XH-J5
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 00:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbYIAWub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 18:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYIAWub
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 18:50:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYIAWua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 18:50:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 753B85CF8A;
	Mon,  1 Sep 2008 18:50:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C3C8C5CF89; Mon,  1 Sep 2008 18:50:25 -0400 (EDT)
In-Reply-To: <20080901213904.GP4985@nan92-1-81-57-214-146.fbx.proxad.net>
 (Yann Dirson's message of "Mon, 1 Sep 2008 23:39:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5F7BAB72-7878-11DD-A0F8-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94620>

Yann Dirson <ydirson@altern.org> writes:

> I often found myself lost when looking at a diff where a couple of
> large dirs where renamed, and a handful of files were modified to take
> the rename into account - not a rare situation, I'd say.  In such a
> case, the diffs themselves are mostly hidden among numerous rename
> entries.

Yes, I've hinted here number of times that rename detection could notice
the fact that neighbouring paths are migrating to the same directory and
boost similarity scores of leftover paths that did not otherwise made the
threshold in such a situation.

I am glad to see finally somebody got interested ;-)

> $ ./git-diff-tree 0f1027 -M
> 0f1027e1aceb4bc5fa682776ab9f72935e2cd1b3
> :040000 040000 6f6159f0245784352414ff38ffb68bae80f30bd6 6f6159f0245784352414ff38ffb68bae80f30bd6 R100   ppc     moved

Yes, diff-tree can show this, and you should be able to teach diff-index
with a clean cache-tree to do similar, but this only applies to the
non-recursive 100% rename at the toplevel, which is too narrow a special
case to be interesting at all.  We perhaps further could run the
similarity comparison on the raw tree objects if we wanted to so that you
can find inexact matches, but I think it is going in the wrong direction.

The thing is, diffcore is designed to be a general mechanism to unify
comparisons on two arbitrary sets of files, be they from tree-vs-tree,
tree-vs-index, tree-vs-worktree, or index-vs-worktree.  The machinery
should be able to operate on any two sets of files in the same way and
produce more-or-less the same results.  It is Ok for callers to give extra
hints, when available, to speed up the computation, but the core of the
algorithm should not depend on the presense of such hints to deduce the
renames.

So please aim to make the hint-less case, "diff-files --no-index", produce
a sensible result.  That should be the first step.
