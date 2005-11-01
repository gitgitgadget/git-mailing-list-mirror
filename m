From: Chris Mason <mason@suse.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 09:11:49 -0500
Message-ID: <20051101141149.GA26847@watt.suse.com>
References: <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, catalin.marinas@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 15:13:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWwrn-0008Me-RY
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 15:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVKAOL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 09:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVKAOL4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 09:11:56 -0500
Received: from mail.suse.de ([195.135.220.2]:29925 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750799AbVKAOLz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 09:11:55 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0A16EE0BB;
	Tue,  1 Nov 2005 15:11:54 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051101090804.GA11618@pasky.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10933>

On Tue, Nov 01, 2005 at 10:08:04AM +0100, Petr Baudis wrote:
> Dear diary, on Tue, Nov 01, 2005 at 01:25:54AM CET, I got a letter
> where Theodore Ts'o <tytso@mit.edu> told me that...
> > For an example of how to make it a first-class operation, it might be
> > worthwhile to look at Chris Mason's "Mercurial Queues" extention to
> > Mercurial:
> > 
> > 	http://www.selenic.com/mercurial/wiki/index.cgi/MqExtension
> > 
> > I've used it once or twice, and hg mq is definitely very nice and
> > convenient, and it makes commits a first-class operation.  On the
> > other hand, I've found that the combination of quilt and
> > Mercurial/BK/git works just fine, even for my own internal development
> > of (for example) the e2fsprogs tree.
> 
> Did anyone do any current detailed comparison between hg mq and StGIT?

I don't think so, but I'll give it a rough try.  I have not used stgit
extensively, so please correct any mistakes below.  Most of the
differences center around the ways we store patches.

Both tools make patches into commits during push.  This allows the
various history commands to see the currently applied patches.

Both tools allow you to make changes to files without running some form
of quilt add first.

StGIT has the ability to rebase patches via three-way merge.  This is
still on my todo list for mq.

StGIT patch storage is very different from quilt and mq.  StGIT keeps
git commit/tree objects around for patches that have been applied.  It
then stores a directory with metadata about the patch
(author/description etc) and the ids of the git commit objects.

In StGIT, importing new patches seems to require stg import, and exporting patches
requires stg export (or a similar git command).  But once the patches
are stored in stgit, push/pop will be very fast.

mq is closer to quilt.  The patches are stored as patches, and hg qpush
is very similar to importing a patch.  This means metadata must be
stored at the top of the patch in some form the import code can
understand (it tries to be smart about this).

hg qrefresh will update the patch file, so the patch is always up to
date wrt to the hg repo.

You can import/export patches with hg commands, or by copying patches
into/from the .hg/patches directory.  This also means you can take a
quilt patch dir, copy it into .hg/patches and just start using mq.

mq has some support for putting the patches directory under
revision control (as a separate repository).

Most of the other differences come from differences between hg and git.
I'm not sure if stgit has some form of annotate, but it's a nice way to
find out which patch changed a given loc in hg/mq.

-chris
