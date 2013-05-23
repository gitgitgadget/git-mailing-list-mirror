From: Ian Kumlien <pomac@vapor.com>
Subject: git hangs on pthread_join
Date: Thu, 23 May 2013 15:01:43 +0200
Message-ID: <20130523130143.GA6376@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 23 15:39:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfVjR-0007SK-87
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 15:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758749Ab3EWNi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 09:38:57 -0400
Received: from mail.vapor.com ([83.220.149.2]:59966 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758671Ab3EWNi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 09:38:57 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2013 09:38:57 EDT
Received: from twilight.demius.net (c-297271d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.114.41])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id 117DC29AC21
	for <git@vger.kernel.org>; Thu, 23 May 2013 15:32:42 +0200 (CEST)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 500608E0D8D; Thu, 23 May 2013 15:01:43 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225246>

Hi,

I'm running a rather special configuration, basically i have a gerrit
server pushing
git data over openvpn connections (company regulations n' stuff)...

git 1.8.2.1 is started by xinetd
...
        port            = 9418
        socket_type     = stream
        wait            = no
        user            = gerrit2
        server          = /usr/bin/git
        server_args     =  daemon --inetd --syslog --export-all
--enable=receive-pack --init-timeout=3 --timeout=180 --base-path=<path>
...
        nice            = 10
        per_source      = UNLIMITED
        instances       = UNLIMITED
        flags           = KEEPALIVE NODELAY
---

Keepalive and nodelay has been added post fact, the same goes for the
timeouts.

I have found "git receive-pack"s that has been running for days/weeks
without terminating....

Attaching gdb and doing a trace results in:
#0  0x0000003261207b35 in pthread_join () from /lib64/libpthread.so.0
#1  0x00000000004ce58b in finish_async ()
#2  0x000000000045744b in cmd_receive_pack ()
#3  0x0000000000404851 in handle_internal_command ()
#4  0x0000000000404c9d in main ()
(sorry don't have any debug data for the binary packages apparenlty (rpms
was
built from the official source))

(RHEL 5 machine with glibc 2.5-65.el5_7.1)

Anyone that has any clues about what could be going wrong?
