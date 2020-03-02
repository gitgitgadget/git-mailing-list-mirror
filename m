Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AB6C3F2D2
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28949214DB
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 13:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgCBNcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:32:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:58862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727361AbgCBNcS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 08:32:18 -0500
Received: (qmail 30067 invoked by uid 109); 2 Mar 2020 13:32:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Mar 2020 13:32:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3128 invoked by uid 111); 2 Mar 2020 13:41:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2020 08:41:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Mar 2020 08:32:17 -0500
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] remote.c: fix handling of push:remote_ref
Message-ID: <20200302133217.GA1176622@coredump.intra.peff.net>
References: <20200228172455.1734888-1-damien.olivier.robert+git@gmail.com>
 <20200228182349.GA1408759@coredump.intra.peff.net>
 <20200301220531.iuokzzdb5gruslrn@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200301220531.iuokzzdb5gruslrn@doriath>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[dropping J from cc, since my earlier email bounced]

On Sun, Mar 01, 2020 at 11:05:31PM +0100, Damien Robert wrote:

> > Saying "*explicit = 1" here seems weird. Isn't the whole point that
> > these modes _aren't_ explicit?
> 
> Well pushremote_for_branch also set explicit=1 if only remote.pushDefault
> is set, so I followed suit.

Yeah, I think the useless "explicit" was a mistake back when the
function was added. See the patch below.

> > It looks like our only caller will ignore our return value unless we say
> > "explicit", though. I have to wonder what the point of that flag is,
> > versus just returning NULL when we don't have anything to return.
> 
> I think you looked at the RR_REMOTE_NAME (ref-filter.c:1455), here the
> situation is handled by RR_REMOTE_REF, where explicit is not used at all.
> So we could remove it.

We do look at it, but it's pointless to do so:

  $ git grep -hn -C4 remote_ref_for_branch origin:ref-filter.c
  1461-	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
  1462-		int explicit;
  1463-		const char *merge;
  1464-
  1465:		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
  1466-					      &explicit);
  1467-		*s = xstrdup(explicit ? merge : "");
  1468-	} else
  1469-		BUG("unhandled RR_* enum");

I think we probably ought to do this as a preparatory patch in your
series.

-- >8 --
Subject: remote: drop "explicit" parameter from remote_ref_for_branch()

Commit 9700fae5ee (for-each-ref: let upstream/push report the remote ref
name, 2017-11-07) added a remote_ref_for_branch() helper, which is
modeled after remote_for_branch(). This includes providing an "explicit"
out-parameter that tells the caller whether the remote was configured by
the user, or whether we picked a default name like "origin".

But unlike remote names, there's no default case for the remote branch
name. In any case where we don't set "explicit", we'd just an empty
string anyway. Let's instead return NULL in this case, letting us
simplify the function interface.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c |  6 ++----
 remote.c     | 11 ++---------
 remote.h     |  3 +--
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6867e33648..9837700732 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1459,12 +1459,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			remote_for_branch(branch, &explicit);
 		*s = xstrdup(explicit ? remote : "");
 	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
-		int explicit;
 		const char *merge;
 
-		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
-					      &explicit);
-		*s = xstrdup(explicit ? merge : "");
+		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push);
+		*s = xstrdup(merge ? merge : "");
 	} else
 		BUG("unhandled RR_* enum");
 }
diff --git a/remote.c b/remote.c
index 593ce297ed..c43196ec06 100644
--- a/remote.c
+++ b/remote.c
@@ -516,14 +516,11 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 	return remote_for_branch(branch, explicit);
 }
 
-const char *remote_ref_for_branch(struct branch *branch, int for_push,
-				  int *explicit)
+const char *remote_ref_for_branch(struct branch *branch, int for_push)
 {
 	if (branch) {
 		if (!for_push) {
 			if (branch->merge_nr) {
-				if (explicit)
-					*explicit = 1;
 				return branch->merge_name[0];
 			}
 		} else {
@@ -534,15 +531,11 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
 						  branch->refname))) {
-				if (explicit)
-					*explicit = 1;
 				return dst;
 			}
 		}
 	}
-	if (explicit)
-		*explicit = 0;
-	return "";
+	return NULL;
 }
 
 static struct remote *remote_get_1(const char *name,
diff --git a/remote.h b/remote.h
index b134cc21be..11d8719b58 100644
--- a/remote.h
+++ b/remote.h
@@ -261,8 +261,7 @@ struct branch {
 struct branch *branch_get(const char *name);
 const char *remote_for_branch(struct branch *branch, int *explicit);
 const char *pushremote_for_branch(struct branch *branch, int *explicit);
-const char *remote_ref_for_branch(struct branch *branch, int for_push,
-				  int *explicit);
+const char *remote_ref_for_branch(struct branch *branch, int for_push);
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
-- 
2.25.1.947.ga5bc3d07fe

