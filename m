From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 11:09:44 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org> <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
 <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH23K-0002zV-Qi
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbYAUTK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbYAUTK4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:10:56 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39668 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751442AbYAUTKz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 14:10:55 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LJ9i9w018713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 11:09:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LJ9iiQ015233;
	Mon, 21 Jan 2008 11:09:44 -0800
In-Reply-To: <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.224 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71311>



On Mon, 21 Jan 2008, Linus Torvalds wrote:
> 
> Will experiment more now that I have a case that reliably fails. The 
> commit that causes this literally shouldn't have caused any semantic 
> changes at all, so this is rather interesting.

Intriguing. It's the "ce_mode" -> CE_REMOVE changes that trigger this bug.

The problem goes away with this one-liner.

I haven't figured out *why*, yet, but the reason I checked CE_REMOVE was 
that it was the only part that wasn't just a pure network order change.

I suspect we have some code-path that didn't check for explicit removal, 
but that happened to check for "mode doesn't match", so clearing ce_mode 
just magically triggered it.

Still looking.

		Linus

---
diff --git a/unpack-trees.c b/unpack-trees.c
index ff46fd6..d6fcf60 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -613,6 +613,7 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 	else
 		verify_absent(ce, "removed", o);
 	ce->ce_flags |= CE_REMOVE;
+	ce->ce_mode = 0;
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	invalidate_ce_path(ce);
 	return 1;
