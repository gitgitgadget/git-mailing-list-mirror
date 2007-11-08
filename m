From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] git-fetch: avoid local fetching from alternate (again)
Date: Thu, 8 Nov 2007 06:22:54 -0500
Message-ID: <20071108112254.GN14735@spearce.org>
References: <20071108080058.GC16690@spearce.org> <20071108100039.GM14735@spearce.org> <7vhcjx2gq5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 12:23:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq5Tg-0001YG-9r
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 12:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370AbXKHLW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 06:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758374AbXKHLW7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 06:22:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39680 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020AbXKHLW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 06:22:58 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iq5TJ-0000tl-BP; Thu, 08 Nov 2007 06:22:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0339E20FBAE; Thu,  8 Nov 2007 06:22:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vhcjx2gq5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63995>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I'm starting to suspect heap corruption again in builtin-fetch.
> > This patch alters the malloc() calls we are doing and may be shifting
> > something around just enough in memory to cause a data overwrite or
> > something and that's why this tag just drops out of the linked list?
> > But then why does that happen in the test suite but not outside.
> > Maybe because the test suite is setting environment variables that
> > I'm not and the impact of those combined with these additional
> > mallocs is what is breaking it?  *sigh*

Found it.  This ain't pretty.  Remember, what's failing in the test
suite is we aren't getting "tag-three-file" automatically followed
during fetch.  This is an annotated tag referring to a blob.

Here's the *WAY WRONG FIX THAT SHOULD NOT EVER BE APPLIED*:

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 847db73..a935b5a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -389,7 +389,7 @@ static struct ref *find_non_local_tags(struct transport *transport,
 
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
-		    lookup_object(ref->old_sha1)) {
+		    has_sha1_file(ref->old_sha1)) {
 			path_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);

(I know Junio knows why this patch shouldn't be applied.
 Its exactly why quickfetch calls rev-list --objects...)

The problem here is my quickfetch patch is bypassing the internal
call to fetch-pack.  Which means we never do object handshaking,
and thus never allocate struct object* for the things we had been
talking about (because we never talked about them!).  Or in the
case of commits, their trees and parents too.  Thus the call above
to lookup_object() for a blob fails, as we never tried to parse it
before in fetch-pack.

Now I'm really not sure why we have blob objects allocated into
memory for lookup_object() during fetch-pack, but apparently we do.
At least during this test vector.  It doesn't make sense if we are
only talking about commits (and their parents).  I'd expect the
root trees to have objects (when the commit buffer was parsed for
graph traversal) but not blobs.

Maybe some smart individual will come up with the right solution to
keep automatic tag following enabled (safely!) while also allowing
us to use quickfetch.  There's got to be a solution that doesn't
implicitly rely upon the handshaking we just happened to do with
the remote peer...

Me, I'm off to catch a few hours of sleep.

-- 
Shawn.
