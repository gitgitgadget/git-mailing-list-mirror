From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [RFC] make --set-upstream work for local branches not in refs/heads
Date: Tue,  4 Mar 2014 15:07:25 +0100
Message-ID: <1393942046-11488-1-git-send-email-krzesimir@endocode.com>
Cc: Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 15:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKq0o-0002yN-9V
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 15:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250AbaCDOH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 09:07:58 -0500
Received: from mail-bk0-f42.google.com ([209.85.214.42]:55681 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaCDOH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 09:07:57 -0500
Received: by mail-bk0-f42.google.com with SMTP id mx12so225325bkb.29
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 06:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tS3IjssVBpLaLwIO3lb2NczOU6aUjDZoCL0KxzgdhVA=;
        b=LdWro4sf7wPJiFs4zvfWccFI2G76cI8CipDy5/6PDuGdN3y/RNjV2fJRuWQ5ZCPIHA
         GDQ5RXhIomwUu0S05tg2zYHnZ7+BUfSz5rj0G7SOShTPnmyHg1wAYtwzvY05zTYqpag/
         xIrHfgKiuouT5BI0cWHNa4HObm4+w1g4MjJGwNoA/rbWc0d49a4cNNr1XBs7yVMsy+Th
         7xnzILKDJ3s47s4B3n51ZnOgSB79NgX2xvo1/uUx/j/ktemNkEBX9+bYHiBd1bD3sEGI
         S6N26dKIci4KFXrbrE7fRWcX2MNTLTHKVxAU46betY3OjSIYxtPoG+VtOgnLlE2BBM5x
         O2fQ==
X-Gm-Message-State: ALoCoQnSVJtkVILfx+7ef6YftwZp0YtUEAyI7iq1g414/88Ok/e4ctusTrLwYhVnUXWu/wOhW5qJ
X-Received: by 10.205.41.202 with SMTP id tv10mr1088029bkb.41.1393942075754;
        Tue, 04 Mar 2014 06:07:55 -0800 (PST)
Received: from localhost.localdomain (p57923D4E.dip0.t-ipconnect.de. [87.146.61.78])
        by mx.google.com with ESMTPSA id r1sm1342213bkk.2.2014.03.04.06.07.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Mar 2014 06:07:54 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243343>

It might be possible (in "Gerrited" setups) to have local branches
outside refs/heads/, like for example in following fetch config:

[remote "origin"]
	url = ssh://user@example.com/my-project
	fetch = +refs/heads/*:refs/remotes/origin/*
	fetch = +refs/wip/*:refs/remotes/origin-wip/*

Let's say that 'test' branch already exist in origin/refs/wip/. If I
call:

git checkout test

then it will create a new branch and add an entry to .git/config:

[branch "test"]
	remote = origin
	merge = refs/wip/test

But if I create a branch 'test2' and call:

git push --set-upstream origin test2:refs/wip/test2

then branch is pushed, but no entry in .git config is created. I have
to do it manually. I attached a hack-patch to have it working just to
check with you if anything like that would be accepted. Obviously the
get_local_refs() would need to compute the actual list of local
hierarchies (if it is possible at all). And it probably should get a
better name. And probably something else.

What do you think?

Krzesimir Nowak (1):
  RFC: make --set-upstream work for branches not in refs/heads/

 transport.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

-- 
1.8.3.1
