From: Junio C Hamano <junkio@cox.net>
Subject: upload-pack is unsafe in corrupt repository
Date: Tue, 20 Jun 2006 05:12:25 -0700
Message-ID: <7vac8881qu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 14:12:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsf5q-0005qh-37
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 14:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWFTMM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 08:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWFTMM1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 08:12:27 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61833 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932610AbWFTMM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 08:12:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620121226.FPFV12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 08:12:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22196>

I was helping Andrew fetching from maintainer trees.  One of the
trees were corrupt (i.e. git-fsck-objects unclean) and there was
a rather grave consequences we found out the hard way (and it is
5am but Tuesday is not my git day X-<).

upload-pack forks a pipeline, whose upstream execs rev-list and
downstream execs pack-objects.  rev-list correctly notices that
it cannot reach some objects and dies, but pack-objects just
says "Ah, the list of object input just ended -- let's send them
all".  This results in git-fetch-pack to be fed an incomplete
pack.  However, git-unpack-objects is happy (the pack is not
corrupt, just that it does not contain what the protocol
exchange expected to send) and git-fetch-pack ends up going all
the way through updating the ref.

Eek.

At this moment, I am just reporting this because I am too tired
to code it myself right now, but I think the fix is to make
upload-pack to fork once more, waitpid() for rev-list and
inject/append garbage in the stream pack-objects produces, in
order to cause unpack-objects (or index-pack) that runs on the
the fetching end to notice, when rev-list or pack-objects barf.

Of course a nicer fix is to add the sideband we have been
discussing about, but that relies on protocol extension and
would not solve the problem for older clients.

Side note: in my head, the sideband would work by the "forked
once more" upload-pack process to listen to both stdout and
stderr of pack-objects, and feed them packetized (instead of the
current "go-straight-stream") by perhaps prefixing them with one
byte (is this a payload, or is this a progress-bar/keepalive type
packet).  Of course, this would change the way the payload is
transferred, so the initial handshake needs to negotiate if the
sideband should be used just like we do other new features like
thin pack transfers.
