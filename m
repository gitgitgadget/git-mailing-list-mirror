From: Junio C Hamano <junkio@cox.net>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 02:40:56 -0700
Message-ID: <7vekamvmxj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
	<20050627235857.GA21533@64m.dyndns.org>
	<Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 11:34:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnCTu-0006Ns-1e
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 11:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVF1JlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVF1JlK
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 05:41:10 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34799 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262023AbVF1Jk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 05:40:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628094057.YVBB1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 05:40:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> But the savings get increasingly bigger the more history we have. That's
LT> also why the packed git archive is about 1/14th of the size of the fully
LT> unpacked disk usage of the git project,...

GIT archive may be an odd-ball because the project itself is so
small, but a fair comparison should include the disk usage of
256 fan-out directories.  Counting them, empty .git/objects/
with the 1.4MB packed archive and 90KB index file ends up being
somewhere around 2.4MB on my machine, compared with 17MB for the
traditional one.

Still a good space reduction.  Good job!

I am now dreaming if we someday would enhance the mechanism with
append-only updates to the *.pack files with complete rewrite of
the *.idx files, and get rid of files under .git/objects totally.

This would make things reasonably friendly to rsync.  The kernel
pack has around 60M pack with 1.1M index, so everyday use would
involve incremental updates to the pack [*1*] and full download
of the index file.

[Footnote]

*1* Presumably many objects are deltified against older objects
which is suboptimal.  Most likely the newer objects are accessed
far more often and they are what we would want to keep in full
not as delta.  So even with this scheme we would want to have
weekly repacking.  Interestingly enough, pack-objects gets the
objects via usual read_sha1_file() interface so it can produce a
new pack from an existing pack.
