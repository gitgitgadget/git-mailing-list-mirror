From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/9] commit: more focused advice in the
 no-changes-staged case
Date: Sat, 24 Jul 2010 19:54:43 -0500
Message-ID: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 02:56:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcpVb-0006ws-Ga
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 02:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab0GYAzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 20:55:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64855 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab0GYAzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 20:55:47 -0400
Received: by iwn7 with SMTP id 7so1570959iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 17:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=IVPzwifIQR/FUNGTmxsGCD1utX7EYmPCdvLBOxjfGgY=;
        b=ndhwoF8YMYUzjG+V1Th420oSPDISfwb6iXoSUNJNvRNnwLu0/7Mp23n3AwcY8hcBZO
         NPtT8I1fxj1v+AhcMt6xzqaW7QNpOxnWBxLaeITZYOKcspAeHuUduhYjaeq89dDFVt/n
         0dPeUfFlS9sC6MzYxh2QWcoQOvOm1Xm4bhPko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=u945cDknHT8ikMo+djM41bkv7OIp7rxmJQecodjOXKijaM55CR5vo/BJOJwsAvn9HF
         0eUMcp0m5XBoyOaPXp3LPmSowYtrCnizrvVfqfEKyMgI0Ty/JR0lr9qZ85p/djVW0I6P
         YGa78kz0P1STPVDW3eRXdAbqFlDBt95PWvBeY=
Received: by 10.231.167.67 with SMTP id p3mr6232436iby.20.1280019347127;
        Sat, 24 Jul 2010 17:55:47 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm1913284ibk.9.2010.07.24.17.55.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 17:55:46 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151692>

Hi,

When last seen[1], this series was a single patch in very rough form,
but there have been almost no functional changes since then.

The patches suppress most output when =E2=80=9Cgit commit=E2=80=9D is r=
un without
stages changed.  So instead of

	$ git commit
	# On branch master
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working dir=
ectory)
	#
	#	modified:   dir1/modified
	#
	# Untracked files:
	#   (use "git add <file>..." to include in what will be committed)
	#
	#	actual
	#	dir1/untracked
	#	dir2/modified
	#	dir2/untracked
	#	expect
	#	output
	#	untracked
	no changes added to commit (use "git add" and/or "git commit -a")

which may cause a newcomer to panic, you get

	$ git commit
	no changes added to commit (use "git add" and/or "git commit -a")

which would just cause her to scratch her head or say =E2=80=9Coh, righ=
t!=E2=80=9D
instead.  Hopefully these patches will at least provide a reminder to
improve the various "no changes" advice messages.

Ideas for future work:

 - add some tests
 - give the full traditional output if -a or any paths were passed on
   the command line.

Most of the patches are code clarity improvements which is not
strictly related to this topic.

Patch 6 cleans up the most obvious script to add tests for this in,
though I have not added any tests to it.

Patch 8 changes commit --dry-run output in a more modest way, to
print the same advice Jeff added to commit proper last month.  I
suspect this is a good change, but input from people who script
around commit --dry-run would be welcome.

Patch 9 is the advertised patch.  It should be self-explanatory.

Thoughts?

Jonathan Nieder (9):
  wt-status: split wt_status_print into digestible pieces
  wt-status: give submodule summary printing its own function
  commit: split off a function to fetch the default log message
  commit: encapsulate commit -s handling in its own function
  commit: split off the piece that writes status
  t7508 (status): modernize style
  commit: give empty-commit avoidance code its own function
  commit --dry-run: give advice on empty amend
  commit: suppress status summary when no changes staged

 builtin/commit.c  |  328 ++++++++------
 t/t7508-status.sh | 1380 ++++++++++++++++++++++++++++-----------------=
--------
 wt-status.c       |  103 +++--
 wt-status.h       |    1 +
 4 files changed, 989 insertions(+), 823 deletions(-)

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/69800=
1/focus=3D145541
