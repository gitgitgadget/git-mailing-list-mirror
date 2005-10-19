From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-clone: don't unpack objects
Date: Wed, 19 Oct 2005 13:09:11 -0700
Message-ID: <7v4q7d5kwo.fsf@assigned-by-dhcp.cox.net>
References: <20051019154341.2aed6998.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:09:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESKFQ-0002m1-V0
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVJSUJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVJSUJN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:09:13 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14770 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751284AbVJSUJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 16:09:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019200848.OGLZ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 16:08:48 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20051019154341.2aed6998.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Wed, 19 Oct 2005 15:43:41 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10301>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Pass --keep flag to git-clone-pack.

Hmph.  Unconditionally?

I do not personally mind this change; I even have this in my
$HOME/share/git-core/templates/config file:

        [clone]
                keeppack = 1

Are there cases where you would do 'git clone' over git native
transport and want the resulting pack expanded?

One use pattern I could think of that you may not want to have
the keeppack behaviour is when you keep multiple, related
foreign repositories.  For example, I could do this:

    cd /tarpit
    git-clone git://kernel.org/pub/scm/.../torvalds/linux-2.6.git/ 2.6

    mkdir -p $HOME/share/git-core/templates/objects/info
    cat >$HOME/share/git-core/templates/objects/info/alternates <<\EOF
    /tarpit/2.6/.git/objects
    EOF
    # disable clone.keeppack in the templates configuration as well.
    ed $HOME/share/git-core/templates/config

    cd /tarpit
    git-clone git://kernel.org/pub/scm/.../jgarzik/libata-dev.git/ ata

The new 'ata' repository created above is set up to borrow from
the cloned '2.6' repository, even before git-clone-pack is run
(thanks to the alternates in the templates).  git-clone-pack
still needs to download and unpack 100k objects, but most of
them are already available through alternates and does not hit
the disk.  It ends up leaving about 1k unpacked object files
that are unique in ata repository.  But we cannot do this if we
say --keep in git-clone unconditionally.

BTW, probably a better way to do the above example would be
(this time without funny templates trick):

    cd /tarpit
    git-clone git://kernel.org/pub/scm/.../torvalds/linux-2.6.git/ 2.6
    git-clone -l -s -n 2.6 ata

    cd ata
    mkdir .git/refs/2.6
    mv .git/refs/heads .git/refs/tags .git/refs/2.6/.
    git-fetch-pack git://kernel.org/pub/scm/.../jgarzik/libata-dev.git/ |
    while read sha1 path
    do
	case "$path" in HEAD) continue ;; esac
	mkdir -p `dirname ".git/$path"`
    	echo "$sha1" > ".git/$path"
    done
    rm -fr .git/refs/2.6

This one asks the other side to send only 6.5k objects instead
of the full cloning-and-discarding, so it achieves the same
result with a lot less burden on the network.

So in that sense, the first example that showed using --keep
does a suboptimal thing does not qualify as a counterargument to
your change, because it already is doing something suboptimal.

What do people on the list think?
