From: Johan Herland <johan@herland.net>
Subject: RFD: Handling case-colliding filenames on case-insensitive filesystems
Date: Wed, 23 Feb 2011 18:11:45 +0100
Message-ID: <201102231811.45948.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 18:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsIFm-0000Og-N6
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 18:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab1BWRLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 12:11:49 -0500
Received: from smtp.opera.com ([213.236.208.81]:37309 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264Ab1BWRLs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 12:11:48 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p1NHBk0f031131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 23 Feb 2011 17:11:46 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167704>

Hi,

At $dayjob we recently had a problem where a developer pushed a commit 
that added new files, two of which were named "foobar.TXT" 
and "FOOBAR.txt". When this commit (or anything based on it) is checked 
out by one of our Windows developers, Git maps two files in its index 
to a single file on the filesystem, and ends up reporting a diff on one 
of those files. The diff won't go away unless one (or both) of the 
case-colliding files is removed from the repo. Obivously, the 
persisting diff prevents the developer from easily rebasing, switching 
branches, merging, bisecting and a number of other useful tasks.

The root of the problem is that the case-colliding files were added in 
the first place, and this should obviously be prevented in projects 
that aim to be compatible with case-insensitive filesystems. To that 
end, I'm currently writing an update hook which will prevent 
case-colliding files from being pushed to our central repo.

However, given that this has already happened, how can we design Git to 
handle this situation more gracefully. In other words, how can we 
better handle checking out filenames that collide on case-insensitive 
filesystems?

My first idea was to simply refuse checking out trees with 
case-colliding filenames. I.e. when core.ignoreCase is enabled, we 
check whether any of the files we're about to checkout map to the same 
filesystem representation, and if they do, we abort the checkout and 
complain loudly to the user. However, that doesn't really help the user 
at all. Failure to checkout would only make it much harder to fix the 
issue.

A colleague suggested instead that Git should notice that the collision 
will occur, and work around the failure to represent the repository 
objects in the file system with a one-to-one match. Either by checking 
out only _one_ of the colliding files, or by using a non-colliding name 
for the second file. After all, Git already has functionality for 
manipulating the file contents on checkout (CRLF conversion). Doesn't 
it make sense to add functionality for manipulating the _directory_ 
contents on checkout as well? Even if that makes sense, I'm not sure 
that implementing it will be straightforward.

Are there better suggestions on how to deal with this?


Thanks,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
