From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] index_name_exists() conversion
Date: Thu, 21 Feb 2008 09:00:55 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802210816380.7833@woody.linux-foundation.org>
References: <7v7igywvnj.fsf@gitster.siamese.dyndns.org> <7vy79evfsn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802210806540.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 18:02:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSEoO-0001sR-Fy
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 18:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbYBURBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 12:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbYBURBo
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 12:01:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48763 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751978AbYBURBn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 12:01:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LH0tTe013093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Feb 2008 09:01:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LH0t4Y031923;
	Thu, 21 Feb 2008 09:00:55 -0800
In-Reply-To: <alpine.LFD.1.00.0802210806540.7833@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.238 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74635>



On Thu, 21 Feb 2008, Linus Torvalds wrote:
> 
> (Also, some code used to just reuse the same cache entry multiple times, 
> and that got illegal for the same reason).

Ahh. I think I may have found it.

It's stupid.

In hash_index_entry(), we insert the entry into the name hash, but if it 
got inserted as the first entry, we don't actually set the ->next pointer 
to NULL.

So the chain would end up pointing to some random crud. I think we were 
just lucky with our allocators generally filling those things with zero.

See if this fixes it.

		Linus

---
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -39,6 +39,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	void **pos;
 	unsigned int hash = hash_name(ce->name, ce_namelen(ce));
 
+	ce->next = NULL;
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
 		ce->next = *pos;
