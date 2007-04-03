From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 09:21:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704030913060.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 18:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYllU-0006v2-6h
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 18:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbXDCQVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 12:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbXDCQVp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 12:21:45 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58902 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbXDCQVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 12:21:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33GLRPD014859
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 09:21:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33GLQZb029438;
	Tue, 3 Apr 2007 09:21:26 -0700
In-Reply-To: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43625>



On Tue, 3 Apr 2007, Linus Torvalds wrote:
> 
> and it uses 52s of CPU-time, and on my 4GB machine it actually started 
> doing IO and swapping, because git-index-pack grew to 4.8GB in size.

Ahh. False alarm.

The problem is actually largely a really stupid memory leak in the SHA1 
collision checking (which wouldn't trigger on a normal pull, but obviously 
does trigger for every single object when testing!)

This trivial patch fixes most of it. git-index-pack still uses too much 
memory, but it does a *lot* better.

Junio, please get this into 1.5.1 (I *think* the SHA1 checking is new, but 
if it exists in 1.5.0 too, it obviously needs the same fix).

It still grows, but it grew to just 287M in size now for the 170M kernel 
object:

	41.59user 1.39system 0:43.64elapsed
	0major+73552minor

which is quite a lot better.

Duh.

		Linus

---
 index-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 6284fe3..3c768fb 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -358,6 +358,7 @@ static void sha1_object(const void *data, unsigned long size,
 		if (size != has_size || type != has_type ||
 		    memcmp(data, has_data, size) != 0)
 			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
+		free(has_data);
 	}
 }
 
