From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Counter-intuitive results for git show and git checkout during rebase 
	with conflict.
Date: Mon, 23 Feb 2009 12:04:53 +0800
Message-ID: <544dda350902222004v742a7175od19ac417f75ddd1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 05:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbS5H-0007R6-JV
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 05:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbZBWEEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 23:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbZBWEEz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 23:04:55 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:28405 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbZBWEEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 23:04:54 -0500
Received: by wf-out-1314.google.com with SMTP id 28so2288889wfa.4
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 20:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=FoN6iiRUFgIW29ma4TNLz79aiKkHOvdNW9CJb7lUPso=;
        b=BWvXXXESDEa7ed0excPCGh0o5Wwp2a5cAQ3lTk6FFqlVBiP8Hleo/kQ7241sXafHUb
         VkRw+l8rXJnD8FcYDNEyCXDCJ5SfVHauhyHRygBSOv7CP+pEMCYApngXsffT3+86q7BG
         iqjQQADvkzsiMnvyP1VAsNt1Q4ujA88h4ANPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Mx/txWBnHa6cxYLGF7TQ88F1LddF2y3XS2sxewekxej/gNwW+ZtDdpALhyNDd2jBVW
         ZzxZGQtLG5ix6F8WffGSHyReBnVBwUwl7maJAZuGEz8XKa8L5sk512UaG5eM2d1MuPwS
         ikCY3dLChFA2UG7SuVb5HjssFliDyq04cBo2I=
Received: by 10.142.214.5 with SMTP id m5mr1770752wfg.110.1235361893547; Sun, 
	22 Feb 2009 20:04:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111076>

The scenario: We have two branches, local and master, we are now on
branch local, and we would like to rebase local wrt master:

	% git rebase master
	conflictedfile: needs merge
	cannot rebase: you have unstaged changes

Obviously we have a conflict, here's the problem: these commands have
counter-intuitive effect (as oppose to during a git merge with
conflict):

  git show :2:conflictedfile  # shows content from master version
  git show :3:conflictedfile  # shows content from local version

  git checkout --ours conflictedfile   # gets content from master version
  git checkout --theirs conflictedfile # gets content from local version

I know why they are counter-intuitive - :2:, :3:, --ours and --theirs
are relative to the current <commit>, and during a conflict due to a
rebase, the current <commit> is some commit that leads to master,
which is not anywhere in the path that leads to local.

So in summary:

Fact 1:
  During a conflict due to a rebase, HEAD is a commit that leads to
  the other branch.

Fact 2:
  During a conflict due to a merge, HEAD is a commit that leads to the
  current branch.

(Please correct me if the two facts above are not true)

Technically there's nothing wrong with the behavior of the commands,
but wouldn't it be better if the arguments :2:conflictedfile and
:3:conflictedfile to git show and the options --ours and --theirs to
git checkout be made aware of the two facts above and do a more
intuitive action?

Or should this be left to a higher level tools to automatically detect
the reason of the conflict and adjust the arguments appropriately so
that the end results are intuitive for the user?

nazri.
