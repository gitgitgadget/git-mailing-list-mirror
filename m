From: Johan Herland <johan@herland.net>
Subject: [RFC] git-clone should create packed refs
Date: Fri, 15 Feb 2008 01:33:19 +0100
Message-ID: <200802150133.19247.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 01:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPoXx-00040X-1Z
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 01:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761696AbYBOAed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763219AbYBOAeY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 19:34:24 -0500
Received: from smtp.getmail.no ([84.208.20.33]:61448 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761696AbYBOAeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 19:34:18 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JW90040D894EL00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 15 Feb 2008 01:34:16 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW900I5H87JOD10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 15 Feb 2008 01:33:19 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW9003XJ87J3OW1@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 15 Feb 2008 01:33:19 +0100 (CET)
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73933>

Hi,

I'm experimenting with converting deep (lots of history) CVS repos to Git, 
and I notice that cloning the resulting Git repos is _slow_. E.g. an 
example repo with 10000 tags and 1000 branches will take ~24 seconds to 
clone. Debugging shows that >95% of that time is spent by calling "git 
update-ref" for each of the 11000 refs. I can easily get the total runtime 
down to ~4 seconds by replacing the "git update-ref ..." with something 
like "echo $sha1 $destname >> $GIT_DIR/packed-refs". Some more 
investigation shows that what's actually taking so long is not writing all 
these 40-bytes ref files and their corresponding reflogs, but rather the 
overhead of creating the "git update-ref" process 11000 times (echo is a 
shell builtin, I presume, so doesn't have the same overhead). My conclusion 
is therefore that making "git clone" a builtin will solve my performance 
problems (since the update-ref is now a function call, rather than a 
subprocess).

Searching the list, I find that - lo and behold - someone (CCed) is actually 
already working on this. :)
(BTW, a progress report on this work would be nice...)


So the only niggle I have left, is that when git-clone is cloning repos with 
thousands of refs, it makes sense to create a packed-refs file directly in 
the clone, instead of having to run "git pack-refs" (or "git gc") 
afterwards to (re)pack the refs. This has pretty much the same reasoning as 
transferring and storing the objects in packs instead of exploding them 
into loose objects.

In my case, the upstream repo already has packed refs, so it just seems 
stupid to explode them into "loose" refs when cloning, and make me re-pack 
them afterwards.

Looking at git-clone.sh, I even find that when cloning, the refs are 
transferred in a format similar (but not identical) to the packed-refs file 
format (see CLONE_HEAD in git-clone.sh).

AFAICS, the only complication with this proposal is how to deal with the 
reflogs. Right now, for each ref created, a corresponding reflog with a 
single entry is written. Therefore - in my example repo above - the 
current "git clone" writes ~22000 files, and my proposal offers only a net 
reduction in #files written by ~50%, instead of ~100%. For reference, the 
reflog entries written by "git clone" look like this:
	"000... $sha1 A U Thor <e@mail> $timestamp  clone: from $repo"
IMHO, these entries don't carry much value:
- The $sha1 is self-evident (and if later changed, will still be mentioned
  in the next reflog entry).
- The author name and email would probably be self-evident/uninteresting in
  most cases.
- The timestamp might be marginally useful, as I can't immediately document
  another way of getting the time of cloning.
- The $repo would also be self-evident in many cases, and would in any case
  also be listed in the config file in the "origin" remote section.
I'd therefore suggest to make reflog creation in "git clone" optional, in 
order to avoid having the number of files written be proportional to the 
number of refs.

I would imagine that even though the time used on Linux for writing 
thousands of files might be negligible, this is not the case on certain 
other OSes...


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
