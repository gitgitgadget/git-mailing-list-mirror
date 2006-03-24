From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] make test (t3600-rm.sh) fails
Date: Fri, 24 Mar 2006 03:08:08 -0800
Message-ID: <7vy7z0yuav.fsf@assigned-by-dhcp.cox.net>
References: <4423C681.3000302@issaris.org>
	<7v7j6k16g2.fsf@assigned-by-dhcp.cox.net>
	<df33fe7c0603240245o516095b5m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 12:08:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMk9P-0006gD-SE
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 12:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWCXLIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 06:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWCXLIL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 06:08:11 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42681 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751626AbWCXLIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 06:08:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324110809.GQUI15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Mar 2006 06:08:09 -0500
To: takis@issaris.org
In-Reply-To: <df33fe7c0603240245o516095b5m@mail.gmail.com>
	(panagiotis.issaris@gmail.com's message of "Fri, 24 Mar 2006 11:45:39
	+0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17910>

Takis <panagiotis.issaris@gmail.com> writes:

> I am running it as fakeroot, as part of the "dpkg-buildpackage
> -rfakeroot -uc -us -b"
> command for building Debian packages. Would this be the problem (the fakeroot)?

That is what is causing this, yes.

	$ mkdir /var/tmp/junk && cd /var/tmp/junk
        $ chmod u+w .
	$ fakeroot sh -c 'date >foo; chmod u-w .; rm foo; ls -l foo'
        $ chmod u+w .
	$ sh -c 'date >foo; chmod u-w .; rm foo; ls -l foo'

The one under fakeroot happily ignores the directory being
unwritable because it mimics to be root.

But that does not mean fakeroot is buggy.  Fakeroot is doing
what it is designed to do.

That does not mean running our tests under fakeroot is stupidity
on your part.  We do not advertise that the tests should not be
run as root.

The test is buggy -- it tries to make sure the command fails
when underlying rm fails, but is not aware that "chmod u-w ."
is not a good way to make ./foo undeletable if you run it as
root.  At least it should skip those two tests if it is run by
root.
