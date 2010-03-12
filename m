From: "Vladimir Panteleev" <vladimir@thecybershadow.net>
Subject: "git stash list" shows HEAD reflog
Date: Fri, 12 Mar 2010 16:52:45 +0200
Message-ID: <op.u9gl97fstuzx1w@cybershadow.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 15:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq6Gh-00044k-RG
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 15:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164Ab0CLOzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 09:55:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:40736 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114Ab0CLOzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 09:55:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nq6GV-0003za-T5
	for git@vger.kernel.org; Fri, 12 Mar 2010 15:55:03 +0100
Received: from 89.28.117.31 ([89.28.117.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 15:55:03 +0100
Received: from vladimir by 89.28.117.31 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 15:55:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 89.28.117.31
User-Agent: Opera Mail/10.50 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142038>

I stumbled upon a curious problem with a repository: the command "git  
stash list" displayed the HEAD reflog instead of the stash list.

The problem was caused by a very long line in ".git/logs/refs/stash". (The  
stash was based on a commit imported from Subversion, the commit message  
of which didn't follow git conventions.) The entire line was longer than  
1023 characters, which is the buffer size passed to fgets in  
for_each_recent_reflog_ent. The validation check (buf[len-1] != '\n')  
causes the line to be skipped. The fix should be simple - if the line read  
didn't fit in the buffer, add a newline anyway instead of skipping the  
line entirely.

That doesn't explain why git displayed the HEAD reflog, though. That seems  
to happen thanks to the check (revs->def && !revs->pending.nr) in  
setup_revisions ("HEAD" is the default, as specified in the caller  
cmd_log_init). It looks like (ideally) git shouldn't rely on whether  
revs->pending is empty to decide whether to use the default, but rather if  
a ref was specified by the user or not.

-- 
Best regards,
  Vladimir                            mailto:vladimir@thecybershadow.net
