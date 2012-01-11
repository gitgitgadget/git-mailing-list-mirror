From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Regulator updates for 3.3
Date: Wed, 11 Jan 2012 13:40:27 -0500
Message-ID: <20120111184026.GA23952@windriver.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com>
 <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com>
 <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, <linux-kernel@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 11 19:40:46 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Rl36K-0003Sq-EO
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Jan 2012 19:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933884Ab2AKSki (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 11 Jan 2012 13:40:38 -0500
Received: from mail.windriver.com ([147.11.1.11]:47022 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111Ab2AKSkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2012 13:40:37 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q0BIeSCY018919
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 11 Jan 2012 10:40:28 -0800 (PST)
Received: from yow-pgortmak-d1 (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Wed, 11 Jan
 2012 10:40:28 -0800
Received: from paul by yow-pgortmak-d1 with local (Exim 4.74)	(envelope-from
 <paul.gortmaker@windriver.com>)	id 1Rl363-0006Fi-3I; Wed, 11 Jan 2012
 13:40:27 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188383>

[Re: Regulator updates for 3.3] On 10/01/2012 (Tue 14:54) Linus Torvalds wrote:

[...]

> So right now "git merge" (and "git pull") make it too easy to make
> those meaningless merge commits. If instead of seven pointless merges

It looks like the editor-by-default solution is a go, but there still
might be value in increasing the visibility of the pointless merges
via. the patch below.

Paul.

> you had (say) had two merges that had messages about *why* they
> weren't pointless, I'd be perfectly happy.
> 
> Addid junio and git to the cc just to bring up this issue of bad UI
> once again. I realize it could break old scripts to start up an editor
> window, but still..
> 
>                        Linus


>From 1a548fa97b78cebcded15d2b00ee3d826f731abd Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 11 Jan 2012 10:33:45 -0500
Subject: [PATCH] merge: Make merge strategy message follow the diffstat

One of the common problems I've seen with people who are
somewhat new to git is that they don't realize that a pull
is a fetch+merge.  They simply decide they want all the
latest stuff and issue a git pull without really thinking
if they are on a branch with local commits or on master,
where a fast forward can take place.

But the one line message that tells you whether you got a fast
forward or a real merge commit is usually pushed off the
screen by all the diffstat information.  So these users won't
even know that their pull has created a merge, and chances
are they will never change their workflow.

By moving the message after the diffstat, there is a better
chance that people will be aware they've done a pointless
merge commit.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/builtin/merge.c b/builtin/merge.c
index 3a45172..9471588 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -370,12 +370,12 @@ static void finish(struct commit *head_commit,
 {
 	struct strbuf reflog_message = STRBUF_INIT;
 	const unsigned char *head = head_commit->object.sha1;
+	int automsg = 0;
 
-	if (!msg)
+	if (!msg) {
+		automsg = 1;
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
-	else {
-		if (verbosity >= 0)
-			printf("%s\n", msg);
+	} else {
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
@@ -409,6 +409,9 @@ static void finish(struct commit *head_commit,
 		diff_flush(&opts);
 	}
 
+	if (!automsg && verbosity >= 0)
+		printf("%s\n", msg);
+
 	/* Run a post-merge hook */
 	run_hook(NULL, "post-merge", squash ? "1" : "0", NULL);
 
-- 
1.7.4.4
