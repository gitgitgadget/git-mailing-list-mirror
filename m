From: Junio C Hamano <junkio@cox.net>
Subject: Delta-transfer using thin-pack
Date: Sun, 19 Feb 2006 15:27:49 -0800
Message-ID: <7voe13exoq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 00:27:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAxy6-0005Jp-27
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 00:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWBSX1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 18:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBSX1v
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 18:27:51 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5353 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932341AbWBSX1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 18:27:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060219232419.KGGY20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Feb 2006 18:24:19 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16457>

I'll be sending out three experimental patches that would come
on top of "next".  With them, you should be able to:

	$ git send-pack --thin other/repo/sitory

and it would send deltified representation based on things not
in the transferred data.

This is somewhat experimental, although I tried it myself and it
seems to work with my limited test.  Do not push into your
production repository with it yet, but please do try it out.

How does it work?

"git send-pack" works by:

 (1) negotiating with the other end to find out what common
     commits our repository and the other one has;

 (2) computing the list of objects to send to the other end by
     running

     "git-rev-list --objects $heads `git-rev-parse --not $commons`"

     ($heads are what we are going to send, $commons are what
     they already have).

 (3) feeding (2) to git-pack-object --stdout, sending the result
     to the other end.

 (4) invoke git-receive-pack on the other end and have it read
     the output from (3), which will feed git-unpack-objects on
     the other end.

In general, the packfile is designed to be "self contained".
This is necessary in case we need to deal with more than one
huge packfiles that we can mmap only one at a time -- we
guarantee that the base object of a deltified object is found
while unpacking that deltified object because the base object
can always be found in the same pack.

However, during send-pack/receive-pack transfer, we will unpack
the resulting packfile on the other end into loose objects, so
it is not strictly necessary to require self-containedness to
the packfile used for the transfer.
