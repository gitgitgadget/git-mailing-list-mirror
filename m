From: Alexander Klink <ak-git@cynops.de>
Subject: Re: git-svn failure when symlink added in svn
Date: Thu, 26 Apr 2007 23:07:09 +0000 (UTC)
Message-ID: <loom.20070427T005115-751@post.gmane.org>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle> <m2slb1c8ps.fsf@fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 10:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhLm2-0003eQ-1B
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 10:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbXD0IZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 04:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbXD0IZo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 04:25:44 -0400
Received: from main.gmane.org ([80.91.229.2]:36112 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbXD0IZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 04:25:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HhLlG-0007eC-Nj
	for git@vger.kernel.org; Fri, 27 Apr 2007 10:25:02 +0200
Received: from IP-213188106106.dialin.heagmedianet.de ([213.188.106.106])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 10:25:02 +0200
Received: from ak-git by IP-213188106106.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 10:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.188.106.106 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.0.11) Gecko/20070312 Firefox/1.5.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45700>

Hi,

Seth Falcon <sethfalcon <at> gmail.com> writes:
> Eric Wong <normalperson <at> yhbt.net> writes:
> > I can't reproduce it on Linux with ext3.  I translated your recipe into
> > a test script in the patch below.  Anybody familiar with OSX and/or HFS
> > know if there's a workaround or fix for this?

I've been investigating this problem too, as it keeps biting me when importing
our (OpenXPKIs) subversion tree using git-svn. I'd love to work with git and
am happy to help with debugging this further. Still, I am a pretty puzzled on why
this happens ...

> And so then on Linux with -v I get (after snipping most of the
> output):
>    First, rewinding head to replay your work on top of it...
>    symlink: 'foo.txt' => 'bar.txt'

> On my OSX laptop I get:
>    First, rewinding head to replay your work on top of it...
>    symlink: 'foo.txt' => ''

Same here (this is a MacBook Pro, for what it's worth, BTW). As said, I've
investigated this a bit further. The empty filename in new seems to come from
trying to read the wrong SHA1 file. If one outputs ce->sha1 before
        void *new = read_sha1_file(ce->sha1, &type, size);
is called, one gets different output on Linux and Mac OS X.
For Seth's example, I get 5f34b0af07646aa529b5b005cde3a9559e606210 on Linux
and e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 on Mac OS X ...

I've tried tracking down where this comes from. Here is what I've learned:
- read_blob_entry() is called from write_entry().
  SHA1 is already incorrect at that point in time.
- write_entry() is called from checkout_entry().
  SHA1 is already incorrect at that point in time.
- checkout_entry() is called from check_updates().
  SHA1 is already incorrect at that point in time.

Unluckily I could not figure out, where it is computed in the first place.
One idea was that maybe it was cached from the old file in the Mac OS X case
and recomputed on Linux or so? Or maybe it's not git's fault but git-svn
messes up (although I doubt it)?

I'll happy try out anything that has a slight chance of solving this issue
(workarounds greatly appreciated, too).

Best regards,
  Alex
