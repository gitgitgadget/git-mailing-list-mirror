From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix "git commit directory/" performance anomaly
Date: Fri, 10 Aug 2007 11:56:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708101154530.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
 <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net> <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
 <7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
 <7v643ovyli.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708100852540.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708100924570.30176@woody.linux-foundation.org>
 <7vsl6rs0l5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJZfP-00071R-Cf
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 20:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761410AbXHJS4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 14:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758843AbXHJS4z
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 14:56:55 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35320 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755452AbXHJS4y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 14:56:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AIudw0000665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 11:56:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AIuYsS003450;
	Fri, 10 Aug 2007 11:56:34 -0700
In-Reply-To: <7vsl6rs0l5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.21__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55562>



On Fri, 10 Aug 2007, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > This trivial patch avoids re-hashing files that are already clean in the 
> > index. This mirrors what commit 0781b8a9b2fe760fc4ed519a3a26e4b9bd6ccffe 
> > did for "git add .", only for "git commit ." instead.
> 
> Makes sense.  Thanks.

Please don't apply that patch without this trivial fix.

I don't know why I didn't notice. It passed all the tests, but it really 
shouldn't have, and the compiler warned.

		Linus

---
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 8d22dfa..a7a4574 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -91,7 +91,7 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 
 	/* Was the old index entry already up-to-date? */
 	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
-		return;
+		return 0;
 
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
