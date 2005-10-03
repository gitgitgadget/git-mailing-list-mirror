From: Junio C Hamano <junkio@cox.net>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Mon, 03 Oct 2005 10:18:02 -0700
Message-ID: <7v8xxasenp.fsf@assigned-by-dhcp.cox.net>
References: <20050930160353.F025C352B7B@atlas.denx.de>
	<Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>
	<7vr7b53y0n.fsf@assigned-by-dhcp.cox.net>
	<7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net>
	<433F52DC.5090906@zytor.com>
	<pan.2005.10.02.09.55.52.564046@smurf.noris.de>
	<4340B73B.1090409@zytor.com> <7virwfuqwv.fsf@assigned-by-dhcp.cox.net>
	<43415C9A.1090502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 19:25:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMTx7-0003iV-9f
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 19:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933248AbVJCRSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 13:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933247AbVJCRSG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 13:18:06 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8943 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S933243AbVJCRSE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 13:18:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051003171801.IFWR19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Oct 2005 13:18:01 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43415C9A.1090502@zytor.com> (H. Peter Anvin's message of "Mon,
	03 Oct 2005 09:30:18 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9639>

"H. Peter Anvin" <hpa@zytor.com> writes:

> As you stated above, we currently use this field in a very inefficient 
> manner, because of old mistakes.  There are several ways to recover from 
> here, some of which are more complex than others.

Solution for in-tree permission mode bits you outlined looked
fine (I'll have to re-read the part about "mode xor (mode &
022)..." part later, though).

For in-cache permission mode bits, we would probably need
something like this:

  * git-update-index will pick up the filesystem bits with the
    current semantics (i.e. look only at (mode & 0100) and
    force 0644 or 0755) by default; --full-perm-bits option
    would bypass this bits munging.

    Once a file is added with --full-perm-bits, it might be
    nice if index file remembers to pick up the full bits next
    time git-update-index is run on the path.  This could be
    achieved by saying that anything stored in the cache with
    non 100644, 100755 nor 120000 bits are such paths without
    having to change the index file format.

  * there are bunch of codes that assume 0644 and 0755 are the
    norm but also know that there are ancient trees that have
    0664 and 0775 and try to treat them equivalently.  They need
    to be selectively neutered; this applies to in-tree
    permission bits as well.

    git-read-tree will read permission mode bits from tree
    object as-is.  I.e. you will get 0644 and 0755 in cache from
    the existing tree objects.  When you check things out with
    002 umask, you will get 0664 and 0775 on the filesystem.  We
    do not want to consider this "mode changed by the user".

    git-update-index --refresh code should not be mode neutered
    to prevent this.  The same thing goes for diff.  These
    currently canonicalize mode bits by looking at (mode &
    0100), but should be changed to do so only when index has
    already the canonical mode bits, or something like that.

  * git-write-tree and git-fsck-objects probably has code to
    reject and correct abnormal mode bits.  They need to be
    neutered.
