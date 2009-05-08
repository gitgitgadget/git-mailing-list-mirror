From: kanagesh radhakrishnan <rkanagesh@gmail.com>
Subject: Error cloning from Git Repository
Date: Fri, 8 May 2009 09:35:22 +0530
Message-ID: <ece1079f0905072105k748d4debl3c899aec3539a185@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 06:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2HLi-0000Oo-JU
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 06:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbZEHEFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 00:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbZEHEFY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 00:05:24 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:55907 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZEHEFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 00:05:23 -0400
Received: by gxk10 with SMTP id 10so2268155gxk.13
        for <git@vger.kernel.org>; Thu, 07 May 2009 21:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=TCiITLAq4Z1MYLy7nGlBbmueWUAvzm1394452L1+ejQ=;
        b=KkBEy4n2PDseaP+ewhmL3zWsRj7Jk9hiFk5Bvi7opfUKBSUc1xlw+yfzpaUiCnummv
         TyIO4oE6eH6XzT3rIhUc5T3oosVfzkswM62cthM6LZCl7J15Tsi5z5jHQwxjzU1rY8cG
         26aGhg2YQrYGriFcvCYTEA4Bz/WCdSEwF2a4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=bw1xM0uJccEFeVHBEHBkBol6BaxH+c3zK+lib9lcunz0uSDonrHaIEjSsbzF8kP16n
         Wbn/YdV+BgreLBhTuPakRVOkjoN9+jmQ2UekFq3gufC+zvYv5ulJWeSL0s/b9PEWwTKf
         CZwWwYaHZTmQvnBq4krNci9R07v58FEXN2Kuc=
Received: by 10.90.33.15 with SMTP id g15mr2477801agg.48.1241755523046; Thu, 
	07 May 2009 21:05:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118560>

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
