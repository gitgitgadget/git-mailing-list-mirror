From: Matthew Walster <matthew@walster.org>
Subject: inexact rename detection warning on "git log -p"
Date: Mon, 13 Apr 2015 10:47:15 +0000 (UTC)
Message-ID: <loom.20150413T121644-743@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 12:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhbwV-00031q-48
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 12:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbbDMKuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 06:50:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:33186 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbbDMKuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 06:50:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YhbwK-0002sT-AK
	for git@vger.kernel.org; Mon, 13 Apr 2015 12:50:04 +0200
Received: from 91-215-166-4.net.lmax.com ([91-215-166-4.net.lmax.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 12:50:04 +0200
Received: from matthew by 91-215-166-4.net.lmax.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 12:50:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.215.166.4 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267075>

Out of idle curiosity, I cloned 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and chose 
to generate some statistics:

$ find -not -iname '.git' | wc
  52154   52154 1820305

That's a few files...

$ git log | wc
8359290 37279781 334525133

Hmmm, well that's not too useful, let's see how many commits there are:

$ git log | grep ^commit | wc
 507296 1014592 24350208

and merges:

$ git log | grep ^Merge: | wc
  36019  111146  854397

I wonder what the total size of all changes are:

$ git log --patch | wc
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your diff.renameLimit variable to at least 779 
and retry the command.
93295818 366207219 3072072294

My bug report is in reference to the warning: It's not clear whether this 
warning just "warns" the user (hence the warning rather than an error) or 
whether it actually had an fault and didn't complete the operation 
successfully. It's also not clear whether the detection was aborted halfway 
through, or whether the work it has so far done has been discarded and is 
therefore idempotent if I *lowered* the renameLimit value (as opposed to 
raising it to fix the warning).

Could the wording be changed to indicate that the operation continued 
without the rename detection? My preferred wording would be:

warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your diff.renameLimit variable to at least 779 
and retry the command.
warning: continuing processing without inexact rename detection

I'm a native English speaker and even I found the wording a little confusing 
-- although people used to gcc will know warning is informational and error 
is abortive, not all git users are aware of the distinction.

Additionally, is the renameLimit something that could potentially be 
something dynamic (i.e. it inspects how much free RAM is available and 
increases the buffer if appropriate) or is that a conscious decision not to 
give the process "free reign"?

Cheers,


Matthew Walster
