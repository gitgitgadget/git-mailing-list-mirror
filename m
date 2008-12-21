From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Dynamically adjusting packed_git_window_size
Date: Sun, 21 Dec 2008 15:37:32 -0600
Message-ID: <1229895454-19498-1-git-send-email-tyler@slide.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 22:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEW0y-0004tl-Fh
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 22:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYLUVhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 16:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYLUVhk
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 16:37:40 -0500
Received: from mx0.slide.com ([208.76.68.7]:60573 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbYLUVhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 16:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=From:To:Subject:Date:Message-Id; bh=4
	r4s1fodAl9MLMKqIpyZZbbr6QmgSWoPdtiVUkoSbDA=; b=q6mhxH9ANh8TUg6Uu
	o1ycX5tUmA1jIhNebPMFj51BwzzdN9cZC3/ntkkQ5DPpaTd59IeH9lzqbZpB1ukK
	8XnR0QSFRFfzmEfCT2pr1fcI0oEiNowB8OgBsxZjzae/8fIDia/w1Q3rgelstXvl
	1XH6g7ez/x6GCVMP2c24A1fcSc=
Received: from nat3.slide.com ([208.76.69.126]:60325 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LEVzX-0001Qd-BN
	for <git@vger.kernel.org>; Sun, 21 Dec 2008 13:37:39 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 51A04A6F0003
	for <git@vger.kernel.org>; Sun, 21 Dec 2008 13:37:39 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.498
X-Spam-Level: 
X-Spam-Status: No, score=0.498 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, HELO_LH_LD=1.215, RCVD_IN_PBL=0.905,
	RCVD_IN_SORBS_DUL=0.877, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hoFJNcp3NaD for <git@vger.kernel.org>;
	Sun, 21 Dec 2008 13:37:39 -0800 (PST)
Received: from localhost.localdomain (unknown [24.240.213.76])
	by calculon.corp.slide.com (Postfix) with ESMTP id B1F1AA6F0001
	for <git@vger.kernel.org>; Sun, 21 Dec 2008 13:37:38 -0800 (PST)
X-Mailer: git-send-email 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103713>

Internally we are using a custom build of Git, and one of the patches
that I apply to newer builds of Git is one to adjust the
DEFAULT_PACKED_GIT_WINDOW_SIZE in git-compat-util.h so Git won't trample
all over our ulimit values on the 64-bit dev machines.

To do away with this, I've got these two (really one) set of patches to
adjust the packed_git_window_size when setup_git_env() is called to a
fraction of the "addressspace" limit (RLIMIT_AS). If the user's
environment defines "ulimit -v" as "unlimited", this code will not take
effect.

It's worth noting that this doesn't force Git to respect these limits,
I'm still tracking down an issue hiding in get_revision() where I'm
experiencing mmap(2) failures executing a `git log` command with
restrictive ulimit settings (Linus, since you were so "pleased" with my
last epic gdb fail, here's today's):

	(gdb)
	open_packed_git (p=0x71f2e0) at sha1_file.c:733
	733             /* We leave these file descriptors open with sliding mmap;
	(gdb)
	735              */
	(gdb)
	741                     return error("cannot set FD_CLOEXEC");
	(gdb)
	746             if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
	(gdb)

	Recursive internal problem.
	[1]    17381 abort      GIT_PAGER= gdb git
	tyler@starfruit:~/source/git/main>

Oi vei.


Cheers,
-R. Tyler Ballance
