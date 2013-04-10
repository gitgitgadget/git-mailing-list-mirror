From: Mike Galbraith <bitbucket@online.de>
Subject: regression: "96b9e0e3 config: treat user and xdg config permission
 problems as errors" busted git-daemon
Date: Wed, 10 Apr 2013 07:33:35 +0200
Message-ID: <1365572015.4658.51.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 10 07:33:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPnfE-0000pG-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 07:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760498Ab3DJFdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 01:33:39 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:62624 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757765Ab3DJFdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 01:33:39 -0400
Received: from [192.168.178.27] (p4FE1812D.dip0.t-ipconnect.de [79.225.129.45])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MC7ge-1UGxxR03ns-009Cgb; Wed, 10 Apr 2013 07:33:37 +0200
X-Mailer: Evolution 3.2.3 
X-Provags-ID: V02:K0:z4JfV88C/xbRTr3uCcUEApikiBqwEMQtcKQPE/A5rre
 XFffXaPALK1dq4ELqZYraao/NyvarKMQjU1VjIIKJ72R65iN/8
 i7vK1hUP4QXlKcnIkwZOAwy0klwHBXi48JhxfFTQx9p1MyrXy7
 RjDbLVmfv8IOf47lX3gLp0VoRF04AOLtmSoJsaE8lcFZIMDoNH
 p02Gg7SJ0vJiKriLXM5hbvIKOTyMeD2xX/jhVOqbs+iVq4steW
 fZ6n9i4gw9KzAV8AIhzJYmsZpG1kZ5pPqWizuxUTn+CFD+7/rH
 oHpljtnkE7R99AcISkrJI0K8ICMjriqwOJRPcofnISWr9uX+Gt
 qhQVZRs90++jmKPzGYJTMp0LCEvHFCIQa5RfJ2nEtrE+8Rz3Uo
 bm25gdqpmj9LQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220661>

Greetings,

I use git-daemon as the keeper of all source (love it).  git is a normal
user, running as git:daemon, with all repositories living in ~git.

git-daemon is started like so:

/usr/lib/git/git-daemon --syslog --detach --reuseaddr --user=git --group=daemon --pid-file=/var/run/git-daemon.pid --export-all --user-path --enable=receive-pack

Try to pull as root or normal user results in:

[pid 26786] access("/root/.config/git/config", R_OK) = -1 EACCES (Permission denied)
[pid 26786] write(2, "fatal: unable to access '/root/."..., 70) = 70
[pid 26785] <... read resumed> "fatal: unable to access '/root/."..., 4096) = 70
[pid 26786] exit_group(128)

Bisection fingered this commit, though it looks like it's really due to
not forgetting who it was at birth.  It's not root, so has no business
rummaging around in /root.  It used to not care, but this commit made
"go away" while looking for non-existent config file terminal.

-Mike
