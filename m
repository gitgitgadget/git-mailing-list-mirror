From: Nix <nix@esperi.org.uk>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 22:49:57 +0100
Message-ID: <87lkd6n62i.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<86zm1sbpeh.fsf@lola.quinscape.zz>
	<20070719123214.GB4929@moonlight.home>
	<863azka7d4.fsf@lola.quinscape.zz> <87ps2inab5.fsf@hades.wkstn.nix>
	<85y7h6dewp.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:50:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID5n8-00049Z-RK
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 23:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765727AbXGWVuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 17:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765495AbXGWVuG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 17:50:06 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:56966 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762021AbXGWVuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 17:50:03 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l6NLnwrw021203;
	Mon, 23 Jul 2007 22:49:58 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l6NLnvSs027995;
	Mon, 23 Jul 2007 22:49:57 +0100
Emacs: don't try this at home, kids!
In-Reply-To: <85y7h6dewp.fsf@lola.goethe.zz> (David Kastrup's message of "Mon, 23 Jul 2007 22:49:10 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
X-DCC-WEiAPG-Metrics: hades 1072; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53489>

On 23 Jul 2007, David Kastrup uttered the following:
> Nix <nix@esperi.org.uk> writes:
>> Actually, if we had a post-checkout hook, we could use a pre-commit
>> hook to keep track of directory existence, permissions, et seq, and
>> a post- checkout hook to restore them.
>
> Actually, tracking permissions would be cheap: one just needs to
> replace the permission-munging macros in git with identity.  Ownership
> -- well, that's harder.
>
> But my sentiment remains: git _tracks_ stuff: it notices when things
> move around and follows them.  Statically snapshotting permissions
> creates a layer that is quite less flexible.  The information gets
> detached.

Not if you record it in a file which is checked in in the same commit
that is tracked, it isn't (that's what the pre-commit hook is for). It's
true that git won't natively have any knowledge of that data, but Linus
has fairly effectively shown that it shouldn't have any such knowledge
and doesn't need it.

(You might want to give git-diff knowledge of it, just so it can skip
it unless a new flag is given. Give the file a nice format, and bingo,
readable permission/ownership diffs!)

(I'd recommend storing the names of user/group file owners as well as
the uids, so you can --- given suitable permissions --- chown to the
right username in preference to uid if that user exists at checkout
time.)


Doing this *efficiently* is another matter: probably a pair of hooks are
needed, run on pre-checkout and post-checkout: they can communicate so
as only to fiddle permissions on things which are newly appeared or
whose permissions have changed.

Obviously because the permissions, ownerships et al aren't recorded in
the index this will slow committing down, but given that
git-update-index will already have sucked the entire tree's inodes into
the page cache anyway, I don't think a second pass over the working tree
snarfing permissions would slow it down much.


As I need this anyway (I'm backing up a filesystem via git, yes, I'm
insane but I need version control and it's horrifically redundant so
packing it will save heaps of space), I guess I'd better get off my
rear and write the code.

(The recent commit-as-a-builtin's introduction of a run_hook() function
will be pretty damn useful: good timing, I guess.)
