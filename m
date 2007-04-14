From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: GIT and the current -stable
Date: Sat, 14 Apr 2007 13:56:00 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070414115600.GA10995@informatik.uni-freiburg.de>
References: <46206842.80203@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Transfer-Encoding: 8bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 13:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcgrc-0001xp-PK
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 13:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbXDNL4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 07:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965522AbXDNL4G
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 07:56:06 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48315 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964792AbXDNL4F (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2007 07:56:05 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HcgrL-0003Ot-PX; Sat, 14 Apr 2007 13:56:03 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l3EBu1rZ011650;
	Sat, 14 Apr 2007 13:56:01 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l3EBu08d011649;
	Sat, 14 Apr 2007 13:56:00 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Rene Herman <rene.herman@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46206842.80203@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44458>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Rene,

Rene Herman wrote:
> each time that a new -stable is released. Rather though, I'd like a simple 
> "git pull" to do this while on this branch while a "git pull" while back on 
> the master branch pulls from the originally cloned Linus repo again.
> 
> Is this possible? Do I want it to be? Comments like "work like this 
> instead" welcome as well; figuring out what the heck it is that I want from 
> git seems to be one of the most difficult questions to answer...
Chris' mail made that somehow superfluous but anyhow.  I have a Python
script to update my Linux tree.  It's attached.

It automatically adds
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.x.y as a
remote as soon as v2.6.x is seen in Linus' repo and then fetches 2.6.16,
2.6.(last - 1) and 2.6.last.  If you want to fetch all, change 

	for stable in (16, last_stable - 1, last_stable):

in

	for stable in xrange(16, last_stable + 1):

The location of the repo is hardcoded to $HOME/gsrc/linux-2.6, but I
think everyone with a bit of intuition should be able to change that ...

So it's not a "git pull" for me, but "update-linux".

Best regards
Uwe

-- 
Uwe Kleine-König

main(){char*a="main(){char*a=%c%s%c;printf(a,34,a,34%c";printf(a,34,a,34
,10);a=",10);a=%c%s%c;printf(a,34,a,34,10);}%c";printf(a,34,a,34,10);}

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=update-linux

#! /usr/bin/env python

import os, re, subprocess, sys

silent = False

git_dir = os.path.join(os.getenv('HOME'), 'gsrc', 'linux-2.6', '.git')
os.putenv('GIT_DIR', git_dir)

devnull = open('/dev/null', 'w', 0)
if silent:
  subprocess_stdout = devnull
else:
  subprocess_stdout = None

if not silent:
  print 'fetch origin'
subprocess.call(['git-fetch', 'origin'], stdout=subprocess_stdout)

sp_describe = subprocess.Popen(['git-describe', 'origin'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
sp_describe_stdin, sp_describe_stderr = sp_describe.communicate()

re_linuxver = re.compile('v2\.6\.(?P<minor>\d+)(?P<stable>\.\d+)?(?P<rc>-rc\d+)?(?P<git>-g[0-9a-fA-F]+)?')
mo = re_linuxver.match(sp_describe_stdin)

if not mo:
  print 'cannot parse version of origin\'s HEAD'
  sys.exit(1)

modict = mo.groupdict()

if modict['rc'] and not modict['stable']:
  last_stable = int(modict['minor']) - 1
else:
  last_stable = int(modict['minor'])

for stable in (16, last_stable - 1, last_stable):
  if subprocess.call(['git', 'repo-config', 'remote.v2.6.%d.y.url' % stable], stdout=devnull) != 0:
    subprocess.call(['git', 'repo-config', 'remote.v2.6.%d.y.url' % stable, 'git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.%d.y.git' % stable])
    subprocess.call(['git', 'repo-config', 'remote.v2.6.%d.y.fetch' % stable, 'refs/heads/master:refs/remotes/stable/v2.6.%d.y' % stable])
    subprocess.call(['git', 'repo-config', 'branch.v2.6.%d.y.remote' % stable, 'v2.6.%d.y' % stable])
    subprocess.call(['git', 'repo-config', 'branch.v2.6.%d.y.remote' % stable, 'v2.6.%d.y' % stable])
    subprocess.call(['git', 'repo-config', 'branch.v2.6.%d.y.merge' % stable, 'refs/heads/master'])

  if not silent:
    print 'fetch v2.6.%d.y' % stable
  subprocess.call(['git-fetch', 'v2.6.%d.y' % stable], stdout=subprocess_stdout)

--UugvWAfsgieZRqgk--
