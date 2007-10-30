From: Melchior FRANZ <mfranz@aon.at>
Subject: [BUG] remote.c/match_explicit() ... NULL pointer dereferenciation (git 1.5.3.4)
Date: Tue, 30 Oct 2007 11:44:32 +0100
Message-ID: <200710301144.32528@rk-nord.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 11:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imoh2-0008Po-5Z
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 11:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbXJ3KvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 06:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbXJ3KvS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 06:51:18 -0400
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:43809 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750981AbXJ3KvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 06:51:17 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2007 06:51:17 EDT
Received: (qmail 15800 invoked from network); 30 Oct 2007 10:44:35 -0000
Received: from unknown (HELO email.aon.at) ([172.18.5.231])
          (envelope-sender <mfranz@aon.at>)
          by fallback02.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 30 Oct 2007 10:44:35 -0000
Received: (qmail 5100 invoked from network); 30 Oct 2007 10:44:32 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL601.highway.telekom.at
Received: from m3498p001.adsl.highway.telekom.at (HELO server.lan) ([88.117.85.33])
          (envelope-sender <mfranz@aon.at>)
          by smarthub92.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 30 Oct 2007 10:44:32 -0000
Received: from localhost (localhost [IPv6:::1])
	by server.lan (Postfix) with ESMTP id 7232D160F65C3
	for <git@vger.kernel.org>; Tue, 30 Oct 2007 11:44:33 +0100 (CET)
User-Agent: KMail/1.9.8
X-PGP: http://members.aon.at/mfranz/melchior.franz
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I'm mucking around with git while implementing a simple, flat
CVS gateway. For tests I created a local remote clone via
"git remote add -f -t master -m master origin /local/path"
(as described on the git-remote man-page). When running a
(wrong) command like  "git push origin foo", whereby "foo"
is nowhere defined in the refspec list:

  [remote "origin"]
          url = /local/path
          fetch = +refs/heads/master:refs/remotes/origin/master
          push = +master:refs/heads/sync

then git-send-pack segfaults in remote.c/count_refspec_match
in the strlen() function, because "pattern" contains garbage.


And this is because in match_explicit() we have these lines:

        if (!matched_src)
                errs = 1;

        if (dst_value == NULL)
                dst_value = matched_src->name;
                                           <<- gdb prints from here


and with the unknown refspec "foo" both dst_value and matched_src
are zero:

  (gdb) print dst_value
  $1 = 0x0

  (gdb) print *rs
  $2 = {
    force = 0,
    pattern = 0,
    src = 0x808d680 "foo",
    dst = 0x0
  }

  (gdb) print matched_src
  $3 = (struct ref *) 0x0

  (gdb) print dst_value
  $4 = 0x34 <Address 0x34 out of bounds>


No idea, why the NULL-pointer dereferenciation doesn't segfault
right away, but assigns 0x34 to dst_value. Compiler bug?

m.



Spec:
  Linux 2.6.23.1  x86/P4
  gcc 4.2.1 (SUSE Linux)   (openSuSE 10.3)
  libc 2.6.1 (20070803)
  git 1.5.3.4  (compiled with -g -O0)
