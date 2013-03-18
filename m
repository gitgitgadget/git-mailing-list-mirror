From: Jeff King <peff@peff.net>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Mon, 18 Mar 2013 13:19:49 -0400
Message-ID: <20130318171949.GB15924@sigill.intra.peff.net>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
 <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
 <20130318073229.GA5551@sigill.intra.peff.net>
 <7vtxo8ody3.fsf@alter.siamese.dyndns.org>
 <20130318164950.GA14844@sigill.intra.peff.net>
 <7vli9kocuc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Molnar <mingo@elte.hu>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 18:20:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHdjU-0006FM-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 18:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab3CRRTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 13:19:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56291 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab3CRRTx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 13:19:53 -0400
Received: (qmail 19654 invoked by uid 107); 18 Mar 2013 17:21:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 13:21:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 13:19:49 -0400
Content-Disposition: inline
In-Reply-To: <7vli9kocuc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218432>

On Mon, Mar 18, 2013 at 10:08:11AM -0700, Junio C Hamano wrote:

> Just for fun, here is a totally unrelated comparison, both with
> current master, compiled with -O2 and running on the same box.
> 
> [without GIT_USE_LOOKUP]
> real    0m39.906s
> real    0m40.020s
> real    0m40.022s
> real    0m40.027s
> real    0m40.146s
> 
> [with GIT_USE_LOOKUP]
> real    0m40.336s
> real    0m40.376s
> real    0m40.452s
> real    0m40.503s
> real    0m40.572s
> 
> Maybe the Newton-Raphson is right as a concept (it does seem to
> result in fewer minor-faults) but the current code is implemented
> poorly and has a huge room for improvement?

I do not see anything obviously wrong in it, though I did not walk
through all of the ofs calculation to look for any clever speedups.
However, I think it is clear from the other timings and Ingo's thread
that glibc 2.11's memcmp does not perform very well on many short reads.
And sha1_entry_pos will do memcmps even smaller than 20 bytes.

What happens if you do this?

diff --git a/sha1-lookup.c b/sha1-lookup.c
index c4dc55d..4ea03bd 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -102,6 +102,17 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 	return -lo-1;
 }
 
+static int short_memcmp(const unsigned char *a,
+			const unsigned char *b,
+			int len)
+{
+	int i;
+	for (i = 0; i < len; i++, a++, b++)
+		if (*a != *b)
+			return *a - *b;
+	return 0;
+}
+
 /*
  * Conventional binary search loop looks like this:
  *
@@ -257,7 +268,7 @@ int sha1_entry_pos(const void *table,
 			    lo, mi, hi, sha1_to_hex(key));
 
 		mi_key = base + elem_size * mi + key_offset;
-		cmp = memcmp(mi_key + ofs_0, key + ofs_0, 20 - ofs_0);
+		cmp = short_memcmp(mi_key + ofs_0, key + ofs_0, 20 - ofs_0);
 		if (!cmp)
 			return mi;
 		if (cmp > 0) {
