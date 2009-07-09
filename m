From: Chris Clayton <chris2553@googlemail.com>
Subject: Problem with git bisect in git-1.6.3.3
Date: Thu, 9 Jul 2009 06:42:16 +0100
Message-ID: <c6b1100b0907082242y7b348b13m8a4607c96b1d164b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 07:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOmOp-00018W-8H
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 07:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbZGIFmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 01:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbZGIFmS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 01:42:18 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59160 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbZGIFmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 01:42:17 -0400
Received: by fxm18 with SMTP id 18so6155730fxm.37
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=I/711y8BMFiKbuCO3v+3iF7D/cH0v2VWRvAMPox5MkQ=;
        b=M94z5F1RcvbkYRFvORtP4y5OsXdbR7hISx+w+ZLklsfQMmMHSWnFafQ2NcvF7/fhnK
         SeIcwu7dbeD1ErYGwDvc5Iq7QIBYVyjftRvN7TFXrNMOz1HoXSS6D6cA9RR26UPnoDKn
         W3JJj8bPbFhMYk/K6k6qbISj75DyIhyzviqKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cTupwaZLeUpdShrwEBb4+yVr5j70f12ub/udgi6h74vxfXjeVPScVOJoP5q/ZWKIxS
         Dtk0GFamBMSrfWJahRnHoUFDn0dA4lVkLNvXmXZIZj9bP5PsYVvFI4PLg0JJywC0G1gV
         wv/wRjLpulmBhWiXom+jN3miuPYc1C/EJcegE=
Received: by 10.204.116.69 with SMTP id l5mr337148bkq.102.1247118136317; Wed, 
	08 Jul 2009 22:42:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122934>

Hi,

I'm using git bisect to track down a problem in 2.6.31-rc2 that is
locking up my laptop. I get so far in the bisection process and then
end up building a kernel that seems to me to be outside the good..bad
range. First time up I thought it might be a case of PBKAC, but I've
run the process again (very carefully) and got to the same place.

The bisect log so far:

[chris:~/kernel/linux-2.6]$ git bisect log
git bisect start
# good: [07a2039b8eb0af4ff464efd3dfd95de5c02648c6] Linux 2.6.30
git bisect good 07a2039b8eb0af4ff464efd3dfd95de5c02648c6
# bad: [8e4a718ff38d8539938ec3421935904c27e00c39] Linux 2.6.31-rc2
git bisect bad 8e4a718ff38d8539938ec3421935904c27e00c39
# good: [e7c5a4f292e0d1f4ba9a3a94b2c8e8b71e35b25a] powerpc/5121: make
clock debug output more readable
git bisect good e7c5a4f292e0d1f4ba9a3a94b2c8e8b71e35b25a
# bad: [d23c45fd84f79a3b84899dac053dcafe9d43ebc9] NFS: Invalid mount
option values should always fail, even with "sloppy"
git bisect bad d23c45fd84f79a3b84899dac053dcafe9d43ebc9
# bad: [2ed0e21b30b53d3a94e204196e523e6c8f732b56] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6
git bisect bad 2ed0e21b30b53d3a94e204196e523e6c8f732b56

but, from Makefile, it appears the last "bad" has placed me at a
change earlier than 2.6.30:

[chris:~/kernel/linux-2.6]$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 30
EXTRAVERSION = -rc6
NAME = Vindictive Armadillo

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not

I'm not an experienced git user, so it may be that I have made an
error or false assumption. I guess it's also possible that I've
screwed my repository, although basically I only use two types of
command - pull a few times a week and the bisect family when I'm
trying to track down a problem.

Come to think of it, I did archive the repository (with tar | bzip2)
about a week ago whilst I changed the hard drive in my laptop. Once
the new drive was installed, I restored the repository and freshened
it up with a git pull. Could this be the root of my problem, please?

Happy to provide more information if needed. Please cc me to any reply
- I'm not subscribed.

Thanks

Chris

-- 
No, Sir; there is nothing which has yet been contrived by man, by
which so much happiness is produced as by a good tavern or inn -
Doctor Samuel Johnson
