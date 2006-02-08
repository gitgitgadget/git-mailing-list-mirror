From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Handling large files with GIT
Date: Wed, 08 Feb 2006 22:20:39 +0100
Message-ID: <87slqty2c8.fsf@mid.deneb.enyo.de>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 08 22:21:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6wk0-0006t4-NM
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 22:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWBHVUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 16:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWBHVUm
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 16:20:42 -0500
Received: from mail.enyo.de ([212.9.189.167]:63617 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S964996AbWBHVUl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 16:20:41 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1F6wjw-0001Q3-Pp
	for git@vger.kernel.org; Wed, 08 Feb 2006 22:20:40 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.60)
	(envelope-from <fw@deneb.enyo.de>)
	id 1F6wjv-0006M6-Mb
	for git@vger.kernel.org; Wed, 08 Feb 2006 22:20:39 +0100
To: git@vger.kernel.org
In-Reply-To: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 8 Feb 2006 22:14:18 +1300")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15752>

* Martin Langhoff:

> SVN does reasonably well tracking his >1GB mbox file. Now, I don't
> know if I like the idea of putting my own mbox file under version
> control, but it looks like projects with large and slow-changing files
> would be in trouble with GIT.

To my surprise, it's not that bad.  The Debian testing-security team
uses a single 1.8 MB file (400 KB compressed) to keep vulnerability
data.  Most changes to that file involve just a few lines.  But even
in this extreme case, git doesn't compare too badly against Subversion
if you pack regularly (but not too often).  Disk usage is actually
*below* Subversion FSFS even with --depth=10 (the default,
unfortunately a bit hard to override).

I plan to do another experiment for GCC, which contains marvels such
as:

  35905  126056 1379093 gcc/ChangeLog-2005
  12610   61215  417584 gcc/combine.c

But the outcome will likely be quite similar to the secure-testing
case: comparable disk space usage, not a difference in the order of
one or more magnitudes.

But Subversion still has got a significant adventage: I can get a
working copy without downloading full history (several gigabytes in
GCC's case).  There's also the slight drawback that you shouldn't pack
too often, otherwise you'll reduce its effectiveness.  You can always
run "git-repack -a -d", but it's rather expensive.  This means that
you need to keep compressed fulltexts from a few dozen revisions, but
I don't think this is a huge burden.  All in all, the compressed
fulltexts/packs model is a pretty good trade-off between disk usage,
end user usability nad code complexity.

In your mbox case, you should simply try Maildir.  The tree object
(which lists all files in the Maildir folder) will still be rather
large (about 40 to 50 bytes per message stored), though.
