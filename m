From: Jeff King <peff@peff.net>
Subject: Re: Local clone checks out wrong branch based on remote HEAD
Date: Tue, 17 Mar 2009 20:54:13 -0400
Message-ID: <20090318005413.GC25454@coredump.intra.peff.net>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 01:55:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljk4V-0002C4-FC
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 01:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbZCRAyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 20:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZCRAyW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 20:54:22 -0400
Received: from peff.net ([208.65.91.99]:43776 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZCRAyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 20:54:21 -0400
Received: (qmail 9163 invoked by uid 107); 18 Mar 2009 00:54:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 20:54:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 20:54:13 -0400
Content-Disposition: inline
In-Reply-To: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113545>

On Tue, Mar 17, 2009 at 12:19:35PM -0700, Tom Preston-Werner wrote:

> After cloning this with a standard `git clone`, the refs are:
> 
> [11:48][tom@solid:~/dev/sandbox/site(release)]$ git branch -r -v
>   origin/HEAD    a52528a Fixed some routing problems
>   origin/release a52528a Fixed some routing problems
>   origin/trunk   a52528a Fixed some routing problems
> 
> And the checked out branch is 'release' instead of 'trunk' as I would expect:

As others have explained, this is because the information is lacking at
the client and we are forced to make a guess. There is a heuristic in
the guess to prefer "master" if it is an option. I suppose we could make
a similar exception for "trunk", which might make sense to people
working with SVN repositories.

OTOH, I am not sure I want to open the can of worms that is writing an
exhaustive list of heuristics that will work for everybody. Fixing the
protocol itself would probably be easier. :)

Here is what such a heuristic would look like, though (on top of next
and totally untested):

---
diff --git a/remote.c b/remote.c
index 76b1bbd..99d2281 100644
--- a/remote.c
+++ b/remote.c
@@ -1529,11 +1529,18 @@ struct ref *guess_remote_head(const struct ref *head,
 	if (head->symref)
 		return copy_ref(find_ref_by_name(refs, head->symref));
 
-	/* If refs/heads/master could be right, it is. */
+	/* We heuristically prefer certain names */
 	if (!all) {
-		r = find_ref_by_name(refs, "refs/heads/master");
-		if (r && !hashcmp(r->old_sha1, head->old_sha1))
-			return copy_ref(r);
+		const char *rules[] = {
+			"refs/heads/master",
+			"refs/heads/trunk",
+		};
+		int i;
+		for (i = 0; i < ARRAY_SIZE(rules); i++) {
+			r = find_ref_by_name(refs, rules[i]);
+			if (r && !hashcmp(r->old_sha1, head->old_sha1))
+				return copy_ref(r);
+		}
 	}
 
 	/* Look for another ref that points there */
