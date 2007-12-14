From: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
Subject: config.c fixes
Date: Fri, 14 Dec 2007 14:28:52 -0500
Message-ID: <20071214192852.GA24187@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 14 19:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3FfZ-0005Ib-Ru
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 19:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbXLNSxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 13:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbXLNSxR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 13:53:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48996 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416AbXLNSxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 13:53:16 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBEIlNFi021367;
	Fri, 14 Dec 2007 13:47:23 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBEIlNoI022832;
	Fri, 14 Dec 2007 13:47:23 -0500
Received: from localhost (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lBEIlNVL015570;
	Fri, 14 Dec 2007 13:47:23 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68326>

Hi,

[ This should have gone out as a cover letter for the patch series
  but some how I didn't manage to make that work ]

While strace'ing builtin-clone I saw this horror:

...
write(3, "remote", 6)                   = 6
write(3, " = ", 3)                      = 3
write(3, "o", 1)                        = 1
write(3, "r", 1)                        = 1
write(3, "i", 1)                        = 1
write(3, "g", 1)                        = 1
write(3, "i", 1)                        = 1
write(3, "n", 1)                        = 1
write(3, "\n", 1)                       = 1
munmap(0xb7f72000, 102)                 = 0
close(3)                                = 0
close(3)                                = -1 EBADF (Bad file descriptor)
...

That's just terrible.  And hey, it turns out the code is terrible too.
I think the best solution is to just parse up the entire config file
up front and keep it in a data structure, make the changes and then
write it all out at the end.  That makes it cheap to make a series of
changes too:

	config = open_config(file);
	set_key(config, key1, value1);
	set_key(config, key2, value2);
	set_key(config, key3, value3);
	commit_config(config);

Or something.  Anyway, for 1.5.4 I wrote the following two patches that
fixes the 1-bytes writes and the double close.

 config.c |  113 +++++++++++++++++++++++--------------------------------------
 1 files changed, 43 insertions(+), 70 deletions(-)

cheers,
Kristian
