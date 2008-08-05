From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Not going beyond symbolic links
Date: Mon, 04 Aug 2008 23:11:11 -0700
Message-ID: <7vej54xa80.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
 <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org>
 <alpine.DEB.1.00.0808050356480.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.1.10.0808041921530.3299@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 08:12:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFmY-0004CP-AC
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 08:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbYHEGL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 02:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbYHEGLZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 02:11:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbYHEGLX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 02:11:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 52B5E4BC0A;
	Tue,  5 Aug 2008 02:11:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 686764BC08; Tue,  5 Aug 2008 02:11:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52796622-62B5-11DD-B0A0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91428>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> IOW, sometimes you may _want_ to use symlinks that way, even within one 
> project - with a symlink allowing you to move parts of it around 
> "transparently".

While I admit that I have managed a large directory split across
partitions grafted via symlinks in pre-git days myself, ever since you
started "tracking" symbolic links with 8ae0a8c (git and symlinks as
tracked content, 2005-05-05), you have pretty much been committed to
"track" symbolic links.

This goes even before that commit. The readdir() loop done in show-files.c
with 8695c8b (Add "show-files" command to show the list of managed (or
non-managed) files., 2005-04-11) does not dereference symbolic links
pointing at a directory elsewhere, which we still have as read_directory()
in dir.c without much change in the basic structure.

I would give some leeway to other people who made comments in this thread,
who may not be so familiar with the low-level git codebase, but I have to
say that if you claim that dereferencing symbolic links in the middle is a
feature, you are not being completely honest, you haven't thought through
the issues, and/or you simply forgot the details.  I'd suspect most likely
it is the last one ;-).

The thing is, the "feature" is not very well supported, even without the
fixes from last night.  If you have a symlink "sym" that points at "dir"
that has "file" in it, and if neither "sym" nor "dir/file" are tracked,
you can "git add sym/file" to add it (I called it a bug).

However:

 (1) starting from the same condition, "git add ." does _not_ add it (you
     get the symbolic link "sym" added to your index instead, as well as
     "dir/file");

 (2) after you add "sym/file" through the bug, if you say "git add .", it
     will be removed from the index and you will instead have "sym" and
     "dir/file" (with an ancient git before 1.5.0, you will get "unable to
     add sym" error instead).

 (3) after you add "sym/file", "git diff" will immediately notice that you
     have removed it (this is a fairly recent fix; 1.5.4.X doesn't notice
     it).

You cannot have it as a reliably usable feature without a major surgery,
and this is fundamental. You simply cannot have it both ways without
telling git which symlink is "tracked" and which are only there for
storage sizing.

If you seriously want to claim that we support such a feature, you would
at least need to:

 (0) have a way for the user to say, "the project tree may have a
     directory D, but I do not want to check it out as a directory because
     my partition is too small.  Whenever you need to create a directory
     there and hang a tree underneath, instead create a symlink that
     points at /export/large/D instead".  Most likely this information
     would go to .git/config;

 (1) whereever we run "create leading directories", we notice and honor
     the above configuration (mostly entry.c::create_directories() called
     from entry.c::checkout_entry());

 (2) whenever we need to check out a file to path D, instead of
     recursively remove everything under it, we remove the symlink and
     deposit the file there (mostly entry.c::remove_subtree() and
     unpack-trees.c::verify_absent());

 (3) whenever we traverse working tree using readdir(), notice that the
     symbolic link we are looking at is the funny "pointing elsewhere but
     this is really a directory" specified in (0) and recurse into the
     directory pointed by it (dir.c::read_directory_recursive() but there
     may be others)

 (4) and we teach has_symlink_leading_path() to special case such a path
     you configured in (0).

I personally do not think adding these to support such a "feature" is such
a high priority, and I do not think it is honest to claim we support such
a feature without doing any of the above.  The current reality is that our
symlink support is still broken in corner cases, and being able to easily
add "sym/path" via "git add" and "git update-index --add" is one of them.
