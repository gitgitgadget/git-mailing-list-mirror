From: Mark Levedahl <mlevedahl@gmail.com>
Subject: rename detection limit checking, cherry picking, and git am -3
Date: Sun, 16 Sep 2007 23:32:31 -0400
Message-ID: <46EDF54F.5030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 05:33:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX7MB-0003t2-RW
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 05:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbXIQDcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 23:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbXIQDcf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 23:32:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:38009 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbXIQDce (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 23:32:34 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1240050wxd
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 20:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=2Z8zlInT1rspNi5qjJ+3mnjGv42FXQpavXCHlMUdc2M=;
        b=hXVnMK1/6FgnAZxD7wgpG16QjNg9LR2yX2zF0FvUehCrTtLRVa7lxEqDyJarP97gSIVUB4HTNiEhK5D6I8wYe3WmA+pkNanIWjR3/lsA2hVkxsVk4T4auZBxLXdHA9C8wP0lhWUVrpt+YPTQlBafM59X/JJayZlzF/YKKfXFLyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=V7zHuYUUksC3+UWoxipVUC71z96toKy3vKrRqJ9n9WI1s+R1RRkhV9e04GbOvrWVqD2StYj8B/jpUTWvx3H40LlL3/m/Ag6yBGiUmpK0og/kfK9GKvdmmQcSaNRZcnfjBWh5LPVzAv6K6+pIm1ywt3FElelNw6VkQz+bLuQxJRk=
Received: by 10.90.92.10 with SMTP id p10mr2630288agb.1189999953625;
        Sun, 16 Sep 2007 20:32:33 -0700 (PDT)
Received: from ?192.168.100.117? ( [71.246.202.205])
        by mx.google.com with ESMTPS id 7sm4651460agd.2007.09.16.20.32.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Sep 2007 20:32:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58381>

Linus' recent patch to invoke limiting on rename detection broke my 
ability to use cherry-picking on one project. This project has about 
4300 files on one branch (a), 2500 on a later branch (b), 226 commits in 
total between the two branches, and a convoluted history of how branch a 
morphed into branch b. About 50 files were renamed in the transition, 
and we need to migrate patches from the still maintained branch a onto 
the new branch b.

Prior to Linus' recent patch to limit rename detection (0024a549), 
cherry picking a patch from a to b, where the patch affected just one 
file, often took about 45 seconds on a 3 GHz pentium 4 with the CPU 
pegged at 100% for the duration. The cherry picking always succeeded and 
correctly followed renames, but was very slow.

Following Linus' patch, the cherry picking fails with a merge conflict 
(almost instantly), complaining the file has been deleted on b but 
modified on a, i.e., the rename detection does not work. I tried raising 
diff.renameLimit to 100000, that seems to have no effect whatsoever on 
cherry-pick (the process aborts with a conflict almost immediately).

Curiously, using "git format-patch x..y --stdout | git am -3" succeeds 
in this case, and runs in well less than a second. This performance 
seems unchanged by the rename detection limit patch.

So, the rename limit patch "broke" git for this usage, though one could 
reasonably argue the previous code was so slow as to be broken anyway.

The curious thing to me is the vast superiority of whatever 
git-format-patch|git-am -3 does, and I wonder if that isn't a 
fundementally better design for cherry picking than git-cherry-pick 
implements (it obviously is for this case).

Mark
