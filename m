From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fix compare symlink against readlink not data
Date: Fri, 06 May 2005 09:26:15 -0700
Message-ID: <7vy8ascod4.fsf@assigned-by-dhcp.cox.net>
References: <20050506134501.GA11430@vrfy.org>
	<20050506160359.GB6904@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:20:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5YG-0003SR-Tr
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEFQ0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVEFQ0X
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:26:23 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29895 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261186AbVEFQ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 12:26:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506162616.WARJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 12:26:16 -0400
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050506160359.GB6904@kroah.com> (Greg KH's message of "Fri, 6
 May 2005 09:03:59 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "GKH" == Greg KH <greg@kroah.com> writes:

GKH> On Fri, May 06, 2005 at 03:45:01PM +0200, Kay Sievers wrote:
>> Thanks to Greg for recognizing this while he added our list of symlinks
>> back to the udev repository.

GKH> Hm, even with this patch applied (it's in Linus's tree right now), I
GKH> still get the following with a clean checked out udev tree:
GKH>  $ cg-diff
GKH>  Index: test/sys/block/cciss!c0d0/device
GKH>  ===================================================================
GKH>  Index: test/sys/block/rd!c0d0/device
GKH>  ===================================================================

GKH> Any idea?

I do not use Cogito but probably it is this piece of code in
cg-Xdiffdo.  It is assuming that a valid SHA1 means it can diff
against the filesystem object that resides there.  It used to be
the case before symlinks but not anymore.

    mkbanner () {
            loc=$1; treeid=$2; fname=$3; mode=$4; sha1=$5;

            if [ "$sha1" != "0000000000000000000000000000000000000000" ]; then
                    git-cat-file blob $sha1 >$loc
            else
                    ln -s "$(pwd)/$fname" "$loc"
                    sha1="!"
            fi

Maybe changing the if to (I'm writing this in e-mail editor so
completely untested) something like:

    if expr "$sha1" : '0*$' >/dev/null ||
       expr "$mode" : '.*120000$' >/dev/null
    then
        git-cat-file blob "$sha1" >$loc

would help?

Also could you try the low-level git command, git-diff-cache -p,
against the tree you are comparing?  The built-in diff stuff
might get this wrong too.


