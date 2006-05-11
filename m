From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix git-pack-objects for 64-bit platforms
Date: Thu, 11 May 2006 12:27:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605111218380.3866@g5.osdl.org>
References: <20060511173632.G60c08b4@leonov.stosberg.net>
 <Pine.LNX.4.64.0605111054290.3866@g5.osdl.org> <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 11 21:28:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeGpc-000369-FU
	for gcvg-git@gmane.org; Thu, 11 May 2006 21:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWEKT2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 15:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWEKT2A
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 15:28:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbWEKT16 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 15:27:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4BJRptH001656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 May 2006 12:27:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4BJRm39024089;
	Thu, 11 May 2006 12:27:50 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19912>



On Thu, 11 May 2006, Junio C Hamano wrote:
> 
> Since I saw a patch that touches only one place, I thought I'd
> better point this out...
> 
> There are a few more places that knows about this
> ((char*)base_pointer + (entry_count * 24)) magic in our code.

Since I _do_ have a 64-bit big-endian architecture, I decided to install 
some of the 64-bit development libraries that I didn't already have, and I 
added "-m64" to the compiler flags.

All the tests seem to pass with the simple fix (and without it, we do 
indeed fail at least t5700-clone-reference.sh).

Of course, there might well be something else that doesn't get coverage, 
but passing all tests is at least a good sign. And since x86-64 has been 
getting pretty extensive coverage, I don't think we have a lot of 64-bit 
bugs per se, this one just happened to hide.

		Linus

---
diff --git a/pack-objects.c b/pack-objects.c
index 523a1c7..1b9e7a1 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -156,7 +156,7 @@ static void prepare_pack_revindex(struct
 
 	rix->revindex = xmalloc(sizeof(unsigned long) * (num_ent + 1));
 	for (i = 0; i < num_ent; i++) {
-		long hl = *((long *)(index + 24 * i));
+		uint32_t hl = *((uint32_t *)(index + 24 * i));
 		rix->revindex[i] = ntohl(hl);
 	}
 	/* This knows the pack format -- the 20-byte trailer
