From: Tim Smith <tzs@tzs.net>
Subject: hook to deal correctly with OS X packages?
Date: Mon, 31 May 2010 18:56:50 -0700
Message-ID: <30C845A9-5D6D-4D60-94A7-49C076F6691A@tzs.net>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 05:13:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJHvD-0004xS-HN
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab0FADNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:13:39 -0400
Received: from pass12.dizinc.com ([72.29.74.7]:45838 "EHLO pass12.dizinc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab0FADNi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 23:13:38 -0400
X-Greylist: delayed 4603 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 May 2010 23:13:38 EDT
Received: from c-24-16-250-127.hsd1.wa.comcast.net ([24.16.250.127]:61742 helo=[192.168.1.11])
	by pass12.dizinc.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <tzs@tzs.net>)
	id 1OJGir-0006wj-Ul
	for git@vger.kernel.org; Mon, 31 May 2010 21:56:54 -0400
X-Mailer: Apple Mail (2.1078)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pass12.dizinc.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tzs.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148071>


On OS X there are document files that aren't really files. They are directories with a metadata attribute that says they are logically files. For example, the popular outliner OmniOutliner stores it outlines that way. An OmniOutliner "document" consists of a directory that contains a "contents.xml" file that has the outline, plus any other files that you've attached to the outline.

This poses a bit of a problem for VCS systems, because from the user point of view, the directory is opaque. Content is added or removed by the programs that edit the document, not directly by the user, and so 

On Mercurial, which I've been evaluating for a couple of months as a replacement for Subversion at work, this can be handled easily with a pre-commit hook:

	[hooks]
	pre-commit = mdfind -0 -onlyin . "kMDItemContentTypeTree = 'com.apple.package'" | xargs -0 hg addremove
 
That mdfind command finds things marked as com.apple.package. For each, the hook adds to the commit any new files found in the package, and removes anything that's been deleted.

I'm done evaluating Mercurial and now it's Git's turn. I'm liking it so far, but am stumped as to how to do the equivalent of the above Mercurial hook.

Does this sound about right? Use a pre-commit hook that checks all the files that have been staged, and see if any of them are in a directory that is a package. If so, it needs to add any changes from those directories that are not staged, and add any untracked files from those directories.

This means that if the user makes a change to a document, and wants it to be committed, the user has to stage at least one file from the package directory. It also means that the user can't partially stage on of these documents, but I think that's an acceptable limitation.

Thanks!

-- 
--Tim Smith
