From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/5] Make 'diff_populate_filespec()' use the new
 'strbuf_readlink()'
Date: Thu, 18 Dec 2008 08:55:50 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812180851120.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain> <20081218121118.3635c53c@crow>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 17:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDMCI-0001ZM-2h
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 17:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbYLRQ4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 11:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbYLRQ4o
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 11:56:44 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46579 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762AbYLRQ4n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 11:56:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIGtpQ6009205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 08:55:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIGtoRO011245;
	Thu, 18 Dec 2008 08:55:51 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20081218121118.3635c53c@crow>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103471>



On Thu, 18 Dec 2008, Mark Burton wrote:
> 
> Does it need a cast on some architectures?

Gaah. My bad. It should work fine ("unsigned long" is physically the same 
type as "size_t" in your case), but on 32-bit x86, size_t is generally 
"unsigned int" - which is the same physical type there (both int and long 
are 32-bit) but causes a valid warning.

I think we should just make the "size" member "size_t". I use "unsigned 
long" out of much too long habit, since we traditionally avoided "size_t" 
in the kernel due to it just being another unnecessary architecture- 
specific detail.

So the proper patch is probably just the following. Sorry about that,

		Linus
---
 diffcore.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diffcore.h b/diffcore.h
index 5b63458..16a73e6 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -30,7 +30,7 @@ struct diff_filespec {
 	void *data;
 	void *cnt_data;
 	const char *funcname_pattern_ident;
-	unsigned long size;
+	size_t size;
 	int count;               /* Reference count */
 	int xfrm_flags;		 /* for use by the xfrm */
 	int rename_used;         /* Count of rename users */
