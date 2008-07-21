From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] builtin-add.c: restructure the code for
 maintainability
Date: Mon, 21 Jul 2008 00:52:06 -0700
Message-ID: <7v7ibfvfmh.fsf@gitster.siamese.dyndns.org>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness>
 <7v3am3yfph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 09:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKqCn-0000aq-CB
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 09:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbYGUHwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 03:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbYGUHwN
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 03:52:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbYGUHwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 03:52:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 23C23363CC;
	Mon, 21 Jul 2008 03:52:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 628C6363CB; Mon, 21 Jul 2008 03:52:08 -0400 (EDT)
In-Reply-To: <7v3am3yfph.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jul 2008 22:22:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECD6F760-56F9-11DD-B64F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89317>

Junio C Hamano <gitster@pobox.com> writes:

> That changed late 2006 when Nico allowed git-add to stage already tracked
> files as well.  We collect the paths in the work tree that match given
> pathspec, and for the directory traverser to do that job, you would need
> an empty index.
>
> 	Side note: 366bfcb (make 'git add' a first class user friendly
> 	interface to the index, 2006-12-04) is something to marvel at.  It
> 	describes the change with its documentation update fully, changes
> 	the semantics in a drastic way, with so little change.
>
>         Documentation/git-add.txt  |   53 ++++++++++++-----------
>         Documentation/tutorial.txt |   46 ++++++++++++++++++---
>         builtin-add.c              |    6 +-
>         wt-status.c                |    2 +-
>         4 files changed, 72 insertions(+), 35 deletions(-)
>
> Perhaps we can add a bit to the dir_struct we give to the traverser to
> tell it to ignore the index even if we have already read one.  That would
> be a much cleaner API enhancement than reading the index and setting aside
> while calling read_directory() which feels like a you know what I would
> call it.

Thinking about this issue a bit more, I realize that the earlier "git add -A"
change was done in a quite inefficient way (i.e. it is as unefficient as
"git add -u && git add ." modulo one fork/exec and read/write index).  For
that matter, the original "git add ." could probably be more efficient
than it currently is.

The thing is, when the user asks "git add .", we do not have to examine
all paths we encounter and perform the excluded() and dir_add_name()
processing, both of which are slower code and use slower data structure by
git standard, especially when the index is already populated.

Instead, we should be able to implement "git add $pathspec..." as:

 - read the index;

 - read_directory() to process untracked, unignored files the current way,
   that is, recursively doing readdir(), filtering them by pathspec and
   excluded(), queueing them via dir_add_name() and finally do
   add_files(); and

 - iterate over the index, filtering them by pathspec, and update only the
   modified/type changed paths but not deleted ones.

And "git add -A" will become exactly the same as above, modulo:

 - missing $pathspec means "." instead of being an error; and 

 - "interate over the index" part handles deleted ones as well,
   i.e. exactly what the current update_callback() in builtin-add.c does.

It is likely that I am too tired to do this right tonight, so I'll go to
bed and expect to find a nicely done patch in my mailbox by somebody else
;-).
