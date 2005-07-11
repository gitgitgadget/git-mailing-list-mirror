From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 13:14:41 -0700
Message-ID: <7virzhrtfy.fsf@assigned-by-dhcp.cox.net>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
	<20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>
	<7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>
	<42D2CBA2.8060705@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bryan.larsen@gmail.com,
	pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 02:05:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds8H2-0000qg-Ay
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVGKUS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 16:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVGKUQR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:16:17 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4060 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262558AbVGKUOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 16:14:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711201440.PQSL15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 16:14:40 -0400
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <42D2CBA2.8060705@yahoo.com> (Bryan Larsen's message of "Mon, 11 Jul 2005 15:42:26 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen <bryanlarsen@yahoo.com> writes:

> Last night, I couldn't think of alternatives to these, but I obviously
> didn't try very hard.  xargs -r can probably happen via a temporary
> file and cp -u can probably be simulated using rsync.

The only user of "xargs -r" in the Linus GIT is git-prune-script
which tries not to run "rm -f" with an empty argument list, like
this:

    git-fsck-cache --cache --unreachable "$@" |
    sed -ne '/unreachable /{
        s/unreachable [^ ][^ ]* //
        s|\(..\)|\1/|p
    }' | {
            cd "$GIT_OBJECT_DIRECTORY" || exit
            xargs -r $dryrun rm -f
    }

Not tested on a BSD, and it is probably as ugly as it can get,
but we could:

    {
        echo 'unreachable nosuch/file';
        git-fsck-cache --cache --unreachable "$@" 
    } |
    sed -ne '/unreachable /{
        s/unreachable [^ ][^ ]* //
        s|\(..\)|\1/|p
    }' | {
            cd "$GIT_OBJECT_DIRECTORY" || exit
            xargs $dryrun rm -f
    }

The only user of "cp -l" in the Linus GIT is git-clone-script
local optimization.  I could revert it to the version that I
originally sent to the list, which uses cpio -pld, if your cpio
groks that flag.

I do not speak for Pasky, but to me "cp -u" sounds just like an
optimization, so maybe defining CP_U='cp -u' and detect missing
support at config time and falling back on the simple "cp" would
be an option?

GNU "cp -a" states that is the same as "-dpR" (never follow
symlinks, preserve link, mode, ownership, and timestamps), so
that can be rewritten as a shell function in cg-Xlib that is
called say cg_copy_tree, whose implementation runs two tar
processes piped together when "cp -a" is not available.  Using a
tarpipe unconditionally is also fine.
