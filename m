Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A238C20248
	for <e@80x24.org>; Thu, 14 Mar 2019 19:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfCNT10 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 15:27:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726848AbfCNT10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 15:27:26 -0400
Received: (qmail 32116 invoked by uid 109); 14 Mar 2019 19:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 19:27:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25709 invoked by uid 111); 14 Mar 2019 19:26:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 15:26:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 15:26:09 -0400
Date:   Thu, 14 Mar 2019 15:26:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] gc: don't run "reflog expire" when keeping reflogs
Message-ID: <20190314192608.GC26250@sigill.intra.peff.net>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
 <20190313235439.30439-5-avarab@gmail.com>
 <20190314004006.GI31968@sigill.intra.peff.net>
 <xmqqmuly9hyg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmuly9hyg.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 01:51:35PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Seeing "--stale-fix" again reminded me: that may be the "oops, we can
> > spend tons of CPU walking history" bit that I mentioned in the other
> > part of the thread. But I don't think git-gc would ever run with that
> > option.
> 
> The option was a purely transitional measure to recover from a bad
> reflog state that could have been left by earlier versions of
> "prune" and "repack" that did not pay attention to the reflog.
> Perhaps we should plan to deprecate and remove it by now?

True, though I have definitely used it over the years to clear out
broken reflog entries from corrupted repositories. In most cases we
should be able to do that much more simply these days, though. Since we
try to keep whole segments of history reachable from an otherwise
unreachable object, you should in general be able to just prune entries
for which we are missing the actual object mentioned in the log.

Of course when you are talking about corruption, all rules go out the
window. So it's possible you'd still need --stale-fix to cover really
broken cases.

I think these days I'd more often just delete the whole reflog in such a
case (once upon a time GitHub tried to use never-expiring reflogs as a
sort of audit trail, but it had all sorts of complications; these days
we log to a separate file).

So I wouldn't be terribly sad to see --stale-fix go away.

All that said, I do think --expire-unreachable still has to traverse to
find out what's reachable. And I think it does it under lock. If I
instrument the tempfile code like the patch below and run:

  GIT_TRACE_TEMPFILE=1 git reflog expire --expire-unreachable=now HEAD

on a copy of my git.git repo, I get:

  15:22:12.163725 tempfile.c:127          activating tempfile '/home/peff/compile/foo/.git/HEAD.lock'
  15:22:12.163769 tempfile.c:127          activating tempfile '/home/peff/compile/foo/.git/logs/HEAD.lock'
  15:22:13.053404 tempfile.c:312          renaming tempfile '/home/peff/compile/foo/.git/logs/HEAD.lock' to '/home/peff/compile/foo/.git/logs/HEAD'
  15:22:13.053416 tempfile.c:327          deleting tempfile '/home/peff/compile/foo/.git/HEAD.lock'

We hold HEAD.lock for almost an entire second.

(Actually, it just occurred to me that "strace -tt git ... 2>&1 | grep
HEAD.lock" would produce basically the same results, no patch needed).

-Peff

---
diff --git a/tempfile.c b/tempfile.c
index d43ad8c191..f7e999d3ca 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -53,6 +53,9 @@
 #include "cache.h"
 #include "tempfile.h"
 #include "sigchain.h"
+#include "trace.h"
+
+static struct trace_key trace_tempfile = TRACE_KEY_INIT(TEMPFILE);
 
 static VOLATILE_LIST_HEAD(tempfile_list);
 
@@ -119,6 +122,9 @@ static void activate_tempfile(struct tempfile *tempfile)
 	volatile_list_add(&tempfile->list, &tempfile_list);
 	tempfile->owner = getpid();
 	tempfile->active = 1;
+
+	trace_printf_key(&trace_tempfile, "activating tempfile '%s'",
+			 tempfile->filename.buf);
 }
 
 static void deactivate_tempfile(struct tempfile *tempfile)
@@ -302,6 +308,9 @@ int rename_tempfile(struct tempfile **tempfile_p, const char *path)
 		return -1;
 	}
 
+	trace_printf_key(&trace_tempfile, "renaming tempfile '%s' to '%s'",
+			 tempfile->filename.buf, path);
+
 	deactivate_tempfile(tempfile);
 	*tempfile_p = NULL;
 	return 0;
@@ -314,6 +323,9 @@ void delete_tempfile(struct tempfile **tempfile_p)
 	if (!is_tempfile_active(tempfile))
 		return;
 
+	trace_printf_key(&trace_tempfile, "deleting tempfile '%s'",
+			 tempfile->filename.buf);
+
 	close_tempfile_gently(tempfile);
 	unlink_or_warn(tempfile->filename.buf);
 	deactivate_tempfile(tempfile);
