From: Junio C Hamano <gitster@pobox.com>
Subject: Not going beyond symbolic links
Date: Mon, 04 Aug 2008 00:49:02 -0700
Message-ID: <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 09:51:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPuqL-0001MV-Aj
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 09:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbYHDHtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 03:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbYHDHtP
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 03:49:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYHDHtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 03:49:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 88A814960F;
	Mon,  4 Aug 2008 03:49:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 89ACF4960E; Mon,  4 Aug 2008 03:49:06 -0400 (EDT)
In-Reply-To: <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 25 Jul 2008 23:46:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4B2908A-61F9-11DD-B29A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91319>

Junio C Hamano <gitster@pobox.com> writes:

> A symlink to us is just a different kind of blob, and by definition a blob
> is the leaf level of a tree structure that represents the working tree in
> the index. There won't be anything hanging below it, and when adding
> things to the index we should not dereference the symlink to see where it
> leads to.
>
> Traditionally we have been loose about this check, and the normal "git
> add" and "git update-index" codepath is still forever broken, and we
> allow:
>
>       $ mkdir dir
>       $ >dir/file
>       $ ln -s dir symlink
>       $ git add symlink/file
>
> but some codepaths that matter more (because they do larger damage
> unattended, as opposed to the above command sequence that can be avoided
> by user education a bit more easily), such as "git apply" and "git
> read-tree", have been corrected using has_symlink_leading_path() since mid
> 2007.  We would need to follow through c40641b (Optimize symlink/directory
> detection, 2008-05-09) and further fix "git add" and "git update-index"
> codepaths to forbid the above command sequence.

I started to revisit this issue and patched "git update-index --add"
and "git add" so far.  Patches follow.

I think we should also check the following and fix them if any of them is
broken.  Under the same "dir/file exists but symlink points at dir"
scenario:

 * "git rm symlink/file" --- should fail without removing dir/file;

 * "git ls-tree $commit -- symlink/file" should *not* fail if $commit does
   have "symlink/file" in it (iow, we cannot add the logic to get_pathspec());

 * "git ls-files --exclude-standard -o -- symlink/file" should not talk
   about "symlink/file".

If we reword the paragraph I quoted at the beginning of this message
slightly:

	A gitlink to is is just a leaf level of a tree structure that
	represents the working tree in the index.  There won't be anything
	hanging below it.

We would need a similar check to stop at module boundary, just like the
helper function we use for these patches, has_symlink_leading_path(),
stops at a symlink.

So without further ado...
