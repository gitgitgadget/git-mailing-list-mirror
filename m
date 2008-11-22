From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to setup a public reposistory?
Date: Sat, 22 Nov 2008 12:12:49 +0100
Message-ID: <4927E931.3080802@op5.se>
References: <354563.49837.qm@web37901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Sat Nov 22 12:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3qRK-00025h-EI
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 12:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796AbYKVLM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 06:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756683AbYKVLM5
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 06:12:57 -0500
Received: from mail.op5.se ([193.201.96.20]:39200 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756627AbYKVLM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 06:12:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 955F11B8005E;
	Sat, 22 Nov 2008 12:08:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yYnU8sS3VCdh; Sat, 22 Nov 2008 12:08:05 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 8EA1C1B80005;
	Sat, 22 Nov 2008 12:08:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <354563.49837.qm@web37901.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101551>

Gary Yang wrote:
> I followed the steps outlined by the links below. But, I am still not able to setup the public repository. I got, fatal: unable to connect a socket (Connection refused). What I did wrong? Please help.
> 
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#setting-up-a-public-repository
> http://dtcsupport.gplhost.com/Git/Public-Repo-Howto
> 
> 0. Prepare your name and email address
> cat ~gyang/.gitconfig
> [user]
>         email = gyang@mycompany.com
>         name = Gary Yang
> 
> 
> 1. Create an archive to send to the server
> 
> /home/gyang% git clone http://git.gplhost.com/dtc-xen.git
> 
> /home/gyang% git clone --bare dtc-xen dtc-xen.git
> 
> /home/gyang% touch dtc-xen.git/git-daemon-export-ok
> 
> /home/gyang% tar -cvzf dtc-xen.git.tar.gz dtc-xen.git
> 
> 
> 2. Install the archive on the web server
> 
> /pub/git% tar -xvzf /home/gyang/dtc-xen.git.tar.gz
> 
> /pub/git/dtc-xen.git% git --bare update-server-info
> 
> /pub/git/dtc-xen.git% mv hooks/post-update.sample hooks/post-update
> 
> /pub/git/dtc-xen.git% chmod +x hooks/post-update
> 
> /pub/git/dtc-xen.git% cat hooks/post-update
> #!/bin/sh
> #
> # An example hook script to prepare a packed repository for use over
> # dumb transports.
> #
> # To enable this hook, rename this file to "post-update".
> 
> exec git-update-server-info
> 
> 
> 3. Configure and start git daemon at the web server
> 
> /pub/git/dtc-xen.git% grep 9418 /etc/services
> git             9418/tcp                        # Git Version Control System
> 
> 
> /pub/git/dtc-xen.git% sudo git daemon --verbose --inetd --export-all /pub/git &
> 

You shouldn't give "--inetd" when starting from command line. Do like this:

  sudo git daemon --detach --verbose --export-all --base-path=/pub/git

Then clone dtc-xen.git using the following command:

  git clone git://git.mycompany.com/dtc-xen.git test-git

> 
> 4. At my local machine. I did
> 
> /home/gyang% git clone git://git.mycompany.com/pub/git/dtc-xen.git test-git
> 
> Initialized empty Git repository in //home/gyang/test-git/.git/
> git.mycompany.com[0: 10.66.4.168]: errno=Connection refused
> fatal: unable to connect a socket (Connection refused)
> 
> 
> ps -efww | grep git
> root      9626 22321  0 11:31 pts/1    00:00:00 git-daemon --verbose --inetd --export-all /pub/git
> 

Yes, it's waiting for input from stdin, which is what "--inetd" does to a
process. Do what I told you above and it'll work just grand.


For further troubleshooting, here are some things to try before asking
about git-daemon again:

ping git.mycompany.com
  # should show reasonable response times

nc git.mycompany.com 9418
  # should give "connection refused", or there's a bug somewhere

ip=$(host git.mycompany.com | sed -n 's/.*has address //p'); echo $ip
  # should list the proper ip address

ssh root@git.mycompany.com "ip addr show | grep 'inet $ip'"
  # should list one ip-address

ssh root@git.mycompany.com "ps -efww | grep git-daemon"
  # should list one process

ssh root@git.mycompany.com "netstat -tpan | grep 0.0.0.0:9418"
  # should list the git-daemon

ssh root@git.mycompany.com "grep git-daemon /var/log/messages"
  # might show error messages from git-daemon

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
