From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: config.c fixes
Date: Fri, 14 Dec 2007 14:22:35 -0500
Message-ID: <1197660157-24109-1-git-send-email-krh@redhat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 14 19:53:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3FfC-0005AJ-3z
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 19:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbXLNSxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 13:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbXLNSxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 13:53:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48988 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbXLNSxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 13:53:06 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBEIf9VZ018939;
	Fri, 14 Dec 2007 13:41:09 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBEIf8KV019771;
	Fri, 14 Dec 2007 13:41:08 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lBEIf8em014282;
	Fri, 14 Dec 2007 13:41:08 -0500
X-Mailer: git-send-email 1.5.4.rc0.8.g8fc45-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68325>

Hi,

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
