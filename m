From: Luis Gutierrez <luis.gutierrez@xmos.com>
Subject: inted problems when upgrading to 1.6.0.4
Date: Tue, 25 Nov 2008 09:29:14 +0000
Message-ID: <492BC56A.6040506@xmos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 10:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4uFH-0004Am-Ji
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 10:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbYKYJ2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 04:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbYKYJ2u
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 04:28:50 -0500
Received: from smtp-out-68.livemail.co.uk ([213.171.216.68]:53605 "EHLO
	smtp-out-68.livemail.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752121AbYKYJ2t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 04:28:49 -0500
Received: from [10.0.102.43] (unknown [195.26.247.140])
	by smtp-out-68.livemail.co.uk (Postfix) with ESMTP id C75DB45EF21
	for <git@vger.kernel.org>; Tue, 25 Nov 2008 09:28:47 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101653>

Hi All,

At my company we have been using git for the past months, and except for 
a few people, everyone is happy with it. Last week, we discovered that 
the mac version of git was misbehaving (v1.5.6.4), but upgrading the 
client to the latest one (v1.6.0.4) fixed the issue. Fearing consistency 
issue between version, I decided to update the version of the central 
repository (ie, the place were people can go and synchronize their code) 
on a RHEL4 box from 1.5.6.4 to 1.6.0.4.
went to my git directory, pulled, checkout v1.6.0.4, and compiled with 
'make --prefix=/usr/loca/ all' and installed with the same comamnd. 
xinted dameon was restarted and then all hell broke loose.

All push/pull/clone operations were failing with the dreaded 'fatal: The 
remote end hung up unexpectedly'. After a few tests, this is what I found:

- I can clone/pull/push if I do it through ssh (ie, git clone 
ssh://server/project)
- I can clone/pull/push if I start git daemon on the command line through
git daemon --syslog --verbose --export-all 
--base-path=/vol0/git/projects --verbose --reuseaddr

But the way I had setup git, through xinetd is broken.

This is my current xinetd config:
service git
{
    disable      = yes
    socket_type  = stream
    wait         = no
    user         = git
    type         = UNLISTED
    protocol     = tcp
    log_on_failure    += USERID
    port         = 9418
    server       = /usr/local/bin/git
    server_args  = daemon --inetd --syslog --verbose --export-all 
--base-path=/vol0/git/projects --allow-override=uploadpack
}

And I'm getting the following errors:
 > git clone git://romanticism/tutorial tutorial.git
Initialized empty Git repository in /tmp/tutorial.git/.git/
fatal: protocol error: bad line length character

before adding the --allow-override=uploadpack I was getting this:
 > git clone git://romanticism/tutorial tutorial.git
Initialized empty Git repository in /tmp/tutorial.git/.git/
fatal: The remote end hung up unexpectedly

Since the error appeared after the upgrade, it seems likely it is either 
a but, or something change regarding inte/xinetd, but I can't find any 
documentation about changes here.

Any help will be appreciated.

Luis Gutierrez
