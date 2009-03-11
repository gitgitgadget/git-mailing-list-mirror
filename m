From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 12:36:30 -0700
Message-ID: <7vtz5z4zsx.fsf@gitster.siamese.dyndns.org>
References: <49B74373.3090609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Saurabh Gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 20:38:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUFk-0004H9-BK
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 20:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbZCKTgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 15:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbZCKTgi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 15:36:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbZCKTgi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 15:36:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C46B3A0481;
	Wed, 11 Mar 2009 15:36:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 89455A047D; Wed,
 11 Mar 2009 15:36:32 -0400 (EDT)
In-Reply-To: <49B74373.3090609@gmail.com> (Saurabh Gupta's message of "Wed,
 11 Mar 2009 10:22:03 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EEC813BA-0E73-11DE-86E0-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112967>

Saurabh Gupta <saurabhgupta1403@gmail.com> writes:

> *1) Domain specific merge helpers*
> Intelligence in the merger can be put which modifies the source file
> according the format. Different file formats can be put in the merger
> to support.

The way "merge" works is:

 - A tree-level 3-way merge is done (either inside merge-recursive backend
   or with "read-tree -m O A B" inside merge-resolve), and trivial merges
   are resolved at the whole-file level without need for any helper.
   Roughly speaking, the definition of "a trivially mergeable path" is a
   path that only one side modified while the other side didn't, or both
   sides modified identically.

 - The remaining paths need to be merged at file level.  The gitattributes
   mechanism is used to decide what exact algorithm to use based on what
   the merged file is; we have a plain-text "xdl" merge driver and "union"
   merge driver built-in, in addition to "binary" merge driver (which
   always says "the changes conflict; use ours as a tentative result).

   When a merge driver is called, it is given three blobs: original, ours
   and theirs (any one of them could be missing).  It is the driver's
   responsibility to come up with an automated merge result when the
   changes do not overlap and report success, or leave an intermediate
   "conflicted merge" and report conflicts.  In either case, the driver is
   expected to return _one_ single bytestream as its tentative result.

 - Cleanly merged paths are updated in the index and their results are
   written out to the work tree.  For paths the merge drivers reported
   conflicts, tentative results returned by the merge drivers are written
   out to the work tree but the index entries for them are left in an
   unmerged state.

 - If all paths are cleanly merged, "git merge" and friends write the
   index out as a tree and create a commit out of it (unless otherwise
   instructed) and report success.

 - When a merge left conflicts, the user can use external tools like "git
   mergetool" to resolve the conflict in the work tree, starting from the
   tentative result given by the merge driver, and "git add" to register
   the resolution to the index.

When people say a "merge helper" in the context of git, I think they think
about at least two kinds, that work at very different layers.  It is
unclear which one you are more interested in, or you are tackling both.

 - A group of new merge drivers that handle various structured text
   formats (e.g. XML based ones), on which the default plain-text merge is
   not suitable, would be a good addition to the git suite.  If you are
   interested in doing this as your GSoC project, it would very much be
   git specific.

 - Amerge helper that takes three files (original, ours and theirs) as its
   input and helps the end user (perhaps graphically) merge them can be
   used at a backend to the "git-mergetool", by registering a filetype as
   "binary" (so that the low-level merge driver won't even try merging the
   contents at the file level), and letting "git-mergetool" invoke the
   "helper" with these three files.  The development of this kind of
   "helper" would not be a git specific project.

Obviously it would help the users to have both, but which kind is more
important?

In a collaborative environment, people do not work in void without any
communication with each other, and they actively try not to step on each
other's toes.  Even when changes are made from both sides of a merge to
the same file (in other words, a file level merge is required), in the
majority of cases, the changes do not overlap, and being able to resolve
such merges cleanly most of the time, without having to resort to an
external "git mergetool", is a huge win in productivity.  I think a domain
specific "merge driver" project would benefit the git users a lot more
than a domain specific "merge helper" that can be used as a "git
mergetool" backend (and can also be used outside git).

Of course, you can do both.

But my point is it is unclear which one you meant when you said "merge
helper".
