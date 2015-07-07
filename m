From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 22/23] worktree: add: auto-vivify new branch when
 <branch> is omitted
Date: Mon, 6 Jul 2015 21:33:01 -0400
Message-ID: <20150707013301.GA26523@flurp.local>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
 <1436203860-846-23-git-send-email-sunshine@sunshineco.com>
 <xmqqpp45ytzh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 03:33:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCHlA-00018k-CV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 03:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbbGGBdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 21:33:11 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33396 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbbGGBdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 21:33:08 -0400
Received: by ieqy10 with SMTP id y10so125405896ieq.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 18:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cLaNirEE+68UQvVRL+BrwI6ldbIHJbk5qAXr/1hadMU=;
        b=hP3V+q0woKO9W7JbpPkCZjai51ya8w3UdaQ2671qlE6q+mPGluBP+4/rlQ9FipZr04
         MriCWcm7WmiErPxHv9ARxbf9VrnRJQ0MkkQrNl4vXHCod6GwHZ/5k0smYgPcZALQDWF1
         YGe777fE8PGugoq+pTkhVw9WaeE/751lbNErCEY0gyQssL/Gz+eQdbA4PpWKFbPHLcj4
         ThAOynM3VZr24hOeDoi0bF6SHqawiilctmL4fElTrMSq0rtwAdoHcf8+w82BLKo7DX0j
         uhoiP1T2hJApTbbPMTKN02QcPm0PVOpgX+WAvzQM1/pRm3rdfzgbnO0w/VMbU1CuQxJk
         j01w==
X-Received: by 10.50.114.40 with SMTP id jd8mr48298057igb.47.1436232788201;
        Mon, 06 Jul 2015 18:33:08 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id n30sm13633142ioi.38.2015.07.06.18.33.07
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 18:33:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqpp45ytzh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273472>

On Mon, Jul 06, 2015 at 12:19:14PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> > index 377ae0f..da71f50 100644
> > --- a/Documentation/git-worktree.txt
> > +++ b/Documentation/git-worktree.txt
> > @@ -9,7 +9,7 @@ git-worktree - Manage multiple worktrees
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git worktree add' [-f] [--detach] [-b <new-branch>] <path> <branch>
> > +'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
> 
> Ahh, OK, this answers my previous question.

Right. I considered squashing this patch with the previous one, in
which case the synopsis question wouldn't have come up, but kept them
separate since they are (or can be) conceptually distinct, and the one
patch builds upon the other (and keeping them separate makes them a
bit easier to review).

> > +	if (ac < 2 && !new_branch && !new_branch_force) {
> > +		int n;
> > +		const char *s = worktree_basename(path, &n);
> > +		new_branch = xstrndup(s, n);
> > +	}
> > +
> 
> and because this is new_branch, not new_branch_force, we will not
> accidentally clobber an existing branch.  The "hotfix" time is when
> the end-user tends to be less careful, and it is a good thing to
> make sure "git worktree add ../hotfix" will not clobber an unrelated
> "hotfix" branch.
> 
> Good.
> 
> Which may be something we would want to have a test for, though.

Good idea. How about the following as a squash-in?

--- 8< ---
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] fixup! worktree: add: auto-vivify new branch when <branch> is omitted

---
 t/t2025-worktree-add.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 8fe242f..ead8aa2 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -150,4 +150,13 @@ test_expect_success '"add" with <branch> omitted' '
 	test_cmp_rev HEAD bat
 '
 
+test_expect_success '"add" auto-vivify does not clobber existing branch' '
+	test_commit c1 &&
+	test_commit c2 &&
+	git branch precious HEAD~1 &&
+	test_must_fail git worktree add precious &&
+	test_cmp_rev HEAD~1 precious &&
+	test_path_is_missing precious
+'
+
 test_done
-- 
2.5.0.rc1.201.ga12d9f8
