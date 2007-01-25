From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: grafts+repack+prune = history at danger
Date: Thu, 25 Jan 2007 18:17:18 +0100
Organization: eudaptics software gmbh
Message-ID: <45B8E61E.C9C5E6C6@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 18:16:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA8D9-00068Y-3r
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbXAYRQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbXAYRQ1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:16:27 -0500
Received: from main.gmane.org ([80.91.229.2]:45632 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030456AbXAYRQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:16:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HA8Co-0007Af-Bh
	for git@vger.kernel.org; Thu, 25 Jan 2007 18:16:10 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 18:16:10 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 18:16:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37744>

Isn't there a major hole in the logic how repack works when grafts are
in effect?

I did this (details follow):

1. specify grafts
2. repack
3. prune
4. clone

Result: Broken history in the clone; info/grafts was not copied.
This is with git version 1.5.0.rc2.g18af.


1. I imported a cvs repository into git and "fixed" the history using
grafts. In particular:

      o--B--X   <== this commit is should be skipped
          \  \
graft =>   ---A--o

I specified in .git/info/grafts that the parent of A should be B. Of
course, commit A has still recorded X as its parent.

2. Then I repacked the repo. But this did not erase all objects:

$ git repack -a -d
$ git count-objects -v
count: 5
size: 28
in-pack: 3392
packs: 1
prune-packable: 0
garbage: 0
$ git fsck-objects
dangling commit bb828bfbd213a97817a95506bab4eeaa70538e2e

This commit bb828... is X.

3. Now git prune happily removes the 5 objects.

4. 'git clone First Second' clones the repository without problems.

But now in the clone the history is kaputt. Because commit X is not in
the cloned pack. Nor is there any info/grafts file. The original history
is still OK as long as the info/grafts file is present; but if it is
removed, the original repo is also damaged.

IMHO, this is a very serious issue. I think that repack should not walk
the grafted history. Alternatively, the info/grafts file must be copied
by the clone and respected by fsck-objects.

-- Hannes
