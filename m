From: Kai Lanz <lanz@stanford.edu>
Subject: Git open calls fail on NFS-mounted NTFS volume
Date: Mon, 30 Nov 2009 15:09:28 -0800
Message-ID: <F7CE7D3D-9237-494C-B6C8-6B6D7AB7CE45@stanford.edu>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 00:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFFVI-0006t6-K5
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 00:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbZK3XRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 18:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbZK3XRt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 18:17:49 -0500
Received: from smtp2.Stanford.EDU ([171.67.219.82]:41928 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbZK3XRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 18:17:48 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2009 18:17:48 EST
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id B23A51707B5
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 15:09:31 -0800 (PST)
Received: from [171.64.171.122] (redips.Stanford.EDU [171.64.171.122])
	by smtp.stanford.edu (Postfix) with ESMTP id 8C71B170762
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 15:09:29 -0800 (PST)
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134147>


There are several places in the code where git calls open() with the  
flag
O_EXCL. This causes a problem for us when the current directory is on an
NFS-mounted NTFS volume shared by an NAS fileserver. The open fails with
"EACCES: Permission denied", even though the user has full read/write
permissions on the target directory.

I used a tiny C program to confirm that the O_EXCL flag is the culprit;
removing that flag from the open() call allows the open to succeed. Of
course, the call also succeeds, with the O_EXCL flag in place, if the
current directory is on an NFS-mounted UNIX filesystem.

We're looking into ways to work around this; one way would be to hack  
the git
source and remove all the O_EXCL flags (are they really needed?), but  
I'm
afraid that might break git in horrible ways. Another way might be to  
mount
the NTFS volume via CIFS instead of NFS. But first I wanted to ask if  
anyone
here can offer a solution based on changing our git configuration or  
our NFS
mount options or the NTFS volume settings. (At present we have no  
gitconfig
file, so all settings are default).

Git version is 1.6.5.3, running on x86_64 RHEL-4, kernel 2.6.9-89.  
The error
the user sees is:

 > cd /WWW
 > git init
fatal: cannot copy '/usr/local/share/git-core/templates/info/exclude' to
'/WWW/.git/info/exclude': Permission denied

Using strace, we can see the offending call:

open("/WWW/.git/info/exclude", O_WRONLY|O_CREAT|O_EXCL, 0666) = -1  
EACCES
(Permission denied)

We know the user has permission to create this file because he can cd  
into
/WWW/.git/info and copy exclude there from the templates directory by  
hand.

-- 
Kai Lanz            Stanford University School of Earth Sciences
