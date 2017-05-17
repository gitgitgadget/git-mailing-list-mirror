Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53C2201A7
	for <e@80x24.org>; Wed, 17 May 2017 14:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbdEQOEY (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 10:04:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:53706 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753323AbdEQOEV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 10:04:21 -0400
Received: (qmail 7885 invoked by uid 109); 17 May 2017 14:04:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 14:04:21 +0000
Received: (qmail 9833 invoked by uid 111); 17 May 2017 14:04:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 10:04:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 10:04:18 -0400
Date:   Wed, 17 May 2017 10:04:18 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        git discussion list <git@vger.kernel.org>
Subject: Re: Performance regression in `git branch` due to ref-filter usage
Message-ID: <20170517140417.kwzznw4su36k6pxv@sigill.intra.peff.net>
References: <dfc3a334-8047-26b0-1142-81c703010507@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfc3a334-8047-26b0-1142-81c703010507@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 01:14:34PM +0200, Michael Haggerty wrote:

> While working on reference code, I was running `git branch` under
> `strace`, when I noticed that `$GIT_DIR/HEAD` was being `lstat()`ed and
> `read()` 121 times. This is in a repository with 114 branches, so
> probably it is being run once per branch. The extra work makes a
> measurable difference to the (admittedly, short) runtime.
> 
> As recently as 2.12.3 the file was only read 4 times when running the
> same command [1].
> 
> The regression bisects to
> 
>     949af0684c (branch: use ref-filter printing APIs, 2017-01-10)
> 
> It would be nice if these extra syscalls could be avoided.
> 
> I haven't checked whether other commands have similar regressions.

It looks like it's part of populate_value(). Each ref checks %(HEAD),
and resolve HEAD individually to see if we're it. So it probably doesn't
affect other commands by default (though you could specify %(HEAD)
manually via for-each-ref).

The solution is to cache the value we read and use it to compare against
each ref. I'm not sure if we can do something more elegant than the
patch below, which just caches it for the length of the program.

> [1] One wonders why the file has to be read more than once, but that's a
> different story and probably harder to fix.

The other ones seem to come from wt_status code, as part of
get_head_description().

---
diff --git a/ref-filter.c b/ref-filter.c
index 1fc5e9970..947919fc4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1284,6 +1284,20 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
+static int head_matches(const char *refname)
+{
+	static int initialized;
+	static char *head;
+
+	if (!initialized) {
+		unsigned char sha1[20];
+		head = resolve_refdup("HEAD", RESOLVE_REF_READING, sha1, NULL);
+		initialized = 1;
+	}
+
+	return head && !strcmp(refname, head);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1369,12 +1383,7 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
-			const char *head;
-			unsigned char sha1[20];
-
-			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-						  sha1, NULL);
-			if (head && !strcmp(ref->refname, head))
+			if (head_matches(ref->refname))
 				v->s = "*";
 			else
 				v->s = " ";
