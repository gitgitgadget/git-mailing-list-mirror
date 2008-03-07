From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] Make 'unpack_trees()' have a separate source and
 destination index
Date: Fri, 7 Mar 2008 13:48:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803071339150.3013@woody.linux-foundation.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org> <8676ea8b0313abfc2e0946f45f636643e28aade8.1204856187.git.torvalds@linux-foundation.org> <alpine.LNX.1.00.0803071603170.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 22:49:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXkRe-0005Yo-Em
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 22:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbYCGVs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 16:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbYCGVs4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 16:48:56 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54913 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751256AbYCGVsz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 16:48:55 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m27Ln8F4014574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Mar 2008 13:49:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m27LmeWi018975;
	Fri, 7 Mar 2008 13:48:41 -0800
In-Reply-To: <alpine.LNX.1.00.0803071603170.19665@iabervon.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.965 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76528>



On Fri, 7 Mar 2008, Daniel Barkalow wrote:
>
> It looks to me like it's leaking stuff stored in the index it creates if 
> it ends up failing.

Yes, adding a "discard_index(&o->result)" to the failure path sounds like 
a good idea. Patch appended.

> I'm not entirely sure of the index lifecycle stuff, 
> but it seems like it would be necessary.

Well, "necessary" may not be the right word, because it's a purely 
internal index thing, so all that happens is a memory leak. But it's 
certainly easy to do and correct.

That said, the *big* memory leak comes from the fact that we leak the 
cache_entry things left and right. That's a very traditional leak: because 
we used to build up the cache entries by just mapping them directly in 
from the index file (and we emulate that in modern times by allocating 
them from one big array), we can't actually free them one-by-one.

So doing the "discard_index()" will free the hash tables etc, which is 
good, and it will free the "istate->alloc" but that is never set on the 
result because we don't get the result from the index read. So we don't 
actually free the individual cache entries themselves that got created 
from the trees.

That's not something new, btw. We never did. But some day we should just 
add a flag to the cache_entry() that it's a "free one by one" kind, and 
then we could/should do it. In the meantime, this one-liner will fix 
*some* of the memory leaks, but not that old traditional one.

		Linus

---
 unpack-trees.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 0cdf198..da68557 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -315,6 +315,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 static int unpack_failed(struct unpack_trees_options *o, const char *message)
 {
+	discard_index(&o->result);
 	if (!o->gently) {
 		if (message)
 			return error(message);
