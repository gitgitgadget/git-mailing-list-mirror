From: Junio C Hamano <junkio@cox.net>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Sun, 02 Oct 2005 22:10:24 -0700
Message-ID: <7virwfuqwv.fsf@assigned-by-dhcp.cox.net>
References: <20050930160353.F025C352B7B@atlas.denx.de>
	<Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>
	<7vr7b53y0n.fsf@assigned-by-dhcp.cox.net>
	<7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net>
	<433F52DC.5090906@zytor.com>
	<pan.2005.10.02.09.55.52.564046@smurf.noris.de>
	<4340B73B.1090409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 07:10:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMIau-0004At-Jw
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 07:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVJCFK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 01:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVJCFK2
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 01:10:28 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57554 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750832AbVJCFK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 01:10:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051003051020.UMFC29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Oct 2005 01:10:20 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4340B73B.1090409@zytor.com> (H. Peter Anvin's message of "Sun,
	02 Oct 2005 21:44:43 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9631>

"H. Peter Anvin" <hpa@zytor.com> writes:

> My point is that I believe it should.  It has the bitfield for it, it 
> just doesn't use it at the moment.

It is a bit more complicated than that.

Long time ago, we used to store the full permission bits and
ended up storing files in 0644 and 0664 modes, depending on who
is writing the tree object.  People with umask 022 checked out
from a tree that recorded blobs with 0664 bits and ended up
getting "mode changed" diff all the time, which was unacceptable
from the SCM point of view.  We _could_ have really changed the
mode bits representation in the tree objects back then to have
type + executable bit, but to preserve backward compatibility,
we chose to keep the bitfield layout and changed the code to
treat 1006xx and 1007yy in older trees to be equivalent to
100644 and 100755.  These days, for newly written tree objects,
above xx and yy 6-bit fields are "Must Be 4" and "Must Be 5"
fields, respectively, not bitfields to store arbitrary group and
other permission information.  git-fsck-objects even complains
about them.

So in that sense, it does _not_ have the bitfield for it, and
obviously we cannot use what we do not have.
