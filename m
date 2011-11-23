From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix revert --abort on Windows
Date: Wed, 23 Nov 2011 04:04:52 -0600
Message-ID: <20111123100452.GA30629@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 11:05:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT9hX-0006Nd-SO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 11:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab1KWKFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 05:05:04 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37235 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab1KWKFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 05:05:01 -0500
Received: by yenq3 with SMTP id q3so1205735yen.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WGIgOgHN7tRy7iyjEssZmmc59jQ0y0R4jvquvOXneI8=;
        b=E8SxwnbjhDIgBDiOw5lwa5w1naSsp+W/2A0Ubk30ej5F6pv/XyzdZk86SfAj9i2a8h
         YEf9hywgZ4CA2pMYyJ07BkhnFEbwat9Xvgt2hFKrHcdNiSybbKxf2ZdXyR0LVrefql0K
         T6IxXCix6TuApI00LHsyRScYd0GUwE6TMwZvk=
Received: by 10.50.169.97 with SMTP id ad1mr27049873igc.35.1322042700999;
        Wed, 23 Nov 2011 02:05:00 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dm1sm31234303igb.6.2011.11.23.02.04.59
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 02:05:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4ECCB3A2.5030102@viscovery.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185834>

Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
>
> On Windows, it is not possible to rename or remove a directory that has
> open files. 'revert --abort' renamed .git/sequencer when it still had
> .git/sequencer/head open. Close the file as early as possible to allow
> the rename operation on Windows.

Nice catch.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Speaking of which, it doesn't make a lot of sense for "git revert
--abort" to be leaving a .git/sequencer-old directory around.  How
about this on top?

-- >8 --
Subject: revert --abort: do not leave behind useless sequencer-old directory

The "git cherry-pick --abort" command currently renames the
.git/sequencer directory to .git/sequencer-old instead of removing it
on success due to an accident.  cherry-pick --abort is designed to
work in three steps:

 1) find which commit to roll back to
 2) call "git reset --merge <commit>" to move to that commit
 3) remove the .git/sequencer directory

But the careless author forgot step 3 entirely.  The only reason the
command worked anyway is that "git reset --merge <commit>" renames the
.git/sequencer directory as a secondary effect --- after moving to
<commit>, or so the logic goes, it is unlikely but possible that the
caller of git reset wants to continue the series of cherry-picks that
was in progress, so git renames the sequencer state to
.git/sequencer-old to be helpful while allowing the cherry-pick to be
resumed if the caller did not want to end the sequence after all.

By running "git cherry-pick --abort", the operator has clearly
indicated that she is not planning to continue cherry-picking.  Remove
the (renamed) .git/sequencer directory as intended all along.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
By the way, as the length of the second-to-last paragraph above might
have hinted, I am not convinced that allowing "git reset --hard" as an
escape route from a cherry-pick sequence was very sensible.  It
_would_ be nice to have a command to return to a known state,
discarding progress in all pending multiple-command guided workflows
(am, rebase, bisect), but git reset is not that command.

 builtin/revert.c          |    1 +
 t/t7106-reset-sequence.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 5dedb51c..818b4abb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -942,6 +942,7 @@ static int sequencer_rollback(struct replay_opts *opts)
 	}
 	if (reset_for_rollback(sha1))
 		goto fail;
+	remove_sequencer_state(1);
 	strbuf_release(&buf);
 	return 0;
 fail:
diff --git a/t/t7106-reset-sequence.sh b/t/t7106-reset-sequence.sh
index 3f86e8c5..83f7ea59 100755
--- a/t/t7106-reset-sequence.sh
+++ b/t/t7106-reset-sequence.sh
@@ -41,4 +41,12 @@ test_expect_success 'reset --hard cleans up sequencer state, providing one-level
 	test_path_is_missing .git/sequencer-old
 '
 
+test_expect_success 'cherry-pick --abort does not leave sequencer-old dir' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	git cherry-pick --abort &&
+	test_path_is_missing .git/sequencer &&
+	test_path_is_missing .git/sequencer-old
+'
+
 test_done
-- 
1.7.8.rc3
