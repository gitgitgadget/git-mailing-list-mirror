From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fixed crash in fetching remote tags when there is not tags.
Date: Wed, 10 Oct 2007 23:27:35 +0200
Message-ID: <20071010212735.GB16635@steel.home>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi> <1191919868-4963-2-git-send-email-v@pp.inet.fi> <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi> <20071009182043.GA2997@steel.home> <20071010051034.GA30834@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-15?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifj5n-00008A-K8
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbXJJV1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756541AbXJJV1i
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:27:38 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:23093 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975AbXJJV1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:27:38 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo1) (RZmta 13.4)
	with ESMTP id e02d43j9AIX539 ; Wed, 10 Oct 2007 23:27:36 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DBEF7277AE;
	Wed, 10 Oct 2007 23:27:35 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BAE86C502; Wed, 10 Oct 2007 23:27:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071010051034.GA30834@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60547>

Jeff King, Wed, Oct 10, 2007 07:10:35 +0200:
> On Tue, Oct 09, 2007 at 08:20:43PM +0200, Alex Riesen wrote:
> 
> > Your test does not crash on my system and your fix is obviously bogus.
> > Just take a look at the only call site of the tail_link_ref: ret
> > cannot be NULL. alloc_ref will crash in memset, if this were the case.
> 
> His work is almost certainly on top of next, which crashes reliably with
> the test and has an additional call site for tail_link_ref. Aside from
> some trailing whitespace in the patch, I think his fix is reasonable.

Ach, I see.

Still, I'd suggest move the test into the caller, firstly because it
is the only place that special. Also, I can't think of a proper reason
to add a NULL ref to a reflist, and so the crashing tail_link_ref will
help us find the callers which use tail_link_ref incorrectly
(illogically too).

As the result of patter expansion can be NULL (empty pattern, as it
seems), lets just check for it. I parked the patch below locally.

diff --git a/remote.c b/remote.c
index 5e92378..58d63ed 100644
--- a/remote.c
+++ b/remote.c
@@ -884,7 +884,8 @@ int get_fetch_map(struct ref *remote_refs,
 			    rm->peer_ref->name);
 	}
 
-	tail_link_ref(ref_map, tail);
+	if (ref_map)
+		tail_link_ref(ref_map, tail);
 
 	return 0;
 }
