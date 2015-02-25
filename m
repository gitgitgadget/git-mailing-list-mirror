From: Jeff King <peff@peff.net>
Subject: Re: [BUG] diffcore-rename with duplicate tree entries can segfault
Date: Wed, 25 Feb 2015 16:40:32 -0500
Message-ID: <20150225214032.GA32295@peff.net>
References: <20150224214311.GA8622@peff.net>
 <xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
 <20150224224918.GA24749@peff.net>
 <xmqqd24yq517.fsf@gitster.dls.corp.google.com>
 <20150224234737.GA8370@peff.net>
 <xmqq8ufmpouz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:40:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQjh9-0003uL-G5
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 22:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbbBYVkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 16:40:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:53363 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752761AbbBYVke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 16:40:34 -0500
Received: (qmail 15268 invoked by uid 102); 25 Feb 2015 21:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 15:40:34 -0600
Received: (qmail 19187 invoked by uid 107); 25 Feb 2015 21:40:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 16:40:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2015 16:40:32 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8ufmpouz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264416>

On Tue, Feb 24, 2015 at 09:00:20PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   3. The sort order check is wrong. :-/ It needs to take into account
> >      git's magic "if it's a tree, pretend it has '/' after it" rule.
> >      That's not too hard for a single tree (fsck.c:verify_ordered does
> >      it). But for filepairs, I'm not sure what to do. Most cases
> >      have a single mode/name pair. But what about a D/F typechange? If
> >      "foo" becomes "foo/", which do I use to sort?
> 
> I think diff-index populates the diff queue in a wrong order and
> then calls diffcore_fix_diff_index() to fix it up.
> 
> I am a bit worried about the effect this stricter input check might
> have to "diff --no-index" codepath, though.

Interesting, I didn't even know about diffcore_fix_diff_index.

Let's forget about sorting for a moment. Unsorted trees will produce odd
results, certainly, but the order of your diff is perhaps the least of
the problems. The only reason we care about it here is to do a cheap
uniq() operation.

But we can also do that with a hash table, or an auxiliary sorted array.
And sure enough, that's exactly what the rename_dst array is. When we
are inserting into it, we can easily detect duplicates there, and just
abort the rename operation. Like:

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4e132f1..e26dd62 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -27,7 +27,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 		struct diff_rename_dst *dst = &(rename_dst[next]);
 		int cmp = strcmp(two->path, dst->two->path);
 		if (!cmp)
-			return dst;
+			return insert_ok ? NULL : dst;
 		if (cmp < 0) {
 			last = next;
 			continue;
@@ -450,8 +450,10 @@ void diffcore_rename(struct diff_options *options)
 			else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
 				 is_empty_blob_sha1(p->two->sha1))
 				continue;
-			else
-				locate_rename_dst(p->two, 1);
+			else {
+				if (!locate_rename_dst(p->two, 1))
+					goto cleanup;
+			}
 		}
 		else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
 			 is_empty_blob_sha1(p->one->sha1))

which I think is a pretty simple and sane fix. I do notice that
rename_dst and rename_src are essentially hash tables. They predate
hashmap.c by quite a bit, but it might be worth moving them. It would
simplify the code, and I suspect perform better (they progressively
insert into a sorted list; in the worst case that means O(n^2)
memmove's, though if the input is sorted we get best-case behavior).

So to go forward, I'm happy to prepare a patch, but I'd like to know:

  1. Does something like the above look reasonable to you (I'd probably
     refactor it to avoid the bizarre return value semantics from
     locate_rename_dst, though)?

  2. If so, do you want something minimal like what's above, or do you
     mind if I build it on top of a hashmap conversion? I suspect the
     logic may also end up more clear with the hashmap (since inserting
     versus lookup will be more distinct in the callers).

-Peff
