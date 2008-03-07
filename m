From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Make unpack_trees() do separate source and
 destination indexes
Date: Thu, 06 Mar 2008 21:45:08 -0800
Message-ID: <7vwsof3x5n.fsf@gitster.siamese.dyndns.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 06:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXVP8-0004eP-Av
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 06:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbYCGFpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 00:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbYCGFpV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 00:45:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbYCGFpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 00:45:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 11E163BB9;
	Fri,  7 Mar 2008 00:45:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 65EA83BB7; Fri,  7 Mar 2008 00:45:15 -0500 (EST)
In-Reply-To: <cover.1204856187.git.torvalds@linux-foundation.org> (Linus
 Torvalds's message of "Thu, 6 Mar 2008 18:16:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76462>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ok, this goes on top of the five-commit series yesterday.  The first two
> patches are pure fixes and cleanups, the third one does a fairly
> mechanical thing to get rid of implied usage of "the_index", and the
> last one actually splits up the source and destination index handling.

What I have been wondering about this series was if we can re-enable
cache-tree for more of the unpack_trees() users.

Currently, all unpack_trees() users, other than a single-tree read-tree,
invalidates the whole cache-tree information, as Daniel's "pop one, decide
what to put back, all in the original index" had too many manual index
manipulations and sprinkling cache_tree_invalidate() call everywhere was
too much cluttering of already hard-to-follow codepath.

I'd want to see at least two-way read-tree preserve as much cache-tree
information as possible.  People often work on one branch to completion
(i.e. make a commit, which involves a write-tree, which leaves a fully
valid cache-tree in the index), switch branches (i.e. two-way read-tree,
which unfortunately decimates cache-tree in the current implementation) to
commit a small fix.  If major parts of the cache-tree were left intact
during branch switching, these unchanged subdirectories do not have to be
rehashed in write-tree when making this final commit.




