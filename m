From: Yann Dirson <ydirson@altern.org>
Subject: [RFC] Adding stack-level logging/undo to StGIT
Date: Sat, 6 Jan 2007 00:19:44 +0100
Message-ID: <20070105231944.GB6179@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 00:19:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2yLn-0005UP-GH
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbXAEXTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXAEXTs
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:19:48 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:55585 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbXAEXTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:19:48 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A7EB77677;
	Sat,  6 Jan 2007 00:19:46 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 7DF901F08C; Sat,  6 Jan 2007 00:19:44 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36046>

This mail is a draft collection of design ideas to hopefully progress
towards full "undo" functionnality in StGIT.  The issue is not
trivial, so I'd prefer to hear from users before starting to code
anything :)


The main goal with this feature is to provide a log of what happenned
to a stgit stack, with sufficient details to be able to undo any
number of operations.  A "stg undo" (and fellow "stg redo") would
replace current --undo flags that only a couple of commands implement.
Another command (maybe "stg slog" ?) would allow to examine this log.

Since some existing stgit operations are already made of several more
elementary operations, the log will most likely have to record sort of
BEGIN/END events, which will pave the way to transactions.


What I'm thinking of is to use a mechanism similar to the one already
used for patch logs: the stack log would use its own head ref pointing
to a commit describing the operation, with the stacklog commit for the
previous operation as parent.

Information to be available from a stacklog commit include:

- the series file
- the current top patchname
- the relevant patchlog commits

The current top can be put into a "Current:" pseudo-header in the
commit message.

The series file seems a good candidate to be history-tracked by GIT
(in its own tree if necessary - a tree would even provide some place
to extend the mechanism when needed).

The list of patchlog commits, ordered by the series file, may or may
not be useful to history-track.  It could be kept in a blob alongside
the series file, or could be part of the stacklog commit message.  The
latter would allow to jump from stacklog to patchlog in gitk at no
cost (although that's hardly an excuse per se ;).


Which patchlogs should be referenced by a stacklog entry ?

I would rule out those for patches left unapplied by the operation,
which (unless I miss some point) are by definition not touched by that
operation (I'm talking about elementary operations like
push/pop/new/delete here - compound operations can obviously have
side-effects, recorded in the elementary stacklogs that build them up).

For elementary operations as well, it looks like just recording the
patchlog for the patch left at the top by the operation could be
enough.  Or do I miss something ?


Maybe maintainance of the stacklog requires a separate index file ?


For compound operations, I'd like to be able to handle them as a
single operation for most purpose - ie, "stg undo" after a "stg push
p1" would both undo the push like "stg push --undo" currently does,
and as well revert the series order to put p1 back where it was
located.

That is, a compound operation would be represented in the stack log by
a single commit.  That commit would in turn point to the sequence of
elementary commits that make the compound, probably by a "Sublogs:"
pseudo-header in the compound stacklog message.

Until a compound operation has been finalized, we would store in the
stacklog the operations that will make the compound, using a special
"BEGIN" operation to mark the start of the transaction.  When
finalizing the transaction, those would be moved from the main
stacklog to the compound stacklog entry, which would replace them.

Problem: with this design, the first operation in the compound will
point to the BEGIN op as its parent; I would prefer to have it point
to the compound's parent (ie. the previous real operation on the
stack).  That would allow to easily "break a transaction", either
before it's finished, or afterwards by "undoing into it".

So probably we should keep the BEGIN marker somewhere else.
Any strong ideas out there ?

Best regards,
-- 
Yann.
