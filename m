From: David Kastrup <dak@gnu.org>
Subject: [PATCH] diff-delta.c: make FLEX_ARRAY=1 work.
Date: Tue, 18 Dec 2007 02:32:14 +0100
Message-ID: <85wsrclqmi.fsf_-_@lola.goethe.zz>
References: <20071218010126.GP14735@spearce.org>
	<7vtzmg3j37.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4RZb-0002t9-Fy
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 02:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbXLRBsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 20:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbXLRBsH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 20:48:07 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:59477 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751518AbXLRBsD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 20:48:03 -0500
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id DE10B3029C1;
	Tue, 18 Dec 2007 02:48:00 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id D2313ABAEC;
	Tue, 18 Dec 2007 02:48:00 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-010-216.pools.arcor-ip.net [84.61.10.216])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id AE9888C463;
	Tue, 18 Dec 2007 02:47:55 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 37CEF1C4CE33; Tue, 18 Dec 2007 02:48:37 +0100 (CET)
In-Reply-To: <7vtzmg3j37.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 17 Dec 2007 17:08:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/5161/Tue Dec 18 00:18:49 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68687>


I remarked previously that diff-delta.c does not work with FLEX_ARRAY=1.
Here is one attempt to change this.  It conceivably still suffers from
potential misalignment problems (which would likely need some union type
magic to avoid 100%), but at least the index calculation should not go
as horribly wrong as previously.

---
Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> I'll try to track it down tomorrow.  But the immediate workaround was
>> to just add '-DFLEX_ARRAY=/* empty */' to my CFLAGS and recompile
>> the world.  This compiler accepts the empty FLEX_ARRAY macro but
>> I'm not sure what feature test(s) would be necessary to make Git
>> able to automatically set that, seeing as how the tests defined in
>> 8e97 are perfectly reasonable and didn't pass.
>> ..., but will try to come up with a reasonable
>> detection patch....
>
> Actually I would be more worried about the breakage in FLEX_ARRAY=1 case
> than misdetection.  Even if your compiler supports the flexible array
> members, the fallback to FLEX_ARRAY=1 ought to work and you are seeing a
> case where it doesn't.

 diff-delta.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 9e440a9..099235c 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -247,7 +247,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	/* Now create the packed index in array form rather than
 	 * linked lists */
 
-	memsize = sizeof(*index)
+	memsize = (char *)&index->hash - (char *)index
 		+ sizeof(*packed_hash) * (hsize+1)
 		+ sizeof(*packed_entry) * entries;
 
@@ -264,7 +264,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	index->src_size = bufsize;
 	index->hash_mask = hmask;
 
-	mem = index + 1;
+	mem = &index->hash;
 	packed_hash = mem;
 	mem = packed_hash + (hsize+1);
 	packed_entry = mem;
-- 
1.5.3.6.995.ge8abd
