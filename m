From: Dmitry Neverov <dmitry.neverov@gmail.com>
Subject: Git gc removes all packs
Date: Thu, 5 Feb 2015 16:13:03 +0100
Message-ID: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 16:13:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJO7J-0001hN-UB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 16:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757732AbbBEPNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 10:13:06 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:47181 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbbBEPNE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 10:13:04 -0500
Received: by mail-we0-f178.google.com with SMTP id k48so8207002wev.9
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=jlZuCIRZfZDz79iJ1Amy8oT0r/3qWHSobR0HaiBsd40=;
        b=eBZ1c2Q9BpffIxZEYSEzEJFH/ajM8LFyT6J1Jr8SU7sK1B9740DA84eSi3keZ7E8T6
         O8EXalFa26PfQsVMUft8hQaM2kKOEemx2AVACcFDmiH+/BuFhfJg1se/g1IbQYAeO1aC
         Jmou+zzoYcZ8he4KTrx7ZrgFzdwuQhRz5t8HwEr3/WpyAJeA88AJFngdsqMp6uEfx9x9
         /v9Ge4NZR+I7TE7cwuchaneMRQ9AO2gl2bLr2vOhJrj5XKI2yBFutpl8qKnKLOsb4TZ+
         AQEhOvUye21hKiVxDZ8ze9ZUCQ7ud5D0jlwwWGUszKbci6/YBzrrI7d0WOuLBdC9/h5l
         ZF5w==
X-Received: by 10.194.121.136 with SMTP id lk8mr8137444wjb.49.1423149183282;
 Thu, 05 Feb 2015 07:13:03 -0800 (PST)
Received: by 10.194.106.9 with HTTP; Thu, 5 Feb 2015 07:13:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263373>

Hi,

I'm experiencing a strange behavior of automatic git gc which corrupts a
local repository. Git version 2.2.2 on Mac OS X 10.10.1.

I'm using git p4 for synchronization with perforce. Sometimes after 'git
p4 rebase' git starts a garbage collection. When gc finishes a local
repository contains no pack files only loose objects, so I have to
re-import repository from perforce. It also doesn't contain a temporary
pack git gc was creating.

Command line history looks like this:

> git p4 rebase
Performing incremental import into refs/remotes/p4/master git branch
Depot paths: //XXX/YYY/
Import destination: refs/remotes/p4/master
Importing revision 352157 (100%)
Rebasing the current branch onto remotes/p4/master
First, rewinding head to replay your work on top of it...
Fast-forwarded master to remotes/p4/master.
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.

> ps aux | grep git
nd              14335  95.0  1.4  4643292 114788   ??  R     8:52PM
0:05.79 git pack-objects --keep-true-parents --honor-pack-keep
--non-empty --all --reflog --indexed-objects
--unpack-unreachable=2.weeks.ago --local --delta-base-offset
/path/to/repo/.git/objects/pack/.tmp-14333-pack
nd              14333   0.0  0.0  2452420    920   ??  S     8:52PM
0:00.00 git repack -d -l -A --unpack-unreachable=2.weeks.ago
nd              14331   0.0  0.0  2436036    744   ??  Ss    8:52PM
0:00.00 git gc --auto

After the 14331 process termination all packs are gone.

One more thing about my setup: since git p4 promotes a use of a linear
history I use a separate repository for another branch in perforce. In
order to be able to cherry-pick between repositories I added this
another repo objects dir as an alternate and also added a ref which is a
symbolic link to a branch in another repo (so I don't have to do any
fetches).

How do I troubleshoot the problem? Is there any way to enable a some
kind of logging for automatic git gc? Can use of alternates or symbolic
links in refs cause such a behavior?

--
Dmitry
