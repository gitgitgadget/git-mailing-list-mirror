From: kanagesh radhakrishnan <rkanagesh@gmail.com>
Subject: Error cloning from Git Repository
Date: Thu, 7 May 2009 17:55:41 +0530
Message-ID: <ece1079f0905070525r636bf145tc9741de0ad90988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 14:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22fg-0000Bq-Ut
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbZEGMZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756682AbZEGMZn
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:25:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:65491 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762197AbZEGMZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 08:25:41 -0400
Received: by yx-out-2324.google.com with SMTP id 3so430998yxj.1
        for <git@vger.kernel.org>; Thu, 07 May 2009 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=TCiITLAq4Z1MYLy7nGlBbmueWUAvzm1394452L1+ejQ=;
        b=i5hGf1s3d5C//79sMyZL04OsxzIyKJn09tZzrByzUutZMAdEmdCHSyiOBCVAqb7S1E
         KP5JlnbrjLdOzTsxKSfVJzK+oBX/Ha2+7NhrjSfz41TDjvY9YfwGKpoCvMm7gRjaTgY8
         OR+AejT4c3hV4/Ea8fIVq4HtYERYfdMGMgpUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=MQ4ktHOsl6AuMayHaaS4Qm3aRHCga/BtsbXays/Cr3Dm+VG6yUtig9JZbgR5IbJMVr
         tkCHD+OctiB5JnC3BqwZlfO7rpMxP5lUshh6tlZAhoti6rmlqrm1U1buQTvunuo5CBDq
         NKBE/t1Z6BUHo3CLpWVTnwaxNmGu8Zl4u23yg=
Received: by 10.90.115.17 with SMTP id n17mr2030521agc.104.1241699141970; Thu, 
	07 May 2009 05:25:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118470>

Hello All,

I am trying to setup a git repository and then publish it using
git-daemon and inetd for other developers in the network to access the
sources.

Server Setup
-------------------
Host system running on Fedora Core 8
Git version 1.5.4.3

A summary of what I have done to setup the Git server is as follows:
$ mkdir /home/kanagesh/test-repo
$ cd test-repo
$ vi test.c <insert text, save, quit>
$ git-init-db
$ git-config user.name kanagesh
$ git-config user.email rkanagesh@gmail.com
$ git-add test.c
$ git-commit -a -m"Initial Commit"

# mkdir -p /var/cache/git
# ln -s /home/kanagesh/test-repo/.git test-repo
# ls -l
    test-repo -> /home/kanagesh/test-repo/.git

xinetd has been setup to listen for git requests on port 9418 and
spawn git-daemon.  This has been done by placing a config file named
'git' under /etc/xinetd.d.  The contents of the config file is as
follows:

service git
{
        disable        = no
        type            = UNLISTED
        port             = 9418
        socket_type = stream
        wait             = no
        user            = nobody
        server          = /usr/local/bin/git-daemon
        server_args     = --inetd --export-all
--base-path=/var/cache/git --syslog --verbose
        log_on_failure  += USERID
}


Clone from the Server
-------------------------------
When I attempt to clone the source from the Git server, I end up with
the following error:

[kanagesh@localhost test]$ git-clone git://192.168.13.171/test-repo
Initialized empty Git repository in /home/kanagesh/work/test/test-repo/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from 'git://192.168.13.171/test-repo' failed.

On checking the log messages in /var/log/messages, I see the following:

May  7 17:29:19 localhost xinetd[17108]: START: git pid=17128
from=::ffff:192.168.13.171
May  7 17:29:19 localhost git-daemon: [17128] Connection from
192.168.13.171:42360
May  7 17:29:19 localhost git-daemon: [17128] Extended attributes (21
bytes) exist <host=192.168.13.171>
May  7 17:29:19 localhost git-daemon: [17128] Request upload-pack for
'/test-repo'
May  7 17:29:19 localhost xinetd[17108]: EXIT: git status=255
pid=17128 duration=0(sec)

Can anyone tell me what I am doing incorrectly?  Any pointers on how
to get a more verbose log from git-daemon would also be very helpful.

Thanks in advance.

Regards,
Kanagesh
