From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] Fix extraneous lstat's in 'git checkout -f'
Date: Tue, 14 Jul 2009 14:19:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907141417160.13838@localhost.localdomain>
References: <alpine.LFD.2.01.0907132040530.13838@localhost.localdomain> <7vzlb7hc7y.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907140750290.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 23:20:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQpQ2-0004gZ-5s
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 23:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756470AbZGNVT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 17:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756238AbZGNVT4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 17:19:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49750 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755965AbZGNVTz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 17:19:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6ELJA6H022212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Jul 2009 14:19:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6ELJASO018901;
	Tue, 14 Jul 2009 14:19:10 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907140750290.13838@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.967 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123271>



In our 'oneway_merge()' we always do an 'lstat()' to see if we might
need to mark the entry for updating.

But we really shouldn't need to do that when the cache entry is already
marked as being ce_uptodate(), and this makes us do unnecessary lstat()
calls if we have index preloading enabled.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

As Junio noticed, I meant "ce_uptodate()", not "ce_valid()", but this is 
basically the simplified version that replaces the one that cared about 
CE_VALID.

On Tue, 14 Jul 2009, Linus Torvalds wrote:
> 
> And in that case, I guess it's also fine. In fact, for that case CE_VALID 
> would tend to really mean "always assume CE_UPTODATE", so then the patch I 
> sent out doesn't really necessarily need the whole "known_uptodate()" 
> thing, and could just use
> 
> 	if (o->reset && !ce_valid(old)) {
> 
> instead.
> 
> Which also makes my other worries go away.
> 
> 			Linus
> 

 unpack-trees.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f9d12aa..48d862d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1004,7 +1004,7 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset) {
+		if (o->reset && !ce_uptodate(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
