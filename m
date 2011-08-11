From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] revert: Allow mixed pick and revert instructions
Date: Thu, 11 Aug 2011 12:22:10 +0530
Message-ID: <CALkWK0kxi+-UEG9g_=BC8vK9DGA85+OKJSrXWH=3XsxpLg-E8g@mail.gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-4-git-send-email-artagnon@gmail.com> <20110810151527.GC31315@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 08:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrP88-0006VY-9Y
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 08:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab1HKGwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 02:52:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63171 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab1HKGwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 02:52:31 -0400
Received: by wyg24 with SMTP id 24so1202120wyg.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 23:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vjEj1jky0qTvtjiAYKk5Oh9FrtLlkCSPv7Ws/lalW/w=;
        b=r6Mw/gr2wx7vGHgvtfYyGC8GieJ/C6LROgtsyT+L0XCl4qOiOI0R1BfQZaySAs/gXy
         d2iWUu2//PdCvqKQNOAhhp8QfUXsxYqSiplg21KOC/Cm+MbLlRKva7UhTZ3/x2hPSJX+
         rAsriZwCUFEIHYRfpdCbqxfq5kAWVpzd9cD5U=
Received: by 10.216.0.66 with SMTP id 44mr7472395wea.63.1313045550088; Wed, 10
 Aug 2011 23:52:30 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Wed, 10 Aug 2011 23:52:10 -0700 (PDT)
In-Reply-To: <20110810151527.GC31315@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179085>

Hi,

On a note unrelated to Jonathan's review, I noticed some weird
behavior while playing with my new series: when picking a commit
that's already picked, all the code until run_git_commit runs just
fine.  Then 'git commit' fails because it's an empty commit.
Unfortunately, run_git_commit returns a positive return status from
do_pick_commit which is against the convention, leading the
cherry-picking machinery to think that a conflict was encountered.
This is highly confusing from the end-user's perspective.  The
operation has suddenly stopped without an error, and '--continue'
seems to continue the operation.  What is going on, right?

I was hesitant to send out the patch to make run_git_commit return an
error, because it breaks some tests in t3505-cherry-pick-empty.sh.
However, the problem is getting on my nerves now, and I believe that
the patch does the Right Thing (TM), even if it means that we have to
change the tests in t3505-cherry-pick-empty.sh.  Thoughts?

-- 8< --
Subject: [PATCH] revert: Classify failure to run 'git commit' as an error

Since a93d2a (revert: Propagate errors upwards from do_pick_commit,
2011-05-20), do_pick_commit differentiates between conflicts and
errors using the signed-ness of its return status.  Unfortunately, it
returns the return status from 'git commit' when it fails to run it,
breaking this convention.  Change this so that any non-zero return
status from run_git_commit is classified as an error.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b452e8..fcd4f3a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -603,7 +603,9 @@ static int do_pick_commit(struct commit *commit,
struct replay_opts *opts)
                rerere(opts->allow_rerere_auto);
        } else {
                if (!opts->no_commit)
-                       res = run_git_commit(defmsg, opts);
+                       if (run_git_commit(defmsg, opts))
+                               return error(_("Failed to run 'git
commit': %s"),
+                                       sha1_to_hex(commit->object.sha1));
        }

        free_message(&msg);
-- 
1.7.6.351.gb35ac.dirty
