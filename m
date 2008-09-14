From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Sun, 14 Sep 2008 10:51:18 +0200
Message-ID: <20080914085118.GC30664@diana.vm.bytemark.co.uk>
References: <20080912215613.10270.20599.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 10:30:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kemzv-0005s3-3E
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 10:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYINI3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 04:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbYINI3M
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 04:29:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1172 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYINI3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 04:29:11 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KenKB-00087g-00; Sun, 14 Sep 2008 09:51:19 +0100
Content-Disposition: inline
In-Reply-To: <20080912215613.10270.20599.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95824>

On 2008-09-12 23:01:27 +0100, Catalin Marinas wrote:

> This patch converts the sink command to use stgit.lib. The behaviour
> is also changed slightly so that it only allows to sink a set of
> patches if there are applied once,

"if they are applied"?

> I'm not sure about the conflict resolution. In this implementation,
> if a conflict happens, the transaction is aborted. In case we allow
> conflicts, I have to dig further on how to implement it with the new
> transaction mechanism (I think "delete" does this).

goto does it too. The docstring of the StackTransaction class explains
how it works (if it doesn't, we need to improve it):

    """A stack transaction, used for making complex updates to an
    StGit stack in one single operation that will either succeed or
    fail cleanly.

    The basic theory of operation is the following:

      1. Create a transaction object.

      2. Inside a::

         try
           ...
         except TransactionHalted:
           pass

      block, update the transaction with e.g. methods like
      L{pop_patches} and L{push_patch}. This may create new git
      objects such as commits, but will not write any refs; this means
      that in case of a fatal error we can just walk away, no clean-up
      required.

      (Some operations may need to touch your index and working tree,
      though. But they are cleaned up when needed.)

      3. After the C{try} block -- wheher or not the setup ran to
      completion or halted part-way through by raising a
      L{TransactionHalted} exception -- call the transaction's L{run}
      method. This will either succeed in writing the updated state to
      your refs and index+worktree, or fail without having done
      anything."""

Not all transaction modifications need to be protected by the try
block, only those that may actually raise TransactionHalted (i.e.
those that may conflict). Specifically, in the code below, you need to
put push_patch() in a try block. Otherwise that exception will
propagate all the way up to the top level, and you will never reach
the transaction's run() call which is where refs are updated and the
new tree checked out.

> An additional point - the transaction object supports functions like
> pop_patches and push_patch. Should we change them for consistency
> and simplicity? I.e., apart from current pop_patches with predicate
> add functions that support popping a list or a single patch. The
> same goes for push_patch.

The current set of functions made sense from an implementation
perspective. But you are right that other variants would be helpful
for some callers.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
